RSpec.describe Headings::Generator do
  describe '#call' do
    context 'when data is correct' do
      it 'generates text with capitalized headings with indexes and indents' do
        data = [
          { id: 1, title: 'heading1', heading_level: 0 },
          { id: 2, title: 'heading2', heading_level: 2 },
          { id: 3, title: 'heading3', heading_level: 1 },
          { id: 4, title: 'heading4', heading_level: 1 }
        ]
        expect(Headings::Generator.new(data).call).to eq(
          "1. Heading1\n\t\t1.1.1. Heading2\n\t1.2. Heading3\n\t1.3. Heading4"
        )

        data2 = [
          { id: 1, title: 'heading1', heading_level: 0 },
          { id: 2, title: 'heading2', heading_level: 3 },
          { id: 3, title: 'heading3', heading_level: 4 },
          { id: 4, title: 'heading4', heading_level: 1 },
          { id: 5, title: 'heading5', heading_level: 0 }
        ]
        expect(Headings::Generator.new(data2).call).to eq(
          "1. Heading1\n\t\t\t1.1.1.1. Heading2\n\t\t\t\t1.1.1.1.1. Heading3\n\t1.2. Heading4\n2. Heading5"
        )
      end
    end

    context 'when data is not an array' do
      it 'raises Headings::Generator::InvalidData error' do
        data = 'test'
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data element is not a hash' do
      it 'raises Headings::Generator::InvalidData error' do
        data = ['test']
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data element does not have a title' do
      it 'raises Headings::Generator::InvalidData error' do
        data = [{ id: 1, heading_level: 0 }]
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data element title is not a string' do
      it 'raises Headings::Generator::InvalidData error' do
        data = [{ id: 1, title: 1, heading_level: 0 }]
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data element does not have a heading_level' do
      it 'raises Headings::Generator::InvalidData error' do
        data = [{ id: 1, title: 'heading1' }]
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data element heading_level is not a integer' do
      it 'raises Headings::Generator::InvalidData error' do
        data = [{ id: 1, title: 'heading1', heading_level: 'a' }]
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end

    context 'when data ids are not unique' do
      it 'raises Headings::Generator::InvalidData error' do
        data = [
          { id: 1, title: 'heading1', heading_level: 0 },
          { id: 1, title: 'heading2', heading_level: 2 },
        ]
        expect { Headings::Generator.new(data).call }.to raise_error(Headings::Generator::InvalidData)
      end
    end
  end
end

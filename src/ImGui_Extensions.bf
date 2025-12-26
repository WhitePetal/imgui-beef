namespace ImGui
{
	extension ImGui
	{
		extension Vector<T>
		{
			private int32 GrowCapacity(int32 sz)
			{
				int32 new_capacity = Capacity > 0 ? (Capacity + Capacity / 2) : 8;
				return new_capacity > sz ? new_capacity : sz;
			}

			public void Reserve(int32 new_capacity) mut
			{
				if(new_capacity <= Capacity)
					return;
				T* new_data = (T*)MemAllocImpl(uint64(new_capacity * sizeof(T)));
				if(Data != null)
				{
					for(int32 i = 0; i < Capacity; ++i)
						new_data[i] = Data[i];
					MemFreeImpl(Data);
				}
				Data = new_data;
				Capacity = new_capacity;
			}

			public void PushBack(T v) mut
			{
				if(Size == Capacity)
					Reserve(GrowCapacity(Size + 1));
				Data[Size++] = v;
			}

			public void PopBack() mut
			{
				--Size;
			}

			public void Clear() mut
			{
				if(Data != null)
				{
					Size = Capacity = 0;
					MemFree(Data);
					Data = null;
				}
			}
		}
	}
}
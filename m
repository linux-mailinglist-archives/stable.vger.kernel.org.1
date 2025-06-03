Return-Path: <stable+bounces-150652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FFACC0C6
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF48169D2A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD275267F75;
	Tue,  3 Jun 2025 07:08:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43291D47AD;
	Tue,  3 Jun 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934509; cv=none; b=tLPV1sIAWCd7tQ+IgnBt227vtHZW6Gj4QwB+9r94tPrlmwzc+TKQpWbgfTKNw4g+7IogJ0WOeyrgzo5sDjCTT/aDgl9kBMuM88KGD9WyH6ALpI4XEx4jy/oG2uOsJmwDzdrr5a9WKSRxuYWesCtGiyzU2xQTWc0vNiIxiQrTofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934509; c=relaxed/simple;
	bh=+B0PBHH61Eka8uNJ2JHoc6EJkC0qS/HA2xw/BuJki74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4u3ur3pvnW0qgsvSWKoeWe1Gal9OGBcO2txmGaFX5m4+J2tpMHro1Zn7h25Q7jerwMVddGn7PpnV5MyQKr/ITFRKCp+JRdWMoLcD/f1+GEm6/qSOgtNHIuBaE+yLjYMOS2wseGC11cKW2Ovfz4kZFRYQfbSboQUPOeseaali/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bBMHs0WFHzYQvmf;
	Tue,  3 Jun 2025 15:08:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 223431A11C6;
	Tue,  3 Jun 2025 15:08:24 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgAnMGNmnz5otIT5OA--.20294S2;
	Tue, 03 Jun 2025 15:08:23 +0800 (CST)
Message-ID: <c093f0d7-58b2-492b-bba5-5e1007a78056@huaweicloud.com>
Date: Tue, 3 Jun 2025 15:08:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-5-pulehui@huaweicloud.com>
 <9117d6d8-df01-4949-a695-29cafe7fe65f@lucifer.local>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <9117d6d8-df01-4949-a695-29cafe7fe65f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnMGNmnz5otIT5OA--.20294S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1rtrWrWF4kJry7Kry3urg_yoW5ArWkp3
	WkA3Z0yF4xtF13Jw1avr909a1fKrs3JF42y34fXFy8ZrnFvr93GF4IkFWYkFW8WrWv9r1r
	uw45JrZ3Wr4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/5/30 19:32, Lorenzo Stoakes wrote:
> On Thu, May 29, 2025 at 03:56:50PM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add test about uprobe pte be orphan during vma merge.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   tools/testing/selftests/mm/merge.c | 42 ++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
>> index c76646cdf6e6..8e1f38d23384 100644
>> --- a/tools/testing/selftests/mm/merge.c
>> +++ b/tools/testing/selftests/mm/merge.c
>> @@ -2,11 +2,13 @@
>>
>>   #define _GNU_SOURCE
>>   #include "../kselftest_harness.h"
>> +#include <fcntl.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <unistd.h>
>>   #include <sys/mman.h>
>>   #include <sys/wait.h>
>> +#include <linux/perf_event.h>
>>   #include "vm_util.h"
> 
> Need to include sys/syscall.h...
> 
>>
>>   FIXTURE(merge)
>> @@ -452,4 +454,44 @@ TEST_F(merge, forked_source_vma)
>>   	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
>>   }
>>
>> +TEST_F(merge, handle_uprobe_upon_merged_vma)
>> +{
>> +	const size_t attr_sz = sizeof(struct perf_event_attr);
>> +	unsigned int page_size = self->page_size;
>> +	const char *probe_file = "./foo";
>> +	char *carveout = self->carveout;
>> +	struct perf_event_attr attr;
>> +	unsigned long type;
>> +	void *ptr1, *ptr2;
>> +	int fd;
>> +
>> +	fd = open(probe_file, O_RDWR|O_CREAT, 0600);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	ASSERT_EQ(ftruncate(fd, page_size), 0);
>> +	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
>> +
>> +	memset(&attr, 0, attr_sz);
>> +	attr.size = attr_sz;
>> +	attr.type = type;
>> +	attr.config1 = (__u64)(long)probe_file;
>> +	attr.config2 = 0x0;
>> +
>> +	ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);
> 
> ...Because this results in:
> 
> In file included from merge.c:4:
> merge.c: In function ‘merge_handle_uprobe_upon_merged_vma’:
> merge.c:480:27: error: ‘__NR_perf_event_open’ undeclared (first use in this function)
>    480 |         ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);
> 

I did not encounter this problem when compiling in the 
tools/testing/selftests/mm directory, but in any case, adding the 
sys/syscall.h header file makes sense.

> Otherwise :>)
> 
>> +
>> +	ptr1 = mmap(&carveout[page_size], 10 * page_size, PROT_EXEC,
>> +		    MAP_PRIVATE | MAP_FIXED, fd, 0);
>> +	ASSERT_NE(ptr1, MAP_FAILED);
>> +
>> +	ptr2 = mremap(ptr1, page_size, 2 * page_size,
>> +		      MREMAP_MAYMOVE | MREMAP_FIXED, ptr1 + 5 * page_size);
>> +	ASSERT_NE(ptr2, MAP_FAILED);
>> +
>> +	ASSERT_NE(mremap(ptr2, page_size, page_size,
>> +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
>> +
>> +	close(fd);
>> +	remove(probe_file);
>> +}
>> +
>>   TEST_HARNESS_MAIN
>> --
>> 2.34.1
>>



Return-Path: <stable+bounces-148129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A3AC85FF
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623953BADD5
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 01:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE114F125;
	Fri, 30 May 2025 01:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050199475;
	Fri, 30 May 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568301; cv=none; b=TQxHgNg/VanqspiG3EmIbySzYFlyTXzKE5q07ltrmsfo0Lx8HNRtUGdyDTSy32SWm00BY9xZS/wOTnFeQl/1mfXUSLKmGWOU67K5/SG5FYFaZg9OeGM4vjWfvsWGKoHAuLUSBalYBsysoI2i83627rRS4V90OZJ8PODVNS4NmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568301; c=relaxed/simple;
	bh=kNaajXg16m+Pd6AypVIjsl97RD3jL0FIaypIp92RAMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3ghHAVYkx2Dyr7hMxhcZ5GCKprDqytnZRGpqnmPtTDMovxfgcxoUwMaC7+iiXylr5QnoK6V9YUgKXRDApX1Bx9C1ZtnLE6qBCJH2KUSnyR6WWxj4/MeCya10ETybMaYxTaF+Wp1GJFGSDvTYt6/v0aI2JtVvr7XLfNZeS9kmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7lsP6cYrzKHN0s;
	Fri, 30 May 2025 09:24:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5797A1A0D9C;
	Fri, 30 May 2025 09:24:56 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgAHpsDmCDlojyTiNg--.49967S2;
	Fri, 30 May 2025 09:24:56 +0800 (CST)
Message-ID: <263929f5-bde6-48fb-a162-298a9f83bf5b@huaweicloud.com>
Date: Fri, 30 May 2025 09:24:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-3-pulehui@huaweicloud.com>
 <20250529121944.3612511aa540b9711657e05a@linux-foundation.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20250529121944.3612511aa540b9711657e05a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHpsDmCDlojyTiNg--.49967S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw18Jw4rury8trWUZFW3Awb_yoW8Jryrpa
	y0ga45Wa1UtF17Gr97Zr1qqrZYyws7tFyUG3srZr4YkasYkrnagF9FkayFvFZ5CFWDK3y5
	tFWUGr93Ga4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/5/30 3:19, Andrew Morton wrote:
> On Thu, 29 May 2025 15:56:48 +0000 Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> When executing move_ptes, the new_pte must be NULL, otherwise it will be
>> overwritten by the old_pte, and cause the abnormal new_pte to be leaked.
>> In order to make this problem to be more explicit, let's add
>> WARN_ON_ONCE when new_pte is not NULL.
>>
>> ...
>>
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -237,6 +237,8 @@ static int move_ptes(struct pagetable_move_control *pmc,
>>   
>>   	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
>>   				   new_pte++, new_addr += PAGE_SIZE) {
>> +		WARN_ON_ONCE(!pte_none(*new_pte));
>> +
>>   		if (pte_none(ptep_get(old_pte)))
>>   			continue;
>>   
> 
> We now have no expectation that this will trigger, yes?  It's a sanity

Hi Andrew,

This can sanitize abnormal new_pte. It is expected that uprobe would not 
come in later, but others, uncertain🤔? So it will be a good alert. And 
after patch 1 it will not trigger WARNING.

> check that patch [1/4] is working?  Perhaps VM_WARN_ON_ONCE() would be

Agree, should I respin one more?

> more appropriate.  And maybe even a comment:
> 
> 	/* temporary, remove this one day */
> 



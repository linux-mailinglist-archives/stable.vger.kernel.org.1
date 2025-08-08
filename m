Return-Path: <stable+bounces-166814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222FB1E007
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 02:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68884189EC4E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6870111A8;
	Fri,  8 Aug 2025 00:56:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008C8C0B
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754614598; cv=none; b=n8Nn0XVlohAJh9EAs6+/0Z8Ieo78l8xesfuRucPbSMrxhZwgfJysTj3SvAHisasn0Q8OxdOhF/zmNq94+BZ+v4FRtCE4n1QolE88xkIBDoUx6NVUc7ZrY2hSSlSSlxu15RWokFnEhl8gi4abU2IE3l6x2Jn9eDf92cZfbR3Np3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754614598; c=relaxed/simple;
	bh=r6SbXK4ArB0MmEJtzQKqQd2ZuyRHh5oycp/t3JnbyB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YB4MEONiR1j4t42HzXH+E3XOMKAI7J3NNkrZp3uvq/TC8BtVw+f5ARgzPtz4rz0l1CkJLHBI1X+OO3W2q5iM6gtI2t1RQmbGa/6GgJXpanQ630j9gemcgTcFrxtXt2ASkfC4IYUO3putNJsnY1UDheSoMyRoZHtsBKisoi+3SJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bylqD4gz4zLpqS;
	Fri,  8 Aug 2025 08:52:08 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 18378180080;
	Fri,  8 Aug 2025 08:56:26 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 Aug
 2025 08:56:25 +0800
Message-ID: <eacf887c-7259-4827-8bdb-8a938f01dc0c@huawei.com>
Date: Fri, 8 Aug 2025 08:56:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Fix possible deadlock in console_trylock_spinning
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <stable@vger.kernel.org>,
	<linux-mm@kvack.org>, Waiman Long <llong@redhat.com>, Breno Leitao
	<leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu Jialin
	<lujialin4@huawei.com>
References: <20250807091444.1999938-1-gubowen5@huawei.com>
 <aJTCGrkg69Ytg-CC@arm.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aJTCGrkg69Ytg-CC@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100007.china.huawei.com (7.202.181.92)

On 8/7/2025 11:11 PM, Catalin Marinas wrote:
> 
>> @@ -433,8 +439,15 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
>>   		list_del(&object->object_list);
>>   	else if (mem_pool_free_count)
>>   		object = &mem_pool[--mem_pool_free_count];
>> -	else
>> +	else {
>> +		/*
>> +		 * Printk deferring due to the kmemleak_lock held.
>> +		 * This is done to avoid deadlock.
>> +		 */
>> +		printk_deferred_enter();
>>   		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
>> +		printk_deferred_exit();
>> +	}
>>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> 
> I wouldn't bother with printk deferring here, just set a bool warn
> variable and report it after unlocking. We recently merged another patch
> that does this.
> 

That's fine, I will send another patch that does not include this part.

>>   
>>   	return object;
>> @@ -632,6 +645,11 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>   		else if (parent->pointer + parent->size <= ptr)
>>   			link = &parent->rb_node.rb_right;
>>   		else {
>> +			/*
>> +			 * Printk deferring due to the kmemleak_lock held.
>> +			 * This is done to avoid deadlock.
>> +			 */
>> +			printk_deferred_enter();
>>   			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
>>   				      ptr);
>>   			/*
>> @@ -639,6 +657,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>   			 * be freed while the kmemleak_lock is held.
>>   			 */
>>   			dump_object_info(parent);
>> +			printk_deferred_exit();
> 
> This is part of __link_object(), called with the lock held, so easier to
> defer the printing as above.
> 
> BTW, the function names in the diff don't match mainline. Which kernel
> version is this patch based on?
> 
The kernel version of this patch is stable-5.10. This part of the code 
exists in function __link_object() in the mainline.


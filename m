Return-Path: <stable+bounces-104419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC469F413C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 04:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56B4164827
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCF12E1CD;
	Tue, 17 Dec 2024 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mZFxNiac"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04A182CD;
	Tue, 17 Dec 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734406405; cv=none; b=UJZK6bODfEafEig3dDsydSOOQ07kIYKunAweNnyRv9I/ksqbG/8/bfkVugTs3k5yHFoGnrsFWcOOY7ttBMdVVTQ4YYIzodUSENmh2rJj8Gjic+ci1F8L3ZpA3o1sR9N5njzbx2PQnQCfBj6sQwCsdpMLODpJSXGvyLsRooj5k20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734406405; c=relaxed/simple;
	bh=hD7lPTejmqYuPJFcXB+8pwN17kgBK5tZ84GafSwM11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHDpbWnlS7P9VomNEDgCcXl4mmOJxY7bksSgGelFYacUneL2rlB/aUwS631tN/lxfPt8b+cRuy4oVDNxE+WfeKKXFH+cRssjhmol2ZUDA4tCDi3hwUNWhgquCS/Wx4mkqzT1fGVSvHXh2TlTqDvkOzNQjCfkbg2wzB+Hwq4nuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mZFxNiac; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ve1cdARtLaTM5vK1iPSn+RtSKdLG519mcJyi0I7S5BQ=;
	b=mZFxNiaczaFlZrDztbPn5wt0+w2yGuYwTlxAnuqtpUe0JaHuG0888DZPUFajkr
	iAPRNcfJS98qQaZYsBaX2napIHmEP8biNHpufWF8RfvVTIrAbqa9vZHM/OX07TLz
	CkPPLc7vrNcM6qGhEGjOX36kHgrGa6U3FohHfFyUjcpCY=
Received: from [172.21.22.210] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3RzXk8GBnx6U4Ag--.41661S2;
	Tue, 17 Dec 2024 11:32:53 +0800 (CST)
Message-ID: <d70d670b-f5af-4f19-a547-6d0ca0bcee5b@126.com>
Date: Tue, 17 Dec 2024 11:32:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734350044-12928-1-git-send-email-yangge1116@126.com>
 <78586900-a5bc-4377-8fb9-f322f2028310@linux.alibaba.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <78586900-a5bc-4377-8fb9-f322f2028310@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3RzXk8GBnx6U4Ag--.41661S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF13CF4UCF4rJr1rJFy7Wrg_yoW8Kw1kpF
	1xAasrtrs8XF9Fkws7t39Y9FWjvw48tFWUGr9Fvr1kuFnI9FnayFs7ta4jka4UXr15ta1Y
	qFWkuasrJa17AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqeHgUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifhC4G2dg7uYnXgAAs7



在 2024/12/17 10:35, Baolin Wang 写道:
> 
> 
> On 2024/12/16 19:54, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>> in __compaction_suitable()") allow compaction to proceed when free
>> pages required for compaction reside in the CMA pageblocks, it's
>> possible that __compaction_suitable() always returns true, and in
>> some cases, it's not acceptable.
>>
>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>> and starting a 32GB virtual machine with device passthrough is
>> extremely slow, taking almost an hour.
>>
>> During the start-up of the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>> Long term GUP cannot allocate memory from CMA area, so a maximum
>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>> machine memory. Since there is 16G of free CMA memory on the NUMA
>> node, watermark for order-0 always be met for compaction, so
>> __compaction_suitable() always returns true, even if the node is
>> unable to allocate non-CMA memory for the virtual machine.
>>
>> For costly allocations, because __compaction_suitable() always
>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>> place, resulting in excessively long virtual machine startup times.
>> Call trace:
>> __alloc_pages_slowpath
>>      if (compact_result == COMPACT_SKIPPED ||
>>          compact_result == COMPACT_DEFERRED)
>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>
>> In order to quickly fall back to remote node, we should remove
>> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
>> in long term GUP flow. After this fix, starting a 32GB virtual machine
>> with device passthrough takes only a few seconds.
>>
>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in 
>> __compaction_suitable()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
> 
> I sent a follow-up fix patch[1] to update the cc->alloc_flags, and with 
> that, looks good to me.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> [1] 
> https://lore.kernel.org/all/20241217022955.141818-1-baolin.wang@linux.alibaba.com/
Thanks



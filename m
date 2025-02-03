Return-Path: <stable+bounces-112001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4440A25764
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839C3A5C15
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C54201246;
	Mon,  3 Feb 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hkvKuTHn"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124371C3BEE;
	Mon,  3 Feb 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580016; cv=none; b=fG+Skwjcw83Ag7dqC+F39ohRYhT5gGmPguNrZgmGjRkxKErrxqkAKK7Kid5Pw1sUDxJpdeAWrkhq8BSiCtILC3Cn4lpVuAIqbrycn+qvy8I1knN5KaZ3xkQ5bM2ut711ao3jHxD6ECsXMRsrVeiyd2Iy5Xiog1URYUkVc4gyAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580016; c=relaxed/simple;
	bh=Sx80YUjhhnseLteuEoUM3NorhxDknbKdBHZVob2EOxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkBVj7oJQSG9AMnZZ3r7Ru25rbh17X3mue0PNV/1azChJiPk2ZohDHeh1sNW0agJBDHoZ5SAycZcXpspdLFqkiXDlKN/lMU+Hqbvuqs0t60lDykJQeuQgIN4P3087gupLBh7pypseyChk0FUYZXGKWmUfGzis2/67icSW3msbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hkvKuTHn; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2dfb1991-3030-4143-890b-83508d1b77e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738580006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sryoh3kv5mKKvU6/1ZDs0iM4PYh5aJgQNrh+wHpnYA0=;
	b=hkvKuTHnGXtyhADrA9IUdNT/aCm/YPcAbHvZkhhgriam/G3F0ClMK5emCEYgn3JIqoumxc
	PdRrIQHKXvviNKU54/ICEi1j81ZURLO/vVgVcyn6BSw2pVizpNxAGvf+yfhK1qJI3D3nDo
	wOLPnDdK4oY88HrAudjE55z0yM5j6eI=
Date: Mon, 3 Feb 2025 18:53:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
To: Lucas Stach <l.stach@pengutronix.de>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250202043355.1913248-1-sashal@kernel.org>
 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2025/2/3 16:59, Lucas Stach wrote:
> Hi Sasha,
>
> Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
>> This is a note to let you know that I've just added the patch titled
>>
>>      drm/etnaviv: Drop the offset in page manipulation
>>
>> to the 6.12-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       drm-etnaviv-drop-the-offset-in-page-manipulation.patch
>> and it can be found in the queue-6.12 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
> please drop this patch and all its dependencies from all stable queues.
>
> While the code makes certain assumptions that are corrected in this
> patch, those assumptions are always true in all use-cases today.

Those patches are harmless even we apply them, and after apply my pitch,
it requires less CPU computation, right?


> I don't see a reason

I think, if 'sg->offset != 0' could happen  or not is really matters here.
My argument was that the real data is stored at 'sg_dma_address(sg)', NOT
the 'sg_dma_address(sg) - sg->offset'.


As we can create a test that we store some kind of data at the middle of
a BO by the CPU, then map this BO with the MMU and ask the GPU fetch the
data.  Do we really have a way tell the GPU to skip the leading garbage
data?


> to introduce this kind of churn to the stable trees


If I'm wrong or miss something, we can get them back, possibly with new
features, additional description, and comments for use-cases. My argument
just that we don't have good reasons to take the'sg->offset' into account
for now.
  

> to fix a theoretical issue.


The start PA of a buffer segment has been altered, but the corresponding
VA is not.

Maybe a approach has to guarantee correct in the theory first.

> Regards,
> Lucas
>
>>
>> commit cc5b6c4868e20f34d46e359930f0ca45a1cab9e3
>> Author: Sui Jingfeng <sui.jingfeng@linux.dev>
>> Date:   Fri Nov 15 20:32:44 2024 +0800
>>
>>      drm/etnaviv: Drop the offset in page manipulation
>>      
>>      [ Upstream commit 9aad03e7f5db7944d5ee96cd5c595c54be2236e6 ]
>>      
>>      The etnaviv driver, both kernel space and user space, assumes that GPU page
>>      size is 4KiB. Its IOMMU map/unmap 4KiB physical address range once a time.
>>      If 'sg->offset != 0' is true, then the current implementation will map the
>>      IOVA to a wrong area, which may lead to coherency problem. Picture 0 and 1
>>      give the illustration, see below.
>>      
>>        PA start drifted
>>        |
>>        |<--- 'sg_dma_address(sg) - sg->offset'
>>        |               .------ sg_dma_address(sg)
>>        |              |  .---- sg_dma_len(sg)
>>        |<-sg->offset->|  |
>>        V              |<-->|    Another one cpu page
>>        +----+----+----+----+   +----+----+----+----+
>>        |xxxx|         ||||||   |||||||||||||||||||||
>>        +----+----+----+----+   +----+----+----+----+
>>        ^                   ^   ^                   ^
>>        |<---   da_len  --->|   |                   |
>>        |                   |   |                   |
>>        |    .--------------'   |                   |
>>        |    | .----------------'                   |
>>        |    | |                   .----------------'
>>        |    | |                   |
>>        |    | +----+----+----+----+
>>        |    | |||||||||||||||||||||
>>        |    | +----+----+----+----+
>>        |    |
>>        |    '--------------.  da_len = sg_dma_len(sg) + sg->offset, using
>>        |                   |  'sg_dma_len(sg) + sg->offset' will lead to GPUVA
>>        +----+ ~~~~~~~~~~~~~+  collision, but min_t(unsigned int, da_len, va_len)
>>        |xxxx|              |  will clamp it to correct size. But the IOVA will
>>        +----+ ~~~~~~~~~~~~~+  be redirect to wrong area.
>>        ^
>>        |             Picture 0: Possibly wrong implementation.
>>      GPUVA (IOVA)
>>      
>>      --------------------------------------------------------------------------
>>      
>>                       .------- sg_dma_address(sg)
>>                       |  .---- sg_dma_len(sg)
>>        |<-sg->offset->|  |
>>        |              |<-->|    another one cpu page
>>        +----+----+----+----+   +----+----+----+----+
>>        |              ||||||   |||||||||||||||||||||
>>        +----+----+----+----+   +----+----+----+----+
>>                       ^    ^   ^                   ^
>>                       |    |   |                   |
>>        .--------------'    |   |                   |
>>        |                   |   |                   |
>>        |    .--------------'   |                   |
>>        |    | .----------------'                   |
>>        |    | |                   .----------------'
>>        |    | |                   |
>>        +----+ +----+----+----+----+
>>        |||||| ||||||||||||||||||||| The first one is SZ_4K, the second is SZ_16K
>>        +----+ +----+----+----+----+
>>        ^
>>        |           Picture 1: Perfectly correct implementation.
>>      GPUVA (IOVA)
>>      
>>      If sg->offset != 0 is true, IOVA will be mapped to wrong physical address.
>>      Either because there doesn't contain the data or there contains wrong data.
>>      Strictly speaking, the memory area that before sg_dma_address(sg) doesn't
>>      belong to us, and it's likely that the area is being used by other process.
>>      
>>      Because we don't want to introduce confusions about which part is visible
>>      to the GPU, we assumes that the size of GPUVA is always 4KiB aligned. This
>>      is very relaxed requirement, since we already made the decision that GPU
>>      page size is 4KiB (as a canonical decision). And softpin feature is landed,
>>      Mesa's util_vma_heap_alloc() will certainly report correct length of GPUVA
>>      to kernel with desired alignment ensured.
>>      
>>      With above statements agreed, drop the "offset in page" manipulation will
>>      return us a correct implementation at any case.
>>      
>>      Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
>>      Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>>      Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> index a382920ae2be0..b7c09fc86a2cc 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> @@ -82,8 +82,8 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
>>   		return -EINVAL;
>>   
>>   	for_each_sgtable_dma_sg(sgt, sg, i) {
>> -		phys_addr_t pa = sg_dma_address(sg) - sg->offset;
>> -		unsigned int da_len = sg_dma_len(sg) + sg->offset;
>> +		phys_addr_t pa = sg_dma_address(sg);
>> +		unsigned int da_len = sg_dma_len(sg);
>>   		unsigned int bytes = min_t(unsigned int, da_len, va_len);
>>   
>>   		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);

-- 
Best regards,
Sui



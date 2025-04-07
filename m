Return-Path: <stable+bounces-128567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB0A7E32B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8013B3B9D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01DA1E835F;
	Mon,  7 Apr 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1r7fsG3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2291E832B
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037078; cv=none; b=D7v4XWJO+Z7X20IX4RjK16zqhjLaPEQ81xAmooITtBhLobbzbE/hjBhUddibUTTW/507t97KpdNcPRr7Qs2XFqb8Up9KWAZ+P14zWpSOCsmK9yTPm8exBuAftYGwKMrKrmhSau3nasLelDX0+H2DhEo9B4Z6Z5XWmUoF9IgoWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037078; c=relaxed/simple;
	bh=UCUUSUeiLfWWGb6fL1dKPqrQ3/1RuxraDiZxVeaRnkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX2B1YUGLX8yt8EKq0egXAZHqatMV+fFAf+ZbqKIm95adSzAKc6yd4kD5OlZDNZgWZ3C3EatkH10Rwbg+h9Wby4Px/taXEIvK9EQliDSYWt2Gd4AerEaokICA5JfFDRPxsapplelQ2dL7tQ6YIsd23Tobh+pMox/GTuc/lPtZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1r7fsG3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744037076; x=1775573076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UCUUSUeiLfWWGb6fL1dKPqrQ3/1RuxraDiZxVeaRnkU=;
  b=M1r7fsG3MwyH8SGXFZL13ioBjqBwnM6jR7Wyl4xqWvlIObcCPUy5aXK0
   xmQhdC/Xrw7bh58hn5G1b8fGqK/ImR7gjSPXtzFljiB6iNjHBnVddiYjh
   aywJ4hPl1spyG3Nx0qdSE6F+3epGWufwT7rEHoxM4n0KRcK7cO/kllDIP
   DKsIdHXHdWuV9KKRMWfSLkCHQM2WSklDt1cmHwls5Nkj1Rmgqt0gH4O9u
   ZDzeQZpvjJjkhk7AQ+fzLkfabjz68MF7kAjPqqbnWg9WIytjekURVCPEz
   IfH+Urd21ag0u3zJgIpEMdJjk3M79C3p5b9ndGufpO54rjo6Yg+dfJyH/
   w==;
X-CSE-ConnectionGUID: tC+32H4FShufUkZYoYgKNA==
X-CSE-MsgGUID: cKMwZKDaRDWj6bXrVHOIXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70803204"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="70803204"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:44:35 -0700
X-CSE-ConnectionGUID: OZ3q3j4CT8qsCAzxIK7Iyw==
X-CSE-MsgGUID: I8EUySWQSXuJxR9Cm3QPPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132116316"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.245.196]) ([10.245.245.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:44:33 -0700
Message-ID: <8ae9b377-5a2d-435f-8e29-ed393b984870@intel.com>
Date: Mon, 7 Apr 2025 15:44:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
 <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/04/2025 15:32, Christian König wrote:
> Am 07.04.25 um 16:18 schrieb Matthew Auld:
>> The page_link lower bits of the first sg could contain something like
>> SG_END, if we are mapping a single VRAM page or contiguous blob which
>> fits into one sg entry. Rather pull out the struct page, and use that in
>> our check to know if we mapped struct pages vs VRAM.
>>
>> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v5.8+
> 
> Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Were is patch #1 from this series?

That one is xe specific:
https://lore.kernel.org/intel-xe/20250407141823.44504-3-matthew.auld@intel.com/T/#m4ef16e478cfc8853d4518448dd345a66d5a7f6d9

I copied your approach with using page_link here, but with added sg_page().

> 
> Thanks,
> Christian.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 9f627caedc3f..c9842a0e2a1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>>   				 struct sg_table *sgt,
>>   				 enum dma_data_direction dir)
>>   {
>> -	if (sgt->sgl->page_link) {
>> +	if (sg_page(sgt->sgl)) {
>>   		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>>   		sg_free_table(sgt);
>>   		kfree(sgt);
> 



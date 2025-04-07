Return-Path: <stable+bounces-128569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948FA7E396
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8506F440743
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8401FBC96;
	Mon,  7 Apr 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4wb0lDK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12631F3FE5
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038115; cv=none; b=n6Gu90+BI1E64+8+NhUP9XK9Vu8//x8RW8qdR7/eJn86f5rGvRQz7OK/COexRa93vny005vdyoSgM5H5pgsbexsKwOKxnzH3KPaKAWqTT6192twrLq2rolIPze8SFnOJRC9R1SkIBlJIBxrv6aStgreCfpxazzi1v1l9bPV8X3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038115; c=relaxed/simple;
	bh=rhSATD/rKMtHYXDCE0o4Mbw5WsGF2rQbenLiBprMTa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIvI/pcvU35YEPlAmMSs5Kwq/TQpPsHVgyz+oQRdLJdynXjaLqj5IOZLBqTW06Tf1J4QIaKzlGN2Y1kvN4Q4IVMyZLSugICCXJ7+Z7vo4R0bkIdBHxH0rWqv2mdUJtt33ZEfho3gnt52Vk3zeDyeV1cPQMAjh/XGib9uy0ssNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4wb0lDK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744038113; x=1775574113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rhSATD/rKMtHYXDCE0o4Mbw5WsGF2rQbenLiBprMTa0=;
  b=a4wb0lDKKbQtzW0kDusCWhG/TGhM1QEYDQustfZngH1lGrRGhhSoYO0f
   wuXTvDXOHODGh9/0bpsAETMUpwCta6LlZ2P0fNtyf/pQmR9vHU+QNLsd0
   xPdNPh+cNRuXJXwCD+lGKzfha1N1T1OjVXnpeIJfzcto6rHFQ97exg10Y
   y2RRkC93drv1wvyyECmdzHTUwwYvrvIBToXrjr8UUE2t0qMoEGqu79apY
   EX+hVyou5CBdbRsM/vKRKOTc37SprAdRv8DOS9Nn5AqWPlMBlJlLD5KnL
   wnXDOJsyYYx2sYznb1RnLFG6782YJTS5pvgM6Kpp9x6OnkU8UWQb1Moi8
   A==;
X-CSE-ConnectionGUID: fD3fUz99TQGo3NvE9E/F6w==
X-CSE-MsgGUID: pBlNv9SXT+ihrhl6OPiBaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70805896"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="70805896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:01:52 -0700
X-CSE-ConnectionGUID: 5VLNdyYJQle5h2IJpNU5DQ==
X-CSE-MsgGUID: afOhJ7tASayu0qyv1q770Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132707010"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.245.196]) ([10.245.245.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:01:50 -0700
Message-ID: <53382877-076a-4bc4-8b70-e2f987b57f8a@intel.com>
Date: Mon, 7 Apr 2025 16:01:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
 <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
 <8ae9b377-5a2d-435f-8e29-ed393b984870@intel.com>
 <fee87af7-be0f-4bae-af1d-8c39923ec20b@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <fee87af7-be0f-4bae-af1d-8c39923ec20b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/04/2025 15:46, Christian König wrote:
> Am 07.04.25 um 16:44 schrieb Matthew Auld:
>> On 07/04/2025 15:32, Christian König wrote:
>>> Am 07.04.25 um 16:18 schrieb Matthew Auld:
>>>> The page_link lower bits of the first sg could contain something like
>>>> SG_END, if we are mapping a single VRAM page or contiguous blob which
>>>> fits into one sg entry. Rather pull out the struct page, and use that in
>>>> our check to know if we mapped struct pages vs VRAM.
>>>>
>>>> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org
>>>> Cc: <stable@vger.kernel.org> # v5.8+
>>>
>>> Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.
>>>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>> Were is patch #1 from this series?
>>
>> That one is xe specific:
>> https://lore.kernel.org/intel-xe/20250407141823.44504-3-matthew.auld@intel.com/T/#m4ef16e478cfc8853d4518448dd345a66d5a7f6d9
>>
>> I copied your approach with using page_link here, but with added sg_page().
> 
> Feel free to add my Acked-by to that one as well.

Thanks.

> 
> I just wanted to double check if we need to push the patches upstream together, but that looks like we can take each through individual branches.

Sounds good.

> 
> Thanks,
> Christian.
> 
>>
>>>
>>> Thanks,
>>> Christian.
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> index 9f627caedc3f..c9842a0e2a1c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>>>>                     struct sg_table *sgt,
>>>>                     enum dma_data_direction dir)
>>>>    {
>>>> -    if (sgt->sgl->page_link) {
>>>> +    if (sg_page(sgt->sgl)) {
>>>>            dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>>>>            sg_free_table(sgt);
>>>>            kfree(sgt);
>>>
>>
> 



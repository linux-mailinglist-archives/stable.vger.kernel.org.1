Return-Path: <stable+bounces-114660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27258A2F0F5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764AA1884B51
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9E1F8BBD;
	Mon, 10 Feb 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODE4SzYm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F091F8BDA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200179; cv=none; b=k4l2j5tu8hVQFSmeuI3cId18GORMXmAxRaf7Ad9j3/hm7ygcob9baMGRHAKYF7xvNPSFAM4r+iJJ3ma+aWTZyW2ceuQHRGN1/Wt40J+y1TL4286Sgk+Rj7MsuTdZ8fWc+3jvphCvB6eaAA1NZhMSeTPoWBDOoKtblG7nsMj7zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200179; c=relaxed/simple;
	bh=8xW1qpxGPuJbKIEKzYxe2Augwz9P+TJaMrcKdlv5Wp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+9SBrjkdW3wH17NNAV8DdjyIFkRhj3+Te6acNm9EQQ82X3vyGCDpYOq0UHt6fnHEVF8kjqrHkko6jZyoLQORPAz1Z+Vk+KfhnvLlMvIVINORme2HLNlvcqr74KoAx2O5Ux0W5dGKfNAfBgqgiaStpbbcI61YWa3vmivEToecJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODE4SzYm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739200178; x=1770736178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8xW1qpxGPuJbKIEKzYxe2Augwz9P+TJaMrcKdlv5Wp4=;
  b=ODE4SzYmKxboqdv+iYvFnZF34mtv+R8AE+8mCASeyMnPoKGU1ltu6bYj
   2zRsgH5Fyx3ejPEeUyFD21ALncM+C3v0WT2XN7hVYpCOOVWho5DbW4mVj
   bJttDzDlfXrgwWhiGQxowh7GzbsW54zgR/PtinaZ9+DYvgwMGam+oPXeX
   Ekh1Jr1Iz4h/CLEZa+N2mqzIEIhoMzwJD9TLIC2L+v3YbkM6RtNxnHirS
   tiLaczSUezvLsP9FWuS4HAd5yzTZcZSQbb4tdF8HasifT6f5TsZ4+690f
   ve1TzEc/cdwgXoxcuIAXwtspb/3XFU9yZPK98fkqVxen76lynJQXSQeI2
   g==;
X-CSE-ConnectionGUID: Q4ShGGcsSeywpspgfSUB7w==
X-CSE-MsgGUID: M1lN+PgbSIGj2eHYNPJRAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39652153"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39652153"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:09:37 -0800
X-CSE-ConnectionGUID: ooyx0ID0Re+uAbn+tjAfhg==
X-CSE-MsgGUID: LiZymh/ASxGtpPjBMNSIpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135474681"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.177.152]) ([10.245.177.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:09:35 -0800
Message-ID: <9c548c30-d95d-469f-af49-3b2b15886c31@linux.intel.com>
Date: Mon, 10 Feb 2025 16:09:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Carve out wopcm portion from the stolen memory
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 Nirmoy Das <nirmoy.das@intel.com>
Cc: intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>, stable@vger.kernel.org
References: <20250207164334.1393054-1-nirmoy.das@intel.com>
 <qx2azqvhrnpyhyag73mhddkje2s5rvb74uhcnx4fcd6sr6na4l@w45ubhrjcidt>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <qx2azqvhrnpyhyag73mhddkje2s5rvb74uhcnx4fcd6sr6na4l@w45ubhrjcidt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/7/2025 11:55 PM, Lucas De Marchi wrote:
> On Fri, Feb 07, 2025 at 05:43:34PM +0100, Nirmoy Das wrote:
>> Top of stolen memory is wopcm which shouldn't be accessed so remove
>> that portion of memory from the stolen memory.
>
> humn... we are already doing this for integrated. The copy & paste is
> small here to deserve a refactor, but maybe mention that this is already
> done for integrated and it was missed on the discrete side?
>
>>
>> Fixes: d8b52a02cb40 ("drm/xe: Implement stolen memory.")
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>
> I'd rather do this 6.11+. It's not important before that as we didn't
> have any platform out of force probe or close to be out of force probe.
>
> We will most likely not be able to apply this patch on 6.8.
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>> drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c | 54 ++++++++++++++------------
>> 1 file changed, 30 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>> index 423856cc18d4..d414421f8c13 100644
>> --- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>> +++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>> @@ -57,12 +57,35 @@ bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe)
>>     return GRAPHICS_VERx100(xe) < 1270 && !IS_DGFX(xe);
>> }
>>
>> +static u32 get_wopcm_size(struct xe_device *xe)
>> +{
>> +    u32 wopcm_size;
>> +    u64 val;
>> +
>> +    val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
>> +    val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
>> +
>> +    switch (val) {
>> +    case 0x5 ... 0x6:
>> +        val--;
>> +        fallthrough;
>> +    case 0x0 ... 0x3:
>> +        wopcm_size = (1U << val) * SZ_1M;
>> +        break;
>> +    default:
>> +        WARN(1, "Missing case wopcm_size=%llx\n", val);
>> +        wopcm_size = 0;
>> +    }
>> +
>> +    return wopcm_size;
>> +}
>
> Please also mention in the commit message the code movement here, that
> is done just for the function to be called by detect_bar2_dgfx()
>
> Other than that, Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Thanks Lucas, sent out a v2 with better commit message and stable tag with 6.11+.


Nirmoy

>
> thanks
> Lucas De Marchi
>
>> +
>> static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
>> {
>>     struct xe_tile *tile = xe_device_get_root_tile(xe);
>>     struct xe_mmio *mmio = xe_root_tile_mmio(xe);
>>     struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> -    u64 stolen_size;
>> +    u64 stolen_size, wopcm_size;
>>     u64 tile_offset;
>>     u64 tile_size;
>>
>> @@ -74,7 +97,13 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
>>     if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
>>         return 0;
>>
>> +    /* Carve out the top of DSM as it contains the reserved WOPCM region */
>> +    wopcm_size = get_wopcm_size(xe);
>> +    if (drm_WARN_ON(&xe->drm, !wopcm_size))
>> +        return 0;
>> +
>>     stolen_size = tile_size - mgr->stolen_base;
>> +    stolen_size -= wopcm_size;
>>
>>     /* Verify usage fits in the actual resource available */
>>     if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
>> @@ -89,29 +118,6 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
>>     return ALIGN_DOWN(stolen_size, SZ_1M);
>> }
>>
>> -static u32 get_wopcm_size(struct xe_device *xe)
>> -{
>> -    u32 wopcm_size;
>> -    u64 val;
>> -
>> -    val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
>> -    val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
>> -
>> -    switch (val) {
>> -    case 0x5 ... 0x6:
>> -        val--;
>> -        fallthrough;
>> -    case 0x0 ... 0x3:
>> -        wopcm_size = (1U << val) * SZ_1M;
>> -        break;
>> -    default:
>> -        WARN(1, "Missing case wopcm_size=%llx\n", val);
>> -        wopcm_size = 0;
>> -    }
>> -
>> -    return wopcm_size;
>> -}
>> -
>> static u32 detect_bar2_integrated(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
>> {
>>     struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> -- 
>> 2.46.0
>>


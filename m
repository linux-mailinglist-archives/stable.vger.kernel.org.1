Return-Path: <stable+bounces-76076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBE978043
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779E5284552
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B51DA0F3;
	Fri, 13 Sep 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwYV4hLv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA21D6DA0
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231244; cv=none; b=Szb0SfjeBvd0Myw8B69CnqENcDeR4TGBTSbqwt0+z2QMJGni+0jES1nEbuBTxPt2D+bLuQkgT7jYR8pYMmHe1jZMU2g/ojbEK96wvZauRiTsB8mGdHSIvz/84lKDxBHQbtCBJkl/LhZZPymSq3mRH+vdhtJwoRthgy6t2405w88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231244; c=relaxed/simple;
	bh=B3aQdvSJL5B7nHEuu2+nF/4cQ04xA9awR9QJAs+PRpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sucqc5ZIiSu9GNzUc/bOnaF0gIIW95rVvwewA6HbL/Ma7fbWYVHYfcf9Ht9/I+4PwxLuFk1ODyWTMNdvu4vs0ESniBZGyDdTiwJUJhGWmoVClczeAp+J5xtfAsqj28s9l+wgDcTFLOj1b3X9u9NLyG2rywS9WDOAqdaG52W0sOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwYV4hLv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726231243; x=1757767243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B3aQdvSJL5B7nHEuu2+nF/4cQ04xA9awR9QJAs+PRpM=;
  b=YwYV4hLv5uJPAd+iZ6tQmiMOY8/A1PzHDXDGUAYKATC0pfkz8XZ3HtpB
   qlfiS3VfSVqo959BLImiQShkmufWlS1xhGuQEzN0J6FKTcNuGM1kyQ/ha
   rkLkxkUdhOecNeuymq2L7ASpssINbXYFUVDX3ZDHR8yT9gmK4K4t1LJqg
   PaoYqzW4e7GS+el/jats8j1Y9TliZleCzWm++8QVKmelG60sTUy5RFD9i
   BcRXf1t30b+v8WDeg/Qszt0wURrhyPY//KAIWLjbmL2y7i2m8DJFQ8cF1
   xPTYF961kvKLBA4/WVIerpm02ma4bZXkQw1EMyogFe61CEoO99gDCi+rv
   w==;
X-CSE-ConnectionGUID: b9zils3aTxeWRo1+Z/LC5Q==
X-CSE-MsgGUID: z0dIqKcYQBCNPBlbP0h/pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28908936"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28908936"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:40:39 -0700
X-CSE-ConnectionGUID: V/9kW3zpRzOy0bQcM9Awgw==
X-CSE-MsgGUID: GEuB+SGcTJ+h6Jp0yh/r5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67901611"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.245.158]) ([10.245.245.158])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:40:37 -0700
Message-ID: <8499dae2-e570-43f5-bd7c-388bb18b0b50@intel.com>
Date: Fri, 13 Sep 2024 13:40:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
To: Andi Shyti <andi.shyti@kernel.org>
Cc: intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org
References: <20240913120023.310565-2-matthew.auld@intel.com>
 <bcgfdjrp5jvkckdgsqpr26bnvkduvxnw7eliudh47uli6jerxl@frgpwy66hsdq>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <bcgfdjrp5jvkckdgsqpr26bnvkduvxnw7eliudh47uli6jerxl@frgpwy66hsdq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 13/09/2024 13:35, Andi Shyti wrote:
> Hi Matt,
> 
> On Fri, Sep 13, 2024 at 01:00:24PM GMT, Matthew Auld wrote:
>> Spec says SW is expected to round up to the nearest 128K, if not already
>> aligned for the CC unit view of CCS. We are seeing the assert sometimes
>> pop on BMG to tell us that there is a hole between GSM and CCS, as well
>> as popping other asserts with having a vram size with strange alignment,
>> which is likely caused by misaligned offset here.
>>
>> BSpec: 68023
>> Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.10+
>> ---
> 
> and... what is the difference between v1 and v2? :-)

I sent wrong version. Just a tiny tweak to commit message to reference 
"CC unit view of CCS" which I didn't feel was worth a changelog.

> 
> Andi
> 
>>   drivers/gpu/drm/xe/xe_vram.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
>> index 7e765b1499b1..8e65cb4cc477 100644
>> --- a/drivers/gpu/drm/xe/xe_vram.c
>> +++ b/drivers/gpu/drm/xe/xe_vram.c
>> @@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
>>   
>>   		offset = offset_hi << 32; /* HW view bits 39:32 */
>>   		offset |= offset_lo << 6; /* HW view bits 31:6 */
>> +		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
>>   		offset *= num_enabled; /* convert to SW view */
>>   
>>   		/* We don't expect any holes */
>> -- 
>> 2.46.0
>>


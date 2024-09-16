Return-Path: <stable+bounces-76193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB4A979CD0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FD728187C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463033770C;
	Mon, 16 Sep 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1yEY1GZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24471B963
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475569; cv=none; b=gHjvMZb9sgd1/kKqwfvoyNQEoE3fIA3el0FWmbjNYZfq5oMgVR1ODA3riZPPE+EwZoEKPMVytMa7a9qM/Amzik4YjR0CSC4nuCyMnVJJ+n8XM5npGC7i7euHk32qF/zbQV1ddMSDmVxZv2AVtO2LpC3mKhrc/8IMJEutOp7j0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475569; c=relaxed/simple;
	bh=cawxThfV/IQb/orQmuNfsIQsJ3BJ3z2tijWShK03/hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcqYwn7qoXXQ0c68xAZtcU7uQsfTkDLrSynuq1fH5U2sc/FUqKELWQaKp9PsdHYSAkydfRywt1+f0Q/dtR1TL+wdfcXABz2LDMcSv6NhDA6BR1b61ZUXO2Rpk0t40aNQEknzERoCPwKoa6Tq1DDdmVhvfKohj3/FDYxdWbCdeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1yEY1GZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726475568; x=1758011568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cawxThfV/IQb/orQmuNfsIQsJ3BJ3z2tijWShK03/hc=;
  b=X1yEY1GZQbrFMgxn6OzbxDRX1U673jgT4X7XahZuJRZFI3ENYs3JPF1r
   b5okIirFotBEWiqdm4A/4C+9Zg2fUfDW7/xdJQdPPro+PbhtPBqUht82e
   ZZSLkahGpdEQRWbpLg/go+aucIQuM+g9QE3ByDKO7SAH2X5BP9aAjGUlO
   NcmjIoTDyPacJk1RttK9XNqFB3fownGN2H6RpY+EF2XJTpJ0+Rx5aUqDF
   DNaH/mmh5oqA7s7h009s8N/7hv+9UMrDcW7DOoZShc1HmgU371S/1x29V
   aPUS70ODK+dTpvZ2LIn/F9VOf22L322et541/FetU/Leo0LZLAdGxM7dx
   g==;
X-CSE-ConnectionGUID: sORnDHWETUeFtkMWo3ZVxA==
X-CSE-MsgGUID: Cd0tl512T1WZcX96pxiY2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25167314"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="25167314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:32:45 -0700
X-CSE-ConnectionGUID: lMVOptgJR5STSwtwFi2yBQ==
X-CSE-MsgGUID: ge20VHTdTr+m74cBhVXgyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="68500622"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO [10.245.244.77]) ([10.245.244.77])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:32:42 -0700
Message-ID: <b6b402ca-243c-4d0d-af54-b20ac39b9ee9@intel.com>
Date: Mon, 16 Sep 2024 09:32:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
 "Jahagirdar, Akshata" <akshata.jahagirdar@intel.com>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240913120023.310565-2-matthew.auld@intel.com>
 <DM4PR11MB54565C34141FA293E75209E7EA662@DM4PR11MB5456.namprd11.prod.outlook.com>
 <DM4PR11MB5456F540B3D043C896C4773EEA662@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <DM4PR11MB5456F540B3D043C896C4773EEA662@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2024 00:29, Lin, Shuicheng wrote:
>>> Spec says SW is expected to round up to the nearest 128K, if not
>>> already aligned for the CC unit view of CCS. We are seeing the assert
>>> sometimes pop on BMG to tell us that there is a hole between GSM and
>>> CCS, as well as popping other asserts with having a vram size with
>>> strange alignment, which is likely caused by misaligned offset here.
>>>
>>> BSpec: 68023
>>> Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for
>>> vram")
>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>>> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>>> Cc: Matt Roper <matthew.d.roper@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.10+
>>> ---
>>>   drivers/gpu/drm/xe/xe_vram.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_vram.c
>>> b/drivers/gpu/drm/xe/xe_vram.c index
>>> 7e765b1499b1..8e65cb4cc477 100644
>>> --- a/drivers/gpu/drm/xe/xe_vram.c
>>> +++ b/drivers/gpu/drm/xe/xe_vram.c
>>> @@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt
>>> *gt, u64
>>> tile_size)
>>>
>>>   		offset = offset_hi << 32; /* HW view bits 39:32 */
>>>   		offset |= offset_lo << 6; /* HW view bits 31:6 */
>>> +		offset = round_up(offset, SZ_128K); /* SW must round up to
>>> nearest
>>> +128K */
>>>   		offset *= num_enabled; /* convert to SW view */
> f> >
>>>   		/* We don't expect any holes */
>>> --
>>> 2.46.0
>>
>> The patch works in my platform.
>> Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
> The round up should be applied to the SW address. So, the right sequence should be as below:
>    		offset *= num_enabled; /* convert to SW view */
> +		offset = round_up(offset, SZ_128K); /* SW must round up to nearest +128K */
> 
> I applied the patch manually and didn't notice the sequence difference. With upper sequence, the patch could fix the misaligned offset issue.

Ok, will move this. Thanks for testing.


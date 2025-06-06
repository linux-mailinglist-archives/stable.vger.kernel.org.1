Return-Path: <stable+bounces-151611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD077AD0134
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 13:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9644175187
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11052868B3;
	Fri,  6 Jun 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVTD/zRR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980508C11
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209315; cv=none; b=qxQugJ5/Iz4b1VTO2+9iz8W1w0XbqZq8OsTzy1gRHfBS2opokSvrUPtwjTj9RcBUBx9Lm5C6SRAEKVgu4VaQoHkjQ39N2JxMMSK8aMZGwE8sdrWG9GKHxdTuRxhpZl2vIuK6aYSHnxHw9p7yMs8ZHhvC3FmgMdo41mVJTUKyGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209315; c=relaxed/simple;
	bh=DtFK5ntKMEALrzQWYhRC0IWxybREtrqJzzoC0C7hIMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s56vd8iJ8DDR71TtW04h6NnkeMOE+FwKEZDLrP93Rg8CbvQecJ7tMNR5kS3DfEKhtuq3l2CmLZy04NLTutnyyXiKNKMrgIKF/oF51W9s84AqOOzJEA6ALb+BGBl/FuCrxId0uc19+ly0VLBbysEzm6lj1vrWH7hwAcd3lXpSLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVTD/zRR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749209313; x=1780745313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DtFK5ntKMEALrzQWYhRC0IWxybREtrqJzzoC0C7hIMY=;
  b=lVTD/zRRYq1MknI8ysz5E1ytjTAZk7ItHxl3Mz2g1fjgxGrPxzgYscVM
   Zd9n/Zv2g/VRalXpByHDB1Gnz8LQPFPq/apM8g7wJvRjYLV5p1uGy/X8s
   m8i6/ejtqor1uSboai2WQ+GafUBqeeYiRKuUpElwIb+lxjLcxG2+bToEX
   mFxGIf9c5FBRLcZPhBiWw8L5MbomDpY5+k7j3W2PfsOT8kpA+pxV2qJoJ
   bZ/ROgU7yFknjmD+BXDjlInhmmOft6kOe7HnOaJuTfJDMpCGNZMQVbNFo
   i+2LoknLhcdJ5S7WtlBlLt+LkWehUIeJrhE+ybCN7UR4Xru/y15KKPIxS
   g==;
X-CSE-ConnectionGUID: IIl6dERsSB25RXFb2TKscg==
X-CSE-MsgGUID: TWWYEFNaRMqVfJ2XHeArgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="61623253"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="61623253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 04:28:33 -0700
X-CSE-ConnectionGUID: mK7iyTD3Rhqgc9ob27PU4w==
X-CSE-MsgGUID: 2SCbEDX6TpeUqcEamVTvdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="176674094"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.52]) ([10.245.245.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 04:28:31 -0700
Message-ID: <6fd6d5cc-9f89-4949-82d4-0f3a55f687af@intel.com>
Date: Fri, 6 Jun 2025 12:28:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/bmg: fix compressed VRAM handling
To: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Jahagirdar, Akshata" <akshata.jahagirdar@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250604181511.1629551-2-matthew.auld@intel.com>
 <CH0PR11MB5444A5B91EBE395713970E41E56CA@CH0PR11MB5444.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <CH0PR11MB5444A5B91EBE395713970E41E56CA@CH0PR11MB5444.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/06/2025 19:21, Cavitt, Jonathan wrote:
> -----Original Message-----
> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Matthew Auld
> Sent: Wednesday, June 4, 2025 11:15 AM
> To: intel-xe@lists.freedesktop.org
> Cc: Ghimiray, Himal Prasad <himal.prasad.ghimiray@intel.com>; Thomas Hellström <thomas.hellstrom@linux.intel.com>; Jahagirdar, Akshata <akshata.jahagirdar@intel.com>; stable@vger.kernel.org
> Subject: [PATCH] drm/xe/bmg: fix compressed VRAM handling
>>
>> There looks to be an issue in our compression handling when the BO pages
>> are very fragmented, where we choose to skip the identity map and
>> instead fall back to emitting the PTEs by hand when migrating memory,
>> such that we can hopefully do more work per blit operation. However in
>> such a case we need to ensure the src PTEs are correctly tagged with a
>> compression enabled PAT index on dgpu xe2+, otherwise the copy will
>> simply treat the src memory as uncompressed, leading to corruption if
>> the memory was compressed by the user.
>>
>> To fix this it looks like we can pass use_comp_pat into emit_pte() on
>> the src side.
> 
> It would be better if we had more confidence here beyond "it looks like"
> (maybe just drop that part) and "There looks to be" (maybe "There is" instead),
> but if we're not comfortable making definitive statements about our compression
> handling, then I won't block this on some minor passive voice issues.

Yeah, this was only really based on code inspection, so unclear if this 
was even a real issue, or whether this is even related to the user 
report. But once more certain of either, will update the commit message.

> Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>

Thanks.

> -Jonathan Cavitt
> 
>>
>> There are reports of VRAM corruption in some heavy user workloads, which
>> might be related: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4495
>>
>> Fixes: 523f191cc0c7 ("drm/xe/xe_migrate: Handle migration logic for xe2+ dgfx")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.12+
>> ---
>>   drivers/gpu/drm/xe/xe_migrate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>> index 8f8e9fdfb2a8..16788ecf924a 100644
>> --- a/drivers/gpu/drm/xe/xe_migrate.c
>> +++ b/drivers/gpu/drm/xe/xe_migrate.c
>> @@ -863,7 +863,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
>>   		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
>>   			xe_res_next(&src_it, src_L0);
>>   		else
>> -			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs,
>> +			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
>>   				 &src_it, src_L0, src);
>>   
>>   		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
>> -- 
>> 2.49.0
>>
>>



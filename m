Return-Path: <stable+bounces-127297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78480A776C9
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2285A188D4C0
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD21EB9E3;
	Tue,  1 Apr 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtcW2qJm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA71EB9FF
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497205; cv=none; b=C5hghW5lxVIDSzW4p4le7PdXwEvOonfmZeB7YjrFAnLI9sQJBqng0UZC7SbcWGcnrcYHGlqAP0zzXOj6KPrfSQrfJBFk21fVwgaDJwtgHMNlW0DPvzhV86zofanPI5oodJRSBIUXa5g5dX/B31PGzFp+7hC0ocMJerIB5ZBCxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497205; c=relaxed/simple;
	bh=PsGkjwijO7QZJn7Tb41UnkWLgAytQqDzIVDErOmndxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AahFUApmSQuHdkJFGVA9fOAYb/22VDYypN5Lk9oaDWpDYtSp144J0tv6BQHoZXuyPte+LCupoYlhO/GBlXeuBA7r3srJVEw5ugRa1ipWIDBzr+PuLj8VmtoT0x3t7FSawfbh9sjYwGu53tSUM+CY2PKZh0+BHODDwjGDI+t2ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtcW2qJm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743497204; x=1775033204;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PsGkjwijO7QZJn7Tb41UnkWLgAytQqDzIVDErOmndxE=;
  b=XtcW2qJmhPnwmwMoHBhpbufymIrLZGLPt9DQLlZdsoRxhk3s+MTUdw3R
   8OO1kcJ7+xfL6AnkW5nmy2YV6rvGHYkthWtx+h70h05T/OEUVTGLBDZOt
   5llGb8kzGw0VI5kamf4VDsdXT4Vv587bjSKN9z1Ciw0Vo3gxRnIXs6mR8
   XaoVxlGBcZfiyHha++nb7nt3GMXqXw6gFfiLIZbS1CBli66+kBgrp5XAN
   5dGR0tvuXcCi5VR3FCfUtjskzgD4ikHp9gqpbPC9fsiAnXsVnrolvE1xA
   vpTWyTqPbSV1J6jjwA0odMH00Q9MFoXH9YWnntlD+Ob3vmQZaovr3WXCT
   Q==;
X-CSE-ConnectionGUID: mKUatddrS/2dEIACJWo4KQ==
X-CSE-MsgGUID: 9TuZ2+LVQgWTUp0hMg+e0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44522765"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44522765"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 01:46:43 -0700
X-CSE-ConnectionGUID: ktFo+2eeRGaQq03HgzqcFA==
X-CSE-MsgGUID: 5nS/a4vKTqKtV1fSTywAcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="157253689"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 01:46:41 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, Kees Cook <kees@kernel.org>, Nicolas
 Chauvet <kwizart@gmail.com>, Damian Tometzki <damian@riscv-rocks.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix unterminated-string-initialization
 warning
In-Reply-To: <Z-la1kFHvH4zu_X5@dell-wzy>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250327124739.2609656-1-jani.nikula@intel.com>
 <Z-la1kFHvH4zu_X5@dell-wzy>
Date: Tue, 01 Apr 2025 11:46:37 +0300
Message-ID: <87bjtg46c2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 30 Mar 2025, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
> On Thu, Mar 27, 2025 at 02:47:39PM +0200, Jani Nikula wrote:
>> Initializing const char opregion_signature[16] = OPREGION_SIGNATURE
>> (which is "IntelGraphicsMem") drops the NUL termination of the
>> string. This is intentional, but the compiler doesn't know this.
>>
>
> Indeed...
>
>> Switch to initializing header->signature directly from the string
>> litaral, with sizeof destination rather than source. We don't treat the
>> signature as a string other than for initialization; it's really just a
>> blob of binary data.
>> 
>> Add a static assert for good measure to cross-check the sizes.
>> 
>> Reported-by: Kees Cook <kees@kernel.org>
>> Closes: https://lore.kernel.org/r/20250310222355.work.417-kees@kernel.org
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13934
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Tested-by: Damian Tometzki <damian@riscv-rocks.de>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>
> Reviewed-by: Zhenyu Wang <zhenyuw.linux@gmail.com>

Thanks for the review, pushed to din.

BR,
Jani.

>
>>  drivers/gpu/drm/i915/gvt/opregion.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
>> index 509f9ccae3a9..dbad4d853d3a 100644
>> --- a/drivers/gpu/drm/i915/gvt/opregion.c
>> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
>> @@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>>  	u8 *buf;
>>  	struct opregion_header *header;
>>  	struct vbt v;
>> -	const char opregion_signature[16] = OPREGION_SIGNATURE;
>>  
>>  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>>  	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
>> @@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>>  	/* emulated opregion with VBT mailbox only */
>>  	buf = (u8 *)vgpu_opregion(vgpu)->va;
>>  	header = (struct opregion_header *)buf;
>> -	memcpy(header->signature, opregion_signature,
>> -	       sizeof(opregion_signature));
>> +
>> +	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
>> +	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
>> +
>>  	header->size = 0x8;
>>  	header->opregion_ver = 0x02000000;
>>  	header->mboxes = MBOX_VBT;
>> -- 
>> 2.39.5
>> 

-- 
Jani Nikula, Intel


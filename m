Return-Path: <stable+bounces-169523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D1B261E0
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA71621DA
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CA72E9EB4;
	Thu, 14 Aug 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fqz4zLPp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F01367
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166127; cv=none; b=hcH2iWkKW2eZ6M6PXOBzDbdnOfE1ogh3EOckDVs7UwRus+r273srj6tSFAlBjJAVgZDPWoU+6nZrQyuXfdv8u0GAzj1cI+bxIbJrmPrY/d+T5BFs1R9ijwJIraP9ep15pui0s0IutXpGsaMgd9xd2Vee5gREZwKbrlkqf5Bhxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166127; c=relaxed/simple;
	bh=ttbDN4ZOU3yZqgR60ZF4HJpMsvIafyaDjgxNW14kxp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3Gs63OQ2btThgu+4+n+nULc5+2B4uUe2ASXS06iwROIUlfnPOxyxhAZ/U0PI8BwMbZFXOrneEbX1azkN2CalnAjnkoZjPDLlW5MRphugO/ZbTxlHe7giouV+hS11IHOE7QA1uQlrwp0l9Y1CVcV9Y9RvucUaU98MXAAd/gqw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fqz4zLPp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755166126; x=1786702126;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ttbDN4ZOU3yZqgR60ZF4HJpMsvIafyaDjgxNW14kxp8=;
  b=Fqz4zLPp5gwb0vqUe5oPbQvh/FKw92PWrQF1X51EYp0alsF5fWLvhz8q
   Q0eZCPMuWIBXKBAd2Bx0JYxPIQ84cZ6sR+NKhSUa6qrzhkLS1EpRCOa5N
   tPHTIDcYf1cLrI2b5fSSZa650GoO82q5FT4GbPb30GkwOcmxOQIhhAY7E
   wOcr38igN1CrqWVq7S0fS1u2y2B6g5AgxdyH+T93aD6pwSfcjH+vJtWn9
   dwz4gcLWrp+zUJL2nEECse8bHVSkPvOZOEyYqQXTU13zSX8Xq/VGIP5MT
   4OXapwGjTxSCo+7M3nrgC5wa8EfjFe7lbYVE/BQkvfGuaXjz8SG/Xd5ij
   A==;
X-CSE-ConnectionGUID: 7r9p9b3VSrO3tjLipANxOg==
X-CSE-MsgGUID: XM9ZMD1QTYCV/IlkGmwwyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57194166"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57194166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 03:08:45 -0700
X-CSE-ConnectionGUID: YGJRew6NSIy5r3+axtXnFw==
X-CSE-MsgGUID: pYa5Aq4dRmq64KXV7jPwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166360384"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.100])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 03:08:44 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Jason@zx2c4.com"
 <Jason@zx2c4.com>
Subject: Re: [PATCH] drm/i915: silence rpm wakeref asserts on
 GEN11_GU_MISC_IIR access
In-Reply-To: <fbb92a6aad7452188396136faced103614519e98.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250805115656.832235-1-jani.nikula@intel.com>
 <fbb92a6aad7452188396136faced103614519e98.camel@intel.com>
Date: Thu, 14 Aug 2025 13:08:40 +0300
Message-ID: <edd962e40182456ef068f306023d73f045d729ca@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025, "Hogander, Jouni" <jouni.hogander@intel.com> wrote:
> On Tue, 2025-08-05 at 14:56 +0300, Jani Nikula wrote:
>> Commit 8d9908e8fe9c ("drm/i915/display: remove small micro-
>> optimizations
>> in irq handling") not only removed the optimizations, it also enabled
>> wakeref asserts for the GEN11_GU_MISC_IIR access. Silence the asserts
>> by
>> wrapping the access inside
>> intel_display_rpm_assert_{block,unblock}().
>>=20
>> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Closes: https://lore.kernel.org/r/aG0tWkfmxWtxl_xc@zx2c4.com
>> Fixes: 8d9908e8fe9c ("drm/i915/display: remove small micro-
>> optimizations in irq handling")
>> Cc: <stable@vger.kernel.org> # v6.13+
>> Suggested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Jouni H=C3=B6gander <jouni.hogander@intel.com>

Thanks, pushed to din.

BR,
Jani.

>
>> ---
>> =C2=A0drivers/gpu/drm/i915/display/intel_display_irq.c | 4 ++++
>> =C2=A01 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c
>> b/drivers/gpu/drm/i915/display/intel_display_irq.c
>> index fb25ec8adae3..68157f177b6a 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display_irq.c
>> +++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
>> @@ -1506,10 +1506,14 @@ u32 gen11_gu_misc_irq_ack(struct
>> intel_display *display, const u32 master_ctl)
>> =C2=A0	if (!(master_ctl & GEN11_GU_MISC_IRQ))
>> =C2=A0		return 0;
>> =C2=A0
>> +	intel_display_rpm_assert_block(display);
>> +
>> =C2=A0	iir =3D intel_de_read(display, GEN11_GU_MISC_IIR);
>> =C2=A0	if (likely(iir))
>> =C2=A0		intel_de_write(display, GEN11_GU_MISC_IIR, iir);
>> =C2=A0
>> +	intel_display_rpm_assert_unblock(display);
>> +
>> =C2=A0	return iir;
>> =C2=A0}
>> =C2=A0
>

--=20
Jani Nikula, Intel


Return-Path: <stable+bounces-249522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKTDFKc8DGp8aQUAu9opvQ
	(envelope-from <stable+bounces-249522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45B57C53B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E36030400A0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4227481A80;
	Tue, 19 May 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZewBbeZU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3A481660
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185246; cv=none; b=vF3wCRInKm9PP7CrzZ/c/gwEoUSvVNczjbwfEE0x1O93WqUhQkYm8o2BjuMwrY/7jCoxkkLAwBKtnBMntVQ+412lWPG/8gcbBVyYA3bxCjTeDI8yXg7I10nHXUSdYACVWGBBm1sjL+03/IC4+iz2JiCTeYEgF7w+Vzxe3mMzhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185246; c=relaxed/simple;
	bh=tJKyOO4VfZJZZx2TNPYjiq75o/ggCQn5QI69/5uhi5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qNR8TZ/UG4cQLxTRtBAGfLFEVhIbPS/5mv8XoXAX+4t158YbTZUN4jG1Vco4vwUFudiRn+xU80ZBSilPFur8jbl8NTmuMvM2Zkc0wzhwxcYguwEqtuK4VjWTnEjlPJfHtAbS5aIojpaAXdtgNUutzS0QlE1WyUaXkbuXGvhyPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZewBbeZU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779185245; x=1810721245;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=tJKyOO4VfZJZZx2TNPYjiq75o/ggCQn5QI69/5uhi5o=;
  b=ZewBbeZU6Pswu1xvvp3wHNeCuViKRXFYHNQBmsAaYo/wrfUY/1fFzaUQ
   4p/tth+1VVHGlZhds4RPUtFFjcXMxsPi9V5f1FjCcTdmdlZTV6lohNAv4
   AigNOUGhY36ENg33BAQYF+Z0EDTA2o0niKwMUPjhtFzOa0TsDSTK6FwBN
   mfVe0EK7+iStgGFDXgERLyGN4upiBa775A5G5uK3OPxdEq6jCC026IhFW
   3WKDfQGnrs75DVkXyn6pwseTupqiHf3/5wCwL3SuMoKKvrBokN2YueU7x
   79019lwQJnSr917KMOZmZIkH2Z9K9cp+4huGhQMlKdTg3mbZ1ly/dk0uC
   Q==;
X-CSE-ConnectionGUID: i4btc47KR6WyE0RoLgJpEg==
X-CSE-MsgGUID: 6Kr4uO4eQGeW4jUHBAxg8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91162564"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91162564"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:07:24 -0700
X-CSE-ConnectionGUID: Cp4vG1DCQIK+oiU3/dzTvw==
X-CSE-MsgGUID: xQfic02cRk6wjwYLa8o4Ig==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:07:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Pranay Samala <pranay.samala@intel.com>, intel-gfx@lists.freedesktop.org
Cc: karthik.b.s@intel.com, sameer.lattannavar@intel.com,
 pranay.samala@intel.com, stable@vger.kernel.org, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH] drm/i915/color: Fix HDR pre-CSC LUT programming loop
In-Reply-To: <20260519075245.383864-1-pranay.samala@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519075245.383864-1-pranay.samala@intel.com>
Date: Tue, 19 May 2026 13:07:18 +0300
Message-ID: <ff124be8331d2c720c6369d85316fc95a325437c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-249522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 5C45B57C53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026, Pranay Samala <pranay.samala@intel.com> wrote:
> The integer lut programming loop never executes completely due to
> incorrect condition (i++ > 130).
>
> Fix to properly program 129th+ entries for values > 1.0.
>
> Cc: <stable@vger.kernel.org> #v6.19
> Fixes: 82caa1c8813f ("drm/i915/color: Program Pre-CSC registers")
> Signed-off-by: Pranay Samala <pranay.samala@intel.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>

Okay, so this is a stable worthy fix, first sent 2=C2=BD months ago [1], and
we're still tossing it around? Folks, there needs to be more urgency
with obvious fixes like this.

I see this was sent separately to intel-gfx and intel-xe [2] lists. The
way to go is to just cross-post it. (Don't send it again, but do check
the CI results for both.)


BR,
Jani.


[1] https://lore.kernel.org/r/20260306165307.3233194-6-chaitanya.kumar.bora=
h@intel.com
[2] https://lore.kernel.org/r/20260519075308.383877-1-pranay.samala@intel.c=
om


> ---
>  drivers/gpu/drm/i915/display/intel_color.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm=
/i915/display/intel_color.c
> index 2d318e922671..3bfe09d81a4c 100644
> --- a/drivers/gpu/drm/i915/display/intel_color.c
> +++ b/drivers/gpu/drm/i915/display/intel_color.c
> @@ -3976,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *d=
sb,
>  				intel_de_write_dsb(display, dsb,
>  						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
>  						   (1 << 24));
> -			} while (i++ > 130);
> +			} while (i++ < 130);
>  		} else {
>  			for (i =3D 0; i < lut_size; i++) {
>  				u32 v =3D (i * ((1 << 24) - 1)) / (lut_size - 1);

--=20
Jani Nikula, Intel


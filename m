Return-Path: <stable+bounces-146073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3DAC0A3F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DDA1887BA0
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668323A9AB;
	Thu, 22 May 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHM0593w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D051A23A6
	for <stable@vger.kernel.org>; Thu, 22 May 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911746; cv=none; b=SSLruU63DaUO2Im/wz3vTHKrVwOA7i5PfXy5Oj4JwK1WhaC2ZLGb4GzHN3l8r4xFo4dy4PncOP1iZVBdaFwKuorMMELLRrZCRGWK9pIsTgDwCDzufV4Y0Dv4rwhkyL8ILy08izoTgXRaMUMk/3rrNaigspbEgye2HrsRW1kccGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911746; c=relaxed/simple;
	bh=tmguASBkmvy1X8vf7OH+HA6E0Ma7HhaEFYbHMjf21jE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JbmBRU8BgahmDZy94/Xogx3oVD2p7jIfqKeCebx07UtUU30NHUsyMN6poCYhIhRwo3RbEkdQdoZjzWIpOgiwThmyqSG4Od/29hfvd2Duc8w0XZPqpNMnHehnmYQ4UejURlawqRKxqvsu53NjZcwbZsjh87kQFqiWxHOJetg4miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHM0593w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747911745; x=1779447745;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=tmguASBkmvy1X8vf7OH+HA6E0Ma7HhaEFYbHMjf21jE=;
  b=OHM0593wGq2aPeQwCLgWWPec6n6KrSumqx650bBqc9Z5Iaa8bumFui3V
   0RhwUltJJqUfb8kPmCohkUgGzTEUuGWlq5lnWJc7aG1qUHNuKCjgFt3Pq
   AbaVgQKGHyH/7LkdmSGAD9RK0WqzbIdAhVZz20TrHoh63zvoaccDTPi9+
   qK3xFzcYk8De89hAdtE3NDfzDRghYwAASg7ADsKHP1/NFFm2wuozG43iS
   0xN2QFZXO595K4/q2Mnt4GpiOqBUeVLiG+VeyYa/zlSvqZ651eGw5hcrg
   UonHDSrKPYIAj+/OgmsREFxp/OHL7Ncap5LGmQOC4ZWFZOQ809jByAEDX
   w==;
X-CSE-ConnectionGUID: 2Gd+SJouQXqXF47miUbtXg==
X-CSE-MsgGUID: Y4FB5fsvS3uNNfqnUsxeiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67487027"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="67487027"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:02:10 -0700
X-CSE-ConnectionGUID: FN/O0HOBTIWdnXIg1jkvkA==
X-CSE-MsgGUID: OfbRVKFPRUyuZ7bOEkC/Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140616926"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:02:07 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
References: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org, Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>, Matthew Auld <matthew.auld@intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Date: Thu, 22 May 2025 14:02:04 +0300
Message-ID: <174791172419.46844.6949522430334944164@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f

Quoting Joonas Lahtinen (2025-05-22 09:41:27)
> This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.
>=20
> The IS_DGFX check was put in place because error capture of buffer
> objects is expected to be broken on devices with VRAM.
>=20
> We seem to have already submitted the userspace fix to remove that
> flag, so lets just rely on that for DG1.

Further, it seems that the userspace fix[1] has already been pushed and
released as part of media-driver 25.2.3, so really no reason to unblock
the broken codepath.

[1] https://github.com/intel/media-driver/commit/93c07d9b4b96a78bab21f6acd4=
eb863f4313ea4a

Regards, Joonas

>=20
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu=
/drm/i915/gem/i915_gem_execbuffer.c
> index 7d44aadcd5a5..02c59808cbe4 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer =
*eb)
>                         continue;
> =20
>                 if (i915_gem_context_is_recoverable(eb->gem_context) &&
> -                   GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> +                   (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > I=
P_VER(12, 0)))
>                         return -EINVAL;
> =20
>                 for_each_batch_create_order(eb, j) {
> --=20
> 2.49.0
>


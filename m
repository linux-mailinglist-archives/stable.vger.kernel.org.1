Return-Path: <stable+bounces-159134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B0AEF557
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CFB4A3CE0
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A5B26F445;
	Tue,  1 Jul 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muqR9yG8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9626A0FC;
	Tue,  1 Jul 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366533; cv=none; b=Vs0f/QsLYdy/Krda7br+hwgHgzmKyxmXBPe2EQ6GOPOLoi8NLDzXgs/vd6bgdLQapQEfvk8DFeS65sOPl3tG9BEZ6tYMVcjZ5sl7uVdcyyCIwWrbyZ6gVNsh6L6JPVTAaA61fCEKKMyzit+g8HPPl6TkMM4y9gYrjsWE4cMhVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366533; c=relaxed/simple;
	bh=QYOItan62HYv9O4lGIDnu60/liPxAvZrr1WMtny4nzY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=tqjKl/8JjRc1v8w9scU/KpyRVAobeIVcHkEUxT8KV5lYeeg+qQayLtLAne7axxgoODkSxk1TSd3v+gLYmY4gCb/fpNU3KVqkiGKRFDZOsx/126zF+aBQSPxIn0CH4tzySIBRbZBhUl9a/g0C7V4MpekMjmMz4aCKN3r3E1sfpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muqR9yG8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751366531; x=1782902531;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=QYOItan62HYv9O4lGIDnu60/liPxAvZrr1WMtny4nzY=;
  b=muqR9yG8TBAbqg271PmpbtfLUJRbtx0byn0TTscISJX3B5bKanFAEM/3
   DfBriirERWU0yyEA3SXA7K8NwXYyLRs1r0+4jehW5klEeimJhEh3KX+9C
   GCfmhl9GnhwlNf70zZsASsF4QHIyn4MjSNuTqtxsjLnp6ET+mHsojyBDH
   iqGudf48HxZ1DALuWCBP/ck/0Y2aiPv5mW3rQtwxBrDwGAP4MutbNT1rD
   tfPBw7SFXTSmKqaCW2i45GqPG0rdQyjKiOIJXO9z93ZpnCmW7BkSKTgT7
   ZFq+CIEQpmIgb8o1hmZiWsxvFTeuNHvH0BG0etnb85bWHQCsTjCSYH3N5
   A==;
X-CSE-ConnectionGUID: ti8lTiFMQbaP21NO5VNetw==
X-CSE-MsgGUID: s/mHGmQIQ9+v5UMu9PMxbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64678934"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64678934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 03:42:11 -0700
X-CSE-ConnectionGUID: lTZQofz/RpeePrUDcyVUwQ==
X-CSE-MsgGUID: pDnQWFaUSNOQzX0s4F8A0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184778799"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 03:42:08 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2025063043-down-countable-2999@gregkh>
References: <2025063043-down-countable-2999@gregkh>
Subject: Re: Patch "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1" has been added to the 6.1-stable tree
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
To: andi.shyti@kernel.org, andi.shyti@linux.intel.com, gregkh@linuxfoundation.org, matthew.auld@intel.com, thomas.hellstrom@linux.intel.com, ville.syrjala@linux.intel.com, sashal@kernel.org
Date: Tue, 01 Jul 2025 13:42:05 +0300
Message-ID: <175136652541.22602.12580210971758725103@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f

Hi Greg,

Please do note that there is a revert for this patch that was part of
the same pull request. That needs to be picked in too in case you are
picking the original patch.

I already got the automated mails from Sasha that both the original commit
and revert were already picked into 6.1, 6.6 and 6.12 trees. Are now in
a perpetual machinery induced loop where the original commit and revert will
be picked in alternating fashion to the stable trees? [1]

Regards, Joonas

[1] Originally, I was under the assumption stable machinery would
automatically skip over patches that have later been reverted, but
that doesn't seem to be the case?

Quoting gregkh@linuxfoundation.org (2025-06-30 14:39:44)
>=20
> This is a note to let you know that I've just added the patch titled
>=20
>     drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
>=20
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      drm-i915-gem-allow-exec_capture-on-recoverable-contexts-on-dg1.patch
> and it can be found in the queue-6.1 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
> From 25eeba495b2fc16037647c1a51bcdf6fc157af5c Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Ville=3D20Syrj=3DC3=3DA4l=3DC3=3DA4?=3D <ville.syrjala@=
linux.intel.com>
> Date: Mon, 12 May 2025 21:22:15 +0200
> Subject: drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>=20
> commit 25eeba495b2fc16037647c1a51bcdf6fc157af5c upstream.
>=20
> The intel-media-driver is currently broken on DG1 because
> it uses EXEC_CAPTURE with recovarable contexts. Relax the
> check to allow that.
>=20
> I've also submitted a fix for the intel-media-driver:
> https://github.com/intel/media-driver/pull/1920
>=20
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Testcase: igt/gem_exec_capture/capture-invisible
> Fixes: 71b1669ea9bd ("drm/i915/uapi: tweak error capture on recoverable c=
ontexts")
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Link: https://lore.kernel.org/r/20250411144313.11660-2-ville.syrjala@linu=
x.intel.com
> (cherry picked from commit d6e020819612a4a06207af858e0978be4d3e3140)
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -2001,7 +2001,7 @@ static int eb_capture_stage(struct i915_
>                         continue;
> =20
>                 if (i915_gem_context_is_recoverable(eb->gem_context) &&
> -                   (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > I=
P_VER(12, 0)))
> +                   GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
>                         return -EINVAL;
> =20
>                 for_each_batch_create_order(eb, j) {
>=20
>=20
> Patches currently in stable-queue which might be from ville.syrjala@linux=
.intel.com are
>=20
> queue-6.1/drm-dp-change-aux-dpcd-probe-address-from-dpcd_rev-to-lane0_1_s=
tatus.patch
> queue-6.1/revert-drm-i915-gem-allow-exec_capture-on-recoverabl.patch
> queue-6.1/drm-i915-gem-allow-exec_capture-on-recoverable-contexts-on-dg1.=
patch
> queue-6.1/drm-i915-gem-allow-exec_capture-on-recoverable-conte.patch


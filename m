Return-Path: <stable+bounces-3859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D7E803168
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504D1B20A12
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089A22EEF;
	Mon,  4 Dec 2023 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9ug1vD5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1FB9C;
	Mon,  4 Dec 2023 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701688956; x=1733224956;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=clj2qIznBCfTgXaKlV017t6Zuf9Mb7py9RfF3gUFjCM=;
  b=c9ug1vD55KkVO+dklDdtd0PmdTHTWFJSt0Ief9OAR5XLVsaSwZGAGLUW
   tPVp/Cau1JadnJI03UopXR/TkaVm8KQ8ZwjK0G1GJYIEfeBgHlmg8/4PD
   AQsq/d1UVURgB+ww8Wgw5yQAJu7RhQM45aF+A0PKRej5oQ3P7ZIWroOUE
   PHg4g2UCV+rsYUnVVU6KsarJHjrY9ooAGv8fnZJORsqNcZnZ36i7yBODu
   1lGqZt77mXqcnODz1pON3Py3nibVcoQFr6ArgB1u637mrH4rpEEf2IUGa
   9I+V7A5xLvjL9fXAxlHCAWp5AqRxuBzSveR1BkMjkomdnDrZe0aHiiK+q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="15264201"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="15264201"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 03:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="804873462"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="804873462"
Received: from shahmoha-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.45.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 03:22:31 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
 ville.syrjala@linux.intel.com, stable@vger.kernel.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/i915: Call intel_pre_plane_updates() also for pipes
 getting enabled" has been added to the 6.1-stable tree
In-Reply-To: <20231204104250.2009121-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231204104250.2009121-1-sashal@kernel.org>
Date: Mon, 04 Dec 2023 13:22:28 +0200
Message-ID: <87il5e2owb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
> This is a note to let you know that I've just added the patch titled
>
>     drm/i915: Call intel_pre_plane_updates() also for pipes getting enabl=
ed
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      drm-i915-call-intel_pre_plane_updates-also-for-pipes.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Turns out this one requires another commit to go with it, both for
v6.7-rc* and stable backports. I was just a bit too late with it for
v6.7-rc4 [1].

Please hold off with all stable backports of this until you can backport

96d7e7940136 ("drm/i915: Check pipe active state in {planes,vrr}_{enabling,=
disabling}()")

from drm-intel-fixes with it. It should find its way to v6.7-rc5.

Thanks, and sorry for the mess. :(


BR,
Jani.


[1] https://lore.kernel.org/all/87fs0m48ol.fsf@intel.com/


>
>
>
> commit ad928967f1fc1951f16e2190472fb5c50401be74
> Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Date:   Tue Nov 21 07:43:15 2023 +0200
>
>     drm/i915: Call intel_pre_plane_updates() also for pipes getting enabl=
ed
>=20=20=20=20=20
>     [ Upstream commit d21a3962d3042e6f56ad324cf18bdd64a1e6ecfa ]
>=20=20=20=20=20
>     We used to call intel_pre_plane_updates() for any pipe going through
>     a modeset whether the pipe was previously enabled or not. This in
>     fact needed to apply all the necessary clock gating workarounds/etc.
>     Restore the correct behaviour.
>=20=20=20=20=20
>     Fixes: 39919997322f ("drm/i915: Disable all planes before modesetting=
 any pipes")
>     Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>     Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20231121054324.99=
88-3-ville.syrjala@linux.intel.com
>     (cherry picked from commit e0d5ce11ed0a21bb2bf328ad82fd261783c7ad88)
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 96e679a176e94..1977f4c6fd889 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -7188,10 +7188,11 @@ static void intel_commit_modeset_disables(struct =
intel_atomic_state *state)
>  		if (!intel_crtc_needs_modeset(new_crtc_state))
>  			continue;
>=20=20
> +		intel_pre_plane_update(state, crtc);
> +
>  		if (!old_crtc_state->hw.active)
>  			continue;
>=20=20
> -		intel_pre_plane_update(state, crtc);
>  		intel_crtc_disable_planes(state, crtc);
>  	}
>=20=20

--=20
Jani Nikula, Intel


Return-Path: <stable+bounces-11822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E1830172
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 09:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF7A287E98
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF612B6A;
	Wed, 17 Jan 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVFc+If9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66812B69
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481126; cv=none; b=E4gwFNSfP0IVzpmPp4Qifi/bjHQdCmOFP/6hvHEt3m7dBYViJMLiXCLV4mLyeFMRVtfAI0EOgrDg2nDI4Gsvlb61a5vmm6BXcSZPadsac4vC84Wymp/rEG1+9k0gqzWl2C0s/vzRLHitGnH4OorOpvJ9kdIABRPbKB0psxQKuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481126; c=relaxed/simple;
	bh=Kl7HEQZ4YznO9N55TROuo/SXRkDmdJkL3MhkevFzG70=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=ErkedKZSHHgI0z3XChr+VE0DUA6Zf4JnwaVkDrlLHuKQvwiwXg9I0DyJ1+f3gYNhwR/eICsP8KqrsnZ55xEswL/eLNOv8bNoroVv+Gk+gUZIPrSNa77kIBJryecMm8LCHzfB8jQHgNe5K5hcBvdf+unZxcy8I0Te+Dnpwcd/Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVFc+If9; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705481124; x=1737017124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Kl7HEQZ4YznO9N55TROuo/SXRkDmdJkL3MhkevFzG70=;
  b=HVFc+If9hPnvS0YQw96GE943lxOYuZpHrJ67Opzh8WwTXIdedxMgZ/Bn
   Ql4WfdAL8xvSypyWQwBhCcxLsS9q6yiJqt+rN/61KlTBcGqiSAzHMv1yf
   PDzgL6xWP7forYStd5HRNDeC7TjaH0QhIfUhVv8PT4pmVrZ9UxcHvxSEJ
   mJKPmf+S62XqWcDj7rBAnYEZKiAupB7U/WFle6GdqtBI/QTuBHX7iTRNS
   AVeV/3vEAQvq6XEIRjVG+n5nufPvZ9KWVwD/vnwMPZtwepx+qoZ+l6q3Q
   a+BFs10GXOBlT1C2fEoQmY3XLtdIWthO2SjmtCIb1ovZzpHpX6QgwYYXu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="403870822"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="403870822"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="854636349"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="854636349"
Received: from msznigir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.230])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:45:21 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/i915/dsi: Do display on sequence later on
 icl+"
In-Reply-To: <20240116210821.30194-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240116210821.30194-1-ville.syrjala@linux.intel.com>
Date: Wed, 17 Jan 2024 10:45:18 +0200
Message-ID: <87il3sqrfl.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> This reverts commit 88b065943cb583e890324d618e8d4b23460d51a3.
>
> Lenovo 82TQ is unhappy if we do the display on sequence this
> late. The display output shows severe corruption.
>
> It's unclear if this is a failure on our part (perhaps
> something to do with sending commands in LP mode after HS
> /video mode transmission has been started? Though the backlight
> on command at least seems to work) or simply that there are
> some commands in the sequence that are needed to be done
> earlier (eg. could be some DSC init stuff?). If the latter
> then I don't think the current Windows code would work
> either, but maybe this was originally tested with an older
> driver, who knows.
>
> Root causing this fully would likely require a lot of
> experimentation which isn't really feasible without direct
> access to the machine, so let's just accept failure and
> go back to the original sequence.
>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10071
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i91=
5/display/icl_dsi.c
> index ac456a2275db..eda4a8b88590 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -1155,6 +1155,7 @@ static void gen11_dsi_powerup_panel(struct intel_en=
coder *encoder)
>  	}
>=20=20
>  	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
> +	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
>=20=20
>  	/* ensure all panel commands dispatched before enabling transcoder */
>  	wait_for_cmds_dispatched_to_panel(encoder);
> @@ -1255,8 +1256,6 @@ static void gen11_dsi_enable(struct intel_atomic_st=
ate *state,
>  	/* step6d: enable dsi transcoder */
>  	gen11_dsi_enable_transcoder(encoder);
>=20=20
> -	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
> -
>  	/* step7: enable backlight */
>  	intel_backlight_enable(crtc_state, conn_state);
>  	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);

--=20
Jani Nikula, Intel


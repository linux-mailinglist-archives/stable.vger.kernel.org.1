Return-Path: <stable+bounces-28404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8280F87FAB4
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 10:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41011C21938
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8467C0BD;
	Tue, 19 Mar 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nw4xmKI+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A051C28
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840561; cv=none; b=S5A98pCEGUJL4QuiOJ9gyfX2HvJeFnx9SU0v9dtnuOOcOU3fLq0LGVdUlU4Zglme7v5i4KEeHbsSM7kJlxm/czdxpbK/rbAQojW4dSeYqvou68+Zzx8ty7l3xS9IheFA4v0ZV+cNs1AMmNJBtEHs0XrCf253IHkFPXwuDe7xrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840561; c=relaxed/simple;
	bh=uaHVx0ncml+pSnJ9yO/wJZGUIiX71HnsafAiV9LPvZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/VcDzZe0V7ZtUCQcyOJ5NaGv8idUfxxmLAjsD2LTV0f/L1yKC3K56o+7CXZcDq9nTEARhyC4HvpOsLug2OAv43+n5pOCpR7UifyY39Lwb1TX6PuU1Fxhs0dURmxOnculth2q2Ql5uSFR75PpSdV9Xgds36sr3TRfxB1ElaDUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nw4xmKI+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710840560; x=1742376560;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=uaHVx0ncml+pSnJ9yO/wJZGUIiX71HnsafAiV9LPvZQ=;
  b=Nw4xmKI+SVrQ3SQo72GRPu3I3fy7bwbp8+ZFcLicqjjo0o0T5cmKW8qZ
   tDuo4gvhtfjL8bH8YaEoXnAsoCBFDyphkzIHQ/KQtakB1Lriv0bxLGyWz
   VTX+Y0dynQ+n9c7lZ5oZQHJmwIp08yiP7SsDi6uo/e5+9A2Vu+apHbNkL
   2qFFmPrxQCd8KU1hlOrUgLCML8x+JVg7+jbDpkOWtEfS8R/SwXUK9+Uqd
   kv3j2goDqb0YtB/bI5slxe3TuRZVD1H0aE1ZZmme85eCkrWm2qlgiUdQp
   TU0S9skHOtqOwq6UPPlU708v22tjlpF5OjLpovhR2eVElddn3JoYj6gpa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9497654"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="9497654"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18378513"
Received: from rcritchl-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.139])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:29:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/bios: Tolerate devdata==NULL in
 intel_bios_encoder_supports_dp_dual_mode()
In-Reply-To: <20240319092443.15769-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240319092443.15769-1-ville.syrjala@linux.intel.com>
Date: Tue, 19 Mar 2024 11:29:14 +0200
Message-ID: <87sf0mo9hx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> If we have no VBT, or the VBT didn't declare the encoder
> in question, we won't have the 'devdata' for the encoder.
> Instead of oopsing just bail early.
>
> We won't be able to tell whether the port is DP++ or not,
> but so be it.
>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10464
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bios.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/=
i915/display/intel_bios.c
> index c7841b3eede8..c13a98431a7b 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -3458,6 +3458,9 @@ bool intel_bios_encoder_supports_dp_dual_mode(const=
 struct intel_bios_encoder_da
>  {
>  	const struct child_device_config *child =3D &devdata->child;

The above oopses already.

BR,
Jani.

>=20=20
> +	if (!devdata)
> +		return false;
> +
>  	if (!intel_bios_encoder_supports_dp(devdata) ||
>  	    !intel_bios_encoder_supports_hdmi(devdata))
>  		return false;

--=20
Jani Nikula, Intel


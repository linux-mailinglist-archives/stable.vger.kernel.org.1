Return-Path: <stable+bounces-52197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2313908CE9
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035401C22A14
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440119D8BB;
	Fri, 14 Jun 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIAJc7z7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E319D8B1
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373727; cv=none; b=jQcVnjfG3+A/JyX1Q6iChuRg+XnV9pd2JWiNI0i7XeK06mQsm0fofmOvCqSvl4hBUoer1Mv12J3PJhfv4GrF80VWjJqexAPa0T9xWzz2UA2+ayqgH2bfLfvQscoc9ncxdB8AVVn/VdeVUsP072m3jXNlmEKAYUaSSJJGbSu53Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373727; c=relaxed/simple;
	bh=wYfq+JJno1w5kVXYZyuHtTOzgW5vH8ZiVp73LqeBpj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jT56p8IfjdtmxuLEwQSpAPvkGHAn3HRELYNWJPw2qlFgJWGbPol6ynWTKv2Dhw4YRvJW70Q0/2JY0eigblRSuCDtRo8dhR5bovHBnqVPQhh7z60B9Rgd3v7Pl/Dv8lkW5tNLWFDb8FqVlAoYmqXDOAjeEtXMAgaTAcriGszDXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIAJc7z7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718373725; x=1749909725;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wYfq+JJno1w5kVXYZyuHtTOzgW5vH8ZiVp73LqeBpj8=;
  b=bIAJc7z76XwGlqctXMDokGJHkrw34e0xsiws9fqgBq+R9+CPFIXHba5k
   Ria/J4RyTTNu8obsOwFYgbv8mvwUAxPiRC6ewnR3zR66/AV2i1X0TaAuZ
   P+SDMLOUi4TV1eLNvKXeaZODhBTYYDUMdPTkx+eyHd9UX9a9XKf1xsTgO
   wxotkkPvbXWyuilROCTR5L5yDjPlHXmiky9PYNenXkDmeNvYfIeoy3a9E
   M60vjV9OjQQinG42snyNrXsigMzQ2fI4DltWnksqvEI6u2a9TOtL+QqGh
   58FfMwc9A4s2F3Y96nJbiwExmDyIzP3HldwiZ6ntnbp/Hpyb7BtDJJMY6
   g==;
X-CSE-ConnectionGUID: 2JogFJqvSjqCyanZw6+S6w==
X-CSE-MsgGUID: Y7+TENAFT9qV8MQieDoo7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="25833637"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="25833637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:02:01 -0700
X-CSE-ConnectionGUID: HskYjzKlQ8G1z95B647H4w==
X-CSE-MsgGUID: B9C5qgrgTZyYI91FBBYc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40612017"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.221])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:02:00 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/i915/mso: using joiner is not possible with
 eDP MSO
In-Reply-To: <ZmwsZCkP6mobS7ki@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1718360103.git.jani.nikula@intel.com>
 <137a010815ab8ba8f266fea7a85fe14d7bfb74cd.1718360103.git.jani.nikula@intel.com>
 <ZmwsZCkP6mobS7ki@intel.com>
Date: Fri, 14 Jun 2024 17:01:15 +0300
Message-ID: <871q4zipxw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Jun 14, 2024 at 01:16:03PM +0300, Jani Nikula wrote:
>> It's not possible to use the joiner at the same time with eDP MSO. When
>> a panel needs MSO, it's not optional, so MSO trumps joiner.
>>=20
>> While just reporting false for intel_dp_has_joiner() should be
>> sufficient, also skip creation of the joiner force enable debugfs to
>> better handle this in testing.
>>=20
>> Cc: stable@vger.kernel.org
>> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++++--
>>  drivers/gpu/drm/i915/display/intel_dp.c              | 4 ++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/driv=
ers/gpu/drm/i915/display/intel_display_debugfs.c
>> index 91757fed9c6d..5eb31404436c 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
>> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
>> @@ -1546,8 +1546,12 @@ void intel_connector_debugfs_add(struct intel_con=
nector *connector)
>>  	if (DISPLAY_VER(i915) >=3D 11 &&
>>  	    (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
>>  	     connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) {
>> -		debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
>> -				    &connector->force_bigjoiner_enable);
>> +		struct intel_dp *intel_dp =3D intel_attached_dp(connector);
>
> That won't give you anything on MST.

Gah!

> Dunno if there's any point in
> trying to do anything here anyway. We don't account for the other
> intel_dp_has_joiner() restrictions here either.

The only point would be skipping a bunch of IGT tests. With the debugfs
in place, kms_big_joiner thinks it enables joiner, and runs extra joiner
tests for nothing.

Thoughts? I guess the simplest fix for stable could be just the last
hunk here.

BR,
Jani.


>
>> +
>> +		/* eDP MSO is not compatible with joiner */
>> +		if (!intel_dp->mso_link_count)
>> +			debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
>> +					    &connector->force_bigjoiner_enable);
>>  	}
>>=20=20
>>  	if (connector_type =3D=3D DRM_MODE_CONNECTOR_DSI ||
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i=
915/display/intel_dp.c
>> index 9a9bb0f5b7fe..ab33c9de393a 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -465,6 +465,10 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>>  	struct intel_encoder *encoder =3D &intel_dig_port->base;
>>  	struct drm_i915_private *dev_priv =3D to_i915(encoder->base.dev);
>>=20=20
>> +	/* eDP MSO is not compatible with joiner */
>> +	if (intel_dp->mso_link_count)
>> +		return false;
>> +
>
> This part looks fine.
>
>>  	return DISPLAY_VER(dev_priv) >=3D 12 ||
>>  		(DISPLAY_VER(dev_priv) =3D=3D 11 &&
>>  		 encoder->port !=3D PORT_A);
>> --=20
>> 2.39.2

--=20
Jani Nikula, Intel


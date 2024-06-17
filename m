Return-Path: <stable+bounces-52351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F007390A8C5
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14C21F23CE3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCD54918;
	Mon, 17 Jun 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VN/aPI21"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E0EEC3
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614225; cv=none; b=iYXC9fpBFs13RCEqcYyoTUB98YSARXbAo+AV3E4KDBBjeOzgIqJHfG1nSYQL6Kav4aFK9jYOkQVFJ8RFQCRu91LSSD2jyRPBbab3Z9IXieEldnhVxlAegKAh/NjTuH+sQidOFYHUXuSCqVrYBwKc1yFPmoqrLT+3k4Jl9RsjLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614225; c=relaxed/simple;
	bh=LmtJFs5U0H0MHRB7Sc+aeWxh+Em43v/yWk9NqtJAg+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbn+FScxc+jSErA+Dj52jsdclbiWLGoUIgfFaoLyTDet5iJvcxliv2N1XszyfwWno79kfJZYTrWfgGCuvGgFxrjjvwUyNkS9qxH+pu3822sXTV+9x6unRWiW69NUrF/oVJUKqc5HSRVQA+meu5KS3eyQD3ytiyWlR7cLG6Ed+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VN/aPI21; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718614223; x=1750150223;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=LmtJFs5U0H0MHRB7Sc+aeWxh+Em43v/yWk9NqtJAg+k=;
  b=VN/aPI21CoHN5NAjEgueotE3rOvLm/pHujuIC4jQuCHNpiaEdIz8m/q9
   buNVirduCzEjKwjuzb/QvA61S8TUaKolUdfFN644EUPTeRvTh9RCxc6sf
   jEVc3XbSgobcu2Aw/agNwx20fx39A+LC8I4Ame111sLrkcdheeM/y9OOd
   +A7UsYIFzFVV2r4B7aQme/PBxyGlgKnc54wf5iRJVNSFvM9wIRYfH21mt
   LQuA+TE0KQpTm9nruXH0vl4/McK9D3Zu+nES9q4v8tsMGWUnppsQbquFL
   3kMejqcQolVLLIqmk9eI82ttcZzRJxKw0LOadaqADO4S1eATKX7f5GwW0
   g==;
X-CSE-ConnectionGUID: Xh7ehDdjSs6Np1Ulz15epA==
X-CSE-MsgGUID: 7Dyt4aLWRVmieHTJ88XOAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32972300"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="32972300"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 01:50:23 -0700
X-CSE-ConnectionGUID: jdK0h3yUR5+gTl6YaRjp2A==
X-CSE-MsgGUID: AmOFWqcEQKGx2DN0GD2KPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41828741"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.85])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 01:50:21 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/mso: using joiner is not possible with eDP MSO
In-Reply-To: <ZmxWKyz8RcqjQ0Mg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240614142311.589089-1-jani.nikula@intel.com>
 <ZmxWKyz8RcqjQ0Mg@intel.com>
Date: Mon, 17 Jun 2024 11:50:17 +0300
Message-ID: <87sexcgdh2.fsf@intel.com>
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
> On Fri, Jun 14, 2024 at 05:23:11PM +0300, Jani Nikula wrote:
>> It's not possible to use the joiner at the same time with eDP MSO. When
>> a panel needs MSO, it's not optional, so MSO trumps joiner.
>>=20
>> v3: Only change intel_dp_has_joiner(), leave debugfs alone (Ville)
>>=20
>> Cc: stable@vger.kernel.org
>> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks, pushed to din with

    Fixes: bc71194e8897 ("drm/i915/edp: enable eDP MSO during link training=
")
    Cc: <stable@vger.kernel.org> # v5.13+

BR,
Jani.

>
>>=20
>> ---
>>=20
>> Just the minimal fix for starters to move things along.
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
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
>>  	return DISPLAY_VER(dev_priv) >=3D 12 ||
>>  		(DISPLAY_VER(dev_priv) =3D=3D 11 &&
>>  		 encoder->port !=3D PORT_A);
>> --=20
>> 2.39.2

--=20
Jani Nikula, Intel


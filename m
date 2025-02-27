Return-Path: <stable+bounces-119826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80807A479FD
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413E8188EEEC
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4E20DD7A;
	Thu, 27 Feb 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEEtgxRe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DC1527B4
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651539; cv=none; b=UoSBVnLAV5t4KJRcKmyEMqUFoagmNreL+1b2CcRtWFH7F//7mNPRilw3uCqwM5cM7bZfr6A+T0+R3iYaDQ+oR+DMf968OdETpI35Fm+liQ4AlGhmN3Dc1aFXOZ7/BVKeH7Db71CjIz0kJOYpVdV2WCiWlLYEw+05XAwNtj6H7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651539; c=relaxed/simple;
	bh=YxMiEOGB4/4hNsdQ8e1dMTscyibUnF1djDeulq5C0iA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HpS0YE0fQ+3iNRm23PJYt5XwsS4SSygb6QMiregpYj5RIWqj6SS/TYU+10TVZUopqqTGHlC469lE/oxl0jzLQdd45UpmgDG58cW7KL3TdPfOQTL/QvqACM6+1cyrngORdaFAqaboyEvQaBWpDjMVv4pkbqZBfGnA3NqhyWPYz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEEtgxRe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740651538; x=1772187538;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YxMiEOGB4/4hNsdQ8e1dMTscyibUnF1djDeulq5C0iA=;
  b=SEEtgxReap+To7XSeeznk5vz27liMiAWPwZUCqoL7eCzp0VMMXZBe1Hb
   fK939DvE8FUWqX3CURJnzZkBV+OAUnTwrbhxTSk2bDSFCWaV3TpuSd+DR
   9ZKmFfRs5y5M8neIYm+hPCO/GIhBiH2NBl6olUb18X22kFZsenwpI8cZG
   mggBWhpVC81D0DUJabO0PLqVAIjnZbmxZ6mz6tJDSws1YliGXrkqT/EG5
   uVYRLsXr2w4ulEzHML0OQOf06iXm58GmUeSrrzq+b4uuy8o6IkhcFpzCG
   1BEWIe/PI4dR7udUYarR98SxmrJ9HXPxGOsY8DbrXuzQ/FF+PB9HJk+2A
   g==;
X-CSE-ConnectionGUID: Fw6drtrNTEaiLSkQos7S9w==
X-CSE-MsgGUID: Mhgm4Tk6Tcm5rsnklta8rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40710887"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40710887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 02:18:57 -0800
X-CSE-ConnectionGUID: b4lpNRuPSxSCV0OjfHumog==
X-CSE-MsgGUID: hC4ckOJkTx+D+CqXAspI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117623688"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.181])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 02:18:55 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH] drm/i915/mst: update max stream count to match number
 of pipes
In-Reply-To: <Z782CKSDNBjlmjct@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250226135626.1956012-1-jani.nikula@intel.com>
 <Z782CKSDNBjlmjct@intel.com>
Date: Thu, 27 Feb 2025 12:18:51 +0200
Message-ID: <871pvj4rn8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2025, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Wed, Feb 26, 2025 at 03:56:26PM +0200, Jani Nikula wrote:
>> We create the stream encoders and attach connectors for each pipe we
>> have. As the number of pipes has increased, we've failed to update the
>> topology manager maximum number of payloads to match that. Bump up the
>> max stream count to match number of pipes, enabling the fourth stream on
>> platforms that support four pipes.
>>=20
>> Cc: stable@vger.kernel.org
>> Cc: Imre Deak <imre.deak@intel.com>
>> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks, pushed to din.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/d=
rm/i915/display/intel_dp_mst.c
>> index 167e4a70ab12..822218d8cfd4 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> @@ -1896,7 +1896,8 @@ intel_dp_mst_encoder_init(struct intel_digital_por=
t *dig_port, int conn_base_id)
>>  	/* create encoders */
>>  	mst_stream_encoders_create(dig_port);
>>  	ret =3D drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
>> -					   &intel_dp->aux, 16, 3, conn_base_id);
>> +					   &intel_dp->aux, 16,
>> +					   INTEL_NUM_PIPES(display), conn_base_id);
>>  	if (ret) {
>>  		intel_dp->mst_mgr.cbs =3D NULL;
>>  		return ret;
>> --=20
>> 2.39.5

--=20
Jani Nikula, Intel


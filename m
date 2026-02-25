Return-Path: <stable+bounces-219619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMmKLKn5nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:31:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14941198189
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2DA304C7EA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992643B8BC1;
	Wed, 25 Feb 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWYlo1Px"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE438F943
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026153; cv=none; b=aOoVt9Y0Oj+kQpdOutuWXhvZMa+OujnlaxPGtjproA6VyAwKu0vVcPBH9zScUxJZ8Mlr7QJSPCW8ywvJXC6mnbqcmoQ+jkz6nzDaQ1Pq9nlLgXFJm79qOT+3rl3Le/B+ISE++D9pw/Jz6fnc8lssyeQaHYXbgGAYNFGAORNdEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026153; c=relaxed/simple;
	bh=DVgT5RMRNWekHbyHQc8KcLrs3cWTMG1K0k1HgAFeRF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWO73RZJUHw5TfLeUanIPUI07Vn8O1rGlYu10uGWekH7Vr6XrB0rj+u0U1CJVrgam7rlJsni6Ze2Y2bjMDM2XIy7rR+DW+aMP6wr0hvQHC+GQwvmtj2Qkjto/x+p0PX8mWtYdNcj/OLdJ5F3soiU1xw8KSq5I0Fl80Xug35jZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWYlo1Px; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772026152; x=1803562152;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DVgT5RMRNWekHbyHQc8KcLrs3cWTMG1K0k1HgAFeRF0=;
  b=RWYlo1PxA+vFIwQoRyW+6dZEprBgv7yHlFqGWdjMFt3Rgh/QfQJ9NPUG
   K6F6Rz6ZygkeIdZ3/VMjmZqQijrnIwusJ8ZKSYgzSAJecxUnssASRsSV9
   VO5Mdtwx/I1VERDd6VixzFZ0/9gOuP8GeDjI/8DxqjASQ+2b7f2HvjDHY
   EnlicU+lpZzdv7anKqaddarob2INlUIq6UxsHTxpGddMDPqRc3VrIGqHq
   z896bQ7W0FWvZy02qkUSAl+KbiYuu0/JN53jtG5+1OTHSRYRD81B4IkUV
   bbd7nGr1YoiLuYmnn4BhfP8GlOVjGv357qGG5c1P4H69bv5QXDZymhHzM
   A==;
X-CSE-ConnectionGUID: UvGiYbNNRaKIBJ37DetJPw==
X-CSE-MsgGUID: wOobzBbuRmul0N0W1zWJMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95679097"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="95679097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 05:29:11 -0800
X-CSE-ConnectionGUID: sFhDSqreQCuseaty/XGkng==
X-CSE-MsgGUID: DqnRm6IwSjqOsCklKY3Y1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216116671"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.68])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 05:29:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, Jouni =?utf-8?Q?H?=
 =?utf-8?Q?=C3=B6gander?=
 <jouni.hogander@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/i915/psr: DSC configuration for Early Transport
In-Reply-To: <528b9b9c-920d-4146-a4f7-97db356e7f28@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260219130743.1232188-1-jouni.hogander@intel.com>
 <20260219130743.1232188-5-jouni.hogander@intel.com>
 <528b9b9c-920d-4146-a4f7-97db356e7f28@intel.com>
Date: Wed, 25 Feb 2026 15:29:04 +0200
Message-ID: <62858fcc175b123862a5071265a65210428e3bc5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219619-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14941198189
X-Rspamd-Action: no action

On Wed, 25 Feb 2026, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> On 2/19/2026 6:37 PM, Jouni H=C3=B6gander wrote:
>> There is Selective Update slice row per frame and picture height
>> configurations needed on DSC when using Selective Update Early
>> Transport. Calculate and configure these when using Early Transport.
>>
>> Bspec: 68927
>> Fixes: 467e4e061c44 ("drm/i915/psr: Enable psr2 early transport as possi=
ble")
>> Cc: <stable@vger.kernel.org> # v6.9+
>
>
> This patch needs the other patch where registers are defined. I am not=20
> sure if stable will only pick this patch or will try to find out the=20
> dependency patch.
>
> We need to check if there is a way to tell the dependency patch/commit=20
> to stable, so that both patches are applied together.
>
> If we want this change to get ported to older kernels, we might need to=20
> squash the register definition patch with this patch.

Nope. Neither we nor stable want dependencies squashed. They'll happily
pick up extra dependency commits if needed, though.

Someone(tm) just needs to let them know about the dependencies when they
send the mail about (the presumably failed) backport attempt.

BR,
Jani.


>
>
>> Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@intel.com>
>> ---
>>   .../drm/i915/display/intel_display_types.h    |  1 +
>>   drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/driver=
s/gpu/drm/i915/display/intel_display_types.h
>> index e8e4af03a6a6..8903804c04b1 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
>> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
>> @@ -1381,6 +1381,7 @@ struct intel_crtc_state {
>>   	u32 psr2_man_track_ctl;
>>=20=20=20
>>   	u32 pipe_srcsz_early_tpt;
>> +	u32 dsc_su_parameter_set_0_calc;
>
> I think let's just have a bool parameter something like=20
> psr_su_update_dsc_pps.
>
> We can set this bool variable during intel_psr2_sel_fetch_update()
>
>
>>=20=20=20
>>   	struct drm_rect psr2_su_area;
>>=20=20=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/=
i915/display/intel_psr.c
>> index 331645a2c9f6..0a2948ec308d 100644
>> --- a/drivers/gpu/drm/i915/display/intel_psr.c
>> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
>> @@ -2618,6 +2618,11 @@ void intel_psr2_program_trans_man_trk_ctl(struct =
intel_dsb *dsb,
>>=20=20=20
>>   	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
>>   			   crtc_state->pipe_srcsz_early_tpt);
>> +	intel_de_write_dsb(display, dsb, DSC_SU_PARAMETER_SET_0_DSC0(crtc->pip=
e),
>> +			   crtc_state->dsc_su_parameter_set_0_calc);
>> +	if (intel_dsc_get_vdsc_per_pipe(crtc_state) > 1)
>> +		intel_de_write_dsb(display, dsb, DSC_SU_PARAMETER_SET_0_DSC1(crtc->pi=
pe),
>> +				   crtc_state->dsc_su_parameter_set_0_calc);
>>   }
>>=20=20=20
>>   static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
>> @@ -2668,6 +2673,23 @@ static u32 psr2_pipe_srcsz_early_tpt_calc(struct =
intel_crtc_state *crtc_state,
>>   	return PIPESRC_WIDTH(width - 1) | PIPESRC_HEIGHT(height - 1);
>>   }
>>=20=20=20
>> +static u32 psr2_dsc_su_parameter_set_0_calc(struct intel_crtc_state *cr=
tc_state,
>> +					    bool full_update)
>> +{
>> +	const struct drm_dsc_config *vdsc_cfg =3D &crtc_state->dsc.config;
>> +	int slice_row_per_frame, pic_height;
>> +
>> +	if (!crtc_state->enable_psr2_su_region_et || full_update ||
>> +	    !crtc_state->dsc.compression_enable)
>> +		return 0;
>> +
>
> Although we are making sure that height of the psr2_su_area is a=20
> multiple of the slice_height, perhaps it would be good to have a=20
> drm_WARN here to flag any misconfiguration i.e. if height is not a=20
> multiple of slice_height.
>
>
>> +	slice_row_per_frame =3D drm_rect_height(&crtc_state->psr2_su_area) / v=
dsc_cfg->slice_height;
>> +	pic_height =3D slice_row_per_frame * vdsc_cfg->slice_height;
>> +
>> +	return DSC_SU_PARAMETER_SET_0_SU_SLICE_ROW_PER_FRAME(slice_row_per_fra=
me) |
>> +		DSC_SU_PARAMETER_SET_0_SU_PIC_HEIGHT(pic_height);
>> +}
>
> Since this writes a DSC register belonging to PPS Set 0, this function=20
> should be moved to intel_vdsc.c.
>
> Also, based on the boolean flag (psr_su_update_dsc_pps) discussed above,=
=20
> this function should simply retrieve the required fields from crtc_state=
=20
> and program the register.
>
> Such a helper function should then be called from=20
> intel_psr2_program_trans_man_trk_ctl() in place of the direct=20
> intel_reg_write() call.
>
> IMO, all register reads/writes, along with the wrappers/helpers around=20
> them, should live in the file corresponding to the block that owns those=
=20
> registers, based on context.
>
>
> Regards,
>
> Ankit
>
>> +
>>   static void clip_area_update(struct drm_rect *overlap_damage_area,
>>   			     struct drm_rect *damage_area,
>>   			     struct drm_rect *pipe_src)
>> @@ -3026,6 +3048,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomi=
c_state *state,
>>   	psr2_man_trk_ctl_calc(crtc_state, full_update);
>>   	crtc_state->pipe_srcsz_early_tpt =3D
>>   		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
>> +	crtc_state->dsc_su_parameter_set_0_calc =3D psr2_dsc_su_parameter_set_=
0_calc(crtc_state,
>> +										   full_update);
>>   	return 0;
>>   }
>>=20=20=20

--=20
Jani Nikula, Intel


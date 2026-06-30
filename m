Return-Path: <stable+bounces-269913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9ReIsCHQ2praQoAu9opvQ
	(envelope-from <stable+bounces-269913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:09:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B46E1F08
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LDN676l2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269913-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269913-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8498F3008D39
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15543403F7;
	Tue, 30 Jun 2026 09:09:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203D37C92E
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:09:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810553; cv=none; b=pZiGdptmMVFRrvmMjb5jJ5WcRkpXK8wUkRmiZpOMsjTqzKZmwD3SwutCY9YpJbNgzW+csuWiPIBsIheGOk+ATodvhS3ld1s0hYp0YUvGuvm7fhxUxLQgQmn8ILrTxCKCCUBJuDzwYfPLEpJcKFUVol2WgzgFyixBfukRPz9iIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810553; c=relaxed/simple;
	bh=ZT5/YqAdR06D3iEcqa+qTOlX/3Y86xOSgxVe475ekKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CVzlC7lFtny6WeWCCm7X6wR0ul+zfpDQonelRTV8E4QU2wch15gILpqRt4r8JTpo+WVFH5TgWn2ILLIQ3w3jkH5HOJc7Fj0dGCc3e4H4j7bp8LnOmLkS/6LULfHTwVmufp4J8U5bArHt/X9zI2Y2s5KEjhPSZh5R58Q2VJ9HzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDN676l2; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782810552; x=1814346552;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ZT5/YqAdR06D3iEcqa+qTOlX/3Y86xOSgxVe475ekKQ=;
  b=LDN676l2CBCGYcp4nD1U23o9stf5uVK8CqopbzpnQyqCPoZFkhRX65Xq
   oX3PoeCPgr3Ly8d73cYuSQ+w/umNxSNbJyhbL7P+J9lOCheBA8nzqEot8
   UdW6JW8Dz8on9MEj3CUBUSVk8bLk3q0inP52Ky2Zzx/y+Z34jIX07chd/
   WZD4/Uhd45ZU/DPTg/Pvu3wJcU/YWDnLcdgM1qiKlArlY2uKVRFL7W6CA
   bLpmYkxicNo80/a54PBlpu3w9I4biw+3wpUHtDQd8Ved7tRs3NieUlNP2
   o1W8iQDHB64Ux+ngBGQ6/sfXetbbfyTMR+AEpcpafc0NFxMEeh5xSaAbr
   A==;
X-CSE-ConnectionGUID: llxVOwprRe+kooRQCkVY9g==
X-CSE-MsgGUID: deZtgH5dTNOTchgOt6fUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83715713"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83715713"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:09:12 -0700
X-CSE-ConnectionGUID: 3rJaxcJtQ6+vhxSNpjY94A==
X-CSE-MsgGUID: XtPPmhh0R/eOEcD+0WaoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="250518809"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:09:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Martin
 Hodo <martin.hodo@intel.com>, stable@vger.kernel.org, Animesh Manna
 <animesh.manna@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@intel.com>, =?utf-8?Q?Micha=C5=82?=
 Grzelak <michal.grzelak@intel.com>
Subject: Re: [PATCH v2] drm/i915/bios: range check LFP Data Block panel_type2
In-Reply-To: <akN8-YNa6kwRVkHk@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625135130.1067872-1-jani.nikula@intel.com>
 <20260626140155.1389655-1-jani.nikula@intel.com>
 <akN8-YNa6kwRVkHk@intel.com>
Date: Tue, 30 Jun 2026 12:09:06 +0300
Message-ID: <b8d3d97a0977f8b7a2fcfedbf7d30fa95d322023@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ville.syrjala@linux.intel.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:animesh.manna@intel.com,m:ville.syrjala@intel.com,m:michal.grzelak@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 812B46E1F08

On Tue, 30 Jun 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Jun 26, 2026 at 05:01:55PM +0300, Jani Nikula wrote:
>> While the panel_type from LFP Data Block is range checked, panel_type2
>> is not. Add a few helpers for range checking, and use them to not only
>> check panel_type2, but also improve clarity and correctness in the panel
>> type selection.
>>=20
>> Discovered using AI-assisted static analysis confirmed by Intel Product
>> Security.
>>=20
>> v2:
>> - Fix commit message typo (Micha=C5=82)
>> - Add is_panel_type_pnp() (Ville)
>>=20
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: 6434cf630086 ("drm/i915/bios: calculate panel type as per child d=
evice index in VBT")
>> Cc: <stable@vger.kernel.org> # v6.0+
>> Cc: Animesh Manna <animesh.manna@intel.com>
>> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@intel.com>
>> Reviewed-by: Micha=C5=82 Grzelak <michal.grzelak@intel.com> # v1
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_bios.c | 36 ++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm=
/i915/display/intel_bios.c
>> index 15ebadc72b88..97cbae2e547e 100644
>> --- a/drivers/gpu/drm/i915/display/intel_bios.c
>> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
>> @@ -623,6 +623,21 @@ get_lfp_data_tail(const struct bdb_lfp_data *data,
>>  		return NULL;
>>  }
>>=20=20
>> +static bool is_panel_type_valid(int panel_type)
>> +{
>> +	return panel_type >=3D 0 && panel_type < 16;
>> +}
>> +
>> +static bool is_panel_type_pnp(int panel_type)
>> +{
>> +	return panel_type =3D=3D 0xff;
>> +}
>> +
>> +static bool is_panel_type_valid_or_pnp(int panel_type)
>> +{
>> +	return is_panel_type_valid(panel_type) || is_panel_type_pnp(panel_type=
);
>> +}
>> +
>>  static int opregion_get_panel_type(struct intel_display *display,
>>  				   const struct intel_bios_encoder_data *devdata,
>>  				   const struct drm_edid *drm_edid, bool use_fallback)
>> @@ -640,15 +655,21 @@ static int vbt_get_panel_type(struct intel_display=
 *display,
>>  	if (!lfp_options)
>>  		return -1;
>>=20=20
>> -	if (lfp_options->panel_type > 0xf &&
>> -	    lfp_options->panel_type !=3D 0xff) {
>> +	if (!is_panel_type_valid_or_pnp(lfp_options->panel_type)) {
>>  		drm_dbg_kms(display->drm, "Invalid VBT panel type 0x%x\n",
>>  			    lfp_options->panel_type);
>>  		return -1;
>>  	}
>>=20=20
>> -	if (devdata && devdata->child.handle =3D=3D DEVICE_HANDLE_LFP2)
>> +	if (devdata && devdata->child.handle =3D=3D DEVICE_HANDLE_LFP2) {
>> +		if (!is_panel_type_valid_or_pnp(lfp_options->panel_type2)) {
>> +			drm_dbg_kms(display->drm, "Invalid VBT panel type 2 0x%x\n",
>> +				    lfp_options->panel_type2);
>> +			return -1;
>> +		}
>> +
>>  		return lfp_options->panel_type2;
>> +	}
>
> Hmm, this code will always return 'panel_type' if it's valid, even
> for LFP2. That seems wrong, but would need to double check the
> Windows behaviour to be sure...
>
> But that's a separate issue, so this patch is
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks, pushed to din.

BR,
Jani.

>
>>=20=20
>>  	drm_WARN_ON(display->drm,
>>  		    devdata && devdata->child.handle !=3D DEVICE_HANDLE_LFP1);
>> @@ -762,13 +783,12 @@ static int get_panel_type(struct intel_display *di=
splay,
>>  				    panel_types[i].name, panel_types[i].panel_type);
>>  	}
>>=20=20
>> -	if (panel_types[PANEL_TYPE_OPREGION].panel_type >=3D 0)
>> +	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
>>  		i =3D PANEL_TYPE_OPREGION;
>> -	else if (panel_types[PANEL_TYPE_VBT].panel_type =3D=3D 0xff &&
>> -		 panel_types[PANEL_TYPE_PNPID].panel_type >=3D 0)
>> +	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
>> +		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
>>  		i =3D PANEL_TYPE_PNPID;
>> -	else if (panel_types[PANEL_TYPE_VBT].panel_type !=3D 0xff &&
>> -		 panel_types[PANEL_TYPE_VBT].panel_type >=3D 0)
>> +	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
>>  		i =3D PANEL_TYPE_VBT;
>>  	else
>>  		i =3D PANEL_TYPE_FALLBACK;
>> --=20
>> 2.47.3

--=20
Jani Nikula, Intel


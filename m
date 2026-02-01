Return-Path: <stable+bounces-212997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJpXLutff2ncpAIAu9opvQ
	(envelope-from <stable+bounces-212997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:15:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4CC61D6
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBBB730086C0
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621353502B4;
	Sun,  1 Feb 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kpITffrX"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B833CEB9;
	Sun,  1 Feb 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769955288; cv=none; b=k0fcvdEdb+ab5Q9MEjZGgVmL7Ffo+zq+gwLNPDage+k6m7XM2mHO8uPvC81D6Zs3mMLd+T6pAV1qfVdvVKWK/MIiAjb7CAeO9wTrs1QI3sgYVAndpdaNfUYeTOC2F8EtaMsof6HwF+fTNIhvqpNoHmHSpHMjvvMHKo/toIy9q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769955288; c=relaxed/simple;
	bh=HyiFrtV16BT2yMD0/WH+EkSthkQwVKOebWrORCHC8bU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Z6KV4kFDSaqciJAaOYmnWdk8TjEPHjHj2Az5VxTEb0hj5DnWzKzBJumbLSbmWYWihppLPmXKqeTjS7Y7/KLEIRrjrDGaZdFFISCg0F5HMBUtmqX0CyUoT8NAnaTe+eZchbYLgB1wuERb4ET3iN6XqCJxgPsTkK6xPEoX3gUfOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kpITffrX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5DE2326125;
	Sun,  1 Feb 2026 15:14:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6vFyFPygDq0; Sun,  1 Feb 2026 15:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769955276; bh=HyiFrtV16BT2yMD0/WH+EkSthkQwVKOebWrORCHC8bU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=kpITffrXNM5mo/aIaQotE/HwHYqgja7BYdRED5/t14rR5pvLSCIBfuFithK+VaFd9
	 TPzlXT08+jGsc/LDw+BhEDSproQ5MVaNlFBDGejKF5gfZ5b8v11/2FcOgkai7Oprkf
	 qIA9Wm3T0eNy1FTIhAr5QLKh5ZTZ0e5fgrpJd5w60lBbR8TRtU9uVOXl9YggSFf23V
	 KN45QW8Ogr2POMi6YUAawsibxCntEyrL0CF53lsEhNOV91IJugr8KQLccrSAoqU4En
	 uQ7mXI304ZNA5kM5bIMXty6PewA9mVZfXPIKdvxuca+/SiK++FFfGU5AajZlsYFPQv
	 zxNL3UkWoPKvg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Feb 2026 19:44:24 +0530
Message-Id: <DG3ORZIEYI9Z.34Z2QZ4J2A21@disroot.org>
Subject: Re: [PATCH 1/3] drm/bridge: samsung-dsim: move bridge init sequence
 to atomic_enable
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, "Inki Dae" <inki.dae@samsung.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
References: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
 <CGME20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e@eucas1p1.samsung.com> <20260124-exynos-dsim-fixes-v1-1-122d047a23d1@disroot.org> <1db5ffdf-924b-49cb-a057-802a1bfe6073@samsung.com>
In-Reply-To: <1db5ffdf-924b-49cb-a057-802a1bfe6073@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212997-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,disroot.org,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,disroot.org:email,disroot.org:dkim,disroot.org:mid]
X-Rspamd-Queue-Id: 22A4CC61D6
X-Rspamd-Action: no action

On 2026-01-26 09:57 +01:00, Marek Szyprowski wrote:
> On 24.01.2026 18:20, Kaustabh Chakraborty wrote:
>> Since commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain
>> pre-enable and post-disable"), pre-enable sequence is called before the
>> CRTC is enabled.
>>
>> This causes unintended side-effects (abberation among potentially other
>> things) in the display when samsung_dsim_init() is called in the
>> pre-enable part of the sequence. Call it in samsung_dsim_atomic_enable()
>> instead.
>>
>> Cc: stable@vger.kernel.org # v6.17 and later
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> I'm not sure if this will be needed:
>
> https://lore.kernel.org/all/20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideaso=
nboard.com/

Tested on v6.19-rc7, this is fixed now. This can be dropped.

>
>
>> ---
>>   drivers/gpu/drm/bridge/samsung-dsim.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bri=
dge/samsung-dsim.c
>> index 1d85e706c74b9..975f8b50ae660 100644
>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
>> @@ -1655,6 +1655,13 @@ static void samsung_dsim_atomic_pre_enable(struct=
 drm_bridge *bridge,
>>   	}
>>  =20
>>   	dsi->state |=3D DSIM_STATE_ENABLED;
>> +}
>> +
>> +static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
>> +				       struct drm_atomic_state *state)
>> +{
>> +	struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
>> +	int ret;
>>  =20
>>   	/*
>>   	 * For Exynos-DSIM the downstream bridge, or panel are expecting
>> @@ -1665,12 +1672,6 @@ static void samsung_dsim_atomic_pre_enable(struct=
 drm_bridge *bridge,
>>   		if (ret)
>>   			return;
>>   	}
>> -}
>> -
>> -static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
>> -				       struct drm_atomic_state *state)
>> -{
>> -	struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
>>  =20
>>   	samsung_dsim_set_display_mode(dsi);
>>   	samsung_dsim_set_display_enable(dsi, true);
>>
> Best regards



Return-Path: <stable+bounces-242054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAKTOuIY82nNxAEAu9opvQ
	(envelope-from <stable+bounces-242054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:54:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F849F805
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42121300CC1B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF33FE675;
	Thu, 30 Apr 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRJkMoYr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089234A773
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539145; cv=none; b=tT6lLchUq9bMRmxKfP13Sfe4wN3xgli0rrP+BzF+BjDnWP7b9WWbmI1gEm0AtWU2JRy67O88HFpLXfh3ij3L2oqmzg34FwxKGZe73rKdhlh6N+XXQGfUxj1jl+JXqbA+sKXamhG5YqL0uJ06ypo4KikjJPySM0zKBFF1CadIcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539145; c=relaxed/simple;
	bh=nh8FeWVgZMmI1Zz40jRCGrGIcuEoqQHDX1Vv7w5wdMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFIvBspZ8ZUihDjP/2Trm7zP6daJ1wgdmTb8o+2Bg25MtrX5BbxBkMeopDtE2iiURBK1zrC6de5UTFLVauMerYfic6ZKCpn1x51jjIRYdCe1BLQiBYZfBwyvmnrZwSYbXp3d1k+GLHQfKImLzr4lXKlL58eqlOIL5iFrsChDYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRJkMoYr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-444826c16ffso592433f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777539142; x=1778143942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nh8FeWVgZMmI1Zz40jRCGrGIcuEoqQHDX1Vv7w5wdMA=;
        b=IRJkMoYrC0NcKTcQ3H3pr9hjyjetobaGvdK5RBUJwJ1S+MM6BCoP2a+x0pzDNqBpeU
         5ahl4AiWlPLmFVE4dnPImZmKr46avcwA4Aq9ZP75Av3dJ94oLQl44V0NGJ9jr8EqLCJQ
         b7a56kJWJbCcZOCGmFpV5ssUO+tpF9l9IW0ztcl9MTU+Vtvr6pfeMkVNrGzWkBjhQxap
         qn9IFmGIY/n+12JzU3C6TOXWj/PCtXMx9+KOxcgVxQsYWv4dfS9IatkVwc+vKGNC/ULl
         uZ2R5uO44CYv/gHfRz5m/FGkQLEkgUWbPedOPY26ycaHnSZ6CKyqsfd3KwUWeCQbnabp
         pjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539142; x=1778143942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh8FeWVgZMmI1Zz40jRCGrGIcuEoqQHDX1Vv7w5wdMA=;
        b=iZ356kgixyVtth2Y0gz00LKgc6iP+gKa74umRB+EZVoHD7Mp6lxeir7WBFSFN7j4qP
         pa8v0Tnz/GaAzkvYWs/sT4rsZ/29ZMr72hAVkJo1fCr1ECjWzO/yjZlnN8VDXqa/qGhg
         vtDjvcXpnCRGqyBaW220sihHlASblEJEv9DKcoxxq/KSooVPq3dudvjApbw13cpO4LpF
         DBn7z3hh+QRD9a/6772M0caUkYxoICNtflXwo7y0iBfJxoZ82Ne/a2u1gbyHnFwsw6Hr
         u7ccVWrtKgT7epH0V0BPo90JJaKiASoT49uDYUglxpTbEbPdYyA2ERUXw3CKzq1NG0Tz
         yqWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JSvX7ucR2pZ3K30rLWX1o+/vm1rQMizQflPRW4A1KVLkvM6/y8mjF5IrYa0t95Z2HjfVyATs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHDRREgnwh9b+ICu71QyGzGYMh8FPU3gIpLsomyEuzh6UUFsM
	FGfzNTaLiD81ZUfknRrNHKCQZRxDMPz3X+BW2t5Xnqp7Rc9TzIqvCASS
X-Gm-Gg: AeBDiev/CDMiqePUTaNo5sBhzADeGu2mchU560Mg9blSnETbiWTie+4Apjc0NTdGflu
	OHf6o+wSD4SCJT+h9V0yjHi4tEtlIrE5f4WJL+X0hhVbaWs35PH8c3lN6ED9qn4wFipJfghz6xz
	27F6pyVFFR3cmnMctkk9TPlGPFBApkcRhKZYCC5NJ3TK0Mdg+qtzbvf05B9JyqIqnTu0NCHrvMT
	KR0RpLWnsr1Fv0FNfb9Ska13uzIMdBjUgFd9HwAVfJ2bB/l9OfFtv1i94TcF5S+2cK1tYPpbic/
	07JY96WasObKm7pum108JOjfYtvmfZtrJBueV6mjYKppA/dbCVsj0Z52pgcBZkQpbCAYZf1UStH
	g2SvTtmAfdx9yVH1I9mvptCfaUMU4vDy29GVsHT0932wvQHPuwmptQbapA1kSudEoxP6E1rLpNj
	zVtQ/STBCzRWg/btrG7b/fH+FlCi4DzsmAF4OFYMUZpOf+Bux1OIs+ThRq
X-Received: by 2002:a05:6000:2486:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4493fa014admr2984866f8f.33.1777539141830;
        Thu, 30 Apr 2026 01:52:21 -0700 (PDT)
Received: from vitor-nb.Home (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217b20sm11157241f8f.22.2026.04.30.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:52:21 -0700 (PDT)
Message-ID: <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
From: Vitor Soares <ivitro@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 30 Apr 2026 09:52:19 +0100
In-Reply-To: <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
References: <20260407144142.1420354-2-ivitro@gmail.com>
	 <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 662F849F805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242054-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]

Hi Luca,

Thanks you for the feedback.

On Thu, 2026-04-30 at 10:10 +0200, Luca Ceresoli wrote:
> On Tue Apr 7, 2026 at 4:41 PM CEST, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> > for both runtime PM and system sleep. This causes the DSI clocks to be
> > disabled twice: once during runtime suspend and again during system
> > suspend, resulting in a WARN message from the clock framework when
> > attempting to disable already-disabled clocks.
> >=20
> > [=C2=A0=C2=A0 84.384540] clk:231:5 already disabled
> > [=C2=A0=C2=A0 84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c=
:1181
> > clk_core_disable+0xa4/0xac
> > ...
> > [=C2=A0=C2=A0 84.579183] Call trace:
> > [=C2=A0=C2=A0 84.581624]=C2=A0 clk_core_disable+0xa4/0xac
> > [=C2=A0=C2=A0 84.585457]=C2=A0 clk_disable+0x30/0x4c
> > [=C2=A0=C2=A0 84.588857]=C2=A0 cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> > [=C2=A0=C2=A0 84.593651]=C2=A0 pm_generic_suspend+0x2c/0x44
> > [=C2=A0=C2=A0 84.597661]=C2=A0 ti_sci_pd_suspend+0xbc/0x15c
> > [=C2=A0=C2=A0 84.601670]=C2=A0 dpm_run_callback+0x8c/0x14c
> > [=C2=A0=C2=A0 84.605588]=C2=A0 __device_suspend+0x1a0/0x56c
> > [=C2=A0=C2=A0 84.609594]=C2=A0 dpm_suspend+0x17c/0x21c
> > [=C2=A0=C2=A0 84.613165]=C2=A0 dpm_suspend_start+0xa0/0xa8
> > [=C2=A0=C2=A0 84.617083]=C2=A0 suspend_devices_and_enter+0x12c/0x634
> > [=C2=A0=C2=A0 84.621872]=C2=A0 pm_suspend+0x1fc/0x368
> >=20
> > To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> > SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
>=20
> This is not what the patch does, the patch uses RUNTIME_PM_OPS.
>=20

I missed changing it. I will send another version fixing the commit message
to RUNTIME_PM_OPS().

> > _enable()/_disable() hooks managed by the DRM framework for both
> > runtime and system-wide PM.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# 6.1.x
> > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > v3 -> v4
> > =C2=A0- Add Reviewed-by from Tomi Valkeinen
> > =C2=A0- Rebase on top of drm-misc-fixes
> > =C2=A0- Verified issue still present on current mainline
> >=20
> > v2 -> v3
> > =C2=A0- Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-=
function]
> > =C2=A0- Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-f=
unction]
> >=20
> > v1 -> v2
> > =C2=A0- Rely only on SET_RUNTIME_PM_OPS() for the PM.
> >=20
> > =C2=A0drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
> > =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > index 0dd85e26248c..e07a9892df4e 100644
> > --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > @@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_op=
s =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.transfer =3D cdns_dsi_=
transfer,
> > =C2=A0};
> >=20
> > -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> > +static int cdns_dsi_resume(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> >=20
> > @@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> >=20
> > -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> > +static int cdns_dsi_suspend(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> >=20
> > @@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> >=20
> > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > cdns_dsi_resume,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
> > +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RUNTIME_PM_OPS(cdns_dsi_susp=
end, cdns_dsi_resume, NULL)
> > +};
>=20
> Not an expert here, but the docs [0] suggest using
> DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?
>=20
> [0]
> https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-L4=
56
>=20
> Luca
>=20

In an earlier discussion [0], we concluded that bridges/panels should only =
deal
with runtime PM:

[0]
https://lore.kernel.org/all/a1cf67da-a0cb-46c5-b22b-10ecca8ab383@ideasonboa=
rd.com/

Best regards,
Vitor Soares


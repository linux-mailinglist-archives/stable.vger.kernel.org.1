Return-Path: <stable+bounces-139728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2FAA9B02
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C173BDD24
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87F26B0A9;
	Mon,  5 May 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQmsDdYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592D1AC458;
	Mon,  5 May 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467242; cv=none; b=uiMkCH9N8t0cWgdYECyM+vkCG946kFdA4CT+k6ZTM65uamsVbqn43k5CE8zijtURcWD5SWRrOlqFE+XOW8jnsqLrTDudIw38UCIiB0pentf8kMDuhK55Chjc7moOc3iaRFGcwKYX00JZsKWJ5Q2RVAlri7lrFjNkonAKFC212xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467242; c=relaxed/simple;
	bh=X2kc3Prodr52+tt+XwRWEYAo9atVWpR9h9AK5kJEn44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJC63Eq6aCeO+zZunZ4Sv3AZEW/uopiMKuSkduRt0JoWXh8WecoPd59aWR8eYubMZxGqA2rTf7ZcWfMBLA4528ib+n0cYhdyOL4qyRq9bnE4KI+lYvPzKO1Q0S+QjJo704IPc4HFIUREPGDKTuGbCTDhiT/HrsHQC5qaM30e57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQmsDdYt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31992985e9.2;
        Mon, 05 May 2025 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746467238; x=1747072038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X2kc3Prodr52+tt+XwRWEYAo9atVWpR9h9AK5kJEn44=;
        b=TQmsDdYtFahr2MfZ4EZrRy0NVHWDYPJAOWLUDk6o6/rTbVR7i0GtmuydD4/82zd/qR
         KTBNuHEGxNOG56WtAQqFOMMXc0pJPAJmOKhof1EN5+qefCEg17h4iMqHfRL7PRWwk0Qj
         qOE9JhTGrjTVo4gT+KsgK32eBXtKZ2OEBb5AxRmRMAmGAtXVTrsBWSMFb5ag7xSwD0Hd
         ifTDy9kHOl92CMV0Xn3x1/yyoZfRr+te5QTUjLgkKMZ0imq7IgF2M6h8wRVYxgVQiZ9B
         qgxzmuydRrq4Qd81Ki61vqFMluOyunABfExOEIxsejf2UUbNiR/fv+ADEaLdVvSEvpyS
         k08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746467238; x=1747072038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2kc3Prodr52+tt+XwRWEYAo9atVWpR9h9AK5kJEn44=;
        b=bXZC6T7Cas7y8IsCDQpbmujprAIF74nLYwvihggdk+4DqmGUQdQRSOmdKSsQwSbQ04
         UqlH64Sug39GhnPCdb+2I3KnZ+VlLi8+DhDI9h+czlmuo+RVm54bqzKTsP3JZu7HeAB7
         ebcgGR4F/DM4eSyfpJXYZS0Br1YUvRUOh7UsT8075tXCAsEA7uPsnGW+NYpWOze+y2Ru
         PeCQGkAqNyf9NGUT/L8F/3x3zakDasXReUAKqyfaBeiEZMuhxiq/UUM3e2en5fxFX5w9
         s7Ogsv2iBHDCrpmDroRpPg87DMX2VNLNEc9dPpmRR3IN8uXE5xPSIKCkrQat4KzlV492
         D/lw==
X-Forwarded-Encrypted: i=1; AJvYcCV8H+VpQ4GBhO59iVo94cAbyVpIDSDkhpY7/veX66SFd0ElXpx9uYObNds61D+8b3M5lsSL5X1MGgQWsrU=@vger.kernel.org, AJvYcCXrO7xuBiZaAWLAHv9bCSPcTfZAMDpRl6HI2ybdXfwt3q2TPJWJnxYovksRR6VYvE1HH8KckKx6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywssr5V3vygfEaX2RGlN5ukSVbOu3cVJHeUswQyzPA9rpVyE4MO
	m8pLVPWSFZ+bk+GDVlrQ8bx3BlEeodBwWPnmOKJF8Ld98Bv5pC3Z
X-Gm-Gg: ASbGnct+uahc51INNb+c5BGjCAHsTeKE+P7NIW3tPRT/qNLdMB05I7+S3MXbwW9Viwv
	RB4Cg7Urh1Qh1jT5sx5HAkHV7FueixS2IdJGT3GB8UaYxv1YXE9pfhvsxzIVRA+Mj39AsWyL/I5
	9GTCidjBOd6AU/GeW94yYm7rABUs8O2c9bB6ab2zu814VFK65SGn2qsy6dEdU333GYD1rLb7YBV
	Sb60SFa5FZl4IMKBW5xh0iwdaxPlIYDaC2rFgoGQ7e1mvPrVJbQ1KjeOhZlWeh8f7VzQeyTK/+y
	xBt6tcQ4tWfxFi3e1oklCr71yw2kchOv6acA1ojFcDw9gW4yzyGdJCUx7a27fb6EZ5tSFaZ8/hi
	rl2vbvAlr
X-Google-Smtp-Source: AGHT+IFmCQpRtFn1Zjb+tUjdWu7qFe1M0ldfr4wRA07rwx1580YsSLKS19pVqFkxPfoHPZSQ9Ii0ug==
X-Received: by 2002:a05:600c:5010:b0:441:bf4e:89c8 with SMTP id 5b1f17b1804b1-441c48b02e1mr79550235e9.3.1746467237971;
        Mon, 05 May 2025 10:47:17 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e602:d900:329e:4b86:b487:53d8? ([2001:8a0:e602:d900:329e:4b86:b487:53d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d1548sm140647505e9.11.2025.05.05.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:47:17 -0700 (PDT)
Message-ID: <33ff9db89056a683e393de09c41d7c98bdbc045e.camel@gmail.com>
Subject: Re: [PATCH v1] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
From: Vitor Soares <ivitro@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org, Aradhya
 Bhatia <aradhya.bhatia@linux.dev>,  Jayesh Choudhary <j-choudhary@ti.com>,
 stable@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Date: Mon, 05 May 2025 18:47:16 +0100
In-Reply-To: <a1cf67da-a0cb-46c5-b22b-10ecca8ab383@ideasonboard.com>
References: <20250428094048.1459620-1-ivitro@gmail.com>
	 <fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com>
	 <ec35d40dcd06ddbcfc0409ffa01aaee22c601716.camel@gmail.com>
	 <a1cf67da-a0cb-46c5-b22b-10ecca8ab383@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 18:30 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 05/05/2025 17:45, Vitor Soares wrote:
> > On Tue, 2025-04-29 at 09:32 +0300, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > On 28/04/2025 12:40, Vitor Soares wrote:
> > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > >=20
> > > > The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callb=
acks
> > > > for both runtime PM and system sleep. This causes the DSI clocks to=
 be
> > > > disabled twice: once during runtime suspend and again during system
> > > > suspend, resulting in a WARN message from the clock framework when
> > > > attempting to disable already-disabled clocks.
> > > >=20
> > > > [=C2=A0=C2=A0 84.384540] clk:231:5 already disabled
> > > > [=C2=A0=C2=A0 84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/c=
lk.c:1181
> > > > clk_core_disable+0xa4/0xac
> > > > ...
> > > > [=C2=A0=C2=A0 84.579183] Call trace:
> > > > [=C2=A0=C2=A0 84.581624]=C2=A0 clk_core_disable+0xa4/0xac
> > > > [=C2=A0=C2=A0 84.585457]=C2=A0 clk_disable+0x30/0x4c
> > > > [=C2=A0=C2=A0 84.588857]=C2=A0 cdns_dsi_suspend+0x20/0x58 [cdns_dsi=
]
> > > > [=C2=A0=C2=A0 84.593651]=C2=A0 pm_generic_suspend+0x2c/0x44
> > > > [=C2=A0=C2=A0 84.597661]=C2=A0 ti_sci_pd_suspend+0xbc/0x15c
> > > > [=C2=A0=C2=A0 84.601670]=C2=A0 dpm_run_callback+0x8c/0x14c
> > > > [=C2=A0=C2=A0 84.605588]=C2=A0 __device_suspend+0x1a0/0x56c
> > > > [=C2=A0=C2=A0 84.609594]=C2=A0 dpm_suspend+0x17c/0x21c
> > > > [=C2=A0=C2=A0 84.613165]=C2=A0 dpm_suspend_start+0xa0/0xa8
> > > > [=C2=A0=C2=A0 84.617083]=C2=A0 suspend_devices_and_enter+0x12c/0x63=
4
> > > > [=C2=A0=C2=A0 84.621872]=C2=A0 pm_suspend+0x1fc/0x368
> > > >=20
> > > > To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> > > > DEFINE_RUNTIME_DEV_PM_OPS(), which avoids redundant suspend/resume =
calls
> > > > by checking if the device is already runtime suspended.
> > > >=20
> > > > Cc: <stable@vger.kernel.org> # 6.1.x
> > > > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 ++=
+++-----
> > > > =C2=A0=C2=A0 1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > index b022dd6e6b6e..62179e55e032 100644
> > > > --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > @@ -1258,7 +1258,7 @@ static const struct mipi_dsi_host_ops cdns_ds=
i_ops
> > > > =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.transfer =3D=
 cdns_dsi_transfer,
> > > > =C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=20
> > > > -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> > > > +static int cdns_dsi_resume(struct device *dev)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_d=
si *dsi =3D dev_get_drvdata(dev);
> > > > =C2=A0=C2=A0=20
> > > > @@ -1269,7 +1269,7 @@ static int __maybe_unused cdns_dsi_resume(str=
uct
> > > > device *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> > > > +static int cdns_dsi_suspend(struct device *dev)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_d=
si *dsi =3D dev_get_drvdata(dev);
> > > > =C2=A0=C2=A0=20
> > > > @@ -1279,8 +1279,8 @@ static int __maybe_unused cdns_dsi_suspend(st=
ruct
> > > > device *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > > > cdns_dsi_resume,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 NULL);
> > > > +static DEFINE_RUNTIME_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend=
,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdns_dsi_resume, NULL);
> > >=20
> > > I'm not sure if this, or the UNIVERSAL_DEV_PM_OPS, is right here. Whe=
n
> > > the system is suspended, the bridge drivers will get a call to the
> > > *_disable() hook, which then disables the device. If the bridge drive=
r
> > > would additionally do something in its system suspend hook, it would
> > > conflict with normal disable path.
> > >=20
> > > I think bridges/panels should only deal with runtime PM.
> > >=20
> > > =C2=A0=C2=A0 Tomi
> > >=20
> >=20
> > In the proposed change, we make use of pm_runtime_force_suspend() durin=
g
> > system-wide suspend. If the device is already suspended, this call is a
> > no-op and disables runtime PM to prevent spurious wakeups during the
> > suspend period. Otherwise, it triggers the device=E2=80=99s runtime_sus=
pend()
> > callback.
> >=20
> > I briefly reviewed other bridge drivers, and those that implement runti=
me
> > PM appear to follow a similar approach, relying solely on runtime PM
> > callbacks and using pm_runtime_force_suspend()/resume() to handle
> > system-wide transitions.
>=20
> Yes, I see such a solution in some of the bridge and panel drivers. I'm=
=20
> probably missing something here, as I don't think it's correct.
>=20
> Why do we need to set the system suspend/resume hooks? What is the=20
> scenario where those will be called, and the=20
> pm_runtime_force_suspend()/resume() do something that's not already done=
=20
> via the normal DRM pipeline enable/disable?
>=20
> =C2=A0 Tomi
>=20

I'm not a DRM expert, but my understanding is that there might be edge case=
s
where the system suspend sequence occurs without the DRM core properly disa=
bling
the bridge =E2=80=94 for example, due to a bug or if the bridge is not boun=
d to an
active pipeline. In such cases, having suspend/resume callbacks ensures tha=
t the
device is still properly suspended and resumed.

Additionally, pm_runtime_force_suspend() disables runtime PM for the device
during system suspend, preventing unintended wakeups (e.g., via IRQs, delay=
ed
work, or sysfs access) until pm_runtime_force_resume() is invoked.

From my perspective, the use of pm_runtime_force_suspend() and
pm_runtime_force_resume() serves as a safety mechanism to guarantee a well-
defined and race-free state during system suspend.

Best regards,
Vitor Soares


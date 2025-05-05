Return-Path: <stable+bounces-139705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA2AA961B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AE4189C05B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B025C83C;
	Mon,  5 May 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtR3FyM+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC6204C0F;
	Mon,  5 May 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456314; cv=none; b=QWDZ30VzF/S/Hu6fHfb/FlK9BxlyoevZUavoMXTbE6+336sKYEC+GdEIBxC6op2ui53ugOFZG9iseBEab9TJ/Y9lnv0al/JY8r1Y5Po8E0C5VWuzyHeTAkftfsgziEYscU16ar2thN4GkLib6+oAtv5Netc6/T7Ajw+b7Ye8twc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456314; c=relaxed/simple;
	bh=Aak0zC7hFrMtPsSvTJIW47N4jkePCGca82zdtPNT7wQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TQe4Dph/Jz74lgSZ8XcJAZzaDpQnkZeierrBaWZnaPrznBkPqww5p/jZrRAQFOjiY3Q2QZ+rGW4NzT3u5EyFK2W85+JEYbuG5Czq4sYssMxg6HG3x2esZk9ueAr6PgaJaZgUGFR6gyN1vsVNwNxuAl7DXn8ZtIjb3L+e7GY2S6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtR3FyM+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a064a3e143so1985229f8f.3;
        Mon, 05 May 2025 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746456310; x=1747061110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aak0zC7hFrMtPsSvTJIW47N4jkePCGca82zdtPNT7wQ=;
        b=YtR3FyM+M1njA+QFd+jZ7kYV5c5RLAu09z01T7GjRIFwsYKEO/meO4mB6HnR8pFHPx
         RNnDIQ7MAak7TOHX3smMGBu4+uupRSRaMfb47ugSqU21MaYP/MMgyzIULH15vbtyqU9X
         VScg5Hl5hCniFgZG5RpFlhwd/mDdWYySuJJToQOrUSR0J8Sx7H08ku1voV/JORff9vQL
         M0DuHqOiYWVxgE9ubflyqywtS+zrJPWZazowxc3QWEl7ymii+KDCUpchdotzw5HGhtXH
         29VqLKAEpieKI6BIZouULxAEoxs8a+4hllEgw8TQq5nTnZRfYcAf3eNqJnQ/5boFGAli
         AWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746456310; x=1747061110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aak0zC7hFrMtPsSvTJIW47N4jkePCGca82zdtPNT7wQ=;
        b=FodfN1REHZk+7154w9M1tF58N+p4oODxDcrwQo+E5e6ZL96ZhTpiAyBEwDjDqzzj4W
         O16WCE11CYaKG1lOQAvyciL9H30jCnzDp3ZsomywGqP56+kIgMESnj1QOOOjjWhoatmh
         wyyraOZtinNlyc9wS5Ly5N5eSSVDidcRkaz+W8fRlXSEZSYGpl6mqb7HudOqWtQzYlpK
         fk8mI6nZ6U09HApZTmfZRmOGuXf7FHL1t290GmkRtUrSUAFNyXPhWvIHsK7SYwNPoNyj
         158tWCZ/gWNuQu3hAJ9sI39C5+0U/wpHaYz4qpuqifONQtkX63JLi0hS/KWzJg7mnapI
         G4ow==
X-Forwarded-Encrypted: i=1; AJvYcCVYxyvAXE2HeIt3tvVbyXyIrnsMTOtveu0BpMD7YyFxm0ymutDiJJXBOSbMuV+dnT/m04I3BMvOa05fr64=@vger.kernel.org, AJvYcCXFIGooLoaDuHWepuxYl/3mOyQHdve10i7ug7rXtqC0/YD7Rf3lD6NKpnMjTvKxu5pnDz0ig2U/@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6vHL4DpH1XXSh7EaeCZAF7hVXP66BMpoNzfQHttyHYWY2zKk
	TDB9xCwqS6UiR9txxMVszSXlSPdDLg9JuNyftY9zmEAA6jTvKr1I
X-Gm-Gg: ASbGncsEBuqe/moNtfrrsPkxiDbB+FirJahRWKGTjbl7pS80DkgiWxp00eGnbv0b5Vi
	PfWK9EGAlsOgRBn+QcdXvul2mjQC32/v/cXhhEB+XfJ1HRhb9v9c3v2mSziBRBHdljsobiO7POw
	C1aAsIk8vcbGH9DEv5KlbL+sOK0PUi+G3w8SzD5i1p+eDv3IOt+aWQQS+6vfehFHexFrzcQ3+92
	/dxyVJwZifwk15QGLC3hIdOm4XlK6CGQe1cV1h6TqnkUZgOpok6g/0jGxt+FwCceFOC5Tp2yAKq
	gLishtnI84Himdc4KyQSPPqCk4o2uJw6EmZLbR9PJoe6EJk/FQ3H72Sm39clHEQgmUsG6e0uChT
	LHxmvXvjA
X-Google-Smtp-Source: AGHT+IHjK1h3k/XdxelFNq/AmylJkok9PMTAM8PU6xwHm3aH5PDmmrprgcYcfC9J9d+yZNo3RyZVzg==
X-Received: by 2002:a5d:5f41:0:b0:3a0:85b5:463b with SMTP id ffacd0b85a97d-3a09fdd83bamr5193375f8f.48.1746456310282;
        Mon, 05 May 2025 07:45:10 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e602:d900:8437:41c5:1bd4:5790? ([2001:8a0:e602:d900:8437:41c5:1bd4:5790])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28082sm180278025e9.34.2025.05.05.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:45:09 -0700 (PDT)
Message-ID: <ec35d40dcd06ddbcfc0409ffa01aaee22c601716.camel@gmail.com>
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
Date: Mon, 05 May 2025 15:45:08 +0100
In-Reply-To: <fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com>
References: <20250428094048.1459620-1-ivitro@gmail.com>
	 <fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 09:32 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 28/04/2025 12:40, Vitor Soares wrote:
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
> > DEFINE_RUNTIME_DEV_PM_OPS(), which avoids redundant suspend/resume call=
s
> > by checking if the device is already runtime suspended.
> >=20
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 +++++-----
> > =C2=A0 1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > index b022dd6e6b6e..62179e55e032 100644
> > --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > @@ -1258,7 +1258,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_op=
s =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.transfer =3D cdns_dsi_=
transfer,
> > =C2=A0 };
> > =C2=A0=20
> > -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> > +static int cdns_dsi_resume(struct device *dev)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> > =C2=A0=20
> > @@ -1269,7 +1269,7 @@ static int __maybe_unused cdns_dsi_resume(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0 }
> > =C2=A0=20
> > -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> > +static int cdns_dsi_suspend(struct device *dev)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cdns_dsi *dsi =
=3D dev_get_drvdata(dev);
> > =C2=A0=20
> > @@ -1279,8 +1279,8 @@ static int __maybe_unused cdns_dsi_suspend(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0 }
> > =C2=A0=20
> > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > cdns_dsi_resume,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
> > +static DEFINE_RUNTIME_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdns_dsi_resume, NULL);
>=20
> I'm not sure if this, or the UNIVERSAL_DEV_PM_OPS, is right here. When=
=20
> the system is suspended, the bridge drivers will get a call to the=20
> *_disable() hook, which then disables the device. If the bridge driver=
=20
> would additionally do something in its system suspend hook, it would=20
> conflict with normal disable path.
>=20
> I think bridges/panels should only deal with runtime PM.
>=20
> =C2=A0 Tomi
>=20

In the proposed change, we make use of pm_runtime_force_suspend() during
system-wide suspend. If the device is already suspended, this call is a
no-op and disables runtime PM to prevent spurious wakeups during the
suspend period. Otherwise, it triggers the device=E2=80=99s runtime_suspend=
()
callback.

I briefly reviewed other bridge drivers, and those that implement runtime
PM appear to follow a similar approach, relying solely on runtime PM
callbacks and using pm_runtime_force_suspend()/resume() to handle
system-wide transitions.

Best regards,
Vitor Soares



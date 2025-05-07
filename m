Return-Path: <stable+bounces-142067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A8AAE2A4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68F71C447BB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061728C2A7;
	Wed,  7 May 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+X1VznF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC52459F0;
	Wed,  7 May 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627318; cv=none; b=hjMOCqLZJod+ubXzJ6bHoqs2lASjsQpgZNrwRqQrsr0ovGw6fsXTStVmzv98FnAjsYRmwEK11H9/OD8RinrMVH8aTsFgZef7CK4JiV3CWN4RiZvM7wxCEfH80M06tKVyRU5rEDDT14XGdgug8CO/46aPDZtp+bV3bU9Yl+zucn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627318; c=relaxed/simple;
	bh=7WtQ6Um5X0TvKCPDhK1Mb2WYpAl7gSSomaptfAFF9Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHtS1iD864fmxvW5qkeMRq+cLvHXG2BCZSY8xNMsn7MkmNgSCvqKcl7nuV+F6JBs1phgkI/BA9wZipO91NfbSZ7/jidJL00dYmTVZ0VBFojDkMnoPmtp1VyUn8IVfF6SbFxUEml8eHUgTsPy92XMFNGo0N1KPF04d/5K+pelnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+X1VznF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so3246359f8f.2;
        Wed, 07 May 2025 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746627314; x=1747232114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WtQ6Um5X0TvKCPDhK1Mb2WYpAl7gSSomaptfAFF9Vk=;
        b=c+X1VznF+3hmA83ktPHp6xEOjzkN+7kakLsFFm+RRieGYaL48occDeTWxX1hOm5T3e
         2CILW7OjSkKJ2HkMiyGtw421goCXhd6dFdBLGvsjWTop3P8cpeN9rfNMKvXLkUlYd334
         A117JiJ6pxRnxEY9wsggBY43wlQe9OY6LvDVFvCMZhboYX79SRag55FApO5U6aFIttza
         PMCjbOto1gIgQos77/viJQW0iSVZklfMOBs99/AjliidZzuIWKQTL06laPzNmSCWt3uF
         +rYTzBcFCWa1436Cb/XY1gkW1QJZwKyJCWCsL2bAKgT75rVYRTaZsuNbHLnU3/5cVseX
         3Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627314; x=1747232114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WtQ6Um5X0TvKCPDhK1Mb2WYpAl7gSSomaptfAFF9Vk=;
        b=ESkBs9TlqfkasVIakX3seG/+joYcJXMQEoaUEk5dh/bH6oSig4iNESfvYt6Acz5Q4n
         wqsOqdJij+jpWblCNSl+GyVn66c7NRV6ok9Kf0S9JiT0pby6CsXxRtPjqX52/PDTFBfL
         /jEdL/769UJ3THwQ29sEN4VA7eHPmQGNAKCqiegEqs1HwCs+62BTZw5or8YuxM2LfUvz
         J9Nl4xKfyxS742VfE0hhk3eta4Ldia4dGcC1JhSz5kAgUML0s3az56onEVYPD3sMbd7u
         BtfZgSRlTrLA1+i84/hKpQ3NzuApxUXPoKNoV5vLFB1wB7FRY1p7MVv+DwOoUwmQpD4R
         bmYg==
X-Forwarded-Encrypted: i=1; AJvYcCVJB98FldJOsk0wxktP1uBDJKcAIaK/wMoMOQyKyf1USa/sBQSdChRp+9MAD5UGomDA+jjjbYa7fI7I67M=@vger.kernel.org, AJvYcCVig0xBFEzMWx655/rusWjItVuFmATEN9cD6iujAuwC48KmYJIwcUTzaXZpsZlRXuTVWrKA5CBm@vger.kernel.org
X-Gm-Message-State: AOJu0YyeI83v0/9eMPQyWRCTn5A9GM1JH0Eo8J7DklaXtqaizvNqDqye
	UEFgXejrSxpnRA8qSnZ0W6fJmB42i/+DI8d4OEZLCblyTdYdF9U+
X-Gm-Gg: ASbGncsfc/YVYrR3aE1fPZCErKrojUhIFk3Kg0CsHYDRZ1U+49iqTNRhOyCwnjkFtLH
	FrnKa7ISCEyEohDGxcYQSatvPmUj2wJ+JJzsL9ukbDKZxClXiy1T4HO2lVclpoyv0/N9rR5/WNr
	cgQnXyqvFyYAPZF7+VwmvE86hkyZDAm0oK+Y2kjBYGA+FrmCOvgh1rBC3jenNmpJuHKqA7/SSNM
	3ABl2ZJHXDulYfDvkgtIOxt466gC3lR4rmeaRYruIuGUkAca+SSkqw9EaZHFT1EH/H5r48Vrxoy
	WwZXryt+SIzTZpsF8S47ppsn414uizOEtvSsuBk5VXGrSVdA7HDkphZu/s1AhWfdpfJnwmxMgWu
	TxK8c/CUS
X-Google-Smtp-Source: AGHT+IHvBC6S3A1QDeoRnBhM5NVsWSAh/gza5DkS6b37h62qIpBcq5I7hq1w2EDQrc0wNNFyBb2neA==
X-Received: by 2002:a05:6000:1a8b:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-3a0b49d7413mr3423382f8f.33.1746627313930;
        Wed, 07 May 2025 07:15:13 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e602:d900:beb4:8333:a918:524e? ([2001:8a0:e602:d900:beb4:8333:a918:524e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328f0fsm2597345e9.7.2025.05.07.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:15:13 -0700 (PDT)
Message-ID: <4e5a938cb36f075596836aea98b54ae44a65c99d.camel@gmail.com>
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
Date: Wed, 07 May 2025 15:15:12 +0100
In-Reply-To: <de4cacee-56ad-4700-b329-7853abc77ea5@ideasonboard.com>
References: <20250428094048.1459620-1-ivitro@gmail.com>
	 <fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com>
	 <ec35d40dcd06ddbcfc0409ffa01aaee22c601716.camel@gmail.com>
	 <a1cf67da-a0cb-46c5-b22b-10ecca8ab383@ideasonboard.com>
	 <33ff9db89056a683e393de09c41d7c98bdbc045e.camel@gmail.com>
	 <de4cacee-56ad-4700-b329-7853abc77ea5@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 21:03 +0300, Tomi Valkeinen wrote:
Hello,

> Hi,
>=20
> On 05/05/2025 20:47, Vitor Soares wrote:
> > On Mon, 2025-05-05 at 18:30 +0300, Tomi Valkeinen wrote:
> > > Hi,
> > >=20
> > > On 05/05/2025 17:45, Vitor Soares wrote:
> > > > On Tue, 2025-04-29 at 09:32 +0300, Tomi Valkeinen wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 28/04/2025 12:40, Vitor Soares wrote:
> > > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > > >=20
> > > > > > The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided
> > > > > > callbacks
> > > > > > for both runtime PM and system sleep. This causes the DSI clock=
s to
> > > > > > be
> > > > > > disabled twice: once during runtime suspend and again during sy=
stem
> > > > > > suspend, resulting in a WARN message from the clock framework w=
hen
> > > > > > attempting to disable already-disabled clocks.
> > > > > >=20
> > > > > > [=C2=A0=C2=A0 84.384540] clk:231:5 already disabled
> > > > > > [=C2=A0=C2=A0 84.388314] WARNING: CPU: 2 PID: 531 at /drivers/c=
lk/clk.c:1181
> > > > > > clk_core_disable+0xa4/0xac
> > > > > > ...
> > > > > > [=C2=A0=C2=A0 84.579183] Call trace:
> > > > > > [=C2=A0=C2=A0 84.581624]=C2=A0 clk_core_disable+0xa4/0xac
> > > > > > [=C2=A0=C2=A0 84.585457]=C2=A0 clk_disable+0x30/0x4c
> > > > > > [=C2=A0=C2=A0 84.588857]=C2=A0 cdns_dsi_suspend+0x20/0x58 [cdns=
_dsi]
> > > > > > [=C2=A0=C2=A0 84.593651]=C2=A0 pm_generic_suspend+0x2c/0x44
> > > > > > [=C2=A0=C2=A0 84.597661]=C2=A0 ti_sci_pd_suspend+0xbc/0x15c
> > > > > > [=C2=A0=C2=A0 84.601670]=C2=A0 dpm_run_callback+0x8c/0x14c
> > > > > > [=C2=A0=C2=A0 84.605588]=C2=A0 __device_suspend+0x1a0/0x56c
> > > > > > [=C2=A0=C2=A0 84.609594]=C2=A0 dpm_suspend+0x17c/0x21c
> > > > > > [=C2=A0=C2=A0 84.613165]=C2=A0 dpm_suspend_start+0xa0/0xa8
> > > > > > [=C2=A0=C2=A0 84.617083]=C2=A0 suspend_devices_and_enter+0x12c/=
0x634
> > > > > > [=C2=A0=C2=A0 84.621872]=C2=A0 pm_suspend+0x1fc/0x368
> > > > > >=20
> > > > > > To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> > > > > > DEFINE_RUNTIME_DEV_PM_OPS(), which avoids redundant suspend/res=
ume
> > > > > > calls
> > > > > > by checking if the device is already runtime suspended.
> > > > > >=20
> > > > > > Cc: <stable@vger.kernel.org> # 6.1.x
> > > > > > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > > > > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/bridge/cadence/cdns-dsi-core=
.c | 10 +++++-----
> > > > > > =C2=A0=C2=A0=C2=A0 1 file changed, 5 insertions(+), 5 deletions=
(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > > > b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > > > index b022dd6e6b6e..62179e55e032 100644
> > > > > > --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > > > +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> > > > > > @@ -1258,7 +1258,7 @@ static const struct mipi_dsi_host_ops
> > > > > > cdns_dsi_ops
> > > > > > =3D {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.tr=
ansfer =3D cdns_dsi_transfer,
> > > > > > =C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> > > > > > +static int cdns_dsi_resume(struct device *dev)
> > > > > > =C2=A0=C2=A0=C2=A0 {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
uct cdns_dsi *dsi =3D dev_get_drvdata(dev);
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > @@ -1269,7 +1269,7 @@ static int __maybe_unused
> > > > > > cdns_dsi_resume(struct
> > > > > > device *dev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn 0;
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> > > > > > +static int cdns_dsi_suspend(struct device *dev)
> > > > > > =C2=A0=C2=A0=C2=A0 {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
uct cdns_dsi *dsi =3D dev_get_drvdata(dev);
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > @@ -1279,8 +1279,8 @@ static int __maybe_unused
> > > > > > cdns_dsi_suspend(struct
> > > > > > device *dev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn 0;
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
> > > > > > cdns_dsi_resume,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 NULL);
> > > > > > +static DEFINE_RUNTIME_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_sus=
pend,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdns_dsi_resume, NULL);
> > > > >=20
> > > > > I'm not sure if this, or the UNIVERSAL_DEV_PM_OPS, is right here.=
 When
> > > > > the system is suspended, the bridge drivers will get a call to th=
e
> > > > > *_disable() hook, which then disables the device. If the bridge d=
river
> > > > > would additionally do something in its system suspend hook, it wo=
uld
> > > > > conflict with normal disable path.
> > > > >=20
> > > > > I think bridges/panels should only deal with runtime PM.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 Tomi
> > > > >=20
> > > >=20
> > > > In the proposed change, we make use of pm_runtime_force_suspend() d=
uring
> > > > system-wide suspend. If the device is already suspended, this call =
is a
> > > > no-op and disables runtime PM to prevent spurious wakeups during th=
e
> > > > suspend period. Otherwise, it triggers the device=E2=80=99s runtime=
_suspend()
> > > > callback.
> > > >=20
> > > > I briefly reviewed other bridge drivers, and those that implement
> > > > runtime
> > > > PM appear to follow a similar approach, relying solely on runtime P=
M
> > > > callbacks and using pm_runtime_force_suspend()/resume() to handle
> > > > system-wide transitions.
> > >=20
> > > Yes, I see such a solution in some of the bridge and panel drivers. I=
'm
> > > probably missing something here, as I don't think it's correct.
> > >=20
> > > Why do we need to set the system suspend/resume hooks? What is the
> > > scenario where those will be called, and the
> > > pm_runtime_force_suspend()/resume() do something that's not already d=
one
> > > via the normal DRM pipeline enable/disable?
> > >=20
> > > =C2=A0=C2=A0 Tomi
> > >=20
> >=20
> > I'm not a DRM expert, but my understanding is that there might be edge =
cases
> > where the system suspend sequence occurs without the DRM core properly
> > disabling
> > the bridge =E2=80=94 for example, due to a bug or if the bridge is not =
bound to an
> > active pipeline. In such cases, having suspend/resume callbacks ensures=
 that
> > the
> > device is still properly suspended and resumed.
> >=20
> > Additionally, pm_runtime_force_suspend() disables runtime PM for the de=
vice
> > during system suspend, preventing unintended wakeups (e.g., via IRQs,
> > delayed
> > work, or sysfs access) until pm_runtime_force_resume() is invoked.
> >=20
> > =C2=A0From my perspective, the use of pm_runtime_force_suspend() and
> > pm_runtime_force_resume() serves as a safety mechanism to guarantee a w=
ell-
> > defined and race-free state during system suspend.
>=20
> But then we must be sure that the suspend sequence is just right.
>=20
> At least in tidss's case, tidss_drv.c has tidss_suspend() which calls=20
> drm_mode_config_helper_suspend(), which, if I recall right, will then=20
> disable the pipeline. This must happen before the bridge's system=20
> suspend call, otherwise the bridge might go to suspend while the=20
> pipeline is still running, which might cause errors on the still-running=
=20
> pipeline entities, and probably crash the bridge's disable() call. If a=
=20
> bridge is a platform device, I don't think there's any ordering between=
=20
> the tidss's and the bridge's suspend calls.
>=20
> If the bridge is not bound to a pipeline, why would it be enabled in the=
=20
> first place?
>=20
> For the bug case... We're in random territory, then. If the driver is=20
> bugging, are you sure it's safe and useful to suspend it? Or would it be=
=20
> better to not do anything...
>=20
> I'm not nacking the patch, as this approach seems to be used in multiple=
=20
> drivers. It just rings multiple alarm bells here, and I don't understand=
=20
> how exactly it's supposed to work. That said, the driver is using=20
> UNIVERSAL_DEV_PM_OPS(), so I think switching to=20
> DEFINE_RUNTIME_DEV_PM_OPS() is at least not worse (well, I can't be=20
> quite sure even about that =3D).
>=20
> =C2=A0 Tomi
>=20

I conducted further tests based on your concerns, specifically regarding th=
e
suspend ordering between the tidss_suspend() and the bridge suspend. Here a=
re my
observations:
 - The bridge (controlled via TI SCI PD) suspends after tidss_suspend(), wh=
ich
uses device-specific PM operations (platform_pm_suspend).
 - I attempted to influence the probe/suspend order via DT node placement a=
nd
delays, but that had no effect on suspend sequencing.
 - I added some debug prints and the pm_runtime_force_suspend() is invoked
before cdns_dsi_suspend(). However, I did not observe any misbehavior durin=
g
suspend/resume.
 - I also tested with only runtime PM support in the driver (without
pm_runtime_force_suspend/resume()), and I couldn't detect any functional
difference nor the issue originally addressed in this patch.

Given that, I will send a v2 of the patch implementing only runtime PM supp=
ort.
If issues arise in the future due to the lack of explicit
pm_runtime_force_suspend/resume() handling, we can revisit and address them=
 at
that time with clearer justification.

Best regards,
Vitor Soares


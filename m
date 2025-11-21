Return-Path: <stable+bounces-195492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3436C78829
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FB6F4E93C5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDA33C186;
	Fri, 21 Nov 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fSTsMi9d"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE82F617D
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720702; cv=none; b=cdRd2kIRuYOQJxcMBqLMLpPWlppW+6v1wGBiBCIR68wb4cpCapw2NKLTMt31X+toPhA6C3904cTiXKNhad8ciUZ7faX40x/gz06d4sJHsxThlwY1RGi74dGjOweMu6SAo37hCBm5KP2HQfWbJdn+MAhNdPhuOoUrFqvGXShi9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720702; c=relaxed/simple;
	bh=hZxuF4I2Rt8oahRFsSMFK1RfclrD5I2EI/3ROzGVs9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acrhxCE6MBaLT4Cqfv3Dyqx+4jGQf++GvBdlaVBqH3iAd4lj8ZS09ktPI9hNddKg1kDjCDknuJOeLFU4issIPwWzejw5HAEgb2BaujSQErzBJYksvGGZT5ZKoIkz4UUJzKRK5L9CwZU8aDcoxGyA//8WY6usg2+P3RPMAnnGOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fSTsMi9d; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E26B0C10199;
	Fri, 21 Nov 2025 10:24:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F4F260719;
	Fri, 21 Nov 2025 10:24:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5757210372180;
	Fri, 21 Nov 2025 11:24:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763720696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EaLMDrnSy+aZcQJAEyz1rERa0lHgFTObgsHcr4fADqM=;
	b=fSTsMi9dDM+3LYmzZEaa7j4KQqDOO9Yl57/5Re8T8+FX8xay297sDzwkpysJqYk8fIR0dY
	MASzUc/eVuNJHYZ+7oPi+/aZgStZi9gRcAGlWZLgjMJKcQsnJWUdFBkuy258Sh7sq+lwhf
	0FR1+eH1ILp/tQV1PZPuGhlxvMNdIm5cNcEqYZhVtz2YJq2zi2YRUB3C7aVCWpJ4GCiHYf
	WgwHsQR8+zisp/dYNVFeJDRe6P0fCUGr8v7hezjHAtw/XjZm5RF7zCjpYdxCJNBMA1I93R
	oIvat45dM6XannIl1R+kurWHDW8MQqXUCT2R85dyfHPWcMHekD+I6L78ZGUlkw==
Date: Fri, 21 Nov 2025 11:24:50 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Maxime Ripard" <mripard@kernel.org>, "Douglas Anderson"
 <dianders@chromium.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Bajjuri Praneeth" <praneeth@ti.com>,
 "Louis Chauvet" <louis.chauvet@bootlin.com>, <stable@vger.kernel.org>,
 <thomas.petazzoni@bootlin.com>, "Jyri Sarha" <jyri.sarha@iki.fi>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
Subject: Re: [PATCH v3] drm/tilcdc: Fix removal actions in case of failed
 probe
Message-ID: <20251121112450.070fe238@kmaincent-XPS-13-7390>
In-Reply-To: <DECU85YFDJFQ.51DNK1JF0CQ4@bootlin.com>
References: <20251118133850.125561-1-kory.maincent@bootlin.com>
	<DECU85YFDJFQ.51DNK1JF0CQ4@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 18:12:40 +0100
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> Hello K=C3=B6ry,
>=20
> On Tue Nov 18, 2025 at 2:38 PM CET, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >
> > The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> > should only be called when the device has been successfully registered.
> > Currently, these functions are called unconditionally in tilcdc_fini(),
> > which causes warnings during probe deferral scenarios.
> >
> > [    7.972317] WARNING: CPU: 0 PID: 23 at
> > drivers/gpu/drm/drm_atomic_state_helper.c:175
> > drm_atomic_helper_crtc_duplicate_state+0x60/0x68 ... [    8.005820]
> > drm_atomic_helper_crtc_duplicate_state from
> > drm_atomic_get_crtc_state+0x68/0x108 [    8.005858]
> > drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c8=
 [
> >  8.005885]  drm_atomic_helper_disable_all from
> > drm_atomic_helper_shutdown+0x90/0x144 [    8.005911]
> > drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc] [
> > 8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [tilc=
dc]
> >
> > Fix this by rewriting the failed probe cleanup path using the standard
> > goto error handling pattern, which ensures that cleanup functions are
> > only called on successfully initialized resources. Additionally, remove
> > the now-unnecessary is_registered flag.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at
> > shutdown/remove time for misc drivers") Signed-off-by: Kory Maincent
> > (TI.com) <kory.maincent@bootlin.com> =20
>=20
> Except for the bug reported by the kernel test robot, this patch looks
> good to me. Just a couple thoughts, below.
>=20
> > @@ -372,16 +371,34 @@ static int tilcdc_init(const struct drm_driver *d=
drv,
> > struct device *dev)
> >
> >  	ret =3D drm_dev_register(ddev, 0);
> >  	if (ret)
> > -		goto init_failed;
> > -	priv->is_registered =3D true;
> > +		goto stop_poll;
> >
> >  	drm_client_setup_with_color_mode(ddev, bpp);
> >
> >  	return 0;
> >
> > -init_failed:
> > -	tilcdc_fini(ddev);
> > +stop_poll:
> > +	drm_kms_helper_poll_fini(ddev);
> > +	tilcdc_irq_uninstall(ddev);
> > +unbind_component:
> > +	if (priv->is_componentized)
> > +		component_unbind_all(dev, ddev);
> > +unregister_cpufreq_notif:
> > +#ifdef CONFIG_CPU_FREQ
> > +	cpufreq_unregister_notifier(&priv->freq_transition,
> > +				    CPUFREQ_TRANSITION_NOTIFIER);
> > +#endif
> > +destroy_crtc:
> > +	tilcdc_crtc_destroy(priv->crtc);
> > +disable_pm:
> > +	pm_runtime_disable(dev);
> > +	clk_put(priv->clk);
> > +free_wq:
> > +	destroy_workqueue(priv->wq);
> > +put_drm:
> >  	platform_set_drvdata(pdev, NULL); =20
>=20
> I'm not 100% sure this is needed, but perhaps it is because of the
> component framework being used.

Yes not sure either but as it was already present I let it here.
Do you think I should remove it?

>=20
> If it is needed, then shouldn't it be present in tilcdc_fini() as well?
>=20
> > +	ddev->dev_private =3D NULL;
> > +	drm_dev_put(ddev);
> >
> >  	return ret;
> >  } =20
>=20
> About tilcdc_fini(), I think it can be itself cleaned up a lot (in another
> patch). Basically it should do the same thing (almost) that are here below
> the 'return 0' line, and in the same order. Now the list of actions is au=
ite
> different and the order is very different.

Yes indeed, but this won't be a fix as there is no real issue in the remove
AFAIK.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


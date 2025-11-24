Return-Path: <stable+bounces-196773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFDC81EEA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5114E347C4F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F502BEC57;
	Mon, 24 Nov 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ubUPd37M"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EE2749D9
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005871; cv=none; b=BcfnK5cyqsHK6QbhH3rbgpfSLx+xjzFk5QzEcYfCAQBd6XdrrsYMtJBsR2lBZd3PqKlje/Em6bgPZg0QhhmvKNjPAmansXaZ3ETkOqPaBN9DvQ7fFMt1/y3JysNkMnSCaI5DrC0cTlJrJRpEkyZeLlxspCGCvu8Dcp3Mqg5gKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005871; c=relaxed/simple;
	bh=2+a9r/KAmOZLoDpWQIBmfIdI6N1D7M/P3D8jTvfNORs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sB9ggiq819GHH/f7XH/wDd7d5OUYSzy26JF9kUJklk1hb0GuFgv5/vRq/zSHp4E+GGTMgjG2QT/W3zjITuWPKBpv6B8K4QqShMN4JkDgKIqpApbAU9w+Ip9u03W7dVbuErXc/VhG2fjzuqr0vdv1u5Hb/hW6aD071x6fcV3JJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ubUPd37M; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C07A44E4189F;
	Mon, 24 Nov 2025 17:37:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 942EA606FC;
	Mon, 24 Nov 2025 17:37:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4583F10370C40;
	Mon, 24 Nov 2025 18:37:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764005864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IT1k2H6nrgHdtTlroFgbSFcgluBiGKWIfAWb5Ws5984=;
	b=ubUPd37M6gqGwXbG3ZXcDx3/9vSdW9lcF8F4LpNK4RQE6RVEUXJg7MnjaDbln140VyXmu3
	hQKzrnfwtKXQBiM4x73nEcn0Dz5XoX9uR5ey1yoAGc0hYzQxqUJ/oqtHx/t+fdopicSCjB
	kCKKlQ8Z/NVNPi5MSa1LGnMluQp1hmGWStzzh9ONmUtbultpcQxjg7v84HMTwvUKG7TGRa
	7AgDQBZo5tH0+CoWC/7VU3eKD/M2FPf6001Y5ect548hs5wnWXoH7EyPyoATSILVROKyGA
	BPmbgTAAwdTx5C7tvbpNTXn76y4lJdpFRgszvD4jzf82h+9sZVQlvyttA1i4ig==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 18:37:39 +0100
Message-Id: <DEH3W0I9EBRB.16EYRXFT7K0ZS@bootlin.com>
Subject: Re: [PATCH v3] drm/tilcdc: Fix removal actions in case of failed
 probe
Cc: "Maxime Ripard" <mripard@kernel.org>, "Douglas Anderson"
 <dianders@chromium.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Bajjuri Praneeth" <praneeth@ti.com>,
 "Louis Chauvet" <louis.chauvet@bootlin.com>, <stable@vger.kernel.org>,
 <thomas.petazzoni@bootlin.com>, "Jyri Sarha" <jyri.sarha@iki.fi>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
To: "Kory Maincent" <kory.maincent@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20251118133850.125561-1-kory.maincent@bootlin.com>
 <DECU85YFDJFQ.51DNK1JF0CQ4@bootlin.com>
 <20251121112450.070fe238@kmaincent-XPS-13-7390>
In-Reply-To: <20251121112450.070fe238@kmaincent-XPS-13-7390>
X-Last-TLS-Session-Version: TLSv1.3

Hi K=C3=B6ry,

On Fri Nov 21, 2025 at 11:24 AM CET, Kory Maincent wrote:
> On Wed, 19 Nov 2025 18:12:40 +0100
> "Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:
>
>> Hello K=C3=B6ry,
>>
>> On Tue Nov 18, 2025 at 2:38 PM CET, Kory Maincent wrote:
>> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>> >
>> > The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helper=
s
>> > should only be called when the device has been successfully registered=
.
>> > Currently, these functions are called unconditionally in tilcdc_fini()=
,
>> > which causes warnings during probe deferral scenarios.
>> >
>> > [    7.972317] WARNING: CPU: 0 PID: 23 at
>> > drivers/gpu/drm/drm_atomic_state_helper.c:175
>> > drm_atomic_helper_crtc_duplicate_state+0x60/0x68 ... [    8.005820]
>> > drm_atomic_helper_crtc_duplicate_state from
>> > drm_atomic_get_crtc_state+0x68/0x108 [    8.005858]
>> > drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c=
8 [
>> >  8.005885]  drm_atomic_helper_disable_all from
>> > drm_atomic_helper_shutdown+0x90/0x144 [    8.005911]
>> > drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc] [
>> > 8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [til=
cdc]
>> >
>> > Fix this by rewriting the failed probe cleanup path using the standard
>> > goto error handling pattern, which ensures that cleanup functions are
>> > only called on successfully initialized resources. Additionally, remov=
e
>> > the now-unnecessary is_registered flag.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at
>> > shutdown/remove time for misc drivers") Signed-off-by: Kory Maincent
>> > (TI.com) <kory.maincent@bootlin.com>
>>
>> Except for the bug reported by the kernel test robot, this patch looks
>> good to me. Just a couple thoughts, below.
>>
>> > @@ -372,16 +371,34 @@ static int tilcdc_init(const struct drm_driver *=
ddrv,
>> > struct device *dev)
>> >
>> >  	ret =3D drm_dev_register(ddev, 0);
>> >  	if (ret)
>> > -		goto init_failed;
>> > -	priv->is_registered =3D true;
>> > +		goto stop_poll;
>> >
>> >  	drm_client_setup_with_color_mode(ddev, bpp);
>> >
>> >  	return 0;
>> >
>> > -init_failed:
>> > -	tilcdc_fini(ddev);
>> > +stop_poll:
>> > +	drm_kms_helper_poll_fini(ddev);
>> > +	tilcdc_irq_uninstall(ddev);
>> > +unbind_component:
>> > +	if (priv->is_componentized)
>> > +		component_unbind_all(dev, ddev);
>> > +unregister_cpufreq_notif:
>> > +#ifdef CONFIG_CPU_FREQ
>> > +	cpufreq_unregister_notifier(&priv->freq_transition,
>> > +				    CPUFREQ_TRANSITION_NOTIFIER);
>> > +#endif
>> > +destroy_crtc:
>> > +	tilcdc_crtc_destroy(priv->crtc);
>> > +disable_pm:
>> > +	pm_runtime_disable(dev);
>> > +	clk_put(priv->clk);
>> > +free_wq:
>> > +	destroy_workqueue(priv->wq);
>> > +put_drm:
>> >  	platform_set_drvdata(pdev, NULL);
>>
>> I'm not 100% sure this is needed, but perhaps it is because of the
>> component framework being used.
>
> Yes not sure either but as it was already present I let it here.
> Do you think I should remove it?

At a quick look at the component framework, it does not seem to
care. However you are fixing a bug, so it's fine if you leave
platform_set_drvdata() untouched out of caution.

>> If it is needed, then shouldn't it be present in tilcdc_fini() as well?
>>
>> > +	ddev->dev_private =3D NULL;
>> > +	drm_dev_put(ddev);
>> >
>> >  	return ret;
>> >  }
>>
>> About tilcdc_fini(), I think it can be itself cleaned up a lot (in anoth=
er
>> patch). Basically it should do the same thing (almost) that are here bel=
ow
>> the 'return 0' line, and in the same order. Now the list of actions is a=
uite
>> different and the order is very different.
>
> Yes indeed, but this won't be a fix as there is no real issue in the remo=
ve
> AFAIK.

Sure! Cleaning up tilcdc_fini() would be a cleanup, not a bugfix, so you
can do it in a separate series without affecting this bugfix patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


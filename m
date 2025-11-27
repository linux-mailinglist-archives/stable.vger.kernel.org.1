Return-Path: <stable+bounces-197074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51450C8D698
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC9764E5BC6
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99561320CC0;
	Thu, 27 Nov 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="McPru5T1"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE72D3237;
	Thu, 27 Nov 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233545; cv=none; b=REZ0DXZDDp+lUUFjpZ9eMOzNZKsCRtuLHrPkd+5Z/YHYLoMUNLoyJKKOtvhf1Fg1TLNq3rTwzrETxdBNc1kyRfTq0vgZjPeY1ADuFUMM1KRrtu5LBomE35aTJ5CmQikMrLtTHL+oQ9D44Hg1FLoJ/8zPB0q1UsmBMPIbqgymLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233545; c=relaxed/simple;
	bh=7MAYwDWFCCO97feX3KIozujtsexcqMt50VGKvenkSrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UdwO621XCr2sacTtyYjX3MmbpHmGKFvG03a1BUbuA72ocV4C4uV7vxgtaQw27a6HSSc/CHXYiqBbL+IcxwVQOpMpyWQPEMIq2l4MlxBXipfDwPMY2mecQ+V1CyhIbYwr7jU3QILJHTOZHKH2MWmdziFTvRGFzX3svkCouMA1v94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=McPru5T1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3F8B34E4191B;
	Thu, 27 Nov 2025 08:52:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 136A76068C;
	Thu, 27 Nov 2025 08:52:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5098102F2750;
	Thu, 27 Nov 2025 09:52:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764233540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sw50z7iMEsw9FXgWSJED+V1hMg03m/TOLOQgkf9Z3ws=;
	b=McPru5T19s8/LhRwuMAS1eUPnHuQ6VRlfw3ODgpJBvS0+Zf4fubBevcnCqTmafbUjFvnhn
	lU36b2bCn/n25EZTMUxAEe08lb7Dujxkb0n51Yrng2xRy+WCqyZvX245uPa4TJQZD8Xq6c
	Iq2RPUyMRaqLjuJrj4PYKu33tQv1OoP9sXOS9Mjq5E3ai30Sy8qEvYHgEObN2Ckwy1A14F
	6q/Ntl+ZJh+y66zc0adyR2E0kAc0jPASnI13RDNZtRJCPz7v448euTD1O154QOCaSFT/mz
	dsy0ij45L0ubhAbRnjnn43C2/ai6LWNreN52g2q1Hj4d6M+YGzTzM4E/eL5R1w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 09:52:15 +0100
Message-Id: <DEJCLD92ZKB0.3ABKT4189ASSV@bootlin.com>
Subject: Re: [PATCH v4] drm/tilcdc: Fix removal actions in case of failed
 probe
Cc: "Bajjuri Praneeth" <praneeth@ti.com>, "Louis Chauvet"
 <louis.chauvet@bootlin.com>, <stable@vger.kernel.org>,
 <thomas.petazzoni@bootlin.com>, "Jyri Sarha" <jyri.sarha@iki.fi>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Douglas Anderson" <dianders@chromium.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20251125090546.137193-1-kory.maincent@bootlin.com>
In-Reply-To: <20251125090546.137193-1-kory.maincent@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Nov 25, 2025 at 10:05 AM CET, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>
> The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> should only be called when the device has been successfully registered.
> Currently, these functions are called unconditionally in tilcdc_fini(),
> which causes warnings during probe deferral scenarios.
>
> [    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_stat=
e_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
> ...
> [    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_ge=
t_crtc_state+0x68/0x108
> [    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_=
all+0x90/0x1c8
> [    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shut=
down+0x90/0x144
> [    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [ti=
lcdc]
> [    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [t=
ilcdc]
>
> Fix this by rewriting the failed probe cleanup path using the standard
> goto error handling pattern, which ensures that cleanup functions are
> only called on successfully initialized resources. Additionally, remove
> the now-unnecessary is_registered flag.
>
> Cc: stable@vger.kernel.org
> Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/=
remove time for misc drivers")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <stable+bounces-215645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKq7GCoMi2lXPQAAu9opvQ
	(envelope-from <stable+bounces-215645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:44:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C30119C49
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F51303E4A5
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA334216C;
	Tue, 10 Feb 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n3JSbTNz"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290B316912
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720262; cv=none; b=e/nOYfuSzId5V72aFSKZKHBbGWCGeYtWGMs6UHKjIuu4885+Xo81Jz0HwY2rNDk1CxjkN6/m9N//3DihyPyHph7EwMMbIJ+xyO+3t41TJbg67NGYSiGFIH8RzWhpuu6ccacPLFQ6RdA/Jz+qrSKKuPyFhzQP9SJMWUx9P8i5Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720262; c=relaxed/simple;
	bh=TeT8fFaQDNGxM84WrlNaLg8VOUAzH6x6QlmmFTijl3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=nAlxO8OLiq+da5BL70JVPWz5At469aTDPDKVoDbLLOJSmPwzOVWW1uaqyzwYy/MKN8GSf+m1gZYJh5f267p0s/D3mQx+HhHUrEkS7QFjdb6t73AeXXLK8CG0gT7Pfy75UmYrk8zjJflqeTfFVgKN2lM69z04K4qydWYL78ZV9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n3JSbTNz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 595DEC8F1FC;
	Tue, 10 Feb 2026 10:44:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 03B6A606BD;
	Tue, 10 Feb 2026 10:44:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35628119D1118;
	Tue, 10 Feb 2026 11:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770720257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rgIZKpgJemM2O7tuO8K6vUcedAgz0oWF401av9M9oVc=;
	b=n3JSbTNzPPfJM80F/e/8JHK/PLG6zjf37tfVMjKnZYMhvuMrbw+0KmWFM6LCcaoSvdp1zW
	L7Zc0a2KN806lX4XRiSL2ul+0I4OYgYssPNrlLIiBMoVkXla5L07BnhnQUCXO0v0r7gsC+
	RFSv5GXp5LcbmZGzFv5tTZwK2j7zqhuvI0iWFgeI49pT3+IfcB77lionxNxp8txH6otmLU
	WJaONHLOTQVq080OME35wHuksw66On1DSxoepctGmq+EjHQFlOOzrWy2TliVIn8yr9T78B
	mEbkbdUfrLg4flbTtpKjsgKWyX0FSsfKt4g0743yTcFBGvPfvUxZP2j5pyJyHg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:44:11 +0100
Message-Id: <DGB7XXI0HSXY.2MZIDNCGYLTFR@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Marek Vasut"
 <marex@denx.de>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: samsung-dsim: Fix memory leak in error path
Cc: <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260209184115.10937-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260209184115.10937-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215645-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: C7C30119C49
X-Rspamd-Action: no action

Hello Osama,

On Mon Feb 9, 2026 at 7:41 PM CET, Osama Abdelkader wrote:
> In samsung_dsim_host_attach(), drm_bridge_add() is called to add the
> bridge. However, if samsung_dsim_register_te_irq() or
> pdata->host_ops->attach() fails afterwards, the function returns
> without removing the bridge, causing a memory leak.
>
> Fix this by adding proper error handling with goto labels to ensure
> drm_bridge_remove() is called in all error paths. Also ensure that
> samsung_dsim_unregister_te_irq() is called if the attach operation
> fails after the TE IRQ has been registered.
>
> samsung_dsim_unregister_te_irq() function is moved without changes
> to be before samsung_dsim_host_attach() to avoid forward declaration.
>
> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Sa=
msung DSIM bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:

Please add the version number to the e-mail Subject, it should be:
  [PATCH v2] drm/bridge: ...
         ^^

No need to resend just for this, but please keep it in mind for the future.

Using b4 automates all of this very nicely, you can consider using it.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


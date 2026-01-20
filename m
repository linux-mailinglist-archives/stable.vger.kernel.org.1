Return-Path: <stable+bounces-210553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI6yBYxYcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:39:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2209511C2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00A73762150
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0744A701;
	Tue, 20 Jan 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jWxVCnbC"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01B43C06B;
	Tue, 20 Jan 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918567; cv=none; b=ELSwB50N7v3ofJnpbJ+9T7dBc0civO4e0SKHEgZDi5UCbzFvR5ERUNyW6xsQI/0t66MBftcdIG9hDyoyRb5WVdZpyi+zrSVYOcwHXeBzkFY9ge0Vm+z0ypkjubVlsI7r1+K8Z6bTctDwUayDja6n5jZvxmEorrC0N3Ut15aszEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918567; c=relaxed/simple;
	bh=oq4ASq6khY2rYBGz2aotRBZA10LhKXDoOCFxTvWas/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pncsEdILSiJctE0eITt1ZgZYqbTpWdXTd3gq6X8Eiqpme4xT5LYWOC8dJI8AnPUI750lDY0rhZVMmVU7gRBL7WleLF0iUY/tVvMh5FcMJHzFQiqB9fnnbEIoOkd+tYKhJp1PIhxHp/26JDshdn32CqjMHmblg7mMlzhmR+ebXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jWxVCnbC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A667B1A2965;
	Tue, 20 Jan 2026 14:16:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75FC1606AB;
	Tue, 20 Jan 2026 14:16:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5B5010B698AE;
	Tue, 20 Jan 2026 15:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768918562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+sjV4jKZbmaCgDV+GkMaLzLnPZD2hmO2N+9AYVVEwgo=;
	b=jWxVCnbCkzG1ahCUoIe6zWU7LBpBHB9DhliiM0lM8yu2Jq6FBVXrGVmvXCS3nMRLdeGeyC
	dhWRn6K1Rh+vjBnUoWUnJXUf4WRGtEXrsg7JshFYDmafpl8SIJdpySEakihoFFiDEqMngi
	iAmQzHGDrXCnxIn0Kyr75uMDpgbg2kBSbohOpxxCRM7qunkgrmR88S1QiUrDxqGpQDNc0/
	8Kr47qQmMW4s++eN70Y8Bug/+6qGCFfEInYJEtufQPtVVPjSs8Eio488J11LDjS0NqdlI+
	oyxbmSmIfSAnD2FxMebS1yS4b5RWHr5imr2k3tGt+6EBj/9wi2F6EtA93teD7Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philippe Cornu <philippe.cornu@st.com>, benjamin.gaignard@linaro.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Adrien Grassein <adrien.grassein@gmail.com>, Liu Ying <victor.liu@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-0-8bad3ef90b9f@bootlin.com>
References: <20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-0-8bad3ef90b9f@bootlin.com>
Subject: Re: [PATCH v2 00/12] drm/bridge: convert users of
 of_drm_find_bridge(), part 2
Message-Id: <176891855295.598401.9824700731247929118.b4-ty@bootlin.com>
Date: Tue, 20 Jan 2026 15:15:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210553-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,st.com,linaro.org,intel.com,ideasonboard.com,kwiboo.se,nxp.com,pengutronix.de,samsung.com,amarulasolutions.com,bootlin.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: B2209511C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 09 Jan 2026 08:31:31 +0100, Luca Ceresoli wrote:
> This series converts all DRM bridge drivers (*) from the now deprecated
> of_drm_find_bridge() to its replacement of_drm_find_and_get_bridge() which
> allows correct bridge refcounting. It also converts per-driver
> "next_bridge" pointers to the unified drm_bridge::next_bridge which puts
> the reference automatically on bridge deallocation.
> 
> This is part of the work to support hotplug of DRM bridges. The grand plan
> was discussed in [0].
> 
> [...]

Applied, thanks!

[01/12] drm: of: drm_of_panel_bridge_remove(): fix device_node leak
        commit: a4b4385d0523e39a7c058cb5a6c8269e513126ca
[02/12] drm: of: drm_of_panel_bridge_remove(): convert to of_drm_find_and_get_bridge()
        commit: f675a276b84488e78287dd22c2e9461e4c008c66
[03/12] drm/bridge: sii902x: convert to of_drm_find_and_get_bridge()
        commit: d07490fb23958006bcecd6f2ba411571c099d104
[04/12] drm/bridge: thc63lvd1024: convert to of_drm_find_and_get_bridge()
        commit: 9d34e1a8cf7b643bca058a65f3441d90099b297f
[05/12] drm/bridge: tfp410: convert to of_drm_find_and_get_bridge()
        commit: 35dd5e1c089b6fd9f503bb15ebc1138d5a3f887e
[06/12] drm/bridge: tpd12s015: convert to of_drm_find_and_get_bridge()
        commit: 0bbca46cd50a527bded903ffe7f32e3761e825bd
[07/12] drm/bridge: lt8912b: convert to of_drm_find_and_get_bridge()
        commit: 31cb3cd7e7149983e279f3d6da3ae5757a965ea5
[08/12] drm/bridge: imx8mp-hdmi-pvi: convert to of_drm_find_and_get_bridge()
        commit: 7654c807f20701ebd1dc7e967270d017dcc36730
[09/12] drm/bridge: imx8qxp-ldb: convert to of_drm_find_and_get_bridge()
        commit: 32529d384cea3a9b939ff1b56aa30a13f8370129
[10/12] drm/bridge: samsung-dsim: samsung_dsim_host_attach: use a temporary variable for the next bridge
        commit: e5e1a0000746ded4d9fa16fceda0748aec2b6e6a
[11/12] drm/bridge: samsung-dsim: samsung_dsim_host_attach: don't use the bridge pointer as an error indicator
        commit: 33f86ac63031d0593e48eb0a738f2d1b1ee29879
[12/12] drm/bridge: samsung-dsim: samsung_dsim_host_attach: convert to of_drm_find_and_get_bridge()
        commit: 685d0dfc37d081e56374852165afc8ab3b3e8d5b

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>



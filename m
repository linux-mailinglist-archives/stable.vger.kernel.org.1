Return-Path: <stable+bounces-206147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA418CFE0BE
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C084E31708C1
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29D33B6C2;
	Wed,  7 Jan 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsLZbs7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3133ADA2;
	Wed,  7 Jan 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792833; cv=none; b=MpTcGfBVa+XwA2DvCzGXrevyvO1NBfAFStzxeVmd4ynKOv/qrChRPF3Nr6OdDRNI/1hmtZk6ZCJCAZoFoYbRYevqSCmNtx5G8Kuejb/wwmnSiRWwWAsNmhH2cHnCrYk8U8/XHk1ngWn7tfOGr/8Xgzm7EcjNhBZ7uw42yoJpksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792833; c=relaxed/simple;
	bh=eRal9aRJEBMws0AwIbeE+xWsj4dyQhrtTO2oF039rMA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=IC7+v86YW2O6dHxnuAeLenlx9XexMsjDRBUKo46fgUJ7bxqHTPIhTnq70JoqIPLb+EIy7qxORY/imFjZpWg0RzNLiMYfEtKWuYxs6UQiKneWSOI1vx5OJG61lyzOFkSvodhI2kjp/z/nJWlmDZoCLZcIeV3dinartIzBQfyu9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsLZbs7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D683CC4CEF7;
	Wed,  7 Jan 2026 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767792832;
	bh=eRal9aRJEBMws0AwIbeE+xWsj4dyQhrtTO2oF039rMA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=ZsLZbs7o8rWvOy1KXRQEHXUY+OZNgKMmY0wLvJ8iieksy79lUKP2qpEbtYYjj18AN
	 E7Xd9oiOs9XbNxr+4a9Ia06cop1T+OsmXvlKomwA1JcpOKqFyXILxvBcNGcMq38DZp
	 HKbwnC7jmd/ik1tz4BPGB9OR3OcTMLK9ETrR22i4v2rVF8AKst/eJmHg3pizbZ0FCZ
	 ciyGXWN51TABOpmO5w4SPjJ/n0kYXGAld0XeeODer6T7xx+Q6wEGXzip1eGcNwjLeM
	 P+aBsWtH1MwJXQHaAnU27itZ5joYHKy6ZNad+h2Z7Sx4DhaMZt9mwn9z9kKmC5JLUb
	 KNZlEazVnbbrQ==
Message-ID: <7e796e122dcbce9a8d7678db9bbfc89d@kernel.org>
Date: Wed, 07 Jan 2026 13:33:49 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 01/12] drm: of: drm_of_panel_bridge_remove(): fix
 device_node leak
In-Reply-To: <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-2-v1-1-283d7bba061a@bootlin.com>
References: <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-2-v1-1-283d7bba061a@bootlin.com>
Cc: benjamin.gaignard@linaro.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Adrien
 Grassein" <adrien.grassein@gmail.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "David
 Airlie" <airlied@gmail.com>, "Fabio Estevam" <festevam@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Inki
 Dae" <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Philippe Cornu" <philippe.cornu@st.com>, "Robert
 Foss" <rfoss@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn
 Guo" <shawnguo@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Wed, 7 Jan 2026 14:12:52 +0100, Luca Ceresoli wrote:
> drm_of_panel_bridge_remove() uses of_graph_get_remote_node() to get a
> device_node but does not put the node reference.
>=20
> Fixes: c70087e8f16f ("drm/drm_of: add drm_of_panel_bridge_remove function=
")
> Cc: stable@vger.kernel.org # v4.15
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


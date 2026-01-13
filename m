Return-Path: <stable+bounces-208261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3037D18807
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29833300A37C
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6F36BCDB;
	Tue, 13 Jan 2026 11:31:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C035CB86
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303914; cv=none; b=IAhsbcKR49HCkLgd134ZvIirZfWB/u3jAeFDmYLfPW8qgeaotSJJckCbchfrNz3IF8Gx/Wv+MfZ7eD8DCAMoFClIOKqUzhTd6LNfyDPAtA/cbUZ5SgeVE5uu9X+t6/P7/GHyTwXm/oRO/8Kusj9PBRVcyrKSUgfHV+oMRwcIj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303914; c=relaxed/simple;
	bh=B4kWBn9gjdvScHFjE+y4UkWXcGn5pKA7zE+7suaO1v0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWYyU9FmHA/eaZE5z80FSTc4egjuDxxTjIaiy5DwdyM2M+TwOerOxSYf1SKPKD1f7xOpVcP8zwla+aIJGyKipLjkfmpJpMAC9jZLs2HFlocTdJTZvVS+r5kOJCDb9OK4OktmIHNMHwIMAKBfLAt2dYtU1sXSqZqozErqrOBQjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vfccf-0008LF-8r; Tue, 13 Jan 2026 12:31:41 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vfccf-000Pj3-1h;
	Tue, 13 Jan 2026 12:31:40 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vfccZ-000000005PZ-3ACz;
	Tue, 13 Jan 2026 12:31:35 +0100
Message-ID: <0d3a41526ba02eee28457fafc95f5152a9c7bb4b.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: parallel-display: Prefer bus format set via
 legacy "interface-pix-fmt" DT property
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marek Vasut <marex@nabladev.com>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, David Airlie <airlied@gmail.com>, Fabio Estevam	
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Simona Vetter <simona@ffwll.ch>,  Thomas Zimmermann <tzimmermann@suse.de>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 13 Jan 2026 12:31:35 +0100
In-Reply-To: <20260110171510.692666-1-marex@nabladev.com>
References: <20260110171510.692666-1-marex@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Sa, 2026-01-10 at 18:14 +0100, Marek Vasut wrote:
> Prefer bus format set via legacy "interface-pix-fmt" DT property
> over panel bus format. This is necessary to retain support for
> DTs which configure the IPUv3 parallel output as 24bit DPI, but
> connect 18bit DPI panels to it with hardware swizzling.
>
> This used to work up to Linux 6.12, but stopped working in 6.13,
> reinstate the behavior to support old DTs.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5f6e56d3319d ("drm/imx: parallel-display: switch to drm_panel_brid=
ge")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp


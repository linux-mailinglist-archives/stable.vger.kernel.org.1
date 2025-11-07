Return-Path: <stable+bounces-192709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB1C3F82D
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31F314E1846
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499A32C316;
	Fri,  7 Nov 2025 10:36:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB2253B59
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511808; cv=none; b=L47JZsLHi1nWNuZ9D0+joCa5zpo7VeU9ix6onlx7tezbR2iX3I4P5nx6Y8QI8j2qWX2sJHcBjBXIumFhpMEo02bwAU2BV4tPBC9kcKPjL/yGFSpHslPp0R3I+diNpVLyZEoUNV7mdtSzKOjuSN+qtSQ5DZXs4jFkBWxtEvIlz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511808; c=relaxed/simple;
	bh=D3MYsOwUR4ontrP/Jui3taLN5zLST+IKcpEwg+9F4BE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqX13fMVjqSOcl98+l9/lUk8kQ8c+SVWQbDRmNMUdtlLQFWXHK3uQsMuMdkbN1lCaKFJvhgZyl88YBpb4TB8xghkPvzZKt3UCXycSMqsdhUju4TR8Zx54SdfmX+FKMPjL70+QKKWILob1ADiZ1BlkanNre/nojoy6OjxK+B30f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpd-0008P1-Hn; Fri, 07 Nov 2025 11:36:37 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpd-007VwK-17;
	Fri, 07 Nov 2025 11:36:37 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vHJpd-0000000041V-14PK;
	Fri, 07 Nov 2025 11:36:37 +0100
Message-ID: <70dda82cef6a916475cf05e3c2e06b95b66402cf.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] media: staging: imx: configure src_mux in
 csi_start
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam
	 <slongerbeam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team
	 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Hans Verkuil
	 <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Michael
 Tretter	 <michael.tretter@pengutronix.de>
Date: Fri, 07 Nov 2025 11:36:37 +0100
In-Reply-To: <20251107-media-imx-fixes-v2-2-07d949964194@pengutronix.de>
References: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
	 <20251107-media-imx-fixes-v2-2-07d949964194@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Fr, 2025-11-07 at 11:34 +0100, Michael Tretter wrote:
> After media_pipeline_start() was called, the media graph is assumed to
> be validated. It won't be validated again if a second stream starts.
>=20
> The imx-media-csi driver, however, changes hardware configuration in the
> link_validate() callback. This can result in started streams with
> misconfigured hardware.
>=20
> In the concrete example, the ipu2_csi1 is driven by a parallel video
> input. After the media pipeline has been started with this
> configuration, a second stream is configured to use ipu1_csi0 with
> MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
> of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
> already running, link_validate won't be called, and the ipu1_csi0 won't
> be reconfigured. The resulting video is broken, because the ipu1_csi0 is
> misconfigured, but no error is reported.
>=20
> Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
> that input to ipu1_csi0 is configured correctly when starting the
> stream. This is a local reconfiguration in ipu1_csi0 and is possible
> while the media pipeline is running.
>=20
> Since csi_start() is called with priv->lock already locked,
> csi_set_src() must not lock priv->lock again. Thus, the mutex_lock() is
> dropped.
>=20
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp


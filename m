Return-Path: <stable+bounces-225330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP7cKUMvtGkEigAAu9opvQ
	(envelope-from <stable+bounces-225330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:37:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3017286232
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06673055E7E
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455B3A9D99;
	Fri, 13 Mar 2026 15:33:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F13A5E80
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415996; cv=none; b=DQJLlNqUjxsFxTpZJb4Cd+8mPhDyG05szDzsUc81iq7TjW4fmcPlA8rxRFM424TQroWZUOGY5MXStpges43G69+TZ8DjARUjnMqJOafM4TjyCez6QXEB10NgVVIrZsf8jf/7GT5oZETzPg+KXiW3mZ5ISL7/H75v7Jxph9idLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415996; c=relaxed/simple;
	bh=nJzdJCq/WJhJOFmoG2P5bc+bTX+ZEuWuo5pI3eX6a7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u79qFbeNgHL4q1KNJSLML4ZH3KhjcI7HFvZkTZwCJ7pucO8W3JNQ6/O5qBcT2NEopC3bYwyN5aSNX733vTRTts2opqB1vG18B9RnjN1jhQqM55cz1/X7i+e+z+QqFx9kczPvhCd7YiP05M8rkxq84c1W+oMTveeU9/maF7sfeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w14Va-0001kX-Md; Fri, 13 Mar 2026 16:33:02 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w14Va-0006Mi-0h;
	Fri, 13 Mar 2026 16:33:02 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w14Va-00000000EjJ-0Vjx;
	Fri, 13 Mar 2026 16:33:02 +0100
Message-ID: <30511e1e0ffd6579091fc4ed1cad084fd81b9c96.camel@pengutronix.de>
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
Date: Fri, 13 Mar 2026 16:33:01 +0100
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,pengutronix.de,kernel.org,ffwll.ch,suse.de,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-225330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: F3017286232
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sa, 2026-01-10 at 18:14 +0100, Marek Vasut wrote:
> Prefer bus format set via legacy "interface-pix-fmt" DT property
> over panel bus format. This is necessary to retain support for
> DTs which configure the IPUv3 parallel output as 24bit DPI, but
> connect 18bit DPI panels to it with hardware swizzling.
>=20
> This used to work up to Linux 6.12, but stopped working in 6.13,
> reinstate the behavior to support old DTs.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5f6e56d3319d ("drm/imx: parallel-display: switch to drm_panel_brid=
ge")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied to drm-misc-next, thanks!

[1/1] drm/imx: parallel-display: Prefer bus format set via legacy "interfac=
e-pix-fmt" DT property
      commit: cdf26e1462c220629bb79d487263b66f8b679eab

regards
Philipp


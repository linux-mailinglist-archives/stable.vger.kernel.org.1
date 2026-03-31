Return-Path: <stable+bounces-231443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CbaGL7ly2myMQYAu9opvQ
	(envelope-from <stable+bounces-231443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:18:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D845A36B8CA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27EA304BDAA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0F3FEB1B;
	Tue, 31 Mar 2026 15:14:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CA3E4C7F
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970086; cv=none; b=AjS664/biXk/2gD3RvIzv+WFCms9F60XFfyKKd/wYIOoiGp4w7Q+9NA/TshHngOa5hi74Ff0k8Fxy5dwbTzRWB4uKCm0B7gjT5xhl3IBILFSrcJPohx28Ng66qXc2ONEyPR5DKL1JY+obC9Owj93jac2dci9Xxs+6smu9S6QLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970086; c=relaxed/simple;
	bh=ROUNo/tHRd68I8Ifwz6YahJR1eZKJhCOZB6ug5FK4jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTAd/fV7AY+i0d6VDKrisEChiKXdmPGi9tYHAFVbkHcK9MzlF/8JX1l2V/HIRZ9vlEGAz6laxakKrF+82I4JDWH1QxOzcZjwnAihrUu3ZhSNT9pDeVPcO7fLC0zKZa9Pc1GZEbqiZUQww2nI1sTycQICjl2Km+Crp37oO6MlSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w7anM-0006b0-Ku; Tue, 31 Mar 2026 17:14:20 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w7anL-0033uI-0H;
	Tue, 31 Mar 2026 17:14:19 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w7anK-00000000EmP-464Y;
	Tue, 31 Mar 2026 17:14:18 +0200
Message-ID: <e7c92eeffd66ed1d4b03f312bd3033451cbd0185.camel@pengutronix.de>
Subject: Re: [PATCH v8 4/5] reset: rzv2h-usb2phy: Keep PHY clock enabled for
 entire device lifetime
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	tomm.merciai@gmail.com, peda@axentia.se
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,  Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josua Mayer
 <josua@solid-run.com>, Arnd Bergmann <arnd@arndb.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 31 Mar 2026 17:14:18 +0200
In-Reply-To: <6584aed8dc4fddb28c2184c83b92b4f3b419bc31.1773319566.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1773319566.git.tommaso.merciai.xr@bp.renesas.com>
	 <6584aed8dc4fddb28c2184c83b92b4f3b419bc31.1773319566.git.tommaso.merciai.xr@bp.renesas.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,gmail.com,axentia.se];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,bp.renesas.com,renesas.com,kernel.org,glider.be,gmail.com,linaro.org,linuxfoundation.org,solid-run.com,arndb.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.880];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url,renesas.com:email]
X-Rspamd-Queue-Id: D845A36B8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Do, 2026-03-12 at 15:50 +0100, Tommaso Merciai wrote:
> The driver was disabling the USB2 PHY clock immediately after register
> initialization in probe() and after each reset operation. This left the
> PHY unclocked even though it must remain active for USB functionality.
>=20
> The behavior appeared to work only when another driver
> (e.g., USB controller) had already enabled the clock, making operation
> unreliable and hardware-dependent. In configurations where this driver
> is the sole clock user, USB functionality would fail.
>=20
> Fix this by:
> - Enabling the clock once in probe() via pm_runtime_resume_and_get()
> - Removing all pm_runtime_put() calls from assert/deassert/status
> - Registering a devm cleanup action to release the clock at removal
> - Removed rzv2h_usbphy_assert_helper() and its call in
>   rzv2h_usb2phy_reset_probe()
>=20
> This ensures the PHY clock remains enabled for the entire device lifetime=
,
> preventing instability and aligning with hardware requirements.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e3911d7f865b ("reset: Add USB2PHY port reset driver for Renesas RZ=
/V2H(P)")
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Applied patch 4 to reset/next, thanks!

[4/5] reset: rzv2h-usb2phy: Keep PHY clock enabled for entire device lifeti=
me
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D8889b289ce1b

regards
Philipp


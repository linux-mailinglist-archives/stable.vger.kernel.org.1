Return-Path: <stable+bounces-249928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OBzDd69DWrH2wUAu9opvQ
	(envelope-from <stable+bounces-249928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:57:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4558F2B7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63332306A72B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88566244661;
	Wed, 20 May 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UdItdDKg"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A62BE03B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285207; cv=none; b=paczu1CwDkCiuzyJf/wIdkLHcknrkPxVsFDiFC2Vg+k32SBYb3TOlyX4Co/p4E9Yf0LSbNDUvp0Uk/EWf2J+eYD3gA6VwBTHlEDSV/U29KwcxU85bSS7ONDDnxRKdgyrPEKFWamlgoRL+4fsuOlYXH5ZMMC+omTaLNrDeIa/LUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285207; c=relaxed/simple;
	bh=bJCi2AmFucesxEWZrq46GWl2SpjUL3UY3JPO1BhKClc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y5ZoiQlDWlHt08cxlPGSzuMuU66PFCSS1mdaYxYsm/cjd8FplFw7IWv7Z0jkhIEmSnXb2LX9p6EuExQep6ITLBAyk/KosE7VgdEsHks5dG+beQnEoxVyNG4Eqc4jDUcvHAoqRwo40sbPeNkSJ5TXDweDjVjSyfbSzCdU0eJ6w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UdItdDKg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779285194; x=1779544394;
	bh=bJCi2AmFucesxEWZrq46GWl2SpjUL3UY3JPO1BhKClc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UdItdDKglWDQR69zzCLerAXz0NZ5NGrieaaakZIlaI2GN0oG3QlEwvuZLfRFmSrUF
	 X2tp1SLwaCPdJv49FTbSa2knrIdgmJ8gDH/bvyujTXH83bk2uiKpxIdcnEdbhnllef
	 FzqOTt5hPM2AqfuGs8Y8jQP03tsBLKH8k4QcAJbGDuwV6aamZTWufR9fe6HpqLH19R
	 hSlMrRdfNsRAMYVaOH0byAROciGKJvkbwQRkRHttz/o9OCGZEwRP1Vvm7Vfq6yUaPu
	 XY3pyrbEg/KumFmg7EWQ4Qc/iyoUPKNjWdyL13c053MvqWPzLzlD6itLK7MdzD9SFE
	 ZbvPW3M9NYOaw==
Date: Wed, 20 May 2026 13:53:08 +0000
To: leo.moerlein@gmail.com
From: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>
Cc: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>, stable@vger.kernel.org
Subject: [PATCH] net: phy: mdio_bus: leave PHY reset deasserted on unregister
Message-ID: <20260520135303.1009639-1-leo.moerlein@proton.me>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: 368d510e3cfe9a886c14fe5265e12582c251a0fe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249928-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.moerlein@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 33D4558F2B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some PHY devices are discovered again after the MDIO bus is torn down and
reprobed, for example when a parent driver first returns -EPROBE_DEFER and
is probed again later.

This breaks boards where external PHYs have per-device reset lines
described through reset-gpios. mdiobus_register_device() acquires the
reset GPIO and asserts reset, mdio_probe() later deasserts it for the
active device, but mdiobus_unregister_device() used to release the GPIO
descriptor without first driving the line back to the inactive state.
If that descriptor was the last owner, then the PHY could remain held
in reset across the next bus registration and disappear from the reprobe
scan.

On a Lantiq GSWIP based FRITZ!Box 7360 v2 this left PHYs 0 and 1 missing
after a deferred reprobe, while PHYs without external reset lines were
still found. DSA then failed to attach those ports with -ENODEV.

Before releasing optional reset resources, deassert reset again for real
PHY devices so the hardware stays discoverable across a later reprobe.

Fixes: 8ea25274ebaf2 ("net: mdiobus: release reset_gpio in mdiobus_unregist=
er_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo M=C3=B6rlein <leo.moerlein@proton.me>
Assisted-by: GitHubCopilot:GPT-5.4
---
 drivers/net/phy/mdio_bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afdf1ad6c0e6..b10670a0b309 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -61,6 +61,13 @@ int mdiobus_unregister_device(struct mdio_device *mdiode=
v)
 =09if (mdiodev->bus->mdio_map[mdiodev->addr] !=3D mdiodev)
 =09=09return -EINVAL;
=20
+=09/*
+=09 * Some PHYs are rediscovered by a later bus reprobe, e.g. after a
+=09 * deferred parent probe. Leave optional reset lines deasserted before
+=09 * releasing them so they don't remain stuck in reset across that retry=
.
+=09 */
+=09mdio_device_reset(mdiodev, 0);
+
 =09mdio_device_unregister_reset(mdiodev);
=20
 =09mdiodev->bus->mdio_map[mdiodev->addr] =3D NULL;
--=20
2.51.2




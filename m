Return-Path: <stable+bounces-249938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIazFoO/DWr32wUAu9opvQ
	(envelope-from <stable+bounces-249938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6D58F457
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B979E3006451
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140BD3E6DD2;
	Wed, 20 May 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bh2Zivn/"
X-Original-To: stable@vger.kernel.org
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2E3E63B8
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285887; cv=none; b=LI+RtQN98/Ge3RB9eGihsJ/rz1GHctvt2Qt+JHwdeFPEUqdiCsSuBl/K6Fm/ZgF/7PLq4OflRCvc5CgfajzX4ffGRpjz6xZmU+0AkNtqMkDG7QSeHj2PJnFUV3F20Vu+2BGPJ9IZAP+rSNyyBv6zmsO3nLVDnyL960kpdq786K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285887; c=relaxed/simple;
	bh=bJCi2AmFucesxEWZrq46GWl2SpjUL3UY3JPO1BhKClc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T4slUumzG1lrFnkQJMnxb9k17Wxp899wSBowzEmHDNa9M8tGIBSg8zUC+iuJ2wOJ7hh25oz5H6e7RiLx0CP37L8kx9jZ3sIppr8m9uVHbFb9zsVTeLV0buQPh1axykQg1ACNucJD2vIV34xcLYPwk7o5LqAAiXY6AWYx87hq44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bh2Zivn/; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779285867; x=1779545067;
	bh=bJCi2AmFucesxEWZrq46GWl2SpjUL3UY3JPO1BhKClc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bh2Zivn/h75YnNUc0/QGa+G5tcOq/ehcd0qBSMJe22Sejuy6cfJQAqi6bauGg93rr
	 qwVIhjkFtPNKp16AgJoTV3uvvD5VcqnHpqU/+C/9uPQFoli0MCcrqy3weJ6weatl62
	 8QYkdOChRPAK7f9VN8+KyWf2yp3ZdcsZ2EF/6IRxrNhs+K3j3MwoF3/aDsd91ymC1K
	 o7WVWZAqV4dZI9r3u+/NpKUZFzM9MAP5UAGplgP1ClraCNIys0fe36Hn3eXv5FEuKU
	 ey74XzqcKZgTcNW+sqO+7xZOw4XfAagO5NrRlGPWz4Fpd4lxLs1BVAzhxJJe+x5C6/
	 qJ3ZqrcVHXevA==
Date: Wed, 20 May 2026 14:04:23 +0000
To: leo.moerlein@gmail.com
From: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>
Cc: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>, stable@vger.kernel.org
Subject: [PATCH] net: phy: mdio_bus: leave PHY reset deasserted on unregister
Message-ID: <20260520140421.1062019-1-leo.moerlein@proton.me>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: 0e0faec7508f741689d7968b6c635254b430c1bf
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249938-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAA6D58F457
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




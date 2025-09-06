Return-Path: <stable+bounces-177952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3649B46D90
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706E37C6710
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0022EFD88;
	Sat,  6 Sep 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyJxGIJO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAF131E2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164359; cv=none; b=p0BfhjtPTDiRWnwTV8QcKhWcvmPhT0M0/iPZsViJ3/dnkTjc5gSV0PsLC9yiBRaHyDDFkJ7q+sDr59EqQdQGFJeiEGQozNC7kfgHzsxnUu03pWduO4ERorjuqY0ba5l9UwNEMxPNM+UZVkSko3E3XUgJJdXrli0OWXcLrKo/qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164359; c=relaxed/simple;
	bh=DafOx3sfUeqsvw67KzRya1yNOhw0qqe4xG7AQgCxOrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQVaocF95Ek8xqvkDJVSbNSvLYlw9ha+fCZz38p9F4zWs57DgeFGLWQZtcTUdvBcwJR5mjGCAz2BkFSrAYWXB+K4WyQy35xFdL8TSoVmkcWcLO5/7Y4k3z4ajOsSlaF9rRQ6Z/dA1YHfYu4+IhGA/0EEwMOITcdzJ4HN95ptRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyJxGIJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA0C4CEE7;
	Sat,  6 Sep 2025 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164358;
	bh=DafOx3sfUeqsvw67KzRya1yNOhw0qqe4xG7AQgCxOrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyJxGIJOH0QmkprMGeRtVqL8pmW7GJup9+ZN8hD/gGZpQ/9UXZ+Fy4KauRcoJ+V0U
	 0azDpd61eHTBRxjCCG+qfwH46dlHBGNRBX2waTg1D2pKOWnfA9e+0B7GIqb2r5zaTx
	 ohzltb4YAVVeitCHuECwksT1u5WQLL1Vcpw4+Zixmrr6qLctYJOWAleOv7dQiQwt0z
	 Xhk7mR/5HKtX7zUoMN++POfFNnYMiXVebuf9mCcJAs0kc8exWAgP5ETWHM7HJDq8Qy
	 /HvWXwfM1kkYcj0d3TgduimUdt0hWg7Uu4Xr+18N8hy5y5O2y45Ks2agw6qkNWXEUY
	 3grku9k0lrvuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>,
	Yuiko Oshino <yuiko.oshino@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] net: phy: microchip: implement generic .handle_interrupt() callback
Date: Sat,  6 Sep 2025 09:12:34 -0400
Message-ID: <20250906131236.3883856-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025042824-quiver-could-ffa2@gregkh>
References: <2025042824-quiver-could-ffa2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit e01a3feb8f69ab620b0016498603cad364f65224 ]

In an attempt to actually support shared IRQs in phylib, we now move the
responsibility of triggering the phylib state machine or just returning
IRQ_NONE, based on the IRQ status register, to the PHY driver. Having
3 different IRQ handling callbacks (.handle_interrupt(),
.did_interrupt() and .ack_interrupt() ) is confusing so let the PHY
driver implement directly an IRQ handler like any other device driver.
Make this driver follow the new convention.

Cc: Nisar Sayed <Nisar.Sayed@microchip.com>
Cc: Yuiko Oshino <yuiko.oshino@microchip.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 30a41ed32d30 ("net: phy: microchip: force IRQ polling mode for lan88xx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/microchip.c    | 19 +++++++++++++++++++
 drivers/net/phy/microchip_t1.c | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index e6ad7d29a0559..b8a1cbd180cdf 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -56,6 +56,24 @@ static int lan88xx_phy_ack_interrupt(struct phy_device *phydev)
 	return rc < 0 ? rc : 0;
 }
 
+static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, LAN88XX_INT_STS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int lan88xx_suspend(struct phy_device *phydev)
 {
 	struct lan88xx_priv *priv = phydev->priv;
@@ -374,6 +392,7 @@ static struct phy_driver microchip_phy_driver[] = {
 
 	.ack_interrupt	= lan88xx_phy_ack_interrupt,
 	.config_intr	= lan88xx_phy_config_intr,
+	.handle_interrupt = lan88xx_handle_interrupt,
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index fed3e395f18e1..553b391d1747a 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -203,6 +203,24 @@ static int lan87xx_phy_ack_interrupt(struct phy_device *phydev)
 	return rc < 0 ? rc : 0;
 }
 
+static irqreturn_t lan87xx_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, LAN87XX_INTERRUPT_SOURCE);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (irq_status == 0)
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int lan87xx_config_init(struct phy_device *phydev)
 {
 	int rc = lan87xx_phy_init(phydev);
@@ -223,6 +241,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 
 		.ack_interrupt  = lan87xx_phy_ack_interrupt,
 		.config_intr    = lan87xx_phy_config_intr,
+		.handle_interrupt = lan87xx_handle_interrupt,
 
 		.suspend        = genphy_suspend,
 		.resume         = genphy_resume,
-- 
2.50.1



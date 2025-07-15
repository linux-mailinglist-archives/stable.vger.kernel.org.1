Return-Path: <stable+bounces-162099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F34B05B92
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D587B8C0B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130E2E3AE0;
	Tue, 15 Jul 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NEOycXdT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB12E1734;
	Tue, 15 Jul 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585670; cv=none; b=HhCcZ/4Dit8HTqOrA/ZGKpYXpVNbTPs3g6O+SU2mW7yuZAHt/qrKefUunF/cyT0iXLEmGQ6cpHoIGasIPYpTsfM/k7+TK99Sd11I9aHfswDmy93jCaSXwTn/xIAJrwJyeHNT6t8+IfI6MlsqBUuJ1YmYLETGgCkRFZrU3LH/2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585670; c=relaxed/simple;
	bh=HXgEyhAIhgPsEP2QcrA4sZwOAS+xVIUJiVrD9Yp1nGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S90THC1LqF6KAylAqZQwM5yYLSAMbKLNgA2nmeDFQ34Hx6hOqWRQ/GkvZHMjdX/FtsskxHfReIBjZc+zCaawsaVeW1ogmTwYSVyW7LmUoZi/KBW+SKveNbKaJWCaQ2NWFQ13ldVcr352HG6xUOBBh0280ztuaYiLDBS6J/n6N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NEOycXdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C12C4CEE3;
	Tue, 15 Jul 2025 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585670;
	bh=HXgEyhAIhgPsEP2QcrA4sZwOAS+xVIUJiVrD9Yp1nGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEOycXdTGIwiu1/OxyDjby+ZcNEnbGxW2WP0NMU9imtubJ2a4LQqrlv7XXOmtf4iX
	 zjBVo+ACqpfTAu4i577xysbnFP01kA+i+ImQfQPlm5bFLVxDLClOZ73HH/VOCbP6tH
	 5PNoqLQDEghlMm7cDYqNt4S/2u/vGFb1NxrORS3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 128/163] net: phy: microchip: limit 100M workaround to link-down events on LAN88xx
Date: Tue, 15 Jul 2025 15:13:16 +0200
Message-ID: <20250715130813.978554260@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit dd4360c0e8504f2f7639c7f5d07c93cfd6a98333 ]

Restrict the 100Mbit forced-mode workaround to link-down transitions
only, to prevent repeated link reset cycles in certain configurations.

The workaround was originally introduced to improve signal reliability
when switching cables between long and short distances. It temporarily
forces the PHY into 10 Mbps before returning to 100 Mbps.

However, when used with autonegotiating link partners (e.g., Intel i350),
executing this workaround on every link change can confuse the partner
and cause constant renegotiation loops. This results in repeated link
down/up transitions and the PHY never reaching a stable state.

Limit the workaround to only run during the PHY_NOLINK state. This ensures
it is triggered only once per link drop, avoiding disruptive toggling
while still preserving its intended effect.

Note: I am not able to reproduce the original issue that this workaround
addresses. I can only confirm that 100 Mbit mode works correctly in my
test setup. Based on code inspection, I assume the workaround aims to
reset some internal state machine or signal block by toggling speeds.
However, a PHY reset is already performed earlier in the function via
phy_init_hw(), which may achieve a similar effect. Without a reproducer,
I conservatively keep the workaround but restrict its conditions.

Fixes: e57cf3639c32 ("net: lan78xx: fix accessing the LAN7800's internal phy specific registers from the MAC driver")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250709130753.3994461-3-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/microchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index c9b6ede7ac6ac..ffca1cec4ec99 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -332,7 +332,7 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	 * As workaround, set to 10 before setting to 100
 	 * at forced 100 F/H mode.
 	 */
-	if (!phydev->autoneg && phydev->speed == 100) {
+	if (phydev->state == PHY_NOLINK && !phydev->autoneg && phydev->speed == 100) {
 		/* disable phy interrupt */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp &= ~LAN88XX_INT_MASK_MDINTPIN_EN_;
-- 
2.39.5





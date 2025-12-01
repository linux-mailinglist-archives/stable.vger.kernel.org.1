Return-Path: <stable+bounces-198010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0610C996F9
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 23:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4C3A1CB4
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119D212FB3;
	Mon,  1 Dec 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxRYpxQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC871E7C03
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629437; cv=none; b=HGIkC4Clk2qZTKBQwWDizS7TF1rTyayZzlDy+bKzwFzXM1HLYIjeybRYy7rUY7M9QSvta5mT0iqFrEFzUGK5F4G2w1X0coCGoR573OOnr7lzoc9KVSsSXFqfDFrD/AUEoOaQDbKs9MctVYBZJIoAGqJqAyI50AWQxFuSyU9hIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629437; c=relaxed/simple;
	bh=lO+fQlP6d08NjPMURZK+KEwqorN6enU1t+5y/wVJkNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr9q+iwKZC8tqK8H2Vsth6qu9pTXAHagn+PmHpWycOhPNquPg2UhPa7S2aSansXLFuhyNrCJgGtVYd01mrNUenKhrIh9MP9bO6Py2FN6v2m9eloPztXl0aU3MmPOhO7p0Oxjn7DIoEyFKtVPQIqEs03Q05E7HxXqsJq0ShtQZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxRYpxQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E8C4CEF1;
	Mon,  1 Dec 2025 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629437;
	bh=lO+fQlP6d08NjPMURZK+KEwqorN6enU1t+5y/wVJkNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxRYpxQec2RU+oBHCFNTpO2TAAsXgdzRpSUg1HAS62TVI1yWZ5UHLXCt4zFghfJpU
	 hHOu7aB/zfqXmlDzRMOrCoEsG16aoq8gSyThAfiC999gqJIgDkGkZ8DJzyt7RbkJfu
	 DjNcr+Jd6gCB4CloX7PmaUKLZ6vwM6OrwnbjOkM+hkD1blQWCc+zUR1/M1TA9C4/RL
	 o+/h508dq2qNvkn1+EPodtdC9oNVeBdkmvbeQmKEnic/W1kFgFbX5Ogk0NyASt7Xd3
	 I4L1mD1oEmGKF/93DtyayhBTD8aRUF8SVippXCmAjE6weE4Ss93x/uxhBZDJlfMoGz
	 ak6lFSoTc6ORg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] can: rcar_canfd: Fix CAN-FD mode as default
Date: Mon,  1 Dec 2025 17:50:34 -0500
Message-ID: <20251201225034.1298247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120155-wrench-aching-b242@gregkh>
References: <2025120155-wrench-aching-b242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6d849ff573722afcf5508d2800017bdd40f27eb9 ]

The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
has aligned with the flow mentioned in the hardware manual for all SoCs
except R-Car Gen3 and RZ/G2L SoCs. On R-Car Gen4 and RZ/G3E SoCs, due to
the wrong logic in the commit[1] sets the default mode to FD-Only mode
instead of CAN-FD mode.

This patch sets the CAN-FD mode as the default for all SoCs by dropping
the rcar_canfd_set_mode() as some SoC requires mode setting in global
reset mode, and the rest of the SoCs in channel reset mode and update the
rcar_canfd_reset_controller() to take care of these constraints. Moreover,
the RZ/G3E and R-Car Gen4 SoCs support 3 modes compared to 2 modes on the
R-Car Gen3. Use inverted logic in rcar_canfd_reset_controller() to
simplify the code later to support FD-only mode.

[1]
commit 45721c406dcf ("can: rcar_canfd: Add support for r8a779a0 SoC")

Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251118123926.193445-1-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ adapted to use existing is_gen4() helper and RCANFD_GEN4_FDCFG() macro instead of new ch_interface_mode field and fcbase struct ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_canfd.c | 53 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 24dd15c917228..ba662bef155ca 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -681,26 +681,6 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
-static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-{
-	if (is_gen4(gpriv)) {
-		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
-					    : RCANFD_GEN4_FDCFG_CLOE;
-
-		for_each_set_bit(ch, &gpriv->channels_mask,
-				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
-					   val);
-	} else {
-		if (gpriv->fdmode)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
-					   RCANFD_GRMCFG_RCMC);
-		else
-			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
-					     RCANFD_GRMCFG_RCMC);
-	}
-}
-
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
 	u32 sts, ch;
@@ -732,6 +712,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* Set the controller into appropriate mode */
+	if (!is_gen4(gpriv)) {
+		if (gpriv->fdmode)
+			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
+					   RCANFD_GRMCFG_RCMC);
+		else
+			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
+					     RCANFD_GRMCFG_RCMC);
+	}
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -750,10 +740,27 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 				"channel %u reset failed\n", ch);
 			return err;
 		}
-	}
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+		/* Set the controller into appropriate mode */
+		if (is_gen4(gpriv)) {
+			/* Do not set CLOE and FDOE simultaneously */
+			if (!gpriv->fdmode) {
+				rcar_canfd_clear_bit(gpriv->base,
+						     RCANFD_GEN4_FDCFG(ch),
+						     RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_set_bit(gpriv->base,
+						   RCANFD_GEN4_FDCFG(ch),
+						   RCANFD_GEN4_FDCFG_CLOE);
+			} else {
+				rcar_canfd_clear_bit(gpriv->base,
+						     RCANFD_GEN4_FDCFG(ch),
+						     RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_clear_bit(gpriv->base,
+						     RCANFD_GEN4_FDCFG(ch),
+						     RCANFD_GEN4_FDCFG_CLOE);
+			}
+		}
+	}
 
 	return 0;
 }
-- 
2.51.0



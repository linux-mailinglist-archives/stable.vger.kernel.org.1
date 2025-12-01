Return-Path: <stable+bounces-198014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F65C99984
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 00:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A02D345935
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3626ED4E;
	Mon,  1 Dec 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRC2GUBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C023B61B
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631750; cv=none; b=NIqDkYeCv0XokOM06CZK5bgUcN3oAg2t2YtGoGefBljuShY2XvSb+nWwtNbpbmeObpwcPmmW/07XtnlDUa46vRJdwPgGUFXMB+yiAZzsVCj/319J/8NIMwiDgv1nrBfTUTXiaGSnkkF8Cunqz1qGZtB9G61qTYJu394roVHh48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631750; c=relaxed/simple;
	bh=EUBZWjc90F/9qqf4JPjLkyXox19Jneu/MLW2lM2uLO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUwIabq9zkt1ELMlblnIJyVZ6iwMTcsVcAQAjftmH6aT/9dwoS8ZqMHpRSWtqDkwCJgL7jKKDdAO4Cn75ofc2lfOkdfQt3nXNfg823EFTTvUlw4UlduCtk0HlMHSaPgZphlieUJhlmVw/YNPBVNW5uwJTXrbw71jQu24rAXNubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRC2GUBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E28C4CEF1;
	Mon,  1 Dec 2025 23:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631750;
	bh=EUBZWjc90F/9qqf4JPjLkyXox19Jneu/MLW2lM2uLO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRC2GUBybPN/620Z+NjmOCtbwzmaZBtL2xtAclQvq4B13wKO7zckbB9H+t+u2612m
	 2ZE7OGxv8U5VkFJgj+eMY+fcD0RLrscEKqZml2wIelqFGaWyhrK3oYaKrA1fKsZcfL
	 SJi8fdC1Kzo/FW/nMN77lB/WvzSEWJfvXYWIhTKCYmCto3QFNGGzUkNpw8UYpUFbZO
	 ROobu0HfHktOeMZiWkKqsRzT24eFGsmSe4IGj6J5i7fXsewk6j3fiCVg4mzW0EkIt4
	 6epWsgjqpIoFUciI3ZJaw2SdzrVWNRxiGK6hOiaUEQYjoJQFVY1/1if3EvPXr4kFB5
	 nfIyKOlGHMpdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] can: rcar_canfd: Fix CAN-FD mode as default
Date: Mon,  1 Dec 2025 18:29:00 -0500
Message-ID: <20251201232900.1304203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120156-taunt-paternity-aa16@gregkh>
References: <2025120156-taunt-paternity-aa16@gregkh>
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
index ae4ebcee60779..5a30667001c94 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -687,26 +687,6 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
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
@@ -738,6 +718,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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
@@ -756,10 +746,27 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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



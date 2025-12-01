Return-Path: <stable+bounces-197926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798FC9824E
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED03E3A279A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61A32D451;
	Mon,  1 Dec 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0XRchIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF62FE585
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604739; cv=none; b=kKk0kUcCDba161Ul82qeO51R7XxxDfXEExvGKVCtRHKHNDn5H9yqWYWNMp1x7HJFaV5jhkJqS6/UAweD3xeBZkSHt2JA8Ns4/qhLX0Xnkt6Grha/JWInA/hNJxzuaODwjKfu276vQAbeo1+q6p3E+t9ByX2up9zj/7lfUG0PwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604739; c=relaxed/simple;
	bh=Jf7mE4nfL0QyVywsyFUwQIx8zcJcRB9tkWkma1tJWdc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ozRl/a2Nun0aRm7ZULxR3JzSJAWppghuf54WgO9tWV5PcIHxKAoBPZ0Zn0fx8V133uEpP9XvPLXck3QnoPQOJfMLXNKnxVQq4kADY+n6kKxIGIsHDjEoKHdj660mydxTraplKRkYrQbBp3tLUaR50OZjkdHrUF6/xcc45DpOc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0XRchIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77678C4CEF1;
	Mon,  1 Dec 2025 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764604738;
	bh=Jf7mE4nfL0QyVywsyFUwQIx8zcJcRB9tkWkma1tJWdc=;
	h=Subject:To:Cc:From:Date:From;
	b=G0XRchIlw69Iotf0bXCRWfSO2U//nDnBRho61Oxsyl5IQoItexl1nsUEZXGiBdnHQ
	 fGA7O/5cFfZXlOVk7JlVurERp0KT9Yn/SrUIoI0pYnpZmO1VNnrN/AZxqzyrVyAZj1
	 lf6bjyJilmWCNU6+wcewwkKIV5JhWgQaqWHiT3hc=
Subject: FAILED: patch "[PATCH] can: rcar_canfd: Fix CAN-FD mode as default" failed to apply to 6.12-stable tree
To: biju.das.jz@bp.renesas.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 16:58:55 +0100
Message-ID: <2025120155-wrench-aching-b242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6d849ff573722afcf5508d2800017bdd40f27eb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120155-wrench-aching-b242@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d849ff573722afcf5508d2800017bdd40f27eb9 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Tue, 18 Nov 2025 12:39:25 +0000
Subject: [PATCH] can: rcar_canfd: Fix CAN-FD mode as default

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

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 45d36adb51b7..4c0d7d26df9f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -709,6 +709,11 @@ static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
 	rcar_canfd_update(val, val, addr);
 }
 
+static void rcar_canfd_clear_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, 0, addr);
+}
+
 static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
 {
 	rcar_canfd_update(mask, val, addr);
@@ -755,25 +760,6 @@ static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
 
-static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-{
-	if (gpriv->info->ch_interface_mode) {
-		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
-					    : RCANFD_GEN4_FDCFG_CLOE;
-
-		for_each_set_bit(ch, &gpriv->channels_mask,
-				 gpriv->info->max_channels)
-			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
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
 	struct device *dev = &gpriv->pdev->dev;
@@ -806,6 +792,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* Set the controller into appropriate mode */
+	if (!gpriv->info->ch_interface_mode) {
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
@@ -823,10 +819,23 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
-	}
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+		/* Set the controller into appropriate mode */
+		if (gpriv->info->ch_interface_mode) {
+			/* Do not set CLOE and FDOE simultaneously */
+			if (!gpriv->fdmode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_CLOE);
+			} else {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+			}
+		}
+	}
 
 	return 0;
 }



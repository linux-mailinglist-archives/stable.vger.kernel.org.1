Return-Path: <stable+bounces-125906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5FA6DE9E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3773216ADD8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E225F980;
	Mon, 24 Mar 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmBmA9Zm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AB25E444
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830091; cv=none; b=LURCQbO5Y2OVm+GZdMRaKM9JKzLy3OQzL/I9NHDdq985vRruDaTyG49Gc0rwI0Xrk5T5Jjpjb4XNDeb61x0QEoeDnoMP7g/b1DcPgFaK8359PIKnZmAP1ZVr9rwa9wS2/1egPb8kR+cTyvO1MMhFt79kIyG+r7HMfTKOfsRPfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830091; c=relaxed/simple;
	bh=t9vEde7F3gvJw9Ap7XD8boNaUi2Uq6YYdLnF+JKE2nQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PJ2R536pItujVeY2KNQpckZPdCvBrxNO1tUloZLyNz/koPRO/svtic1Obpc1qT2TT7XWR60WfJCP3oKczJvR4oqtJhHRnKPCM5Tjekj7d7DFKEj/MLz1GWFuvSEv2HS4K86jOhpjNwDlqZkM9LMV4GbEtJwehvKGtztAA0uyM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmBmA9Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10EBC4CEEA;
	Mon, 24 Mar 2025 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830090;
	bh=t9vEde7F3gvJw9Ap7XD8boNaUi2Uq6YYdLnF+JKE2nQ=;
	h=Subject:To:Cc:From:Date:From;
	b=LmBmA9ZmLWXRRCqS4iYnewvSxe3QO1NcGgFCpJFU8kUcWfgGu0Mk+Va264/KKpkyk
	 qry0vEIkazkMk+KWnmcIXkHNkiMwQIocnUieXcNT7a/JavHFWOz6glnDH/krGwdTeo
	 /BSYLllIw9HmqTCJmD4cJ6VekAHL+wEHWvus5dwk=
Subject: FAILED: patch "[PATCH] can: rcar_canfd: Fix page entries in the AFL list" failed to apply to 5.10-stable tree
To: biju.das.jz@bp.renesas.com,geert+renesas@glider.be,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:26:39 -0700
Message-ID: <2025032439-lumpiness-enchilada-083b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1dba0a37644ed3022558165bbb5cb9bda540eaf7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032439-lumpiness-enchilada-083b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1dba0a37644ed3022558165bbb5cb9bda540eaf7 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Fri, 7 Mar 2025 17:03:27 +0000
Subject: [PATCH] can: rcar_canfd: Fix page entries in the AFL list

There are a total of 96 AFL pages and each page has 16 entries with
registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
the rule entries (r = 0..15).

Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
which is incorrect as the testing on RZ/G3E shows ch1 and ch4
gets a start value of 0 and the register contents are overwritten.

Fix this issue by using rule_entry corresponding to the channel
to find the page entries in the AFL list.

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250307170330.173425-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index df1a5d0b37b2..aa3df0d05b85 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -787,22 +787,14 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 }
 
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
-					   u32 ch)
+					   u32 ch, u32 rule_entry)
 {
-	u32 cfg;
-	int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if (ch == 0) {
-		start = 0; /* Channel 0 always starts from 0th rule */
-	} else {
-		/* Get number of Channel 0 rules and adjust */
-		cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
-		start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
-	}
-
 	/* Enable write access to entry */
-	page = RCANFD_GAFL_PAGENUM(start);
+	page = RCANFD_GAFL_PAGENUM(rule_entry);
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
 			   (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
 			    RCANFD_GAFLECTR_AFLDAE));
@@ -818,13 +810,13 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 		offset = RCANFD_C_GAFL_OFFSET;
 
 	/* Accept all IDs */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, rule_entry_index), 0);
 	/* IDE or RTR is not considered for matching */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, rule_entry_index), 0);
 	/* Any data length accepted */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, rule_entry_index), 0);
 	/* Place the msg in corresponding Rx FIFO entry */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, start),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, rule_entry_index),
 			   RCANFD_GAFLP1_GAFLFDP(ridx));
 
 	/* Disable write access to page */
@@ -1851,6 +1843,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
+	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	int i;
@@ -2023,7 +2016,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_configure_tx(gpriv, ch);
 
 		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch);
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
 	}
 
 	/* Configure common interrupts */



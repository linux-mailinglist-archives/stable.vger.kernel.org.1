Return-Path: <stable+bounces-58229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283392A348
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E400A1C20E1E
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC481AD2;
	Mon,  8 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L8ckTLxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19793FB94
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443147; cv=none; b=MsYioXyG9VLBNJ5Xij6wm/6uFsMy/YsQto7se+F3E2ME5KBaaSFka1kpQats5Z4b4SkO9jV0G8zhIXMAS8c0vhN1XfcIofOpNy7qDEFI2ikVfPVRbV8uO/5eKAETAQMDGFz0o0yPUoLc/NpHVJLSkoXsDMoch8iS2XO5z0aYiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443147; c=relaxed/simple;
	bh=hSA6O5JI19o9478sE8EBm1m4Cy5lcpBbf+k/KM0OP8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BLnbdFgiMTcSVeljhbGP4raZW6sKMzxdva5GPKbZ8KRUh27AV8Ips8zKlPSSVNzdBURRqAED+1JBjDHUuGqT/6Qdi9eK7Gu1zgJr8j7VO3B9LK6fMkrAZNCJdekjSmJ6yOT1r+UQN5LeL93rAR+4eLZUPeJDt6FEhNK33JoRPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L8ckTLxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C1BC116B1;
	Mon,  8 Jul 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443147;
	bh=hSA6O5JI19o9478sE8EBm1m4Cy5lcpBbf+k/KM0OP8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=L8ckTLxbo02vjFOoKEoySGRJfhGIqRpd0q7ELEylTZ/QMNlVJC9P3irHIr0SDdJNC
	 mce4YmxZJXQE/Iry+yTZ0bltSKSe6KZsBkwM6gKJX4VyA7Z2zvvHMhClhuLpc+ttAR
	 RY6RLkIj/hRc7yj/8XhFfjtVVDkg0zISEMdAXoDo=
Subject: FAILED: patch "[PATCH] mtd: rawnand: Ensure ECC configuration is propagated to upper" failed to apply to 5.10-stable tree
To: miquel.raynal@bootlin.com,s.hauer@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:52:24 +0200
Message-ID: <2024070824-sprint-steadying-855b@gregkh>
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
git cherry-pick -x 3a1b777eb9fb75d09c45ae5dd1d007eddcbebf1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070824-sprint-steadying-855b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3a1b777eb9fb ("mtd: rawnand: Ensure ECC configuration is propagated to upper layers")
80fe603160a4 ("mtd: nand: ecc-bch: Stop using raw NAND structures")
ea146d7fbf50 ("mtd: nand: ecc-bch: Update the prototypes to be more generic")
127aae607756 ("mtd: nand: ecc-bch: Drop mtd_nand_has_bch()")
3c0fe36abebe ("mtd: nand: ecc-bch: Stop exporting the private structure")
8c5c20921856 ("mtd: nand: ecc-bch: Cleanup and style fixes")
cdbe8df5e28e ("mtd: nand: ecc-bch: Move BCH code to the generic NAND layer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a1b777eb9fb75d09c45ae5dd1d007eddcbebf1f Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 7 May 2024 10:58:42 +0200
Subject: [PATCH] mtd: rawnand: Ensure ECC configuration is propagated to upper
 layers

Until recently the "upper layer" was MTD. But following incremental
reworks to bring spi-nand support and more recently generic ECC support,
there is now an intermediate "generic NAND" layer that also needs to get
access to some values. When using "converted" ECC engines, like the
software ones, these values are already propagated correctly. But
otherwise when using good old raw NAND controller drivers, we need to
manually set these values ourselves at the end of the "scan" operation,
once these values have been negotiated.

Without this propagation, later (generic) checks like the one warning
users that the ECC strength is not high enough might simply no longer
work.

Fixes: 8c126720fe10 ("mtd: rawnand: Use the ECC framework nand_ecc_is_strong_enough() helper")
Cc: stable@vger.kernel.org
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Closes: https://lore.kernel.org/all/Zhe2JtvvN1M4Ompw@pengutronix.de/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/linux-mtd/20240507085842.108844-1-miquel.raynal@bootlin.com

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d7dbbd469b89..acd137dd0957 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6301,6 +6301,7 @@ static const struct nand_ops rawnand_ops = {
 static int nand_scan_tail(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_device *base = &chip->base;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i;
 
@@ -6445,9 +6446,13 @@ static int nand_scan_tail(struct nand_chip *chip)
 	if (!ecc->write_oob_raw)
 		ecc->write_oob_raw = ecc->write_oob;
 
-	/* propagate ecc info to mtd_info */
+	/* Propagate ECC info to the generic NAND and MTD layers */
 	mtd->ecc_strength = ecc->strength;
+	if (!base->ecc.ctx.conf.strength)
+		base->ecc.ctx.conf.strength = ecc->strength;
 	mtd->ecc_step_size = ecc->size;
+	if (!base->ecc.ctx.conf.step_size)
+		base->ecc.ctx.conf.step_size = ecc->size;
 
 	/*
 	 * Set the number of read / write steps for one page depending on ECC
@@ -6455,6 +6460,8 @@ static int nand_scan_tail(struct nand_chip *chip)
 	 */
 	if (!ecc->steps)
 		ecc->steps = mtd->writesize / ecc->size;
+	if (!base->ecc.ctx.nsteps)
+		base->ecc.ctx.nsteps = ecc->steps;
 	if (ecc->steps * ecc->size != mtd->writesize) {
 		WARN(1, "Invalid ECC parameters\n");
 		ret = -EINVAL;



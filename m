Return-Path: <stable+bounces-179438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F107B560AB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9E3565654
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1A2EC565;
	Sat, 13 Sep 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiCgljn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671062EB5D8
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766180; cv=none; b=pdIFG3R0ZwKvJhE2KmzTzKYS2VxvGk7fP57SOrYRAW8Cg3QsOzPATCWC9eGWZcTB2FjRS1hPWn5Ssl5btosQxznnZiWY8MYnwpV+8F9+yhs2iP//wDwFz4hgCMwVNfB4gQAd1HRHuebghWeSyZK7VdktK9BKEU6aJHUnC3mXsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766180; c=relaxed/simple;
	bh=a2mufQn9CyyGPTnz9yfAjccaMMhkKci035kmZDazAuo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oyr8QM1pPrmsdIyMF+2kqVcXbdNPDxeOq1pwocTgeTJTdScDGqHc9jKcWMGtC1tu/To2eNpaPhKZLCiPdLkNolrX/yyb/WwqZFPsLBa2T7vIOiR+oVG2BcK36jNwefPxuCa64teOqqOTV2kYOFV/J0sPwR2veq7BUMMvpEqgX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiCgljn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A35BC4CEEB;
	Sat, 13 Sep 2025 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766179;
	bh=a2mufQn9CyyGPTnz9yfAjccaMMhkKci035kmZDazAuo=;
	h=Subject:To:Cc:From:Date:From;
	b=JiCgljn19MJ6IhPkAZK1mkSNQdONkYeSK4CIZLK9qJwhmxHbKov6gE102MOsUJ6Yg
	 XMsIyAxpKFhYNjc2JPBt26FE1LwwADtB/06jsZnVMZoEXwkDUwk+48L3wys8duwq3Z
	 z5VJJgLVtovpvLhmDoQleRQSFktsyKkvwExv1E/8=
Subject: FAILED: patch "[PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing" failed to apply to 5.10-stable tree
To: alexander.sverdlin@gmail.com,ada@thorsis.com,alexander.sverdlin@siemens.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:22:46 +0200
Message-ID: <2025091346-museum-immunity-ab3d@gregkh>
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
git cherry-pick -x fd779eac2d659668be4d3dbdac0710afd5d6db12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091346-museum-immunity-ab3d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd779eac2d659668be4d3dbdac0710afd5d6db12 Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Thu, 21 Aug 2025 14:00:57 +0200
Subject: [PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Having setup time 0 violates tAR, tCLR of some chips, for instance
TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
98 dc 90 15 76 ...).

Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
[1], but it looks more appropriate to just calculate setup time properly.

[1] Link: https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ApplicationNotes/ApplicationNotes/doc6255.pdf

Cc: stable@vger.kernel.org
Fixes: f9ce2eddf176 ("mtd: nand: atmel: Add ->setup_data_interface() hooks")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 84ab4a83cbd6..db94d14a3807 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1377,14 +1377,24 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 	if (ret)
 		return ret;
 
+	/*
+	 * Read setup timing depends on the operation done on the NAND:
+	 *
+	 * NRD_SETUP = max(tAR, tCLR)
+	 */
+	timeps = max(conf->timings.sdr.tAR_min, conf->timings.sdr.tCLR_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NRD_SHIFT, ncycles);
+	if (ret)
+		return ret;
+
 	/*
 	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
-	 *
-	 * NRD_SETUP is always 0.
+	 * NRD_CYCLE = max(tRC, NRD_SETUP + NRD_PULSE + NRD_HOLD)
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
 	ncycles = max(totalcycles, ncycles);



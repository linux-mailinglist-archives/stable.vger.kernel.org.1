Return-Path: <stable+bounces-179439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC7B560AC
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2717B85C3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7C2ECD05;
	Sat, 13 Sep 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqYOIFIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EA2EC085
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766183; cv=none; b=lyK7pHfJcnw1FnuQROrs9Wia3sA+YMqb5Ddkg44OIJ1A5s2SapSJrl1/uVHlHyLoWVomYhmb5shQ0saza82S0H6ZJ7gPG1qvDU3enBYUm1dk1F/kPPS/cLTAbA9JQ5fPRuafVN3Wq7CPlzV5AaWG7apxcQCVmgaTugj1NOLrvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766183; c=relaxed/simple;
	bh=jt/0RnGQcsjwR9RomdvT5WKQK8zogBpePMLgiMx5tBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p2qi8ZGMZdUm3cPCE26px3e7Q2XGJxXoA97k8IUggg+o0wbGW1bTDI2YZZTiFMkob46rJwOPQAFld7AO8Dmz6R43SbyzvS+JFWn8PkqRkvU4zwn0FRRFTSh+NeaEtZY0jY8WHshuKZkD795cHXaiyElggi7+nxfrQOv0PJjBiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqYOIFIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D5C4CEEB;
	Sat, 13 Sep 2025 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766183;
	bh=jt/0RnGQcsjwR9RomdvT5WKQK8zogBpePMLgiMx5tBc=;
	h=Subject:To:Cc:From:Date:From;
	b=cqYOIFIsUcFKinTRoQgjD9KQnd9/3n2El2oHvrXHo8rDltA+nd71c15UT6iDfAzF2
	 3TZuqel4JoVaMmx7U2khB5fx8pD8b7+RIwh5GNCzagImBlX6K1HKC4ESQ7lTzcg5EQ
	 a7AalfOJprzJ9iDnUio+0ynTWZlH4v6jsy/KfhVo=
Subject: FAILED: patch "[PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing" failed to apply to 5.4-stable tree
To: alexander.sverdlin@gmail.com,ada@thorsis.com,alexander.sverdlin@siemens.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:22:46 +0200
Message-ID: <2025091346-runaround-croon-39cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fd779eac2d659668be4d3dbdac0710afd5d6db12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091346-runaround-croon-39cc@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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



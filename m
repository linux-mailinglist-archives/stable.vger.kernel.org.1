Return-Path: <stable+bounces-171974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B35B2F766
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214C07AFE02
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4C30F809;
	Thu, 21 Aug 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="FANoF1CS"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5E28DB52
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777688; cv=none; b=WxYQ7qMpGj1rCQtekz6UOSwCpIz6yW29C1b8mqO7PkyA+QAboOWN3CH9QbmtnmqKSSnlOc+viIQt09iyfU4VwslNTiEqygzNIdQoz19G97IFLCrN2/VQjwCZ7U1xPWHvxjeN2/Zb7qvfuf+GRae2dPbwNWHit5N+HQJIp2xwmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777688; c=relaxed/simple;
	bh=AZqPOIs8oTppgZY6LZx0VdFQyYDMm9MLTjA6k0xXVeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PH/qAE8zSQx6jtBtUH2rOgS8dn1pOOOmx4ea3U5RfKcSOQNBNhe32Yq0RsROazJNkEizewLixreImYwVzeWbph5rvCerImhzhu5vP2wMZUQxVcfckDNRDzSlYcyiaz439AqPueRxo90OeOWigiQVl/GK0L5ueeWdIdaSCaig7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=FANoF1CS; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250821120115d86f8bb70b0fc29d5b
        for <stable@vger.kernel.org>;
        Thu, 21 Aug 2025 14:01:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uFziv+Xoqi8s1O750PzRShk/r5lOsnFwo6no1Ndpf4A=;
 b=FANoF1CSNcNhr0AzulgktsCv51sdgu0zyLNmYj8uo+YgW5H+jcFgTEBccktzoVBc0cXQqz
 WZxAe1J/kqCmDXahSLd0oi//0StCM16PlOty2c9HNjqo71J6+dTuX1xgCG/1Aj6pakw2thA/
 RYHKTD3gGvm0zZ0d+dngae0QJm40XFUVUER0jtG41a7XMMuvBLMqwHF6mhG8SaWMpdKggF7/
 soaC1OgPgeedpFJghTnbrTLjH2Xyny5SZAZoVdbmJpwBucU1OejrhxmRA386vL2ywecXGz5+
 /NkOrAmXc/He6Bki0O2CQJj6dtLU7aCGNdD0WrAOBgIKIRO5b8Z2w9ow==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
	linux-mtd@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Balamanikandan.Gunasundar@microchip.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
Date: Thu, 21 Aug 2025 14:00:57 +0200
Message-ID: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

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
---
v2:
- Cc'ed stable
- reformatted atmel_smc_cs_conf_set_setup() call
- rebased onto mtd/fixes

 drivers/mtd/nand/raw/atmel/nand-controller.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dedcca87defc7..ad0eff385e123 100644
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
-- 
2.50.1



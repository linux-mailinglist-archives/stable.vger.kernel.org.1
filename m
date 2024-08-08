Return-Path: <stable+bounces-66002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C894B72C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795BA283689
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16A188CAD;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gN0Uk/uq"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3C187845;
	Thu,  8 Aug 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101109; cv=none; b=g/F8zRwU62ErQzg77FHnknheQBH5OzGuDbPmwnQoaMC5mkOjZAzxzDFJjnCly5IH+PKWtZZFW6iavAejpa/n9Y0fbUTgOjiVAe/WhbIBM4FtKy27CY/tAlboSIjYc6ccpxWUzNV/f1l8kqleTx99DOjARiVX/mXTfPSoJyIsbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101109; c=relaxed/simple;
	bh=LMXtIrcdC4H9G0lbWS6XSXvCMbNu5NBZqkE0JDrJLOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rf2oSmmOLVZBmf2f+32RH3h+oCY5vfcOR0UBoyPkkiHQp8Mqi9tTy4euznQo9zp29URvTSqCX6l893gbRIARSQy2jMCQvrRBXleood1mBSmIdbwdsC52sag8Nbq+m5j1kNzjlBt6OgWcaoR9ct36we3QLGiL8vFZ1dwbmm4R+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gN0Uk/uq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 90A4EC0009;
	Thu,  8 Aug 2024 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1sNai9Jq2u7qPOllWQVrRFQ040G46WCUggP4JjIwzw=;
	b=gN0Uk/uqPGnTJ6esXWrtABtNBxnV4yIYif8QxXp/26PxdMvJIF8+ln3j2iWbJExBMXWwdv
	EUqX566FoQ7JYaGSTsUc5q27vmLFMqURO6dDWKjtXv1zvTU+pib0UncbHMXpb/Wy9ypA2D
	f2Eifo/uWZpMOoPIv9BLZhmnE8WfYsMKDl9UbpP8kc4UEbNADAkqgJ2kUEEn0uesVDXuFt
	LJKyvkZBpBuhY06XT8xKLgiTkVM9M44jHsPecZRtP9bdUQfnfJ9REoo4PayPcbuuudW3z7
	tuW79gJL2vSc7kJx9JNDWKyupzpwyZdOTgjeSd+1BWH5NyfwmddTH1a2gOOMkA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/36] soc: fsl: cpm1: qmc: Update TRNSYNC only in transparent mode
Date: Thu,  8 Aug 2024 09:10:54 +0200
Message-ID: <20240808071132.149251-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The TRNSYNC feature is available (and enabled) only in transparent mode.

Since commit 7cc9bda9c163 ("soc: fsl: cpm1: qmc: Handle timeslot entries
at channel start() and stop()") TRNSYNC register is updated in
transparent and hdlc mode. In hdlc mode, the address of the TRNSYNC
register is used by the QMC for other internal purpose. Even if no weird
results were observed in hdlc mode, touching this register in this mode
is wrong.

Update TRNSYNC only in transparent mode.

Fixes: 7cc9bda9c163 ("soc: fsl: cpm1: qmc: Handle timeslot entries at channel start() and stop()")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 76bb496305a0..bacabf731dcb 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -940,11 +940,13 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
 		goto end;
 	}
 
-	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
-	if (ret) {
-		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
-			chan->id, ret);
-		goto end;
+	if (chan->mode == QMC_TRANSPARENT) {
+		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
+		if (ret) {
+			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
+				chan->id, ret);
+			goto end;
+		}
 	}
 
 	/* Restart the receiver */
@@ -982,11 +984,13 @@ static int qmc_chan_start_tx(struct qmc_chan *chan)
 		goto end;
 	}
 
-	ret = qmc_setup_chan_trnsync(chan->qmc, chan);
-	if (ret) {
-		dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
-			chan->id, ret);
-		goto end;
+	if (chan->mode == QMC_TRANSPARENT) {
+		ret = qmc_setup_chan_trnsync(chan->qmc, chan);
+		if (ret) {
+			dev_err(chan->qmc->dev, "chan %u: setup TRNSYNC failed (%d)\n",
+				chan->id, ret);
+			goto end;
+		}
 	}
 
 	/*
-- 
2.45.0



Return-Path: <stable+bounces-236627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAptM+EY3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4343EEDB9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E59273030B8F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368862FFFBE;
	Mon, 13 Apr 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9ikF5Uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC3302146;
	Mon, 13 Apr 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097394; cv=none; b=j3Rzd4l4ixxS3TYl5blVTo9A7xoix8GbkfT4NjU91JvZNUGA2mTxQyIibbd+Y3xyVlzQ/HcMFFZS0hmcg4Z4J0umhN7vV7bkxOEAAHd5rhtOW/gyMETnpAt+1VJZwlaGoxW5sOs1m1GmKqYloulfoRBpgfVA9RX33vXnWBiYD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097394; c=relaxed/simple;
	bh=LkUo140fVMn6MS7b6kloeNYd8ZgqpXWRMQKFp7SFOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1A8try348o4UVewogRmCTiM/TIEiEcvTM837N8i5ykQOOrD/JrjtkVPfUxvTYF4dDu5Jv9sJ0JDVu7HK0lXwvzLBI6louSgwig676JZs1/TkDQvyz6TLCCNfuwAggatsukee9u8gbO68SmP7YaG1aCcA7qt0Y0owBVmbYeQ/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9ikF5Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E8EC2BCB3;
	Mon, 13 Apr 2026 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097393;
	bh=LkUo140fVMn6MS7b6kloeNYd8ZgqpXWRMQKFp7SFOzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9ikF5UhJ/2t5K3ypa2UVyYqGwSRN4uTPvTgLc+RkRZYxUhNSqU40phjWjAHIva2p
	 4UhnyRFlPw2EI/72PGauGjwnUU7i1IF6Y2O4OjUwA9wRXIff1AqHHGXv6D8RnEXMZf
	 qCxvtDyfIsrBFGe9fmiPl6lil3djyOmquMAqn4Ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 118/570] regulator: pca9450: Make IRQ optional
Date: Mon, 13 Apr 2026 17:54:09 +0200
Message-ID: <20260413155834.863250592@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236627-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kontron.de:email]
X-Rspamd-Queue-Id: 8C4343EEDB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 83808c54064eef620ad8645dfdcaffe125551532 ]

The IRQ line might not be connected on some boards. Allow the driver
to be probed without it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Link: https://patch.msgid.link/20240708084107.38986-5-frieder@fris.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 5d0efaf47ee9 ("regulator: pca9450: Correct interrupt type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pca9450-regulator.c | 41 +++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 556074d7fe242..756e4807d27a7 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -704,11 +704,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 	unsigned int device_id, i;
 	int ret;
 
-	if (!i2c->irq) {
-		dev_err(&i2c->dev, "No IRQ configured?\n");
-		return -EINVAL;
-	}
-
 	pca9450 = devm_kzalloc(&i2c->dev, sizeof(struct pca9450), GFP_KERNEL);
 	if (!pca9450)
 		return -ENOMEM;
@@ -775,23 +770,25 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
-	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
-					pca9450_irq_handler,
-					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
-					"pca9450-irq", pca9450);
-	if (ret != 0) {
-		dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
-			pca9450->irq);
-		return ret;
-	}
-	/* Unmask all interrupt except PWRON/WDOG/RSVD */
-	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
-				IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
-				IRQ_THERM_105 | IRQ_THERM_125,
-				IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
-	if (ret) {
-		dev_err(&i2c->dev, "Unmask irq error\n");
-		return ret;
+	if (pca9450->irq) {
+		ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
+						pca9450_irq_handler,
+						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+						"pca9450-irq", pca9450);
+		if (ret != 0) {
+			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
+				pca9450->irq);
+			return ret;
+		}
+		/* Unmask all interrupt except PWRON/WDOG/RSVD */
+		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
+					IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
+					IRQ_THERM_105 | IRQ_THERM_125,
+					IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
+		if (ret) {
+			dev_err(&i2c->dev, "Unmask irq error\n");
+			return ret;
+		}
 	}
 
 	/* Clear PRESET_EN bit in BUCK123_DVS to use DVS registers */
-- 
2.51.0





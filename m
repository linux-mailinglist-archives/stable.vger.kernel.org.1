Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4B6FAA63
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjEHLCm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjEHLCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6C2945D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF1562A38
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012C1C433EF;
        Mon,  8 May 2023 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543664;
        bh=bPpjuJhKjHFDob9qP1LhmD7q8YeQbCIPhuGF1oi6CRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsJif8UeHZXOPp3Bq0BG5au41ShJvAbhw2AESNQYogUdhp7rW/Bxr0hgGA6zD0NkA
         CejNJq5LAUccEGmSW4iJTlpU+wZ3Z7w9bkb9Sf+DcXavTzjy7nhCbTEJHlmOjmbWsx
         pPyNCF/XU16bWzKjgbFNz5pBSO76AJqdJMYg56jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 144/694] tpm, tpm: Implement usage counter for locality
Date:   Mon,  8 May 2023 11:39:39 +0200
Message-Id: <20230508094437.131295897@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

[ Upstream commit 7a2f55d0be296c4e81fd782f3d6c43ed4ec7e265 ]

Implement a usage counter for the (default) locality used by the TPM TIS
driver:
Request the locality from the TPM if it has not been claimed yet, otherwise
only increment the counter. Also release the locality if the counter is 0
otherwise only decrement the counter. Since in case of SPI the register
accesses are locked by means of the SPI bus mutex use a sleepable lock
(i.e. also a mutex) to ensure thread-safety of the counter which may be
accessed by both a userspace thread and the interrupt handler.

By doing this refactor the names of the amended functions to use a more
appropriate prefix.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 955df4f87760 ("tpm, tpm_tis: Claim locality when interrupts are reenabled on resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 63 +++++++++++++++++++++++----------
 drivers/char/tpm/tpm_tis_core.h |  2 ++
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 39f27edb32879..c5fef63c6179d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -136,16 +136,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static int release_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
+{
+	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+
+	return 0;
+}
+
+static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+	mutex_lock(&priv->locality_count_mutex);
+	priv->locality_count--;
+	if (priv->locality_count == 0)
+		__tpm_tis_relinquish_locality(priv, l);
+	mutex_unlock(&priv->locality_count_mutex);
 
 	return 0;
 }
 
-static int request_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	unsigned long stop, timeout;
@@ -186,6 +197,20 @@ static int request_locality(struct tpm_chip *chip, int l)
 	return -1;
 }
 
+static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	int ret = 0;
+
+	mutex_lock(&priv->locality_count_mutex);
+	if (priv->locality_count == 0)
+		ret = __tpm_tis_request_locality(chip, l);
+	if (!ret)
+		priv->locality_count++;
+	mutex_unlock(&priv->locality_count_mutex);
+	return ret;
+}
+
 static u8 tpm_tis_status(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
@@ -652,7 +677,7 @@ static int probe_itpm(struct tpm_chip *chip)
 	if (vendor != TPM_VID_INTEL)
 		return 0;
 
-	if (request_locality(chip, 0) != 0)
+	if (tpm_tis_request_locality(chip, 0) != 0)
 		return -EBUSY;
 
 	rc = tpm_tis_send_data(chip, cmd_getticks, len);
@@ -673,7 +698,7 @@ static int probe_itpm(struct tpm_chip *chip)
 
 out:
 	tpm_tis_ready(chip);
-	release_locality(chip, priv->locality);
+	tpm_tis_relinquish_locality(chip, priv->locality);
 
 	return rc;
 }
@@ -765,14 +790,14 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	}
 	priv->irq = irq;
 
-	rc = request_locality(chip, 0);
+	rc = tpm_tis_request_locality(chip, 0);
 	if (rc < 0)
 		return rc;
 
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
 	if (rc < 0) {
-		release_locality(chip, priv->locality);
+		tpm_tis_relinquish_locality(chip, priv->locality);
 		return rc;
 	}
 
@@ -811,7 +836,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 		rc = -1;
 	}
 
-	release_locality(chip, priv->locality);
+	tpm_tis_relinquish_locality(chip, priv->locality);
 
 	return rc;
 }
@@ -927,8 +952,8 @@ static const struct tpm_class_ops tpm_tis = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-	.request_locality = request_locality,
-	.relinquish_locality = release_locality,
+	.request_locality = tpm_tis_request_locality,
+	.relinquish_locality = tpm_tis_relinquish_locality,
 	.clk_enable = tpm_tis_clkrun_enable,
 };
 
@@ -962,6 +987,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
 	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
+	priv->locality_count = 0;
+	mutex_init(&priv->locality_count_mutex);
 
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -1008,14 +1035,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 
-	rc = request_locality(chip, 0);
+	rc = tpm_tis_request_locality(chip, 0);
 	if (rc < 0) {
 		rc = -ENODEV;
 		goto out_err;
 	}
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-	release_locality(chip, 0);
+	tpm_tis_relinquish_locality(chip, 0);
 
 	rc = tpm_chip_start(chip);
 	if (rc)
@@ -1075,13 +1102,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		 * proper timeouts for the driver.
 		 */
 
-		rc = request_locality(chip, 0);
+		rc = tpm_tis_request_locality(chip, 0);
 		if (rc < 0)
 			goto out_err;
 
 		rc = tpm_get_timeouts(chip);
 
-		release_locality(chip, 0);
+		tpm_tis_relinquish_locality(chip, 0);
 
 		if (rc) {
 			dev_err(dev, "Could not get TPM timeouts and durations\n");
@@ -1099,11 +1126,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
-			rc = request_locality(chip, 0);
+			rc = tpm_tis_request_locality(chip, 0);
 			if (rc < 0)
 				goto out_err;
 			disable_interrupts(chip);
-			release_locality(chip, 0);
+			tpm_tis_relinquish_locality(chip, 0);
 		}
 	}
 
@@ -1176,13 +1203,13 @@ int tpm_tis_resume(struct device *dev)
 	 * an error code but for unknown reason it isn't handled.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
-		ret = request_locality(chip, 0);
+		ret = tpm_tis_request_locality(chip, 0);
 		if (ret < 0)
 			return ret;
 
 		tpm1_do_selftest(chip);
 
-		release_locality(chip, 0);
+		tpm_tis_relinquish_locality(chip, 0);
 	}
 
 	return 0;
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index b68479e0de10f..1d51d5168fb6e 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -91,6 +91,8 @@ enum tpm_tis_flags {
 
 struct tpm_tis_data {
 	u16 manufacturer_id;
+	struct mutex locality_count_mutex;
+	unsigned int locality_count;
 	int locality;
 	int irq;
 	bool irq_tested;
-- 
2.39.2




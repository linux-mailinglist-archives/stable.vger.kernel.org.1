Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA270EA83
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 03:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbjEXBER (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 21:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXBEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 21:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EF184
        for <stable@vger.kernel.org>; Tue, 23 May 2023 18:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0614D60EAA
        for <stable@vger.kernel.org>; Wed, 24 May 2023 01:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AFDC4339B;
        Wed, 24 May 2023 01:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684890251;
        bh=upIwVL0YNXLwSLdhuct7sxmNrhTCks78NN3IynIf2vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3QhwswpLsYMQI+djmQy1hms1n+fb5n9NT7kv2w6nWtdWuZOshZGNwWt5rCiZjFH/
         S6BSxYlhTlD2Q8xjH0Opv+mrvA1i14pn2wUp87ThX534vxdT+MWZkIBS1WIUso2EzH
         LN4Ypw+YAfhk+TI8KWqBZxaWwadeC4PnnmlFeavOXOaRkzYhqzyO1RPy01cZT68sAS
         PM1g5COr+MFNYACQDp5XgBH9SJY4zpXTH79XIKfLCmLCXhjQV0E1UaffkxdblqTzgD
         YskdtZ0WXCiuLGFN2qfUJc0qR1XiKOkMTzBVZdCSdrYER5RENcksJIjIo+7MkCYhCY
         x0ns0PV0xFiQA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 6.1.y 1/2] tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
Date:   Wed, 24 May 2023 04:03:52 +0300
Message-Id: <20230524010353.243162-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023052208-chirping-preset-9644@gregkh>
References: <2023052208-chirping-preset-9644@gregkh>
MIME-Version: 1.0
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

commit 1398aa803f198b7a386fdd8404666043e95f4c16 upstream.

Before sending a TPM command, CLKRUN protocol must be disabled. This is not
done in the case of tpm1_do_selftest() call site inside tpm_tis_resume().

Address this by decorating the calls with tpm_chip_{start,stop}, which
should be always used to arm and disarm the TPM chip for transmission.

Finally, move the call to the main TPM driver callback as the last step
because it should arm the chip by itself, if it needs that type of
functionality.

Cc: stable@vger.kernel.org # v6.1+
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Link: https://lore.kernel.org/linux-integrity/CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero/
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 42 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index eecfbd7e9786..cf09d2045e08 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1159,19 +1159,19 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 	u32 intmask;
 	int rc;
 
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	/* reenable interrupts that device may have lost or
-	 * BIOS/firmware may have disabled
+	/*
+	 * Re-enable interrupts that device may have lost or BIOS/firmware may
+	 * have disabled.
 	 */
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), priv->irq);
-	if (rc < 0)
-		goto out;
+	if (rc < 0) {
+		dev_err(&chip->dev, "Setting IRQ failed.\n");
+		return;
+	}
 
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
-		goto out;
+		return;
 
 	intmask |= TPM_INTF_CMD_READY_INT
 	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
@@ -1179,11 +1179,9 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
 
-out:
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	return;
+	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+	if (rc < 0)
+		dev_err(&chip->dev, "Enabling interrupts failed.\n");
 }
 
 int tpm_tis_resume(struct device *dev)
@@ -1191,27 +1189,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
-	ret = tpm_tis_request_locality(chip, 0);
-	if (ret < 0)
+	ret = tpm_chip_start(chip);
+	if (ret)
 		return ret;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
-	ret = tpm_pm_resume(dev);
-	if (ret)
-		goto out;
-
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
-out:
-	tpm_tis_relinquish_locality(chip, 0);
 
-	return ret;
+	tpm_chip_stop(chip);
+
+	ret = tpm_pm_resume(dev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
-- 
2.39.2


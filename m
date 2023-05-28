Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0894713DE1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjE1T3x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjE1T3w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73832F4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E7061D08
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD00C433D2;
        Sun, 28 May 2023 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302183;
        bh=g3a+J6zJJz23/RyYviFr08+3UhC8iK3afvwi81twaPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Larz/IdD6Tesn272wUef+dA9tEReYW4j9rybrtq7y+aHIxA39s0hucch2MqmlPCUX
         lDXmuN0KHjhAqzi2NAwbPEa+DYZBnLHfiLC+qPg5lRfKLmZIxCYH/fRGPJufd3n9hZ
         xbn2AhYACUL9rQw6Utj3mGCYP59fPtW4EGoQ8q9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 005/127] tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
Date:   Sun, 28 May 2023 20:09:41 +0100
Message-Id: <20230528190836.365528152@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit 1398aa803f198b7a386fdd8404666043e95f4c16 ]

Before sending a TPM command, CLKRUN protocol must be disabled. This is not
done in the case of tpm1_do_selftest() call site inside tpm_tis_resume().

Address this by decorating the calls with tpm_chip_{start,stop}, which
should be always used to arm and disarm the TPM chip for transmission.

Finally, move the call to the main TPM driver callback as the last step
because it should arm the chip by itself, if it needs that type of
functionality.

Cc: stable@vger.kernel.org
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Closes: https://lore.kernel.org/linux-integrity/CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero/
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 43 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index a35c117ee7c80..a5c22fb4ad428 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1190,25 +1190,20 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
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
 
 	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
-
-	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-
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
@@ -1216,27 +1211,27 @@ int tpm_tis_resume(struct device *dev)
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




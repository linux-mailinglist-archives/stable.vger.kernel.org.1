Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D763713E4E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjE1TeT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjE1TeS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41DBB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC6C61DB2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A099C433EF;
        Sun, 28 May 2023 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302455;
        bh=3W3wsoUU1mIsb4tYuJG/RRtkd0sDh3JAMYEds54qB94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONGhg8DSQ2gyla4+f6RuJjeAFQaMUP2cXgurLr1vLwGPHQZ0jdgMd6/rkM7/5tjad
         jAqKuKsdXQ+pBG4eQqpG7eKn/BWzSrkPlndDJAYxPM6eIk9MZKtKMmWs6F8uIbQdnF
         yyDnQ4ZuPRmiK+flSgG7IB2+32rus1DAVUxz+Bo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/119] tpm, tpm_tis: Avoid cache incoherency in test for interrupts
Date:   Sun, 28 May 2023 20:10:02 +0100
Message-Id: <20230528190835.462201336@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

[ Upstream commit 858e8b792d06f45c427897bd90205a1d90bf430f ]

The interrupt handler that sets the boolean variable irq_tested may run on
another CPU as the thread that checks irq_tested as part of the irq test in
tpm_tis_send().

Since nothing guarantees cache coherency between CPUs for unsynchronized
accesses to boolean variables the testing thread might not perceive the
value change done in the interrupt handler.

Avoid this issue by setting the bit TPM_TIS_IRQ_TESTED in the flags field
of the tpm_tis_data struct and by accessing this field with the bit
manipulating functions that provide cache coherency.

Also convert all other existing sites to use the proper macros when
accessing this bitfield.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 1398aa803f19 ("tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis.c      |  2 +-
 drivers/char/tpm/tpm_tis_core.c | 21 +++++++++++----------
 drivers/char/tpm/tpm_tis_core.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 4be19d8f3ca95..0d084d6652c41 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -243,7 +243,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 		irq = tpm_info->irq;
 
 	if (itpm || is_itpm(ACPI_COMPANION(dev)))
-		phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
+		set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
 
 	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
 				 ACPI_HANDLE(dev));
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index eecfbd7e97867..6b05a84c3a206 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -376,7 +376,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
 	size_t count = 0;
-	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
+	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
@@ -509,7 +509,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	int rc, irq;
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
+	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
+	     test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		return tpm_tis_send_main(chip, buf, len);
 
 	/* Verify receipt of the expected IRQ */
@@ -519,11 +520,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	rc = tpm_tis_send_main(chip, buf, len);
 	priv->irq = irq;
 	chip->flags |= TPM_CHIP_FLAG_IRQ;
-	if (!priv->irq_tested)
+	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		tpm_msleep(1);
-	if (!priv->irq_tested)
+	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
 		disable_interrupts(chip);
-	priv->irq_tested = true;
+	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	return rc;
 }
 
@@ -666,7 +667,7 @@ static int probe_itpm(struct tpm_chip *chip)
 	size_t len = sizeof(cmd_getticks);
 	u16 vendor;
 
-	if (priv->flags & TPM_TIS_ITPM_WORKAROUND)
+	if (test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags))
 		return 0;
 
 	rc = tpm_tis_read16(priv, TPM_DID_VID(0), &vendor);
@@ -686,13 +687,13 @@ static int probe_itpm(struct tpm_chip *chip)
 
 	tpm_tis_ready(chip);
 
-	priv->flags |= TPM_TIS_ITPM_WORKAROUND;
+	set_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 
 	rc = tpm_tis_send_data(chip, cmd_getticks, len);
 	if (rc == 0)
 		dev_info(&chip->dev, "Detected an iTPM.\n");
 	else {
-		priv->flags &= ~TPM_TIS_ITPM_WORKAROUND;
+		clear_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 		rc = -EFAULT;
 	}
 
@@ -736,7 +737,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	if (interrupt == 0)
 		return IRQ_NONE;
 
-	priv->irq_tested = true;
+	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
 		wake_up_interruptible(&priv->read_queue);
 	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
@@ -819,7 +820,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	if (rc < 0)
 		goto restore_irqs;
 
-	priv->irq_tested = false;
+	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 1d51d5168fb6e..4a58b870b4188 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -87,6 +87,7 @@ enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
 	TPM_TIS_INVALID_STATUS		= BIT(1),
 	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
+	TPM_TIS_IRQ_TESTED		= BIT(3),
 };
 
 struct tpm_tis_data {
@@ -95,7 +96,6 @@ struct tpm_tis_data {
 	unsigned int locality_count;
 	int locality;
 	int irq;
-	bool irq_tested;
 	unsigned long flags;
 	void __iomem *ilb_base_addr;
 	u16 clkrun_enabled;
-- 
2.39.2




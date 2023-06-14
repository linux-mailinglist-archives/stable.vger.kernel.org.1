Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8233713E4F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjE1TeV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjE1TeU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DADBB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2B761DDF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB8BC433D2;
        Sun, 28 May 2023 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302458;
        bh=abbRKnp1zzMnJdGS4SO2xGzuHR5HXAct+6UKDH2yqbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qL/O/3Hznc9zmr3Xm4KRY4d/W1QdZZUBxiaGMsIvGuY1OXgwGP1kn5+oZN8S1cXyM
         2kqeXoQA831Ow6RuROJQxERKVePVn3VLqQvPVF1ibXbpl6GO6Njll4+npwFWIJmheS
         QsJ6eU3rGoD8k3rRgUvUphZJbdZfp54gaGn1UGZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/119] tpm, tpm_tis: Only handle supported interrupts
Date:   Sun, 28 May 2023 20:10:03 +0100
Message-Id: <20230528190835.490380620@linuxfoundation.org>
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

[ Upstream commit e87fcf0dc2b47fac5b4824f00f74dfbcd4acd363 ]

According to the TPM Interface Specification (TIS) support for "stsValid"
and "commandReady" interrupts is only optional.
This has to be taken into account when handling the interrupts in functions
like wait_for_tpm_stat(). To determine the supported interrupts use the
capability query.

Also adjust wait_for_tpm_stat() to only wait for interrupt reported status
changes. After that process all the remaining status changes by polling
the status register.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 1398aa803f19 ("tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 120 +++++++++++++++++++-------------
 drivers/char/tpm/tpm_tis_core.h |   1 +
 2 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6b05a84c3a206..a35c117ee7c80 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	long rc;
 	u8 status;
 	bool canceled = false;
+	u8 sts_mask = 0;
+	int ret = 0;
 
 	/* check current status */
 	status = chip->ops->status(chip);
 	if ((status & mask) == mask)
 		return 0;
 
-	stop = jiffies + timeout;
+	/* check what status changes can be handled by irqs */
+	if (priv->int_mask & TPM_INTF_STS_VALID_INT)
+		sts_mask |= TPM_STS_VALID;
 
-	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+	if (priv->int_mask & TPM_INTF_DATA_AVAIL_INT)
+		sts_mask |= TPM_STS_DATA_AVAIL;
+
+	if (priv->int_mask & TPM_INTF_CMD_READY_INT)
+		sts_mask |= TPM_STS_COMMAND_READY;
+
+	sts_mask &= mask;
+
+	stop = jiffies + timeout;
+	/* process status changes with irq support */
+	if (sts_mask) {
+		ret = -ETIME;
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
 			return -ETIME;
 		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
+			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
 					       &canceled),
 			timeout);
 		if (rc > 0) {
 			if (canceled)
 				return -ECANCELED;
-			return 0;
+			ret = 0;
 		}
 		if (rc == -ERESTARTSYS && freezing(current)) {
 			clear_thread_flag(TIF_SIGPENDING);
 			goto again;
 		}
-	} else {
-		do {
-			usleep_range(priv->timeout_min,
-				     priv->timeout_max);
-			status = chip->ops->status(chip);
-			if ((status & mask) == mask)
-				return 0;
-		} while (time_before(jiffies, stop));
 	}
+
+	if (ret)
+		return ret;
+
+	mask &= ~sts_mask;
+	if (!mask) /* all done */
+		return 0;
+	/* process status changes without irq support */
+	do {
+		status = chip->ops->status(chip);
+		if ((status & mask) == mask)
+			return 0;
+		usleep_range(priv->timeout_min,
+			     priv->timeout_max);
+	} while (time_before(jiffies, stop));
 	return -ETIME;
 }
 
@@ -1032,8 +1054,40 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (rc < 0)
 		goto out_err;
 
-	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
-		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
+	/* Figure out the capabilities */
+	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
+	if (rc < 0)
+		goto out_err;
+
+	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
+		intfcaps);
+	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
+		dev_dbg(dev, "\tBurst Count Static\n");
+	if (intfcaps & TPM_INTF_CMD_READY_INT) {
+		intmask |= TPM_INTF_CMD_READY_INT;
+		dev_dbg(dev, "\tCommand Ready Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
+		dev_dbg(dev, "\tInterrupt Edge Falling\n");
+	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
+		dev_dbg(dev, "\tInterrupt Edge Rising\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
+		dev_dbg(dev, "\tInterrupt Level Low\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
+		dev_dbg(dev, "\tInterrupt Level High\n");
+	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT) {
+		intmask |= TPM_INTF_LOCALITY_CHANGE_INT;
+		dev_dbg(dev, "\tLocality Change Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_STS_VALID_INT) {
+		intmask |= TPM_INTF_STS_VALID_INT;
+		dev_dbg(dev, "\tSts Valid Int Support\n");
+	}
+	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
+		intmask |= TPM_INTF_DATA_AVAIL_INT;
+		dev_dbg(dev, "\tData Avail Int Support\n");
+	}
+
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 
 	rc = tpm_tis_request_locality(chip, 0);
@@ -1067,32 +1121,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
-	/* Figure out the capabilities */
-	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
-	if (rc < 0)
-		goto out_err;
-
-	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
-		intfcaps);
-	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
-		dev_dbg(dev, "\tBurst Count Static\n");
-	if (intfcaps & TPM_INTF_CMD_READY_INT)
-		dev_dbg(dev, "\tCommand Ready Int Support\n");
-	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
-		dev_dbg(dev, "\tInterrupt Edge Falling\n");
-	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
-		dev_dbg(dev, "\tInterrupt Edge Rising\n");
-	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
-		dev_dbg(dev, "\tInterrupt Level Low\n");
-	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
-		dev_dbg(dev, "\tInterrupt Level High\n");
-	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
-		dev_dbg(dev, "\tLocality Change Int Support\n");
-	if (intfcaps & TPM_INTF_STS_VALID_INT)
-		dev_dbg(dev, "\tSts Valid Int Support\n");
-	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
-		dev_dbg(dev, "\tData Avail Int Support\n");
-
 	/* INTERRUPT Setup */
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
@@ -1123,7 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		else
 			tpm_tis_probe_irq(chip, intmask);
 
-		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
+		if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+			priv->int_mask = intmask;
+		} else {
 			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
@@ -1170,13 +1200,7 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 	if (rc < 0)
 		goto out;
 
-	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
-	if (rc < 0)
-		goto out;
-
-	intmask |= TPM_INTF_CMD_READY_INT
-	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
-	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
+	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 4a58b870b4188..e978f457fd4d4 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -96,6 +96,7 @@ struct tpm_tis_data {
 	unsigned int locality_count;
 	int locality;
 	int irq;
+	unsigned int int_mask;
 	unsigned long flags;
 	void __iomem *ilb_base_addr;
 	u16 clkrun_enabled;
-- 
2.39.2




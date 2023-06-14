Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD3713E52
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjE1Te2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjE1Te1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F1A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2543C61DE7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44220C433EF;
        Sun, 28 May 2023 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302465;
        bh=YFhqIeVEmNPf7SStHeuINYZfRW+iR9DOwmGTsRK2Cjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw9V0wea1cjzq8fygxQzQktDHOcuzyLRLBdLV9m2JX9F8CTlBv8Wh+hZ40/VWKmeJ
         k3SrchrOuLrEbXf8N5HPmKbBh/ycvoEfSLxUYfE3qILN5oRq7KZiqNLPA9gblIAh0i
         TPy4efEu6WsLVi2ssuUpgTc/I0Kh7BEX1ocnG/HY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/119] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers
Date:   Sun, 28 May 2023 20:10:06 +0100
Message-Id: <20230528190835.580007732@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
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

[ Upstream commit 0c8862de05c1a087795ee0a87bf61a6394306cc0 ]

TPM chip bootstrapping was removed from tpm_chip_register(), and it
was relocated to tpm_tis_core. This breaks all drivers which are not
based on tpm_tis because the chip will not get properly initialized.

Take the corrective steps:
1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-shot.
2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts the
   things  as tehy used to be.

Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Fixes: 548eb516ec0f ("tpm, tpm_tis: startup chip before testing for interrupts")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/all/ZEjqhwHWBnxcaRV5@xpf.sh.intel.com/
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c     | 22 +++++++++++++++++++---
 drivers/char/tpm/tpm.h          |  2 +-
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 include/linux/tpm.h             | 13 +++++++------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 47c2861af45a3..31d8074821524 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -602,13 +602,19 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 }
 
 /*
- * tpm_chip_startup() - performs auto startup and allocates the PCRs
+ * tpm_chip_bootstrap() - Boostrap TPM chip after power on
  * @chip: TPM chip to use.
+ *
+ * Initialize TPM chip after power on. This a one-shot function: subsequent
+ * calls will have no effect.
  */
-int tpm_chip_startup(struct tpm_chip *chip)
+int tpm_chip_bootstrap(struct tpm_chip *chip)
 {
 	int rc;
 
+	if (chip->flags & TPM_CHIP_FLAG_BOOTSTRAPPED)
+		return 0;
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		return rc;
@@ -621,9 +627,15 @@ int tpm_chip_startup(struct tpm_chip *chip)
 stop:
 	tpm_chip_stop(chip);
 
+	/*
+	 * Unconditionally set, as driver initialization should cease, when the
+	 * boostrapping process fails.
+	 */
+	chip->flags |= TPM_CHIP_FLAG_BOOTSTRAPPED;
+
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_chip_startup);
+EXPORT_SYMBOL_GPL(tpm_chip_bootstrap);
 
 /*
  * tpm_chip_register() - create a character device for the TPM chip
@@ -640,6 +652,10 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
+	rc = tpm_chip_bootstrap(chip);
+	if (rc)
+		return rc;
+
 	tpm_sysfs_add_device(chip);
 
 	tpm_bios_log_setup(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 88d3bd76e0760..f6c99b3f00458 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -263,7 +263,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
-int tpm_chip_startup(struct tpm_chip *chip);
+int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 9f76c9a5aa422..f02b583005a53 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1125,7 +1125,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
 
-	rc = tpm_chip_startup(chip);
+	rc = tpm_chip_bootstrap(chip);
 	if (rc)
 		goto out_err;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362de..cea64d58ef9f7 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -273,13 +273,14 @@ enum tpm2_cc_attrs {
 #define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
-	TPM_CHIP_FLAG_TPM2		= BIT(1),
-	TPM_CHIP_FLAG_IRQ		= BIT(2),
-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
+	TPM_CHIP_FLAG_TPM2			= BIT(1),
+	TPM_CHIP_FLAG_IRQ			= BIT(2),
+	TPM_CHIP_FLAG_VIRTUAL			= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS		= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED		= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
-	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
+	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.39.2




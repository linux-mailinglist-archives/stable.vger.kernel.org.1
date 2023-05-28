Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D51A713DE2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjE1T3z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjE1T3y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D466F7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E06F61D23
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF40C433EF;
        Sun, 28 May 2023 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302185;
        bh=4WbFydIr6yPKEHVuAN7j4xkPSUeP+zsygvx0qR5oLB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EObKa5CNUYX5SC8CwBh6PvzY8PMqNRq2Qnqmq07rJwvjufF/hAPxfjaJEQ1Z24+/X
         Fhu/wkzgQ6VmF4sscA5HBefjFcElVDyCLz8r1tq864ptkSrHXIRyM6nF3RpGsDXB+z
         Kma4FBhuFssXEV+yMdq5qNTBIDfDH3y0ySuSG8II=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 006/127] tpm, tpm_tis: startup chip before testing for interrupts
Date:   Sun, 28 May 2023 20:09:42 +0100
Message-Id: <20230528190836.402747998@linuxfoundation.org>
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

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

[ Upstream commit 548eb516ec0f7a484a23a902835899341164b8ea ]

In tpm_tis_gen_interrupt() a request for a property value is sent to the
TPM to test if interrupts are generated. However after a power cycle the
TPM responds with TPM_RC_INITIALIZE which indicates that the TPM is not
yet properly initialized.
Fix this by first starting the TPM up before the request is sent. For this
the startup implementation is removed from tpm_chip_register() and put
into the new function tpm_chip_startup() which is called before the
interrupts are tested.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c     | 38 +++++++++++++++++++++------------
 drivers/char/tpm/tpm.h          |  1 +
 drivers/char/tpm/tpm_tis_core.c |  5 +++++
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 2a05d8cc0e795..6fdfa65a00c37 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -605,6 +605,30 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 	return rc;
 }
 
+/*
+ * tpm_chip_startup() - performs auto startup and allocates the PCRs
+ * @chip: TPM chip to use.
+ */
+int tpm_chip_startup(struct tpm_chip *chip)
+{
+	int rc;
+
+	rc = tpm_chip_start(chip);
+	if (rc)
+		return rc;
+
+	rc = tpm_auto_startup(chip);
+	if (rc)
+		goto stop;
+
+	rc = tpm_get_pcr_allocation(chip);
+stop:
+	tpm_chip_stop(chip);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_startup);
+
 /*
  * tpm_chip_register() - create a character device for the TPM chip
  * @chip: TPM chip to use.
@@ -620,20 +644,6 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_chip_start(chip);
-	if (rc)
-		return rc;
-	rc = tpm_auto_startup(chip);
-	if (rc) {
-		tpm_chip_stop(chip);
-		return rc;
-	}
-
-	rc = tpm_get_pcr_allocation(chip);
-	tpm_chip_stop(chip);
-	if (rc)
-		return rc;
-
 	tpm_sysfs_add_device(chip);
 
 	tpm_bios_log_setup(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 830014a266090..88d3bd76e0760 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -263,6 +263,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
+int tpm_chip_startup(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index a5c22fb4ad428..9f76c9a5aa422 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1124,6 +1124,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	/* INTERRUPT Setup */
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
+
+	rc = tpm_chip_startup(chip);
+	if (rc)
+		goto out_err;
+
 	if (irq != -1) {
 		/*
 		 * Before doing irq testing issue a command to the TPM in polling mode
-- 
2.39.2




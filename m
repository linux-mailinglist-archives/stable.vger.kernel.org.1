Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2172B70EA84
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 03:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjEXBEV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 21:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbjEXBEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 21:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11742139
        for <stable@vger.kernel.org>; Tue, 23 May 2023 18:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9559661363
        for <stable@vger.kernel.org>; Wed, 24 May 2023 01:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62E3C433D2;
        Wed, 24 May 2023 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684890258;
        bh=vlC8xLxqGr07hkVmuw3TAv0lbJSgp+mE8RtQ5nijZEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BecbJPjGiIWSVMcGWLqOlVAUDyDFxUPKQRvgKHQd8N5ue9CqNbJ+pQWTEkU/jC9ZX
         JYZNe//z0IXZlme2eqGeGS0P+fLycJhVSchQcN64yuSIXENYDrAR37AF0Dpenf9cYx
         XHaj+r0ZK/VR3kVUyLmYQddmoTs1PxtsBGNBeexv4NBoG8nagMS4RFesLVB5D3hmEe
         X/Vi0efJy6C4EQj/87SkFWWOv1jXQMSFe5azP+tcB/FEIMzx+lihj6cofou6bUfmOE
         jkT8NF1yZIc+ADB5w1MdqJOIfDkaDbsXMOKelv5CUHnKOUF1IOrohC6MWnuM/M5Wf/
         eXyb/EbZ7/GcQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 6.1.y 2/2] tpm: Prevent hwrng from activating during resume
Date:   Wed, 24 May 2023 04:03:53 +0300
Message-Id: <20230524010353.243162-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524010353.243162-1-jarkko@kernel.org>
References: <2023052208-chirping-preset-9644@gregkh>
 <20230524010353.243162-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 99d46450625590d410f86fe4660a5eff7d3b8343 upstream.

Set TPM_CHIP_FLAG_SUSPENDED in tpm_pm_suspend() and reset in
tpm_pm_resume(). While the flag is set, tpm_hwrng() gives back zero
bytes. This prevents hwrng from racing during resume.

Cc: stable@vger.kernel.org # v6.1+
Fixes: 6e592a065d51 ("tpm: Move Linux RNG connection to hwrng")
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c      |  4 ++++
 drivers/char/tpm/tpm-interface.c | 10 ++++++++++
 include/linux/tpm.h              |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 5165f6d3da22..5e6d849c64ee 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -568,6 +568,10 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
+		return 0;
+
 	return tpm_get_random(chip, data, max);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7e513b771832..0f941cb32eb1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -412,6 +412,8 @@ int tpm_pm_suspend(struct device *dev)
 	}
 
 suspended:
+	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
@@ -429,6 +431,14 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
+
+	/*
+	 * Guarantee that SUSPENDED is written last, so that hwrng does not
+	 * activate before the chip has been fully resumed.
+	 */
+	wmb();
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362d..1fc953fa4158 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -280,6 +280,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
+	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.39.2


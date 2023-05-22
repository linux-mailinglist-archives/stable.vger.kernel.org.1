Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54770C4C4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEVSBD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEVSBC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E194
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05DB61F9E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C25C433D2;
        Mon, 22 May 2023 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778460;
        bh=j9YTYv7FXhz8ptVE89y53trrD3G4EMuWqeo+4YG9zgc=;
        h=Subject:To:Cc:From:Date:From;
        b=C+4ALf0yTkLyLnRWU38X6xU7+iAKuoBEhMCzjoaEQDIHOFahNyP2uaFZhGvijoicU
         zQGLCAM3maFdipDVGX/zRwPujr9NMamfhvm6Jx3qbsxnf891XLwcWyXd9eNWi6cXXb
         +BaxWgfro0tlbtjwRmUPdLBNt/pO2suwExup+5YI=
Subject: FAILED: patch "[PATCH] tpm: Prevent hwrng from activating during resume" failed to apply to 6.3-stable tree
To:     jarkko@kernel.org, jsnitsel@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:00:57 +0100
Message-ID: <2023052257-oppose-sculpture-982a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 99d46450625590d410f86fe4660a5eff7d3b8343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052257-oppose-sculpture-982a@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

99d464506255 ("tpm: Prevent hwrng from activating during resume")
0c8862de05c1 ("tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers")
548eb516ec0f ("tpm, tpm_tis: startup chip before testing for interrupts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99d46450625590d410f86fe4660a5eff7d3b8343 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 26 Apr 2023 20:29:28 +0300
Subject: [PATCH] tpm: Prevent hwrng from activating during resume

Set TPM_CHIP_FLAG_SUSPENDED in tpm_pm_suspend() and reset in
tpm_pm_resume(). While the flag is set, tpm_hwrng() gives back zero
bytes. This prevents hwrng from racing during resume.

Cc: stable@vger.kernel.org
Fixes: 6e592a065d51 ("tpm: Move Linux RNG connection to hwrng")
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index c10a4aa97373..cd48033b804a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -571,6 +571,10 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
+		return 0;
+
 	return tpm_get_random(chip, data, max);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 4463d0018290..586ca10b0d72 100644
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
index 77693389c3f9..6a1e8f157255 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -282,6 +282,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_ALWAYS_POWERED		= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
+	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)


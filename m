Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0248970C4C8
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjEVSBP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjEVSBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A6CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA6B61F9E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579AC433D2;
        Mon, 22 May 2023 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778471;
        bh=OLTjiYZsWrSkG8drNpY+R64VUvGVEWRLqgOKSP4HW8M=;
        h=Subject:To:Cc:From:Date:From;
        b=pIZQ9eC/XbmSanO160b15+XEkfgbaYPwWqdbtDOg0plrLrp8OcJD7QHHMYXrFxEfA
         ALZkbOIbJo+z0RGBxRs6H3j+yyqXdudails9d+nbErcWrVRPB6UJjhUbjfZpwB69oM
         quY174LO2tPZv5keFT9w7bVACGVzU5wOOwvuEV/Q=
Subject: FAILED: patch "[PATCH] tpm: Prevent hwrng from activating during resume" failed to apply to 4.19-stable tree
To:     jarkko@kernel.org, jsnitsel@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:01:00 +0100
Message-ID: <2023052200-unguided-creasing-0e4c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 99d46450625590d410f86fe4660a5eff7d3b8343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052200-unguided-creasing-0e4c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

99d464506255 ("tpm: Prevent hwrng from activating during resume")
0c8862de05c1 ("tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers")
548eb516ec0f ("tpm, tpm_tis: startup chip before testing for interrupts")
1382999aa054 ("tpm: Allow system suspend to continue when TPM suspend fails")
0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for TPM2 modules")
aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
7084eddf6be9 ("tpm: Add tpm_version_major sysfs file")
2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
74edff2d74c6 ("tpm: Move tpm_buf code to include/linux/")
44abdb377b7c ("tpm: use GFP_KERNEL instead of GFP_HIGHMEM for tpm_buf")
2e2ee5a2db06 ("tpm: Add a flag to indicate TPM power is managed by firmware")
28eba2fddd5a ("tpm: Remove a deprecated comments about implicit sysfs locking")
fa4f99c05320 ("tpm: tpm_ibm_vtpm: Fix unallocated banks")
43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")
d6fc9fcbaa65 ("kbuild: compile-test exported headers to ensure they are self-contained")
e846f0dc57f4 ("kbuild: add support for ensuring headers are self-contained")
a2d635decbfa ("Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm")

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


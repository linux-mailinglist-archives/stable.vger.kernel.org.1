Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476370C4CC
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEVSB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjEVSBY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781CC115
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07AF46205D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252A8C433EF;
        Mon, 22 May 2023 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778482;
        bh=197z2M7wBiZhS+B41e8hUnT0qRjjxg0iFVbtv1oiOiw=;
        h=Subject:To:Cc:From:Date:From;
        b=jJRbcmjDUqNexrmb03Xy+XAqkYKkV8JppJQgH4dkNwNqmFd1mjy03ExUmFYnlM3aA
         snZ2p8YlQ/OqO9FwgP38MpE7nYdJ7SKPEI7+kFfZGb0RqLZG0WANv5EV1M8x1+KQTC
         tq83ZM05eNHygFd8vvCObisP2eqof3ch/D2HG4kw=
Subject: FAILED: patch "[PATCH] tpm_tis: Use tpm_chip_{start,stop} decoration inside" failed to apply to 5.15-stable tree
To:     jarkko@kernel.org, Jason@zx2c4.com, jsnitsel@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:01:09 +0100
Message-ID: <2023052209-dart-bamboo-8ae4@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1398aa803f198b7a386fdd8404666043e95f4c16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052209-dart-bamboo-8ae4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1398aa803f19 ("tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume")
955df4f87760 ("tpm, tpm_tis: Claim locality when interrupts are reenabled on resume")
7a2f55d0be29 ("tpm, tpm: Implement usage counter for locality")
e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
15d7aa4e46eb ("tpm, tpm_tis: Claim locality before writing interrupt registers")
ed9be0e6c892 ("tpm, tpm_tis: Do not skip reset of original interrupt vector")
6d789ad72695 ("tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed")
282657a8bd7f ("tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register")
858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in test for interrupts")
7bfda9c73fa9 ("tpm: Add flag to use default cancellation policy")
bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
79ca6f74dae0 ("tpm: fix Atmel TPM crash caused by too frequent queries")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1398aa803f198b7a386fdd8404666043e95f4c16 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 26 Apr 2023 20:29:27 +0300
Subject: [PATCH] tpm_tis: Use tpm_chip_{start,stop} decoration inside
 tpm_tis_resume

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

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 02945d53fcef..558144fa707a 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1209,25 +1209,20 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
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
@@ -1235,27 +1230,27 @@ int tpm_tis_resume(struct device *dev)
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


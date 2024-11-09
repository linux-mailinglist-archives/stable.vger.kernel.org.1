Return-Path: <stable+bounces-92005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB849C2DDE
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EB51F215E7
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7719415E;
	Sat,  9 Nov 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d5xVUo2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCB1448E4
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163839; cv=none; b=G+azmcjIEHUhYJa08csZ8egRdrMPYQdsmTpGojYx7Jq71nHjS7baX4cvLPxz3ni+nG8fuq/PSiHG3ZYLdXaaUzY+BrKUVtLq0BgI3R/Jl2qBFdDQQ/7ilYbbm0bcNXTfrVCYtdUQcHoF1UdAOdMINEeP1XD1KCiR95dqQeEc8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163839; c=relaxed/simple;
	bh=sqZNEm7NXdjSEtpF29s7v64CaeyXn9r8HQNApRKIR7k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VLidjYLj1PYOHn2SVuL9raFq5BWKEctlOV3PmhdR49Vne6mzWu4HTSaIBDB+8YJjlug+GqVTL1IY7/LFlnTfzyJMOWIVSKgTaLUdK7ffAx9MI9KxqI/WoogD3IvfgErMLPVN4Qs2yqy3dCYr0ke41q0BHX8HB2hYPqtOVpwt7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d5xVUo2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9DAC4CECE;
	Sat,  9 Nov 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731163838;
	bh=sqZNEm7NXdjSEtpF29s7v64CaeyXn9r8HQNApRKIR7k=;
	h=Subject:To:Cc:From:Date:From;
	b=d5xVUo2uS3GF7YAnjj+HV7dzsLCeEhUGqkO48j0tDAuQGjjhfLyU4o3WgDKI9C5X6
	 /Bl7GeiPquapqmh2ix0f13eoFCM5pPFh3lZkmq8Oh5njeKLmb5brgz2WMeMNqgiQbZ
	 K4rL81GRGmZiaC7wAbvoRHRjoNnvmlE+fGQIFOMo=
Subject: FAILED: patch "[PATCH] tpm: Lock TPM chip in tpm_pm_suspend() first" failed to apply to 6.1-stable tree
To: jarkko@kernel.org,jsnitsel@redhat.com,mikeseohyungjin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 15:50:27 +0100
Message-ID: <2024110927-staple-scotch-2d0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9265fed6db601ee2ec47577815387458ef4f047a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110927-staple-scotch-2d0a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9265fed6db601ee2ec47577815387458ef4f047a Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 31 Oct 2024 02:16:09 +0200
Subject: [PATCH] tpm: Lock TPM chip in tpm_pm_suspend() first

Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
according, as this leaves window for tpm_hwrng_read() to be called while
the operation is in progress. The recent bug report gives also evidence of
this behaviour.

Aadress this by locking the TPM chip before checking any chip->flags both
in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
check inside tpm_get_random() so that it will be always checked only when
the lock is reserved.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Mike Seo <mikeseohyungjin@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 1ff99a7091bb..7df7abaf3e52 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
-	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
-	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
-		return 0;
-
 	return tpm_get_random(chip, data, max);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8134f002b121..b1daa0d7b341 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc) {
+		/* Can be safely set out of locks, as no action cannot race: */
+		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
 	    !pm_suspend_via_firmware())
 		goto suspended;
 
-	rc = tpm_try_get_ops(chip);
-	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-			tpm2_end_auth_session(chip);
-			tpm2_shutdown(chip, TPM2_SU_STATE);
-		} else {
-			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
-		}
-
-		tpm_put_ops(chip);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		tpm2_end_auth_session(chip);
+		tpm2_shutdown(chip, TPM2_SU_STATE);
+		goto suspended;
 	}
 
+	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+
 suspended:
 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+	tpm_put_ops(chip);
 
+out:
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
@@ -440,11 +445,18 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!chip)
 		return -ENODEV;
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
+		rc = 0;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
 		rc = tpm1_get_random(chip, out, max);
 
+out:
 	tpm_put_ops(chip);
 	return rc;
 }



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21877ABA3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHMVYG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHMVYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE810EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD5D628B4
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC80C433C7;
        Sun, 13 Aug 2023 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961845;
        bh=WBhgL/98sI1Q+PMVwRtyWLFC6/NQXjMe0NjnBnC29Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNQFbg61RFTBiyP9B29UWs4jJzGAJuqKe0VOZRpgCDig5DYvqX2CiRXFSlFhFyhvi
         4sV4Pv0C05ercwwQO60jV3H2BiSrSRUCYy2AYlrqh4fQwEiwhkoBmQm7FAvxqkkwJa
         zK2+/xi95bmAbO6fFbYUdhlPO7XoK3sBOtgvBo7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, daniil.stas@posteo.net,
        bitlord0xff@gmail.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 002/206] tpm: Disable RNG for all AMD fTPMs
Date:   Sun, 13 Aug 2023 23:16:12 +0200
Message-ID: <20230813211725.045201856@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 554b841d470338a3b1d6335b14ee1cd0c8f5d754 upstream.

The TPM RNG functionality is not necessary for entropy when the CPU
already supports the RDRAND instruction. The TPM RNG functionality
was previously disabled on a subset of AMD fTPM series, but reports
continue to show problems on some systems causing stutter root caused
to TPM RNG functionality.

Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
that claim to have fixed or not. To accomplish this, move the detection
into part of the TPM CRB registration and add a flag indicating that
the TPM should opt-out of registration to hwrng.

Cc: stable@vger.kernel.org # 6.1.y+
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Reported-by: daniil.stas@posteo.net
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
Reported-by: bitlord0xff@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c |   68 +-------------------------------------------
 drivers/char/tpm/tpm_crb.c  |   30 +++++++++++++++++++
 include/linux/tpm.h         |    1 
 3 files changed, 33 insertions(+), 66 deletions(-)

--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -510,70 +510,6 @@ static int tpm_add_legacy_sysfs(struct t
 	return 0;
 }
 
-/*
- * Some AMD fTPM versions may cause stutter
- * https://www.amd.com/en/support/kb/faq/pa-410
- *
- * Fixes are available in two series of fTPM firmware:
- * 6.x.y.z series: 6.0.18.6 +
- * 3.x.y.z series: 3.57.y.5 +
- */
-#ifdef CONFIG_X86
-static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	u32 val1, val2;
-	u64 version;
-	int ret;
-
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return false;
-
-	ret = tpm_request_locality(chip);
-	if (ret)
-		return false;
-
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
-	if (ret)
-		goto release;
-	if (val1 != 0x414D4400U /* AMD */) {
-		ret = -ENODEV;
-		goto release;
-	}
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
-	if (ret)
-		goto release;
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
-
-release:
-	tpm_relinquish_locality(chip);
-
-	if (ret)
-		return false;
-
-	version = ((u64)val1 << 32) | val2;
-	if ((version >> 48) == 6) {
-		if (version >= 0x0006000000180006ULL)
-			return false;
-	} else if ((version >> 48) == 3) {
-		if (version >= 0x0003005700000005ULL)
-			return false;
-	} else {
-		return false;
-	}
-
-	dev_warn(&chip->dev,
-		 "AMD fTPM version 0x%llx causes system stutter; hwrng disabled\n",
-		 version);
-
-	return true;
-}
-#else
-static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	return false;
-}
-#endif /* CONFIG_X86 */
-
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
@@ -588,7 +524,7 @@ static int tpm_hwrng_read(struct hwrng *
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-	    tpm_amd_is_rng_defective(chip))
+	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -719,7 +655,7 @@ void tpm_chip_unregister(struct tpm_chip
 {
 	tpm_del_legacy_sysfs(chip);
 	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !tpm_amd_is_rng_defective(chip))
+	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -463,6 +463,28 @@ static bool crb_req_canceled(struct tpm_
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
+static int crb_check_flags(struct tpm_chip *chip)
+{
+	u32 val;
+	int ret;
+
+	ret = crb_request_locality(chip, 0);
+	if (ret)
+		return ret;
+
+	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
+	if (ret)
+		goto release;
+
+	if (val == 0x414D4400U /* AMD */)
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+
+release:
+	crb_relinquish_locality(chip, 0);
+
+	return ret;
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -800,6 +822,14 @@ static int crb_acpi_add(struct acpi_devi
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
+	rc = tpm_chip_bootstrap(chip);
+	if (rc)
+		goto out;
+
+	rc = crb_check_flags(chip);
+	if (rc)
+		goto out;
+
 	rc = tpm_chip_register(chip);
 
 out:
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -283,6 +283,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
+	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)



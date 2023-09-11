Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDA79AE54
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348964AbjIKVb6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjIKOao (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDDE4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45FAC433C7;
        Mon, 11 Sep 2023 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442639;
        bh=rd1bWokMPBOvmS2kyH+FHN3d+qK3DrGGEcr+rglJadE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yVNdIqyDjmEYLOUGxppfgJwIZ79z1uRv7b5qDmG0vPCjCLxwCwCtAofJnKMXT4y1S
         JzYqU9C51cCGwzKv2itYYWabSDL4bNWVQgsg5KkzkGShqveMKzIoPvj8fa66ZfGTgS
         KcupPOJOCjOANRxISMm4Biw7FTIWtiCBUROf/lA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Todd Brandt <todd.e.brandt@intel.com>,
        Patrick Steinhardt <ps@pks.im>,
        Raymond Jay Golo <rjgolo@gmail.com>,
        Ronan Pigott <ronan@rjp.ie>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH 6.4 088/737] tpm: Enable hwrng only for Pluton on AMD CPUs
Date:   Mon, 11 Sep 2023 15:39:07 +0200
Message-ID: <20230911134652.961214749@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko@kernel.org>

commit 8f7f35e5aa6f2182eabcfa3abef4d898a48e9aa8 upstream.

The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
reported systems the TPM doesn't reply at bootup and returns back the
command code. This makes the TPM fail probe on Lenovo Legion Y540 laptop.

Since only Microsoft Pluton is the only known combination of AMD CPU and
fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
aware of this, print also info message to the klog.

Cc: stable@vger.kernel.org
Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
Reported-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
Reported-by: Ronan Pigott <ronan@rjp.ie>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_crb.c |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -463,28 +463,6 @@ static bool crb_req_canceled(struct tpm_
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
-static int crb_check_flags(struct tpm_chip *chip)
-{
-	u32 val;
-	int ret;
-
-	ret = crb_request_locality(chip, 0);
-	if (ret)
-		return ret;
-
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
-	if (ret)
-		goto release;
-
-	if (val == 0x414D4400U /* AMD */)
-		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
-
-release:
-	crb_relinquish_locality(chip, 0);
-
-	return ret;
-}
-
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -826,9 +804,14 @@ static int crb_acpi_add(struct acpi_devi
 	if (rc)
 		goto out;
 
-	rc = crb_check_flags(chip);
-	if (rc)
-		goto out;
+#ifdef CONFIG_X86
+	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		dev_info(dev, "Disabling hwrng\n");
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+	}
+#endif /* CONFIG_X86 */
 
 	rc = tpm_chip_register(chip);
 



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91F77AC7D
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjHMVdn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjHMVdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD11010EB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BFC462C31
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EDDC433C7;
        Sun, 13 Aug 2023 21:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962423;
        bh=Pqto4RCSUYorcD6f08wv3KtTDFDwY3/5CIZ/g00nBr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOXzVYG888CAjF5QJk5Ng0TJHmcGrrqHRQZD/1Drdv5VtrLV5x1P/GQZ6CmT49acZ
         FezkM/CiwyaisWR11pJGy8LHwUotv3ILk7C3c4jKPPcBTN2+sbt62QLMraGmJ+V1ZR
         P+wu9lnz2LVfg1p2yHpqhpegBhEPxoGgNFmOeTTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 004/149] tpm: Add a helper for checking hwrng enabled
Date:   Sun, 13 Aug 2023 23:17:29 +0200
Message-ID: <20230813211718.892183470@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

commit cacc6e22932f373a91d7be55a9b992dc77f4c59b upstream.

The same checks are repeated in three places to decide whether to use
hwrng.  Consolidate these into a helper.

Also this fixes a case that one of them was missing a check in the
cleanup path.

Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -518,10 +518,20 @@ static int tpm_hwrng_read(struct hwrng *
 	return tpm_get_random(chip, data, max);
 }
 
+static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
+{
+	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+		return false;
+	if (tpm_is_firmware_upgrade(chip))
+		return false;
+	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
+		return false;
+	return true;
+}
+
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
-	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
+	if (!tpm_is_hwrng_enabled(chip))
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -626,7 +636,7 @@ int tpm_chip_register(struct tpm_chip *c
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -651,8 +661,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8677ABAA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjHMVYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHMVYX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23DF10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39738628E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8AC433C8;
        Sun, 13 Aug 2023 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961864;
        bh=PDqFwxloBi56MjK1bImd8BijxMoZfbqySfjUa9RU8Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGZ8YWKGUaUKE8ouPivTHW22ZqngofA2DTTifVCuVXS6aY7Ry1U0vgcOeQEXlkX/a
         DQ4GzpQL/oAF46OkedUlAZA6y+yBLvS511V7yCuXMaPfTbEIoczgV0v8ihulCzDnsF
         wvYqTP+23meq/EVeYPWDrL3vZUrNFfmci5h5yzLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 004/206] tpm: Add a helper for checking hwrng enabled
Date:   Sun, 13 Aug 2023 23:16:14 +0200
Message-ID: <20230813211725.099915890@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -521,10 +521,20 @@ static int tpm_hwrng_read(struct hwrng *
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
@@ -629,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *c
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -654,8 +664,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))



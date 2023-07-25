Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E077613DD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjGYLOm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjGYLOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A73A87
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03EAC61689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12370C433C8;
        Tue, 25 Jul 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283604;
        bh=boWSQTh5R5RCY689d119uUAIm9h3yiLXWWgLlQKPDZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFcgzx8nwDhRRS3RhnK6f55r8uVVjPFd3AAP70o+rncruROF9B3VMkx7ez0XQMvgt
         0dRAKWuiyO2f3Gs1j2UOrSvJvpFxb8xPcCmVBe4pmy6Eu0HbLpUFXS380Id1ERhJTz
         57P8dZXJeTyUt0jL0pupXd1sJqWECdxaKih1rJuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/509] regulator: core: Streamline debugfs operations
Date:   Tue, 25 Jul 2023 12:39:54 +0200
Message-ID: <20230725104556.199928876@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 08880713ceec023dd94d634f1e8902728c385939 ]

If CONFIG_DEBUG_FS is not set:

    regulator: Failed to create debugfs directory
    ...
    regulator-dummy: Failed to create debugfs directory

As per the comments for debugfs_create_dir(), errors returned by this
function should be expected, and ignored:

 * If debugfs is not enabled in the kernel, the value -%ENODEV will be
 * returned.
 *
 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

Adhere to the debugfs spirit, and streamline all operations by:
  1. Demoting the importance of the printed error messages to debug
     level, like is already done in create_regulator(),
  2. Further ignoring any returned errors, as by design, all debugfs
     functions are no-ops when passed an error pointer.

Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_create_dir")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/2f8bb6e113359ddfab7b59e4d4274bd4c06d6d0a.1685013051.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e4ff64d28c778..52b75779dbb7e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1751,19 +1751,17 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	if (err != -EEXIST)
 		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-	if (IS_ERR(regulator->debugfs)) {
+	if (IS_ERR(regulator->debugfs))
 		rdev_dbg(rdev, "Failed to create debugfs directory\n");
-	} else {
-		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-				   &regulator->uA_load);
-		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
-		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
-		debugfs_create_file("constraint_flags", 0444,
-				    regulator->debugfs, regulator,
-				    &constraint_flags_fops);
-	}
+
+	debugfs_create_u32("uA_load", 0444, regulator->debugfs,
+			   &regulator->uA_load);
+	debugfs_create_u32("min_uV", 0444, regulator->debugfs,
+			   &regulator->voltage[PM_SUSPEND_ON].min_uV);
+	debugfs_create_u32("max_uV", 0444, regulator->debugfs,
+			   &regulator->voltage[PM_SUSPEND_ON].max_uV);
+	debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
+			    regulator, &constraint_flags_fops);
 
 	/*
 	 * Check now if the regulator is an always on regulator - if
@@ -5032,10 +5030,8 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (IS_ERR(rdev->debugfs)) {
-		rdev_warn(rdev, "Failed to create debugfs directory\n");
-		return;
-	}
+	if (IS_ERR(rdev->debugfs))
+		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 
 	debugfs_create_u32("use_count", 0444, rdev->debugfs,
 			   &rdev->use_count);
@@ -5938,7 +5934,7 @@ static int __init regulator_init(void)
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (IS_ERR(debugfs_root))
-		pr_warn("regulator: Failed to create debugfs directory\n");
+		pr_debug("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
-- 
2.39.2




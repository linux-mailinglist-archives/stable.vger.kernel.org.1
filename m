Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676AB761615
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjGYLgW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjGYLgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6A1BC3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C64616AB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A4CC433C7;
        Tue, 25 Jul 2023 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284966;
        bh=YFOP5Qgoht4cesuKR40BMktqIm1arh8Mf8W+8RQ0wkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMZDnKbN9OczTI4jjxent38L18ow/KA6q/LbYyp/IId4m+NTWdhRzTiUI4etPdyXG
         lD6UYWVHMeYFDhS2sRo9OWIuHD05Uzc+Kh6bakXz4GJWcVdpaPilYTs3RL3DzAMJ00
         qe0KHCHyPyJGpDRHhNNJYaauJYU/ErAUme4m4/Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 036/313] regulator: core: Streamline debugfs operations
Date:   Tue, 25 Jul 2023 12:43:09 +0200
Message-ID: <20230725104522.636136615@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 0ac9c763942f9..fe4b666edd037 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1710,19 +1710,17 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
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
@@ -4906,10 +4904,8 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
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
@@ -5797,7 +5793,7 @@ static int __init regulator_init(void)
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (IS_ERR(debugfs_root))
-		pr_warn("regulator: Failed to create debugfs directory\n");
+		pr_debug("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
-- 
2.39.2




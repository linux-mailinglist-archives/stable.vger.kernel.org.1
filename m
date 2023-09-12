Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA879BBD6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379573AbjIKWov (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbjIKNy7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:54:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55245FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEEDC433C8;
        Mon, 11 Sep 2023 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440495;
        bh=zHoqCv9+8QpIUTaB3887I16EYQ1TKFUfCEJRoC4scQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9ZtrZ4nGItWTFlcA8aS47VoYSpZHkURhrpLpH64k2xAMhN3DzA4en3IRBjpi8t/6
         Vk5FMCDKsybKdUBiZgkhgGmxRhWpTNrvoQVDymqeZv/f1KNDHKeL9U3mEO7P3z4Mxl
         v0BzliOB/BwozY6UZ4vm5KbEmKnG1i/u0ooYKByM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 055/739] cpufreq: amd-pstate-ut: Remove module parameter access
Date:   Mon, 11 Sep 2023 15:37:34 +0200
Message-ID: <20230911134652.653993086@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

[ Upstream commit 8d6e5e8268e89979d86501dbb8385ce2e6154de1 ]

In amd-pstate-ut, shared memory-based systems call
get_shared_mem() as part of amd_pstate_ut_check_enabled()
function. This function was written when CONFIG_X86_AMD_PSTATE
was tristate config and amd_pstate can be built as a module.

Currently CONFIG_X86_AMD_PSTATE is a boolean config and module
parameter shared_mem is removed. But amd-pstate-ut code still
accesses this module parameter. Remove those accesses.

Fixes: 456ca88d8a52 ("cpufreq: amd-pstate: change amd-pstate driver to be built-in type")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Suggested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate-ut.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 7f3fe20489818..cf07ee77d3ccf 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -64,27 +64,9 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 static bool get_shared_mem(void)
 {
 	bool result = false;
-	char path[] = "/sys/module/amd_pstate/parameters/shared_mem";
-	char buf[5] = {0};
-	struct file *filp = NULL;
-	loff_t pos = 0;
-	ssize_t ret;
-
-	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
-		filp = filp_open(path, O_RDONLY, 0);
-		if (IS_ERR(filp))
-			pr_err("%s unable to open %s file!\n", __func__, path);
-		else {
-			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
-			if (ret < 0)
-				pr_err("%s read %s file fail ret=%ld!\n",
-					__func__, path, (long)ret);
-			filp_close(filp, NULL);
-		}
 
-		if ('Y' == *buf)
-			result = true;
-	}
+	if (!boot_cpu_has(X86_FEATURE_CPPC))
+		result = true;
 
 	return result;
 }
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C377A7B44
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjITLuq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITLup (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9DD3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F2C433C8;
        Wed, 20 Sep 2023 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210638;
        bh=DAf19xp33GLkVxVRLMmh7svB1/lqSFIiE581PC4hrog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOV5Kh0jNNVxNx6kSb5JymgmapKWDrANtgBk35VsUg1juX9WY+6oEabCHT0olODcE
         ptBMZfnrPUfU1/M6Q7JxwiBQKO5M5HDOso0hNNhJghvCWA/BDn0+QFS9EHAzS5JKtx
         SC32xC3ukNQgUfuADdXUvj/zuKDxYkiDP7uVgYdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pengfei Xu <pengfei.xu@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 149/211] PM: hibernate: Fix the exclusive get block device in test_resume mode
Date:   Wed, 20 Sep 2023 13:29:53 +0200
Message-ID: <20230920112850.484315193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 148b6f4cc3920e563094540fe1a12d00d3bbccae ]

Commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
in test_resume mode") fixes a hibernation issue under test_resume mode.
That commit is supposed to open the block device in non-exclusive mode
when in test_resume. However the code does the opposite, which is against
its description.

In summary, the swap device is only opened exclusively by swsusp_check()
with its corresponding *close(), and must be in non test_resume mode.
This is to avoid the race condition that different processes scribble the
device at the same time. All the other cases should use non-exclusive mode.

Fix it by really disabling exclusive mode under test_resume.

Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
Closes: https://lore.kernel.org/lkml/000000000000761f5f0603324129@google.com/
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Chenzhou Feng <chenzhoux.feng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2b4a946a6ff5c..8d35b9f9aaa3f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -786,9 +786,9 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check(snapshot_test);
+		error = swsusp_check(false);
 		if (!error)
-			error = load_image_and_restore(snapshot_test);
+			error = load_image_and_restore(false);
 	}
 	thaw_processes();
 
@@ -945,14 +945,14 @@ static int software_resume(void)
 	pm_pr_dbg("Looking for hibernation image.\n");
 
 	mutex_lock(&system_transition_mutex);
-	error = swsusp_check(false);
+	error = swsusp_check(true);
 	if (error)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(false);
+		swsusp_close(true);
 		goto Unlock;
 	}
 
@@ -973,7 +973,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore(false);
+	error = load_image_and_restore(true);
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
@@ -987,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(false);
+	swsusp_close(true);
 	goto Finish;
 }
 
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363BF6FACBC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjEHL1l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjEHL1T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B2B4BBFF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E5862DAD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC9AC433D2;
        Mon,  8 May 2023 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545230;
        bh=j4uS4KE5pxGfuHogMe3HeMd/YIK2+mS/kKBnvpskTAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGf7lzQeUOKQUPqOeWK5bntD8s4q4pp7za0z3QIZKWKe5gmnkTjhmwI6CFxiFYuK0
         XhregWhmmNlgPUyt+OPQCrOI9BeUsHbfMWgAPajFbjR8d/RSg8snt5ssBl7cdLhuUr
         DV7gaElVCzy9jkkiDKIIrDBFbcHP4TWRDGqcgQng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 667/694] PM: hibernate: Turn snapshot_test into global variable
Date:   Mon,  8 May 2023 11:48:22 +0200
Message-Id: <20230508094457.740010496@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 08169a162f97819d3e5b4a342bb9cf5137787154 ]

There is need to check snapshot_test and open block device
in different mode, so as to avoid the race condition.

No functional changes intended.

Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 7 ++++++-
 kernel/power/power.h     | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 793c55a2becba..aa551b093c3f6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -64,6 +64,7 @@ enum {
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
+bool snapshot_test;
 
 static const struct platform_hibernation_ops *hibernation_ops;
 
@@ -716,7 +717,6 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
-	bool snapshot_test = false;
 	unsigned int sleep_flags;
 	int error;
 
@@ -744,6 +744,9 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
+	/* protected by system_transition_mutex */
+	snapshot_test = false;
+
 	lock_device_hotplug();
 	/* Allocate memory management structures */
 	error = create_basic_memory_bitmaps();
@@ -940,6 +943,8 @@ static int software_resume(void)
 	 */
 	mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
 
+	snapshot_test = false;
+
 	if (swsusp_resume_device)
 		goto Check_image;
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f4339432096..b83c8d5e188de 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -59,6 +59,7 @@ asmlinkage int swsusp_save(void);
 
 /* kernel/power/hibernate.c */
 extern bool freezer_test_done;
+extern bool snapshot_test;
 
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
-- 
2.39.2




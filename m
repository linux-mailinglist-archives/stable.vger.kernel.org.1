Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02277613E2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjGYLOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjGYLOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527D420C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B856166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A7C433C7;
        Tue, 25 Jul 2023 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283615;
        bh=OtWOUdu18ilo6la3nBd+jD3sK9RBHL4kjdR2RWlzrAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxWpjHttHqySUnILlK+b+vuazo1WkQEL2ADbBpWlGp33KHUea64iYgRv1hLwnI7GU
         F5D4YH2c7MV9aqTQKZAxdk6Q50XMtYMCgcob/i+71cDc4Tt9WnKsCQzIjwxRz9FVlm
         NeR3bSiumDfx3HMr/ebGtf8RE/ZBbRV2f9Av6xAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Davidlohr Bueso <dbueso@suse.de>,
        Li Zhijian <zhijianx.li@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 032/509] rcuscale: Always log error message
Date:   Tue, 25 Jul 2023 12:39:31 +0200
Message-ID: <20230725104555.126487424@linuxfoundation.org>
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

From: Li Zhijian <zhijianx.li@intel.com>

[ Upstream commit 86e7ed1bd57d020e35d430542bf5d689c3200568 ]

Unconditionally log messages corresponding to errors.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Stable-dep-of: 23fc8df26dea ("rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 28bc688e2705c..4452c3c4060ce 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -49,8 +49,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
 #define VERBOSE_SCALEOUT_STRING(s) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
-#define VERBOSE_SCALEOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
+#define SCALEOUT_ERRSTRING(s) \
+	pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s)
 
 /*
  * The intended use cases for the nreaders and nwriters module parameters
@@ -484,11 +484,11 @@ rcu_scale_cleanup(void)
 	 * during the mid-boot phase, so have to wait till the end.
 	 */
 	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
 	if (rcu_gp_is_normal() && gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
 	if (gp_exp && gp_async)
-		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
+		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
 	if (torture_cleanup_begin())
 		return;
@@ -803,7 +803,7 @@ rcu_scale_init(void)
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -823,7 +823,7 @@ rcu_scale_init(void)
 		kcalloc(nrealwriters, sizeof(*writer_n_durations),
 			GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.39.2




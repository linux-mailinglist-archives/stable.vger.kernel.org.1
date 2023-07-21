Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6630275D1BA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGUSwZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGUSwQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DEB3ABF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9738E61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F0FC433C7;
        Fri, 21 Jul 2023 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965528;
        bh=UPmaUMCgvutc5xvwrXOTQQ72MNUXvFNamClvMRQm4sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYvCrhrEYiZ6dAoZraOrkO5IgBkox9yQ2+99T4HYTbxSy8IxOecPguf3B+fcLJaH4
         ax7RjzvDyB2R67hlD4J8K1OnNvgNSIfHfpHvcAcDP9DBLykDWtx4EZFOkPjSblDMzG
         ZxXxj5KF9GJSRWyHDyY4PR8eBwRTffNc8wX9Wp3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 023/532] rcuscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Fri, 21 Jul 2023 17:58:47 +0200
Message-ID: <20230721160615.924175547@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit ef1ef3d47677dc191b88650a9f7f91413452cc1b ]

The rcu_scale_shutdown() and kfree_scale_shutdown() kthreads/functions
use wait_event() to wait for the rcuscale test to complete.  However,
each updater thread in such a test waits for at least 100 grace periods.
If each grace period takes more than 1.2 seconds, which is long, but
not insanely so, this can trigger the hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Stable-dep-of: 23fc8df26dea ("rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5c8449a8827a1..a3e86c4843d37 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -609,8 +609,7 @@ static int compute_real(int n)
 static int
 rcu_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_scale_cleanup();
 	kernel_power_off();
@@ -736,8 +735,8 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+	wait_event_idle(shutdown_wq,
+			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
-- 
2.39.2




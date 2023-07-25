Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74F67613E1
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjGYLOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjGYLOc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C94200
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3708D6165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C95C433C8;
        Tue, 25 Jul 2023 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283612;
        bh=SE+iWFJUY5CQmpA2iG//KOdabp5zcuUfR+g2dAx5U4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwHNnLedYax1Fd002MO88SPnDJsFVVsAuvI0UFIBKFvv/XpuuygvDIxZ5GG5VRAri
         tsn6qlxfLWkqJkgkOQ/P3PqdwgHTA+ZwWMFNFCDGGp5ENu1L0V4EylyjTwOK0C1RbJ
         9MRRDEkPrXsulWMwZFz2InViR/rBHqlczhLfom9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jiangong.Han" <jiangong.han@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 031/509] rcuscale: Console output claims too few grace periods
Date:   Tue, 25 Jul 2023 12:39:30 +0200
Message-ID: <20230725104555.076993817@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Jiangong.Han <jiangong.han@windriver.com>

[ Upstream commit 811192c5f24bfd7246ce9ce06f668d8c408bf39b ]

The rcuscale console output claims N grace periods, numbered from zero
to N, which means that there were really N+1 grace periods.  The root
cause of this bug is that rcu_scale_writer() stores the number of the
last grace period (numbered from zero) into writer_n_durations[me]
instead of the number of grace periods.  This commit therefore assigns
the actual number of grace periods to writer_n_durations[me], and also
makes the corresponding adjustment to the loop outputting per-grace-period
measurements.

Sample of old console output:
    rcu-scale: writer 0 gps: 133
    ......
    rcu-scale:    0 writer-duration:     0 44003961
    rcu-scale:    0 writer-duration:     1 32003582
    ......
    rcu-scale:    0 writer-duration:   132 28004391
    rcu-scale:    0 writer-duration:   133 27996410

Sample of new console output:
    rcu-scale: writer 0 gps: 134
    ......
    rcu-scale:    0 writer-duration:     0 44003961
    rcu-scale:    0 writer-duration:     1 32003582
    ......
    rcu-scale:    0 writer-duration:   132 28004391
    rcu-scale:    0 writer-duration:   133 27996410

Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Stable-dep-of: 23fc8df26dea ("rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95479af9..28bc688e2705c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -457,7 +457,7 @@ rcu_scale_writer(void *arg)
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max;
+	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -531,7 +531,7 @@ rcu_scale_cleanup(void)
 			wdpp = writer_durations[i];
 			if (!wdpp)
 				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
+			for (j = 0; j < writer_n_durations[i]; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,
-- 
2.39.2




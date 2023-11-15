Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33127ECB28
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjKOTUb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjKOTUb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A842D44
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26F3C433C9;
        Wed, 15 Nov 2023 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076027;
        bh=SuHBy7E/NykkDtC6n19gCdulU5oaKDv7JLs8pq2REQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GC9GaLj5UF4Dw42UMLAt65poD7yNSBtcKmO/nLN38Tl/Jjh12hHgjbt16w0kkZU0g
         E4YFS3EfNqawvpManJ9NbtFLe0aq16b0h/CfC0T4o1y6KpQ0tetWQgRY3qSXdOwuOb
         kPW/3JV1HsoSjXl8FVLW/ZKX/zFMGvv8MVtnxRH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leo Yu-Chi Liang <ycliang@andestech.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 005/550] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Date:   Wed, 15 Nov 2023 14:09:49 -0500
Message-ID: <20231115191601.087096401@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit c0490bc9bb62d9376f3dd4ec28e03ca0fef97152 ]

We don't need to maintain per-queue leaf_cfs_rq_list on !SMP, since
it's used for cfs_rq load tracking & balancing on SMP.

But sched debug interface uses it to print per-cfs_rq stats.

This patch fixes the !SMP version of cfs_rq_is_decayed(), so the
per-queue leaf_cfs_rq_list is also maintained correctly on !SMP,
to fix the warning in assert_list_leaf_cfs_rq().

Fixes: 0a00a354644e ("sched/fair: Delete useless condition in tg_unthrottle_up()")
Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Closes: https://lore.kernel.org/all/ZN87UsqkWcFLDxea@swlinux02/
Link: https://lore.kernel.org/r/20230913132031.2242151-1-chengming.zhou@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d9c2482c5a35..7e3ed4f447fdf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4654,7 +4654,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return true;
+	return !cfs_rq->nr_running;
 }
 
 #define UPDATE_TG	0x0
-- 
2.42.0




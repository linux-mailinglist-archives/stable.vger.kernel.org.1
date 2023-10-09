Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39B87BE08E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377355AbjJINl3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376588AbjJINl2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527F9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24807C433C8;
        Mon,  9 Oct 2023 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858886;
        bh=7kr1apUnOgof/nfGWbasV0ilaEMeFeYctRygXQ+ufAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GtvB8ku34lrKOHqqPuQUOiFLpIe5gKfbIjF9PDZ1iQ3JmiZPNNUpNRwKc2cw/0yTP
         39C9Zh2FhLGc1pytSi9Efb4BFZblq4RewS7tpPFu7+2Rhg6tZ9BqH9mB/ISQndKLNd
         w1XbnZp296jHUjIQ4oclRVB6w/lrHZM/l9PNq+tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 132/226] cgroup: Fix suspicious rcu_dereference_check() usage warning
Date:   Mon,  9 Oct 2023 15:01:33 +0200
Message-ID: <20231009130130.210024505@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengming Zhou <zhouchengming@bytedance.com>

commit f2aa197e4794bf4c2c0c9570684f86e6fa103e8b upstream.

task_css_set_check() will use rcu_dereference_check() to check for
rcu_read_lock_held() on the read-side, which is not true after commit
dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
commit drop explicit rcu_read_lock(), change to RCU-sched read-side
critical section. So fix the RCU warning by adding check for
rcu_read_lock_sched_held().

Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20220305034103.57123-1-zhouchengming@bytedance.com
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cgroup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7653f54189502..c9c430712d471 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -451,6 +451,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
-- 
2.40.1




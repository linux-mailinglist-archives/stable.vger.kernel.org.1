Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64F7A378D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbjIQTWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjIQTVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:21:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37853121
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:21:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C976C433CA;
        Sun, 17 Sep 2023 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978482;
        bh=7Ag7NWEfq0QVHfuPVFVxVBuFntRl6y5Jds8nMixXlbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwS5DMo7BCFJPqMKcTpMk1VhsWVmwnSj/q9WNogb56Rr9mmoztPz2S9fc6ZtqkHuo
         +uKQPUClT2ISrPV+Pv6E8uOm96zR+LNn4zOHa6grexpeDxqfxmy7+XAXR3yHPq9p93
         Org6eoCiCp8hnuuRN3ektum/b01L9TyyrPzUIGsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Waiman Long <longman@redhat.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 071/406] refscale: Fix uninitalized use of wait_queue_head_t
Date:   Sun, 17 Sep 2023 21:08:45 +0200
Message-ID: <20230917191103.012187196@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit f5063e8948dad7f31adb007284a5d5038ae31bb8 ]

Running the refscale test occasionally crashes the kernel with the
following error:

[ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
[ 8569.952900] #PF: supervisor read access in kernel mode
[ 8569.952902] #PF: error_code(0x0000) - not-present page
[ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
[ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
[ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
  :
[ 8569.952940] Call Trace:
[ 8569.952941]  <TASK>
[ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
[ 8569.952959]  kthread+0x10e/0x130
[ 8569.952966]  ret_from_fork+0x1f/0x30
[ 8569.952973]  </TASK>

The likely cause is that init_waitqueue_head() is called after the call to
the torture_create_kthread() function that creates the ref_scale_reader
kthread.  Although this init_waitqueue_head() call will very likely
complete before this kthread is created and starts running, it is
possible that the calling kthread will be delayed between the calls to
torture_create_kthread() and init_waitqueue_head().  In this case, the
new kthread will use the waitqueue head before it is properly initialized,
which is not good for the kernel's health and well-being.

The above crash happened here:

	static inline void __add_wait_queue(...)
	{
		:
		if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here

The offset of flags from list_head entry in wait_queue_entry is
-0x18. If reader_tasks[i].wq.head.next is NULL as allocated reader_task
structure is zero initialized, the instruction will try to access address
0xffffffffffffffe8, which is exactly the fault address listed above.

This commit therefore invokes init_waitqueue_head() before creating
the kthread.

Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 4e419ca6d6114..dbd670376c42e 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -692,12 +692,11 @@ ref_scale_init(void)
 	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
+		init_waitqueue_head(&reader_tasks[i].wq);
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (firsterr)
 			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
 	}
 
 	// Main Task
-- 
2.40.1




Return-Path: <stable+bounces-1285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4EF7F7EE6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A0AB2176C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518828DC3;
	Fri, 24 Nov 2023 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5Vqr9A+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35EF33CC7;
	Fri, 24 Nov 2023 18:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6309EC433C8;
	Fri, 24 Nov 2023 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851018;
	bh=kmpwIOJpM7H/mLSAegnIwFskjQCoH8l3SaYWRtm1kXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5Vqr9A+JgtvITBmUSmdxB5/UBxqDv+ibENVVFI5jzNFESw8pniRR80VnxOsGI57y
	 Ao1Croar07VnsIXbBoy00zG5kQdnCoGJGGhdONYAXOm8N4GsupT/kM3gt/syCXcGKd
	 /VkZGVBS3hL0HWt2EqJGnZU3n/dkPOBlza7/6IoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Raits <igor.raits@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 6.5 281/491] sched/core: Fix RQCF_ACT_SKIP leak
Date: Fri, 24 Nov 2023 17:48:37 +0000
Message-ID: <20231124172033.022576144@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Jia <jiahao.os@bytedance.com>

commit 5ebde09d91707a4a9bec1e3d213e3c12ffde348f upstream.

Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.

This warning may be triggered in the following situations:

    CPU0                                      CPU1

__schedule()
  *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
  pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
    newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
      rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
      raw_spin_rq_unlock(this_rq)
                                      rq_lock(*CPU0_rq*, &rf)
                                      rq_clock_start_loop_update()
                                      rq->clock_update_flags & RQCF_ACT_SKIP <--
      raw_spin_rq_lock(this_rq)

The purpose of RQCF_ACT_SKIP is to skip the update rq clock,
but the update is very early in __schedule(), but we clear
RQCF_*_SKIP very late, causing it to span that gap above
and triggering this warning.

In __schedule() we can clear the RQCF_*_SKIP flag immediately
after update_rq_clock() to avoid this RQCF_ACT_SKIP leak warning.
And set rq->clock_update_flags to RQCF_UPDATED to avoid
rq->clock_update_flags < RQCF_ACT_SKIP warning that may be triggered later.

Fixes: ebb83d84e49b ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
Closes: https://lore.kernel.org/all/20230913082424.73252-1-jiahao.os@bytedance.com
Reported-by: Igor Raits <igor.raits@gmail.com>
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5377,8 +5377,6 @@ context_switch(struct rq *rq, struct tas
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
-	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
@@ -6634,6 +6632,7 @@ static void __sched notrace __schedule(u
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
+	rq->clock_update_flags = RQCF_UPDATED;
 
 	switch_count = &prev->nivcsw;
 
@@ -6713,8 +6712,6 @@ static void __sched notrace __schedule(u
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);




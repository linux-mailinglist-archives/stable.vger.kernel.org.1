Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2072F209
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjFNBgE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 21:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjFNBf7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 21:35:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D633EA
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:35:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569fee67d9dso3213237b3.1
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686706554; x=1689298554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUP1rteuLNLGDjGu/kihOwC9q1N72CjFLHVL2ZrQjcE=;
        b=V4kth1jPU8iY3OzZf7Yhm3mGcrug/yYVoVAljgWp24wIj9FEKJfVcuRN5fp6KrvTjh
         8iJm3taTzqzVk+H/Hx9+Zjn8unVvnnXz6DI1PodZ3BNctJKy/rstYHGHFgRbUPPL5JzI
         1mqEEvdDjlcdUDLXkPGkwFDdr4cbNfMfIOpmZrsgWQY6aklIhQi/PyQ3NbC+mVmL0QWH
         OV+WI3Welu4hJETH4cxzNGYzmuqgcS/hYpIE53OzvfJ0O9OxUqCk4ndHepo2rhjzm1By
         8pwdWXdv7XtoXTYf0XisvTjj1z4apQFdfRSLgLWrWfxWRgG0gcDHLTmPgoZOTdi4bIZk
         ksjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686706554; x=1689298554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUP1rteuLNLGDjGu/kihOwC9q1N72CjFLHVL2ZrQjcE=;
        b=J59xjJWt7CNVEzoX05KOFls7AQWHCg2FbH4xB/MiGDt0LrV7aW1L5iavmAo/jdgByY
         dJwHODeuAcimEMzncrHQz64ESnjXM91BxopX9Y8L7FXjhbWQnAbb/DLHXdvHM9zFzeIg
         w2TZkZuFSKxtIBLuQogEOZRxNHWd2fC/XuMNP0TZxbw/Uris0bgm0A1/zoDS/z/s1UUd
         9WhVuOm0tboLjjTH3S5/ywws6LObl9/Zdqf93dxdqyoBhcZcZ0imja1I6G/F2aF90Q/m
         easYP+qW8IkwcST+j2DYKw6q9znSlxyWE1NGrfdU37iaGMFxlQrZVvN/PQ1HtSVaBpKH
         SHzw==
X-Gm-Message-State: AC+VfDz3QaDk3ZDuEnHxFhtj1hfziZc5UsLOD6N0NOwR9J5GNaFkMwux
        OitfPkPFfJ7Otbi5JukyOqAO/DUIWL5D45XF+9qa6NWNJ6hOnZmV7LfHcnb7Y4AegxhoQzJlUFN
        yPn0dR382BSS+b5smD3sVw9rSO4YkBPG05fDxxugKxqioXma6jvq4zq01/b5EQg==
X-Google-Smtp-Source: ACHHUZ75dd96I0T8xzjyXpM0TFgNY9742Tk9oKxZ9nIlLixG1EHvkdKbx1ONrqPUVIkpr6Mak5T98agrnok=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:bbff:ed76:4140:fb87])
 (user=surenb job=sendgmr) by 2002:a81:b625:0:b0:56c:f903:8678 with SMTP id
 u37-20020a81b625000000b0056cf9038678mr83147ywh.2.1686706554693; Tue, 13 Jun
 2023 18:35:54 -0700 (PDT)
Date:   Tue, 13 Jun 2023 18:35:46 -0700
In-Reply-To: <20230614013548.1382385-1-surenb@google.com>
Mime-Version: 1.0
References: <20230614013548.1382385-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614013548.1382385-2-surenb@google.com>
Subject: [RESEND 1/1] linux-5.15/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ziwei Dai <ziwei.dai@unisoc.com>

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

commit 5da7cb193db32da783a3f3e77d8b639989321d48 upstream.

Memory passed to kvfree_rcu() that is to be freed is tracked by a
per-CPU kfree_rcu_cpu structure, which in turn contains pointers
to kvfree_rcu_bulk_data structures that contain pointers to memory
that has not yet been handed to RCU, along with an kfree_rcu_cpu_work
structure that tracks the memory that has already been handed to RCU.
These structures track three categories of memory: (1) Memory for
kfree(), (2) Memory for kvfree(), and (3) Memory for both that arrived
during an OOM episode.  The first two categories are tracked in a
cache-friendly manner involving a dynamically allocated page of pointers
(the aforementioned kvfree_rcu_bulk_data structures), while the third
uses a simple (but decidedly cache-unfriendly) linked list through the
rcu_head structures in each block of memory.

On a given CPU, these three categories are handled as a unit, with that
CPU's kfree_rcu_cpu_work structure having one pointer for each of the
three categories.  Clearly, new memory for a given category cannot be
placed in the corresponding kfree_rcu_cpu_work structure until any old
memory has had its grace period elapse and thus has been removed.  And
the kfree_rcu_monitor() function does in fact check for this.

Except that the kfree_rcu_monitor() function checks these pointers one
at a time.  This means that if the previous kfree_rcu() memory passed
to RCU had only category 1 and the current one has only category 2, the
kfree_rcu_monitor() function will send that current category-2 memory
along immediately.  This can result in memory being freed too soon,
that is, out from under unsuspecting RCU readers.

To see this, consider the following sequence of events, in which:

o	Task A on CPU 0 calls rcu_read_lock(), then uses "from_cset",
	then is preempted.

o	CPU 1 calls kfree_rcu(cset, rcu_head) in order to free "from_cset"
	after a later grace period.  Except that "from_cset" is freed
	right after the previous grace period ended, so that "from_cset"
	is immediately freed.  Task A resumes and references "from_cset"'s
	member, after which nothing good happens.

In full detail:

CPU 0					CPU 1
----------------------			----------------------
count_memcg_event_mm()
|rcu_read_lock()  <---
|mem_cgroup_from_task()
 |// css_set_ptr is the "from_cset" mentioned on CPU 1
 |css_set_ptr = rcu_dereference((task)->cgroups)
 |// Hard irq comes, current task is scheduled out.

					cgroup_attach_task()
					|cgroup_migrate()
					|cgroup_migrate_execute()
					|css_set_move_task(task, from_cset, to_cset, true)
					|cgroup_move_task(task, to_cset)
					|rcu_assign_pointer(.., to_cset)
					|...
					|cgroup_migrate_finish()
					|put_css_set_locked(from_cset)
					|from_cset->refcount return 0
					|kfree_rcu(cset, rcu_head) // free from_cset after new gp
					|add_ptr_to_bulk_krc_lock()
					|schedule_delayed_work(&krcp->monitor_work, ..)

					kfree_rcu_monitor()
					|krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
					|queue_rcu_work(system_wq, &krwp->rcu_work)
					|if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
					|call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request new gp

					// There is a perious call_rcu(.., rcu_work_rcufn)
					// gp end, rcu_work_rcufn() is called.
					rcu_work_rcufn()
					|__queue_work(.., rwork->wq, &rwork->work);

					|kfree_rcu_work()
					|krwp->bulk_head_free[0] bulk is freed before new gp end!!!
					|The "from_cset" is freed before new gp end.

// the task resumes some time later.
 |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.

This commit therefore causes kfree_rcu_monitor() to refrain from moving
kfree_rcu() memory to the kfree_rcu_cpu_work structure until the RCU
grace period has completed for all three categories.

v2: Use helper function instead of inserted code block at kfree_rcu_monitor().

[UR: backport to 5.15-stable]
[UR: Added missing need_offload_krc() function]
Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Resending per Greg's request.
Original posting: https://lore.kernel.org/all/20230418102518.5911-2-urezki@gmail.com/

 kernel/rcu/tree.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03902ee655ee..df016f6d0662 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3328,6 +3328,30 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 }
 
+static bool
+need_offload_krc(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krcp->bkvhead[i])
+			return true;
+
+	return !!krcp->head;
+}
+
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krwp->bkvhead_free[i])
+			return true;
+
+	return !!krwp->head_free;
+}
+
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
@@ -3344,14 +3368,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		// Try to detach bkvhead or head and attach it over any
-		// available corresponding free channel. It can be that
-		// a previous RCU batch is in progress, it means that
-		// immediately to queue another one is not possible so
-		// in that case the monitor work is rearmed.
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
-				(krcp->head && !krwp->head_free)) {
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		if (need_offload_krc(krcp)) {
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
-- 
2.41.0.162.gfafddb0af9-goog


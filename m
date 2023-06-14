Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BF72F20A
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 03:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbjFNBgG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 21:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjFNBf7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 21:35:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3EAE57
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:35:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5b8a9d82cso303077276.0
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686706556; x=1689298556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsFdg865wN1blTyBxq1yRNIHuZvnA0ls60ZLbViitVU=;
        b=kps7zk5Nt2FjA2vuiZckDl1/KTSwAl5lp4Js0qdqPiNa4fPlfbm1n1tY2T4m7cKhuw
         lRjXfvbnRYTZ4JOGCnbz5760BLgSaTqDN+kzKJKOId8cWsQGZAYGSqNxSh+zH/0HsGtG
         Lidsc+Bslzn7siI0jeBHcV9LxeEJrs1ScAA1V9KAjOrmjixKeXPL9uTk4o3LP2wKUksN
         BMbtiEnZHw7LpxCBmZhRgaHHDsMsTS2IUVP+XETK6AGtE8VOY9RLZh/s3c7shEh7MFi/
         GG+8agFphQVLWCPdqq504RLM10PuZTvtKKHpkbMGACdM3rc9MtW+Y7Ns/o7/GxmMcvfM
         Gu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686706556; x=1689298556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsFdg865wN1blTyBxq1yRNIHuZvnA0ls60ZLbViitVU=;
        b=MIKHcYwj2aSjaeBgeisw9CXkNiAYxyZjOIXzYNfUEF8dji7W8TP392HcFF6PeSTivf
         BkreFapotcbFykbgm0X+wcxohrGzyoWzfiQYTHFs3U0BJc4W/uXnw8dty9Nypp4qexaj
         GXUcDkT0kUVsCMpHrHHxaerMO/FOU0ip9GXRZLgv6WurFosmfe5PTFP1wtmm0mSM4GfQ
         j7lul9gwXtCBJs0o61CgWtonAzP6Sq1bMkwUECAE+NVRQEVc5nZA3Rg9Ti3G1N1Gf8u2
         db1Sb7hcknaFELJD9P58wvt4ft0dHob7lLFhhF5fqUfnDH49dsP+yMS0q/aSP5SAgHkA
         yTtA==
X-Gm-Message-State: AC+VfDzMHPs4ZXTcpPbzQoyxqwwm6KGT4f53ChEyweO3CyecurNwqHt5
        RtPO85lR3r/7FVHqVJnOX3NY8h8m7d0QtdL7Q92rT8lfS3ycm8vo9PfLREEsXC7gllKlUjPvQ0b
        Bm+92es0yQxsR6cFyFemmETNl/biWaEt1ftw+2HcGR3T3ubdTzXbF5gikvNC1KA==
X-Google-Smtp-Source: ACHHUZ5S5+Fqz+IHqzirlY0RcTM3HSeWrNe7g47af0yLqo8PjX3FUT4tuBmlg0oLCmnY1OejEgyD4KD/jlw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:bbff:ed76:4140:fb87])
 (user=surenb job=sendgmr) by 2002:a25:aa8d:0:b0:bcd:f98e:f5f with SMTP id
 t13-20020a25aa8d000000b00bcdf98e0f5fmr376311ybi.13.1686706556695; Tue, 13 Jun
 2023 18:35:56 -0700 (PDT)
Date:   Tue, 13 Jun 2023 18:35:47 -0700
In-Reply-To: <20230614013548.1382385-1-surenb@google.com>
Mime-Version: 1.0
References: <20230614013548.1382385-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614013548.1382385-3-surenb@google.com>
Subject: [RESEND 1/1] linux-6.1/rcu/kvfree: Avoid freeing new kfree_rcu()
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

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

[UR: backport to 6.1-stable]
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
Original posting: https://lore.kernel.org/all/20230418102518.5911-3-urezki@gmail.com/

 kernel/rcu/tree.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ce34ca0b5b98..d03122f90cc4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3099,6 +3099,18 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
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
 static void
 schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
@@ -3130,14 +3142,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
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


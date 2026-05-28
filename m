Return-Path: <stable+bounces-255072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEWtLMZ7GGrbkQgAu9opvQ
	(envelope-from <stable+bounces-255072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:30:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A715F5A51
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 224AC307A898
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E063FBB68;
	Thu, 28 May 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nCbEw506"
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F935E1D3;
	Thu, 28 May 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989104; cv=none; b=hWRzES/KQM00+CuIdeQIxweorzcyN9F6hgJXYvWPtUYBAQq9U4ltf7HozSn7en4RF8hXySmSnQvNodES1MjnU63nasuKFo5fI2Jtzb19qvI7yFUrYv+tCluPhcdwAyMfgatzGDBTy+hXw/yN3cznbAIn6rH4UYxE1KZADLcqvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989104; c=relaxed/simple;
	bh=azwSYEsf3r6x24RDR7LSUUr3c/+UT/n9HxTbQOqYIZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YF0ULs0y5NEJy6ngDte2kxLXGWCrQsd2CKWNwESWaDZexZdDOqoewXiTgfqoqt2gYcPEqtWSinoBQEer09vDPZUBxCH+Tamn08nzAf4RNoDRS0cu8nGSOLXtbAQNoaufOWVJS1d0/gQwaw8QQSGaeP7a0QkWikktKKbgY3zOkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nCbEw506; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from PC-202605011814.localdomain (unknown [IPV6:2409:8924:2013:1a6b:50af:214a:ea2b:7da2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4036887fb;
	Fri, 29 May 2026 01:19:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	matthew.brost@intel.com,
	niranjana.vishwanathapura@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc_submit: use READ_ONCE/WRITE_ONCE for suspend_pending
Date: Fri, 29 May 2026 01:19:30 +0800
Message-Id: <20260528171930.623349-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6f99548903a1kunm6e76f1936c74e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0wdVhhKHh4eSRlIS0JOS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSU9BSUtKSEFKGk0ZQU5LGh1BSUpPGkEeGkkZQU
	wfGklZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=nCbEw506UJYzD67aLWJo3J9KfJ7f5n7W3RuJitYlmy3jzzgRNUkyCgOqG7PBI8hQQqoSd1uJxjf1DsaPOcrjUcMjNQIQP8jQTgzSMtJetk324NNsufjdxZ38sLOit//yEexmNrd+ICitogTYKH8gEvUEx/6aq/DMlz8T4EQeYMo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=grI5+WkDPw1Kkq8OqNs6nxRmvCl6kGjPTMtYyzg5qYY=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,intel.com,lists.freedesktop.org,vger.kernel.org,seu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-255072-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: B8A715F5A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xe_guc_submit.c mixes plain loads and stores of q->guc->suspend_pending
with READ_ONCE()/WRITE_ONCE() accesses in the suspend fence wait/signal
paths.

On a running system this is reachable when one thread queues or waits
for exec queue suspend while another CPU concurrently processes suspend
completion or queue teardown. The shared suspend_pending flag can then
be set in guc_exec_queue_suspend(), sampled in __suspend_fence_signal(),
__guc_exec_queue_process_msg_suspend(), guc_exec_queue_stop(), and
handle_sched_done(), and waited on in guc_exec_queue_suspend_wait().

That leaves a data race on the suspend_pending completion flag and
breaks the local ONCE-access contract for the same shared state.

The issue was found on Linux v6.18.21 by our static analysis tool while
scanning XE shared status flags that mixed plain and ONCE accesses, and
then manually reviewed in xe_guc_submit.c.

It was then confirmed with a reproducible no-device QEMU KCSAN selftest
built into xe.ko that preserved the same access pattern as this code:

  1. a setter thread performs a plain suspend_pending = true;
  2. a signaler thread does a plain if (suspend_pending) check, then
     WRITE_ONCE(suspend_pending, false) and wake_up();
  3. a waiter thread blocks on !READ_ONCE(suspend_pending).

That selftest produced repeated target KCSAN reports between the setter
and signaler threads.

Convert the remaining file-local suspend_pending sites in
xe_guc_submit.c to READ_ONCE()/WRITE_ONCE(). This keeps all set, check,
and clear uses on the same access family and matches the existing
waiter path, which already uses READ_ONCE().

Build-tested with:
  make olddefconfig
  make -j"$(nproc)" drivers/gpu/drm/xe/xe_guc_submit.o

Runtime-tested with:
  reproducible QEMU no-device KCSAN selftest built into xe.ko

No Intel XE hardware was available for runtime testing of the real
driver path. This QEMU run is a no-device KCSAN validation harness, not
a hardware-backed suspend test.

Fixes: 627c961d672d ("drm/xe: Add timeout to preempt fences")
Cc: stable@vger.kernel.org

Representative repeated KCSAN report from the no-device XE selftest:
  xe suspend_pending selftest: starting no-device mixed-ONCE validation
  xe suspend_pending selftest: actor contract = plain set(true), plain
  check, READ_ONCE waiter, WRITE_ONCE clear + wake_up
  ==================================================================
  BUG: KCSAN: data-race in xe_suspend_pending_setter_thread [xe] /
  xe_suspend_pending_signaler_thread [xe]

  write to 0xffff9a87425e0b20 of 1 bytes by task 99 on cpu 1:
   xe_suspend_pending_setter_thread+0x1a/0x60 [xe]
   kthread+0x1c2/0x340
   ret_from_fork+0x166/0x180
   ret_from_fork_asm+0x1a/0x30

  read to 0xffff9a87425e0b20 of 1 bytes by task 100 on cpu 0:
   xe_suspend_pending_signaler_thread+0x48/0x90 [xe]
   kthread+0x1c2/0x340
   ret_from_fork+0x166/0x180
   ret_from_fork_asm+0x1a/0x30

  value changed: 0x00 -> 0x01

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 0 UID: 0 PID: 100 Comm: xe1153_signaler Not tainted
  6.18.21-dirty #23 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
  1.15.0-1 04/01/2014
  ==================================================================
  xe suspend_pending selftest: completed set_iters=22395630
  signal_iters=8319270 wait_iters=9847185 wait_timeouts=3048
  final_pending=0

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ecee50d82710..1d036ccaacc9 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1542,7 +1542,7 @@ static void __guc_exec_queue_process_msg_set_sched_props(struct xe_sched_msg *ms
 
 static void __suspend_fence_signal(struct xe_exec_queue *q)
 {
-	if (!q->guc->suspend_pending)
+	if (!READ_ONCE(q->guc->suspend_pending))
 		return;
 
 	WRITE_ONCE(q->guc->suspend_pending, false);
@@ -1555,7 +1555,7 @@ static void suspend_fence_signal(struct xe_exec_queue *q)
 
 	xe_gt_assert(guc_to_gt(guc), exec_queue_suspended(q) || exec_queue_killed(q) ||
 		     xe_guc_read_stopped(guc));
-	xe_gt_assert(guc_to_gt(guc), q->guc->suspend_pending);
+	xe_gt_assert(guc_to_gt(guc), READ_ONCE(q->guc->suspend_pending));
 
 	__suspend_fence_signal(q);
 }
@@ -1583,7 +1583,7 @@ static void __guc_exec_queue_process_msg_suspend(struct xe_sched_msg *msg)
 			set_exec_queue_suspended(q);
 			disable_scheduling(q, false);
 		}
-	} else if (q->guc->suspend_pending) {
+	} else if (READ_ONCE(q->guc->suspend_pending)) {
 		set_exec_queue_suspended(q);
 		suspend_fence_signal(q);
 	}
@@ -1831,7 +1831,7 @@ static int guc_exec_queue_suspend(struct xe_exec_queue *q)
 
 	xe_sched_msg_lock(sched);
 	if (guc_exec_queue_try_add_msg(q, msg, SUSPEND))
-		q->guc->suspend_pending = true;
+		WRITE_ONCE(q->guc->suspend_pending, true);
 	xe_sched_msg_unlock(sched);
 
 	return 0;
@@ -1870,7 +1870,7 @@ static void guc_exec_queue_resume(struct xe_exec_queue *q)
 	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_RESUME;
 	struct xe_guc *guc = exec_queue_to_guc(q);
 
-	xe_gt_assert(guc_to_gt(guc), !q->guc->suspend_pending);
+	xe_gt_assert(guc_to_gt(guc), !READ_ONCE(q->guc->suspend_pending));
 
 	xe_sched_msg_lock(sched);
 	guc_exec_queue_try_add_msg(q, msg, RESUME);
@@ -1916,7 +1916,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 		else if (exec_queue_destroyed(q))
 			__guc_exec_queue_destroy(guc, q);
 	}
-	if (q->guc->suspend_pending) {
+	if (READ_ONCE(q->guc->suspend_pending)) {
 		set_exec_queue_suspended(q);
 		suspend_fence_signal(q);
 	}
@@ -2178,7 +2178,7 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
 		xe_gt_assert(guc_to_gt(guc), runnable_state == 0);
 		xe_gt_assert(guc_to_gt(guc), exec_queue_pending_disable(q));
 
-		if (q->guc->suspend_pending) {
+		if (READ_ONCE(q->guc->suspend_pending)) {
 			suspend_fence_signal(q);
 			clear_exec_queue_pending_disable(q);
 		} else {
-- 
2.34.1


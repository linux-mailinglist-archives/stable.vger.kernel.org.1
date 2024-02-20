Return-Path: <stable+bounces-21102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A733D85C723
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A51F226DE
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BC1509AC;
	Tue, 20 Feb 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1I/4EEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825A14AD12;
	Tue, 20 Feb 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463357; cv=none; b=KoDZXi0e+1PBlaLluJBa7jH2yaZ6fMkTgmW1ASxqeZPb+rc+PHX2yOl1nDpab9mzicENH1nQCx0zGwPG614IA5eZC2LnCBqzSevuLPuRp8X7ZxX3MSF5lJfTqSfmQaLM5izSTCeGZ44n5Hq7YsWyAoNVJYfzdVWk5iFs1J8cl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463357; c=relaxed/simple;
	bh=P0OXPEDXiNXQjUxfPApijBeX2skbr3B41DNlGEjXusU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJVbAcr2dhZCe5SyRHiUBt3t0rdz8EuGqgeM1QWilYo2aRQ7eybH/YCUbQfEV/y083/5Wkhw/wpUC01MfMYN3k4nO/EO2R2SbnzijngiNDD/KSKPAS4OrW322J5p54zYiD40HJZuiD/4U+Dyx5MpJFs8z07pAdrzfPMN9zuibkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1I/4EEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB178C433F1;
	Tue, 20 Feb 2024 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463357;
	bh=P0OXPEDXiNXQjUxfPApijBeX2skbr3B41DNlGEjXusU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1I/4EEafh/RdtyIWRzy8JKv6NaO1FTGnThvMmQXuqmkR8IPcGJ9kMSx9vwoURFG/
	 D1Qsye+CT/Dmz5zAW4HsaQeuTt9LR9Uegtk7x5iWgxQE/5qWcJwOuUqMgSGtqy+ZWZ
	 L4lJj7HwaaxnGSMUopE9YRpM+Ts0sEFKm+YsYIlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shaoqin Huang <shahuang@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/331] KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test
Date: Tue, 20 Feb 2024 21:52:15 +0100
Message-ID: <20240220205638.191364594@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ba58f873cdeec30b6da48e28dd5782c5a3e1371b ]

When finishing the final iteration of dirty_log_test testcase, set
host_quit _before_ the final "continue" so that the vCPU worker doesn't
run an extra iteration, and delete the hack-a-fix of an extra "continue"
from the dirty ring testcase.  This fixes a bug where the extra post to
sem_vcpu_cont may not be consumed, which results in failures in subsequent
runs of the testcases.  The bug likely was missed during development as
x86 supports only a single "guest mode", i.e. there aren't any subsequent
testcases after the dirty ring test, because for_each_guest_mode() only
runs a single iteration.

For the regular dirty log testcases, letting the vCPU run one extra
iteration is a non-issue as the vCPU worker waits on sem_vcpu_cont if and
only if the worker is explicitly told to stop (vcpu_sync_stop_requested).
But for the dirty ring test, which needs to periodically stop the vCPU to
reap the dirty ring, letting the vCPU resume the guest _after_ the last
iteration means the vCPU will get stuck without an extra "continue".

However, blindly firing off an post to sem_vcpu_cont isn't guaranteed to
be consumed, e.g. if the vCPU worker sees host_quit==true before resuming
the guest.  This results in a dangling sem_vcpu_cont, which leads to
subsequent iterations getting out of sync, as the vCPU worker will
continue on before the main task is ready for it to resume the guest,
leading to a variety of asserts, e.g.

  ==== Test Assertion Failure ====
  dirty_log_test.c:384: dirty_ring_vcpu_ring_full
  pid=14854 tid=14854 errno=22 - Invalid argument
     1  0x00000000004033eb: dirty_ring_collect_dirty_pages at dirty_log_test.c:384
     2  0x0000000000402d27: log_mode_collect_dirty_pages at dirty_log_test.c:505
     3   (inlined by) run_test at dirty_log_test.c:802
     4  0x0000000000403dc7: for_each_guest_mode at guest_modes.c:100
     5  0x0000000000401dff: main at dirty_log_test.c:941 (discriminator 3)
     6  0x0000ffff9be173c7: ?? ??:0
     7  0x0000ffff9be1749f: ?? ??:0
     8  0x000000000040206f: _start at ??:?
  Didn't continue vcpu even without ring full

Alternatively, the test could simply reset the semaphores before each
testcase, but papering over hacks with more hacks usually ends in tears.

Reported-by: Shaoqin Huang <shahuang@redhat.com>
Fixes: 84292e565951 ("KVM: selftests: Add dirty ring buffer test")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Link: https://lore.kernel.org/r/20240202231831.354848-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 50 +++++++++++---------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 936f3a8d1b83..e96fababd3f0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -376,7 +376,10 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 
 	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
 
-	/* Cleared pages should be the same as collected */
+	/*
+	 * Cleared pages should be the same as collected, as KVM is supposed to
+	 * clear only the entries that have been harvested.
+	 */
 	TEST_ASSERT(cleared == count, "Reset dirty pages (%u) mismatch "
 		    "with collected (%u)", cleared, count);
 
@@ -415,12 +418,6 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 	}
 }
 
-static void dirty_ring_before_vcpu_join(void)
-{
-	/* Kick another round of vcpu just to make sure it will quit */
-	sem_post(&sem_vcpu_cont);
-}
-
 struct log_mode {
 	const char *name;
 	/* Return true if this mode is supported, otherwise false */
@@ -433,7 +430,6 @@ struct log_mode {
 				     uint32_t *ring_buf_idx);
 	/* Hook to call when after each vcpu run */
 	void (*after_vcpu_run)(struct kvm_vcpu *vcpu, int ret, int err);
-	void (*before_vcpu_join) (void);
 } log_modes[LOG_MODE_NUM] = {
 	{
 		.name = "dirty-log",
@@ -452,7 +448,6 @@ struct log_mode {
 		.supported = dirty_ring_supported,
 		.create_vm_done = dirty_ring_create_vm_done,
 		.collect_dirty_pages = dirty_ring_collect_dirty_pages,
-		.before_vcpu_join = dirty_ring_before_vcpu_join,
 		.after_vcpu_run = dirty_ring_after_vcpu_run,
 	},
 };
@@ -513,14 +508,6 @@ static void log_mode_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 		mode->after_vcpu_run(vcpu, ret, err);
 }
 
-static void log_mode_before_vcpu_join(void)
-{
-	struct log_mode *mode = &log_modes[host_log_mode];
-
-	if (mode->before_vcpu_join)
-		mode->before_vcpu_join();
-}
-
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -719,6 +706,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 	uint32_t ring_buf_idx = 0;
+	int sem_val;
 
 	if (!log_mode_supported()) {
 		print_skip("Log mode '%s' not supported",
@@ -788,12 +776,22 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	/* Start the iterations */
 	iteration = 1;
 	sync_global_to_guest(vm, iteration);
-	host_quit = false;
+	WRITE_ONCE(host_quit, false);
 	host_dirty_count = 0;
 	host_clear_count = 0;
 	host_track_next_count = 0;
 	WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
 
+	/*
+	 * Ensure the previous iteration didn't leave a dangling semaphore, i.e.
+	 * that the main task and vCPU worker were synchronized and completed
+	 * verification of all iterations.
+	 */
+	sem_getvalue(&sem_vcpu_stop, &sem_val);
+	TEST_ASSERT_EQ(sem_val, 0);
+	sem_getvalue(&sem_vcpu_cont, &sem_val);
+	TEST_ASSERT_EQ(sem_val, 0);
+
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	while (iteration < p->iterations) {
@@ -819,15 +817,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		assert(host_log_mode == LOG_MODE_DIRTY_RING ||
 		       atomic_read(&vcpu_sync_stop_requested) == false);
 		vm_dirty_log_verify(mode, bmap);
-		sem_post(&sem_vcpu_cont);
 
-		iteration++;
+		/*
+		 * Set host_quit before sem_vcpu_cont in the final iteration to
+		 * ensure that the vCPU worker doesn't resume the guest.  As
+		 * above, the dirty ring test may stop and wait even when not
+		 * explicitly request to do so, i.e. would hang waiting for a
+		 * "continue" if it's allowed to resume the guest.
+		 */
+		if (++iteration == p->iterations)
+			WRITE_ONCE(host_quit, true);
+
+		sem_post(&sem_vcpu_cont);
 		sync_global_to_guest(vm, iteration);
 	}
 
-	/* Tell the vcpu thread to quit */
-	host_quit = true;
-	log_mode_before_vcpu_join();
 	pthread_join(vcpu_thread, NULL);
 
 	pr_info("Total bits checked: dirty (%"PRIu64"), clear (%"PRIu64"), "
-- 
2.43.0





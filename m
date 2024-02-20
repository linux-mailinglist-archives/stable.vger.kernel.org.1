Return-Path: <stable+bounces-20897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0AB85C62B
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E4A1C21645
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDF151CD8;
	Tue, 20 Feb 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S3nzetEt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E661509BF;
	Tue, 20 Feb 2024 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462713; cv=none; b=fv5LNy1ZgumThSP7ZLbes1TK20Xgl7v9xKOMK+HPYAXGxf2tNH1jT2P7QvbsFuLmXHHnDExHyeKKUrEN5pnNZBwCB6cwDJpLsNh+UuaH7/WaQY8fpb+dbEeWoQK35fj3htkvEkmW+bbG1Y7tFOLD1n8YKeh9ZyTtSriEsOCiKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462713; c=relaxed/simple;
	bh=VO9/qavqVHWMPxCBAAgtvth/e5sR9/t9dvsvHmh7lfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEIMJ1XlWpSDQONBubGSdNVMlrRWVtsicIcrab+z9BL+HLqza1koV7l85Pq4oqAFbvF40q31iDcIRFdbKhN8G7EOA8g8ARiykb2mSQa8mXWi3hQSTCet+wq6d9ql/xEX8QlTaNcyog8UCJjlh6dYNyAkfEWMxQ+c0s1XA7Mousg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S3nzetEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE55C433C7;
	Tue, 20 Feb 2024 20:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462712;
	bh=VO9/qavqVHWMPxCBAAgtvth/e5sR9/t9dvsvHmh7lfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3nzetEtkjeYATZ67pua66vBvq/dTRZ7C2UySSBQGRHg4JkqlvHnQdjwGNGOEserV
	 4hRCj6L77OQEyL9duMP/ms4xtF0FLliyDkukKJMfSp+cBpbufpQRPhIzoeyA+gVNyQ
	 dFGRtLWZj0kzB8PLxzk1eBKzIKvNv4OctN5TY0+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gavin Shan <gshan@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/197] KVM: selftests: Clear dirty ring states between two modes in dirty_log_test
Date: Tue, 20 Feb 2024 21:49:33 +0100
Message-ID: <20240220204841.511386546@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavin Shan <gshan@redhat.com>

[ Upstream commit 7167190ddb863bd061c0c6b61f4cec94184b40da ]

There are two states, which need to be cleared before next mode
is executed. Otherwise, we will hit failure as the following messages
indicate.

- The variable 'dirty_ring_vcpu_ring_full' shared by main and vcpu
  thread. It's indicating if the vcpu exit due to full ring buffer.
  The value can be carried from previous mode (VM_MODE_P40V48_4K) to
  current one (VM_MODE_P40V48_64K) when VM_MODE_P40V48_16K isn't
  supported.

- The current ring buffer index needs to be reset before next mode
  (VM_MODE_P40V48_64K) is executed. Otherwise, the stale value is
  carried from previous mode (VM_MODE_P40V48_4K).

  # ./dirty_log_test -M dirty-ring
  Setting log mode to: 'dirty-ring'
  Test iterations: 32, interval: 10 (ms)
  Testing guest mode: PA-bits:40,  VA-bits:48,  4K pages
  guest physical test memory offset: 0xffbfffc000
    :
  Dirtied 995328 pages
  Total bits checked: dirty (1012434), clear (7114123), track_next (966700)
  Testing guest mode: PA-bits:40,  VA-bits:48, 64K pages
  guest physical test memory offset: 0xffbffc0000
  vcpu stops because vcpu is kicked out...
  vcpu continues now.
  Notifying vcpu to continue
  Iteration 1 collected 0 pages
  vcpu stops because dirty ring is full...
  vcpu continues now.
  vcpu stops because dirty ring is full...
  vcpu continues now.
  vcpu stops because dirty ring is full...
  ==== Test Assertion Failure ====
  dirty_log_test.c:369: cleared == count
  pid=10541 tid=10541 errno=22 - Invalid argument
     1	0x0000000000403087: dirty_ring_collect_dirty_pages at dirty_log_test.c:369
     2	0x0000000000402a0b: log_mode_collect_dirty_pages at dirty_log_test.c:492
     3	 (inlined by) run_test at dirty_log_test.c:795
     4	 (inlined by) run_test at dirty_log_test.c:705
     5	0x0000000000403a37: for_each_guest_mode at guest_modes.c:100
     6	0x0000000000401ccf: main at dirty_log_test.c:938
     7	0x0000ffff9ecd279b: ?? ??:0
     8	0x0000ffff9ecd286b: ?? ??:0
     9	0x0000000000401def: _start at ??:?
  Reset dirty pages (0) mismatch with collected (35566)

Fix the issues by clearing 'dirty_ring_vcpu_ring_full' and the ring
buffer index before next new mode is to be executed.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221110104914.31280-7-gshan@redhat.com
Stable-dep-of: ba58f873cdee ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 27 ++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index b5234d6efbe1..8758c10ec850 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -226,13 +226,15 @@ static void clear_log_create_vm_done(struct kvm_vm *vm)
 }
 
 static void dirty_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
-					  void *bitmap, uint32_t num_pages)
+					  void *bitmap, uint32_t num_pages,
+					  uint32_t *unused)
 {
 	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
 }
 
 static void clear_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
-					  void *bitmap, uint32_t num_pages)
+					  void *bitmap, uint32_t num_pages,
+					  uint32_t *unused)
 {
 	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
 	kvm_vm_clear_dirty_log(vcpu->vm, slot, bitmap, 0, num_pages);
@@ -329,10 +331,9 @@ static void dirty_ring_continue_vcpu(void)
 }
 
 static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
-					   void *bitmap, uint32_t num_pages)
+					   void *bitmap, uint32_t num_pages,
+					   uint32_t *ring_buf_idx)
 {
-	/* We only have one vcpu */
-	static uint32_t fetch_index = 0;
 	uint32_t count = 0, cleared;
 	bool continued_vcpu = false;
 
@@ -349,7 +350,8 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 
 	/* Only have one vcpu */
 	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vcpu),
-				       slot, bitmap, num_pages, &fetch_index);
+				       slot, bitmap, num_pages,
+				       ring_buf_idx);
 
 	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
 
@@ -406,7 +408,8 @@ struct log_mode {
 	void (*create_vm_done)(struct kvm_vm *vm);
 	/* Hook to collect the dirty pages into the bitmap provided */
 	void (*collect_dirty_pages) (struct kvm_vcpu *vcpu, int slot,
-				     void *bitmap, uint32_t num_pages);
+				     void *bitmap, uint32_t num_pages,
+				     uint32_t *ring_buf_idx);
 	/* Hook to call when after each vcpu run */
 	void (*after_vcpu_run)(struct kvm_vcpu *vcpu, int ret, int err);
 	void (*before_vcpu_join) (void);
@@ -471,13 +474,14 @@ static void log_mode_create_vm_done(struct kvm_vm *vm)
 }
 
 static void log_mode_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
-					 void *bitmap, uint32_t num_pages)
+					 void *bitmap, uint32_t num_pages,
+					 uint32_t *ring_buf_idx)
 {
 	struct log_mode *mode = &log_modes[host_log_mode];
 
 	TEST_ASSERT(mode->collect_dirty_pages != NULL,
 		    "collect_dirty_pages() is required for any log mode!");
-	mode->collect_dirty_pages(vcpu, slot, bitmap, num_pages);
+	mode->collect_dirty_pages(vcpu, slot, bitmap, num_pages, ring_buf_idx);
 }
 
 static void log_mode_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
@@ -696,6 +700,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	unsigned long *bmap;
+	uint32_t ring_buf_idx = 0;
 
 	if (!log_mode_supported()) {
 		print_skip("Log mode '%s' not supported",
@@ -771,6 +776,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_dirty_count = 0;
 	host_clear_count = 0;
 	host_track_next_count = 0;
+	WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
@@ -778,7 +784,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(p->interval * 1000);
 		log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
-					     bmap, host_num_pages);
+					     bmap, host_num_pages,
+					     &ring_buf_idx);
 
 		/*
 		 * See vcpu_sync_stop_requested definition for details on why
-- 
2.43.0





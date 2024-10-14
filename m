Return-Path: <stable+bounces-83718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A599BF00
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB661F249BB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F11C331A;
	Mon, 14 Oct 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjVv0Q1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFD1C32FF;
	Mon, 14 Oct 2024 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878403; cv=none; b=SlC5GrAMojMkZRsPQ8p1X5qH0rciLgYeFPbKAxE3y+S1dSIqQTAO/ALMEBkJwKlgdqG6eWEfcj1GIGwBu5S0Po4cnCtcriMM1fhGRcIVUZjrwgP4GJZ/C/PwJe7wKgagtyL7K8qCrxiQGm0CBoZlmDpKG5tWIrCR+7/1QBDKc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878403; c=relaxed/simple;
	bh=05CO9drUQ5UXdLsYQ9SNi6onE4hMkEb4iN5v4UY2Vig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpZ6Tfnjvom02UdasFy8uAsj4/zBshUQFFFLF6WjZpVDQjwGF5TtcHIjtRE4mY2d22SzT9VEIJkNPxw0+tDQaocdFAGG50XQ3/Fp5+rcRA6HreJEUtcYstBBx+jHq0aXSWaxjG3L+g//rzXtqDi18WZqzeA1dEX8G2DF+Qm7pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjVv0Q1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA959C4CEC3;
	Mon, 14 Oct 2024 04:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878402;
	bh=05CO9drUQ5UXdLsYQ9SNi6onE4hMkEb4iN5v4UY2Vig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjVv0Q1yxle5OxOCeXjAEXk+O7bR+LXeOan59AmJk+0bZ38tNNo2DrUusK9evXGr9
	 rgPeXRKDv8pKicUtw2l8EujKA33oWeZqUEpmtFQ7ZBSCuFpXgF3akqk4DSn7hr7qZP
	 5wepnuIky1gH1xLK4ZAUk7p4M/XB61TSv9v0tq+QBRvaZKnSyGNqSkgZiQxpxfSwYz
	 xHjyP3BXT4HUNeRWcBtZ5puNRiMCrZDMhqdulM+51L+dmv8TrfBWFEePePA414+cgP
	 FMq8lCM6U+CnmuujHxj7o05BRWX2fHbkBDTefVN1sKIsMjZ1S8m0PIkBdS9t2TWBYh
	 uo8c5QjTQc3xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dimitri Sivanich <sivanich@hpe.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dimitri.sivanich@hpe.com,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.4 2/2] misc: sgi-gru: Don't disable preemption in GRU driver
Date: Sun, 13 Oct 2024 23:59:54 -0400
Message-ID: <20241014035958.2266211-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035958.2266211-1-sashal@kernel.org>
References: <20241014035958.2266211-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Dimitri Sivanich <sivanich@hpe.com>

[ Upstream commit b983b271662bd6104d429b0fd97af3333ba760bf ]

Disabling preemption in the GRU driver is unnecessary, and clashes with
sleeping locks in several code paths.  Remove preempt_disable and
preempt_enable from the GRU driver.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/sgi-gru/grukservices.c | 2 --
 drivers/misc/sgi-gru/grumain.c      | 4 ----
 drivers/misc/sgi-gru/grutlbpurge.c  | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0197441a1eae7..8dc1c5e519aff 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -257,7 +257,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -271,7 +270,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index e2325e3d077ea..4f7a0f8472556 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -941,10 +941,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -953,7 +951,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -969,7 +966,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608df..1107dd3e2e9fa 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -65,7 +65,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -79,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
-- 
2.43.0



Return-Path: <stable+bounces-83720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435A99BF05
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3624D1C22875
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF31C760A;
	Mon, 14 Oct 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/IY+gXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3731C75EC;
	Mon, 14 Oct 2024 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878410; cv=none; b=c60Do677LJwKH4lOhBowqg0AD+2rBtXevtykoa6KAyXpjPHNk3R1E9bBHybzlXUEUTDJupcXq/U8XKPQlYsoLgqskMmBs3OojzugQQpbwMWptUCrFnOwlw3V+To8y7aLU2n7ItqlSoUZv8tM+ttn1LXnTeEm/dlR/cay6YNfhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878410; c=relaxed/simple;
	bh=Yl2B1acKFZiQG5WnQceixFSuKe8xMeyl7RRDMyZnsfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QukVfqkeDgtK+/WrzRjv5ZKvqboOaoPBdo8s4MpsKJp9TypJA2hK4Mus4dLHglkma0Z00SlNNb5lHKaTJWpqqOlRjE9zEKSY6+rFn9VqkPsm0ukbhbevuO55oB5U4vMnx8F0VMsLamlVNTwztjMJixYUTU92b8XtIVgIsLOdxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/IY+gXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3378C4CEC3;
	Mon, 14 Oct 2024 04:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878410;
	bh=Yl2B1acKFZiQG5WnQceixFSuKe8xMeyl7RRDMyZnsfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/IY+gXQ+kVxobC84cRNdajMOeycFhCN+GLE893jlygmc4GUDlyIFz/Q6sEgspga+
	 XBg+uTg3t/as2yZBy4SyXcQb5rq0vxd2Ob9ElelxRzgdwXSEAH1c+gLCzEyVIA+TI4
	 mZOaUUH2xPm2hHZS/sJ6SXS3DYXGDmR2qj8JPaKqf5pSTb2iqTcRn4nkgFSFcZutMz
	 gR4hfphvSiz08Z5t7B4//Ax4zFC/rgo4WU7PcJGhMBsnH1G113fc/9/YQF3JQrBeJR
	 9xBZtdL6YUqWbfrvUkUgOtxlabLPLqT/psD4n8o4vLKTgvN/KbgEte+O15qkSZX8P/
	 9Z6ftBWng/4Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dimitri Sivanich <sivanich@hpe.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dimitri.sivanich@hpe.com,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 4.19 2/2] misc: sgi-gru: Don't disable preemption in GRU driver
Date: Mon, 14 Oct 2024 00:00:02 -0400
Message-ID: <20241014040006.2269066-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014040006.2269066-1-sashal@kernel.org>
References: <20241014040006.2269066-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index 030769018461b..256be2e12faa1 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -270,7 +270,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -284,7 +283,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 8c3e0317c115b..cb4c97210ec36 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -954,10 +954,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -966,7 +964,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -982,7 +979,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index be28f05bfafa9..0f837cc3a417b 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -78,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -92,7 +91,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
-- 
2.43.0



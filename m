Return-Path: <stable+bounces-83695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946AE99BEBD
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53608284B1E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03D19F41B;
	Mon, 14 Oct 2024 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwYSXhW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15419F132;
	Mon, 14 Oct 2024 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878325; cv=none; b=c2Ia6aed3hTPZhulVcSVN41hu6sHZHWkIpKcAJ3cjUxUxhrfx/nQGbnoqZr/Yxbq+zxYll/pV+GXn919vl/UgBVm9kE0X38fMNDl7/lvqTFmea0cVtVZb0AhNa7JQGKy1ZGYXsZGwhemodvLvqC7tfSEa+Mfn3npIeiGtkJjhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878325; c=relaxed/simple;
	bh=qBitYCjPlfviFcj9OzfeFwt/TyyNuF9Sx6hyLwEe4U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H12EHZOCB99ThuJ2vbYc705ilDZrDEfv6gt+gKVrj+tKeunXncyrPVhsL6PGatKkykwuhuMu1DW+btPYdsig1WlyhoZQoA04+K1WecBN4sXGjbzqHUNqvNgNYTZ8mnl9rZRqTkUnxzVxQYATnFSM3/cvPYl9oOCvrs+Sha3e1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwYSXhW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8583C4CECE;
	Mon, 14 Oct 2024 03:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878324;
	bh=qBitYCjPlfviFcj9OzfeFwt/TyyNuF9Sx6hyLwEe4U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwYSXhW2TM506Fn0tsmda6OmRKDbjWEtjbEnOmxc5k3kC3RQKTyiwBj1+SEL7flXX
	 jPpWbkYgj0zTQbvD46aMIaAdCVaglkeiWct8cxvPX0sVyPhxydrZlsu67g7TAW9/fj
	 wAludE6VmQAxIiZ9wAwFD6ZHCcm5owDsu5FIZUyuSJWiNC7V3xkKKn8ZMQah+8WADT
	 w91tdI2iR/N7LaMncQrq57Hl8uLI9j0LgrNsWmoSOTnLC3fgRblM6ye40aHMdyzDD/
	 gI/vxt/bjtLJ7GFYR2bQ3R9Idd37XZE9mnm8cJjvoxtg/sfPkru9y8ujDwYgEW4U8r
	 HGle6zi6MYcxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dimitri Sivanich <sivanich@hpe.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dimitri.sivanich@hpe.com,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.6 17/17] misc: sgi-gru: Don't disable preemption in GRU driver
Date: Sun, 13 Oct 2024 23:58:07 -0400
Message-ID: <20241014035815.2247153-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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
index 37e804bbb1f28..205945ce9e86a 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -258,7 +258,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -272,7 +271,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 4eb4b94551390..d2b2e39783d06 100644
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



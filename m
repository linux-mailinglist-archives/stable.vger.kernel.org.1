Return-Path: <stable+bounces-161990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF021B05B0A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8524E7AC45D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1683BBF2;
	Tue, 15 Jul 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/zrDviw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313C193077;
	Tue, 15 Jul 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585380; cv=none; b=RKIIg1ZPnvsGaG36Hiir/LVzgBGIkkVnxBVA3BTxS41atJDibgxelsp1PeHJCN7np/zFALM18nWtmikL6i6Pvlwqfwir8C0esSC7UmujQwmtnqKHlNH2KnAZxfeBfXrQBZKl5AjUxK0WZ5fPL7qhphcmqemmaUEGDc8GUdMkq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585380; c=relaxed/simple;
	bh=8xx3D6IuOBTU87WqT+DrFV2baVi3oHQN0+y5qejrEo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hsj2BXjKpynI9Mag23jBnmbWlNxu628uwKh1HWZhvs1PugpQ659cOoUzyN5mMaR5XtbDt7QzheEsiNdHbsJYh9Vn/HJEq0fBnpc/NOLA3VerTrrsAyCLrG5BIz4xd28aa4Pgll8uFFawQRoaAdqXPmk/WIDieCO7D9QYMYKrsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/zrDviw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F9C4CEF1;
	Tue, 15 Jul 2025 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585380;
	bh=8xx3D6IuOBTU87WqT+DrFV2baVi3oHQN0+y5qejrEo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/zrDviw4GUDKFeb8V2+RqSwZQGCuSiiCBbBR0n/QgM69JTJvgY4EH67iu1NlExwM
	 6RrjGM8V95HTIk6DMby7IrXbEsW7NMn7DArB/Ckv5JKjsUO5tV6n7e0n0HpWSTQoYl
	 UUvFgHcL1AnbRbnJIdYWHuCa3rf1p2zabixB0s7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lin cao <lin.cao@amd.com>,
	Jingwen Chen <Jingwen.Chen2@amd.com>,
	Victor Skvortsov <victor.skvortsov@amd.com>,
	Zhigang Luo <zhigang.luo@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12 006/163] drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV
Date: Tue, 15 Jul 2025 15:11:14 +0200
Message-ID: <20250715130809.034395150@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit dc0297f3198bd60108ccbd167ee5d9fa4af31ed0 upstream.

RLCG Register Access is a way for virtual functions to safely access GPU
registers in a virtualized environment., including TLB flushes and
register reads. When multiple threads or VFs try to access the same
registers simultaneously, it can lead to race conditions. By using the
RLCG interface, the driver can serialize access to the registers. This
means that only one thread can access the registers at a time,
preventing conflicts and ensuring that operations are performed
correctly. Additionally, when a low-priority task holds a mutex that a
high-priority task needs, ie., If a thread holding a spinlock tries to
acquire a mutex, it can lead to priority inversion. register access in
amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.

The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
called, which attempts to acquire the mutex. This function is invoked
from amdgpu_sriov_wreg, which in turn is called from
gmc_v11_0_flush_gpu_tlb.

The [ BUG: Invalid wait context ] indicates that a thread is trying to
acquire a mutex while it is in a context that does not allow it to sleep
(like holding a spinlock).

Fixes the below:

[  253.013423] =============================
[  253.013434] [ BUG: Invalid wait context ]
[  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  253.013464] -----------------------------
[  253.013475] kworker/0:1/10 is trying to lock:
[  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.013815] other info that might help us debug this:
[  253.013827] context-{4:4}
[  253.013835] 3 locks held by kworker/0:1/10:
[  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
[  253.014154] stack backtrace:
[  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
[  253.014224] Workqueue: events work_for_cpu_fn
[  253.014241] Call Trace:
[  253.014250]  <TASK>
[  253.014260]  dump_stack_lvl+0x9b/0xf0
[  253.014275]  dump_stack+0x10/0x20
[  253.014287]  __lock_acquire+0xa47/0x2810
[  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014321]  lock_acquire+0xd1/0x300
[  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014562]  ? __lock_acquire+0xa6b/0x2810
[  253.014578]  __mutex_lock+0x85/0xe20
[  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014782]  ? sched_clock_noinstr+0x9/0x10
[  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014808]  ? local_clock_noinstr+0xe/0xc0
[  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.015029]  mutex_lock_nested+0x1b/0x30
[  253.015044]  ? mutex_lock_nested+0x1b/0x30
[  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
[  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
[  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
[  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
[  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
[  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
[  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
[  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
[  253.017493]  local_pci_probe+0x4b/0xb0
[  253.017746]  work_for_cpu_fn+0x1a/0x30
[  253.017995]  process_one_work+0x21e/0x680
[  253.018248]  worker_thread+0x190/0x330
[  253.018500]  ? __pfx_worker_thread+0x10/0x10
[  253.018746]  kthread+0xe7/0x120
[  253.018988]  ? __pfx_kthread+0x10/0x10
[  253.019231]  ret_from_fork+0x3c/0x60
[  253.019468]  ? __pfx_kthread+0x10/0x10
[  253.019701]  ret_from_fork_asm+0x1a/0x30
[  253.019939]  </TASK>

v2: s/spin_trylock/spin_lock_irqsave to be safe (Christian).

Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: Zhigang Luo <zhigang.luo@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Minor context change fixed. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |    5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4144,7 +4144,6 @@ int amdgpu_device_init(struct amdgpu_dev
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
-	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -4170,6 +4169,7 @@ int amdgpu_device_init(struct amdgpu_dev
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
+	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
 
 	INIT_LIST_HEAD(&adev->reset_list);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1010,6 +1010,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgp
 	void *scratch_reg2;
 	void *scratch_reg3;
 	void *spare_int;
+	unsigned long flags;
 
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
 		dev_err(adev->dev,
@@ -1031,7 +1032,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgp
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
 
-	mutex_lock(&adev->virt.rlcg_reg_lock);
+	spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags);
 
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
@@ -1090,7 +1091,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgp
 
 	ret = readl(scratch_reg0);
 
-	mutex_unlock(&adev->virt.rlcg_reg_lock);
+	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -275,7 +275,8 @@ struct amdgpu_virt {
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
 
-	struct mutex rlcg_reg_lock;
+	/* Spinlock to protect access to the RLCG register interface */
+	spinlock_t rlcg_reg_lock;
 };
 
 struct amdgpu_video_codec_info;




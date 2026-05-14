Return-Path: <stable+bounces-247256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABveOBMIBmrFdwIAu9opvQ
	(envelope-from <stable+bounces-247256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:36:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA375455FE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902B3305C62C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A840390998;
	Thu, 14 May 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM6QD87x"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C4389454
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780098; cv=none; b=RauLHI57hh96Tw+ii5zWrKbqaNGzIXaeIcbC9BRagAD+bbDL1rESMCuL+yIVv4aqjpY2tKjWpAP8pwG8Vd4nHN1egrHqOftUpWgFi73pgKhMISu0WQEbkDN6dMreWohWPvyveAt+YY6+NB7Lm5LrP3+XyR9uNBU8TVk02QIO/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780098; c=relaxed/simple;
	bh=YTDNd6I6jxgC4FyzfyUFd/DKlyJTkC9SaUZkjawUs5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KeP+1wMv8fpOBU+eMYG/CjLOYhyf3V1ho152s5xVfi+R9HvYSariQWW9t0niwi8O/2vjQGm7jpoQNN4/YSyjsu3GL51see9yonkojwyf4sApZlAb7dUZlW8ALM/yH+ZE++8YG7a3ezFj7JcPR69ysm5jw486FQH8FOdB/ODpIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PM6QD87x; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7e06cbc08d6so21571953a34.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780093; x=1779384893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJZSwJgHW1qi/veTVjOv8141CX4bdbJfqSMVtdsHeyA=;
        b=PM6QD87xXJFM5re42QK2hkHQHvmrbevmt6HVrgr4GrCML4dBrdu5TgS1vKwogpEmLo
         w59iD+auuxd8BjKc9VLnmQfMT2Nb77Nz/d0hAyUO0WSnMgxRNh8mNk+PwWlaRvhqPskB
         B08e58y1m46zgfm2jn2vAffn6xZUlL8MBQbCqcYxHV15VwABwA50WS2u64as8Xs2gP9E
         XS6yfItRERgD5t53rLM1cgT54pqmxO1WAwaWcA0V81JdgqnFCO5Lt4UlJMbGrqfzgzHJ
         9+SSMJJcFdc22W6ylGUkSPzjOoTslP+feVMIe0DgnwUYE0p4ByGZm30MmUphPQtS9mTv
         Kpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780093; x=1779384893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJZSwJgHW1qi/veTVjOv8141CX4bdbJfqSMVtdsHeyA=;
        b=XKoGzcVVdctIaG4T8O3fKi5h2js0cSbROQ25n7gf0aVESdnfingmDhggW2Iqy8BpBa
         K1pEVdX1YavOYKzs64pD6gYraGB1+alfm0hvUQDW1zOwsMDAQUltw50cWSYJreiQD8BH
         6PWeebnYsIHrKmcCImV9EPeOaiFyomBEFaA4+F6L0SHaIJw8/yPFbMZPghQUDiIQnElU
         Q6HOQIYbci9DfWphhibMRfjumgVP+uBa97sv/YzyBa/P8ug9lc8gtOOZ911rmCiMcJ3R
         OoiKypY9oGrA88AJv6G3qyVXCMJKg/XBSnGh5pAlI9FoOdVdnzEC6FBLiUsXx9+XWX/0
         DsrA==
X-Forwarded-Encrypted: i=1; AFNElJ/pDftzDddauVfYNpYLu5aCPZJ2vtKYjKStNg9lo9yVc6XxF0nMiM34xUuWthuY7+/MqV2Ufnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfkydhWFqzuvowlDo6v7d5DLGti4UT2BpG0am7NLaGxeGmUbf
	sM6Ntp014ePIIgBhCYfr0y9Zt5ykpXoTkoVwpyiIU0wi0A13Ieu/KBoye5jnfXOzL5TLapvlu6P
	DdtwqiNSDmw==
X-Received: from ilqa16.prod.google.com ([2002:a05:6e02:1210:b0:4fa:a7a5:6571])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1511:b0:699:900d:7caf
 with SMTP id 006d021491bc7-69c9b433008mr233081eaf.47.1778780093121; Thu, 14
 May 2026 10:34:53 -0700 (PDT)
Date: Thu, 14 May 2026 17:34:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260514173449.3282188-1-rananta@google.com>
Subject: [PATCH v2] vfio/pci: Use a private flag to prevent power state change
 with VFs
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, stable@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3FA375455FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247256-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rananta@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current implementation uses pci_num_vf() while holding the
memory_lock to prevent changing the power state of a PF when
VFs are enabled. This creates a lockdep circular dependency
warning because memory_lock is held during device probing.

[  286.997167] ======================================================
[  287.003363] WARNING: possible circular locking dependency detected
[  287.009562] 7.0.0-dbg-DEV #3 Tainted: G S
[  287.015074] ------------------------------------------------------
[  287.021270] vfio_pci_sriov_/18636 is trying to acquire lock:
[  287.026942] ff45bea2294d4968 (&vdev->memory_lock){+.+.}-{4:4}, at:
vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.036530]
[  287.036530] but task is already holding lock:
[  287.042383] ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4}, at:
vfio_group_fops_unl_ioctl+0x44d/0x7b0
[  287.051879]
[  287.051879] which lock already depends on the new lock.
[  287.051879]
[  287.060070]
[  287.060070] the existing dependency chain (in reverse order) is:
[  287.067568]
[  287.067568] -> #2 (&new_dev_set->lock){+.+.}-{4:4}:
[  287.073941]        __mutex_lock+0x92/0xb80
[  287.078058]        vfio_assign_device_set+0x66/0x1b0
[  287.083042]        vfio_pci_core_register_device+0xd1/0x2a0
[  287.088638]        vfio_pci_probe+0xd2/0x100
[  287.092933]        local_pci_probe_callback+0x4d/0xa0
[  287.098001]        process_scheduled_works+0x2ca/0x680
[  287.103158]        worker_thread+0x1e8/0x2f0
[  287.107452]        kthread+0x10c/0x140
[  287.111230]        ret_from_fork+0x18e/0x360
[  287.115519]        ret_from_fork_asm+0x1a/0x30
[  287.119983]
[  287.119983] -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
[  287.127219]        __flush_work+0x345/0x490
[  287.131429]        pci_device_probe+0x2e3/0x490
[  287.135979]        really_probe+0x1f9/0x4e0
[  287.140180]        __driver_probe_device+0x77/0x100
[  287.145079]        driver_probe_device+0x1e/0x110
[  287.149803]        __device_attach_driver+0xe3/0x170
[  287.154789]        bus_for_each_drv+0x125/0x150
[  287.159346]        __device_attach+0xca/0x1a0
[  287.163720]        device_initial_probe+0x34/0x50
[  287.168445]        pci_bus_add_device+0x6e/0x90
[  287.172995]        pci_iov_add_virtfn+0x3c9/0x3e0
[  287.177719]        sriov_add_vfs+0x2c/0x60
[  287.181838]        sriov_enable+0x306/0x4a0
[  287.186038]        vfio_pci_core_sriov_configure+0x184/0x220
[  287.191715]        sriov_numvfs_store+0xd9/0x1c0
[  287.196351]        kernfs_fop_write_iter+0x13f/0x1d0
[  287.201338]        vfs_write+0x2be/0x3b0
[  287.205286]        ksys_write+0x73/0x100
[  287.209233]        do_syscall_64+0x14d/0x750
[  287.213529]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.219120]
[  287.219120] -> #0 (&vdev->memory_lock){+.+.}-{4:4}:
[  287.225491]        __lock_acquire+0x14c6/0x2800
[  287.230048]        lock_acquire+0xd3/0x2f0
[  287.234168]        down_write+0x3a/0xc0
[  287.238019]        vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.243436]        __rpm_callback+0x8c/0x310
[  287.247730]        rpm_resume+0x529/0x6f0
[  287.251765]        __pm_runtime_resume+0x68/0x90
[  287.256402]        vfio_pci_core_enable+0x44/0x310
[  287.261216]        vfio_pci_open_device+0x1c/0x80
[  287.265947]        vfio_df_open+0x10f/0x150
[  287.270148]        vfio_group_fops_unl_ioctl+0x4a4/0x7b0
[  287.275476]        __se_sys_ioctl+0x71/0xc0
[  287.279679]        do_syscall_64+0x14d/0x750
[  287.283975]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.289559]
[  287.289559] other info that might help us debug this:
[  287.289559]
[  287.297582] Chain exists of:
[  287.297582]   &vdev->memory_lock --> (work_completion)(&arg.work)
--> &new_dev_set->lock
[  287.297582]
[  287.310023]  Possible unsafe locking scenario:
[  287.310023]
[  287.315961]        CPU0                    CPU1
[  287.320510]        ----                    ----
[  287.325059]   lock(&new_dev_set->lock);
[  287.328917]
lock((work_completion)(&arg.work));
[  287.336153]                                lock(&new_dev_set->lock);
[  287.342523]   lock(&vdev->memory_lock);
[  287.346382]
[  287.346382]  *** DEADLOCK ***
[  287.346382]
[  287.352315] 2 locks held by vfio_pci_sriov_/18636:
[  287.357125]  #0: ff45bea208ed3e18 (&group->group_lock){+.+.}-{4:4},
at: vfio_group_fops_unl_ioctl+0x3e3/0x7b0
[  287.367048]  #1: ff45bea3a96b8230 (&new_dev_set->lock){+.+.}-{4:4},
at: vfio_group_fops_unl_ioctl+0x44d/0x7b0
[  287.376976]
[  287.376976] stack backtrace:
[  287.381353] CPU: 191 UID: 0 PID: 18636 Comm: vfio_pci_sriov_
Tainted: G S                  7.0.0-dbg-DEV #3 PREEMPTLAZY
[  287.381355] Tainted: [S]=CPU_OUT_OF_SPEC
[  287.381356] Call Trace:
[  287.381357]  <TASK>
[  287.381358]  dump_stack_lvl+0x54/0x70
[  287.381361]  print_circular_bug+0x2e1/0x300
[  287.381363]  check_noncircular+0xf9/0x120
[  287.381364]  ? __lock_acquire+0x5b4/0x2800
[  287.381366]  __lock_acquire+0x14c6/0x2800
[  287.381368]  ? pci_mmcfg_read+0x4f/0x220
[  287.381370]  ? pci_mmcfg_write+0x57/0x220
[  287.381371]  ? lock_acquire+0xd3/0x2f0
[  287.381373]  ? pci_mmcfg_write+0x57/0x220
[  287.381374]  ? lock_release+0xef/0x360
[  287.381376]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381377]  lock_acquire+0xd3/0x2f0
[  287.381378]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381379]  ? lock_is_held_type+0x76/0x100
[  287.381382]  down_write+0x3a/0xc0
[  287.381382]  ? vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381383]  vfio_pci_core_runtime_resume+0x1f/0xa0
[  287.381384]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  287.381385]  __rpm_callback+0x8c/0x310
[  287.381386]  ? ktime_get_mono_fast_ns+0x3d/0xb0
[  287.381389]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  287.381390]  rpm_resume+0x529/0x6f0
[  287.381392]  ? lock_is_held_type+0x76/0x100
[  287.381394]  __pm_runtime_resume+0x68/0x90
[  287.381396]  vfio_pci_core_enable+0x44/0x310
[  287.381398]  vfio_pci_open_device+0x1c/0x80
[  287.381399]  vfio_df_open+0x10f/0x150
[  287.381401]  vfio_group_fops_unl_ioctl+0x4a4/0x7b0
[  287.381402]  __se_sys_ioctl+0x71/0xc0
[  287.381404]  do_syscall_64+0x14d/0x750
[  287.381405]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.381406]  ? trace_irq_disable+0x25/0xd0
[  287.381409]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Introduce a private flag 'sriov_active' in the vfio_pci_core_device
struct. This  allows the driver to track the SR-IOV power state requirement
without  relying on pci_num_vf() while holding the memory_lock. The lock is
now  only held to set the flag and ensure the device is in D0, after which
pci_enable_sriov() can be called without the lock.

Fixes: f4162eb1e2fc ("vfio/pci: Change the PF power state to D0 before enabling VFs")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++++---
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8a..2fb95f54a1e26 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -271,8 +271,11 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	int ret;
 
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (pci_num_vf(pdev) && state > PCI_D0)
-		return -EBUSY;
+	if (state > PCI_D0) {
+		lockdep_assert_held_write(&vdev->memory_lock);
+		if (vdev->sriov_active)
+			return -EBUSY;
+	}
 
 	if (vdev->needs_pm_restore) {
 		if (pdev->current_state < PCI_D3hot && state >= PCI_D3hot) {
@@ -2292,8 +2295,9 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 
 		down_write(&vdev->memory_lock);
 		vfio_pci_set_power_state(vdev, PCI_D0);
-		ret = pci_enable_sriov(pdev, nr_virtfn);
+		vdev->sriov_active = true;
 		up_write(&vdev->memory_lock);
+		ret = pci_enable_sriov(pdev, nr_virtfn);
 		if (ret) {
 			pm_runtime_put(&pdev->dev);
 			goto out_del;
@@ -2307,6 +2311,13 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	}
 
 out_del:
+	/*
+	 * Avoid taking the memory_lock intentionally. A race with a power
+	 * state transition would at most result in an -EBUSY, leaving the
+	 * device in PCI_D0.
+	 */
+	vdev->sriov_active = false;
+
 	mutex_lock(&vfio_pci_sriov_pfs_mutex);
 	list_del_init(&vdev->sriov_pfs_item);
 out_unlock:
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f7..f1451ee4744ac 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			sriov_active:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.631.ge1b05301d1-goog



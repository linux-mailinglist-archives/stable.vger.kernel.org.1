Return-Path: <stable+bounces-18251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA928481FB
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C9A1C20D2D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011C18E1D;
	Sat,  3 Feb 2024 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WY4MfbzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D43ACB;
	Sat,  3 Feb 2024 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933660; cv=none; b=gDlMo1lo3SWbh8EPsU3acUbTZWwXefVHiPcYhk7TNji628iuKqCnho+nOsyvioyrVHuombrA+FLwLaCwlFvTg/2FcsGhNvYBpMS5SrmDVqsdh7bpi+9putXc0tGybjKR7KyWs0Cwru0aYJ31NpZv48NnAz8XD4i+e2VOvjxyLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933660; c=relaxed/simple;
	bh=bwtWifbC9LNP+NwhVtjklSCRWkmMK3dENrKv8NHV36A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCj6Y9a70iUrhCHWDMAHSeYJn1zgk7U9S9/PkidGMinSENDTqjojYSfdZp/1U4YzikxQV0dLlxd1ce/Q8JIIfUw1cU7EAzJnCKmf8UgokULX2+QvgO7eKrEV/0hDjIuRHwarQgicSmSWNAPEbkHxrSFR0p6LQXd66R8lI+HTz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WY4MfbzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898B8C433F1;
	Sat,  3 Feb 2024 04:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933659;
	bh=bwtWifbC9LNP+NwhVtjklSCRWkmMK3dENrKv8NHV36A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WY4MfbzM5N6UUrxRT/E+Pq2RlX03E8lUNFesTanT1dVdpdOEEhtwcfw27ydZmPwxd
	 AfnB5jciWzV37txJGg3uFSqqS8DRKmxsT19LyZzAazeEWuOaqCJ8ZEAVlEDyjKr9jD
	 Ftm244D23XEsG2YCp9NqbNZJPtYWwxq7rubbKMX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 247/322] drm/amdkfd: Fix lock dependency warning with srcu
Date: Fri,  2 Feb 2024 20:05:44 -0800
Message-ID: <20240203035407.153279378@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 2a9de42e8d3c82c6990d226198602be44f43f340 ]

======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-yangp #2289 Not tainted
------------------------------------------------------
kworker/0:2/996 is trying to acquire lock:
        (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x5/0x1a0

but task is already holding lock:
        ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}, at:
	process_one_work+0x211/0x560

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        svm_range_list_lock_and_flush_work+0x3d/0x110 [amdgpu]
        svm_range_set_attr+0xd6/0x14c0 [amdgpu]
        kfd_ioctl+0x1d1/0x630 [amdgpu]
        __x64_sys_ioctl+0x88/0xc0

-> #2 (&info->lock#2){+.+.}-{3:3}:
        __mutex_lock+0x99/0xc70
        amdgpu_amdkfd_gpuvm_restore_process_bos+0x54/0x740 [amdgpu]
        restore_process_helper+0x22/0x80 [amdgpu]
        restore_process_worker+0x2d/0xa0 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

-> #1 ((work_completion)(&(&process->restore_work)->work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        __cancel_work_timer+0x12c/0x1c0
        kfd_process_notifier_release_internal+0x37/0x1f0 [amdgpu]
        __mmu_notifier_release+0xad/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        do_exit+0x322/0xb90
        do_group_exit+0x37/0xa0
        __x64_sys_exit_group+0x18/0x20
        do_syscall_64+0x38/0x80

-> #0 (srcu){.+.+}-{0:0}:
        __lock_acquire+0x1521/0x2510
        lock_sync+0x5f/0x90
        __synchronize_srcu+0x4f/0x1a0
        __mmu_notifier_release+0x128/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        svm_range_deferred_list_work+0x19f/0x350 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

other info that might help us debug this:
Chain exists of:
  srcu --> &info->lock#2 --> (work_completion)(&svms->deferred_list_work)

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
        lock((work_completion)(&svms->deferred_list_work));
                        lock(&info->lock#2);
			lock((work_completion)(&svms->deferred_list_work));
        sync(srcu);

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a4c911fa1675..b51224a85a38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2343,8 +2343,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
 
-		/* Pairs with mmget in svm_range_add_list_work */
-		mmput(mm);
+		/* Pairs with mmget in svm_range_add_list_work. If dropping the
+		 * last mm refcount, schedule release work to avoid circular locking
+		 */
+		mmput_async(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
-- 
2.43.0





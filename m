Return-Path: <stable+bounces-128105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D3A7AF45
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B87189B859
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B023C8D1;
	Thu,  3 Apr 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLtO7UHv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE423C8CA;
	Thu,  3 Apr 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707980; cv=none; b=srv9HnKFH44TYpR2/pjH0hoiFeXCM4dg1VEOqaDgaRn+EVPmBiV0XAdcVWfvNj91WbSJ0hUs+9UU55Apjo7oaBmB4ApnOo+1Pc86hvZbUtgiNjGKjqwMZq6swf665j5E/CJizCiR8IMT2gwkFC+2myl9OS0/2LxdKLFOFkrtvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707980; c=relaxed/simple;
	bh=PgnUp57nbSLgIVLWQWjVY9Gmoz+uXHJK+CkYC9Zf010=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4R9LhmPAUV9pj3lWlF7ocC5dxE4CAO73SLqBCcAqUoM6PNCfpqlSODRjbxFNaJAx9Kt9j2keWV8UoKGmxw53LND5dZ3MznZjwkVVxK1DHr4yxpLFJRZjdBvBogz0f9MRO3nPgc7N1kiHEOsQICLsdmB09gV87456285YhckVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLtO7UHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF38C4CEE3;
	Thu,  3 Apr 2025 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707980;
	bh=PgnUp57nbSLgIVLWQWjVY9Gmoz+uXHJK+CkYC9Zf010=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLtO7UHvNTFeV6kZJGPUa8B0X4pvQjBEurbBsuA/k0kxkzycasDl6CTLnazGUb88z
	 ChNxXzOgp1HOGVndPnLoqJdTINgcR2c2EVaMzVpXPQMbQvZ/kLC4+MjEV3uKVWGCpq
	 gwJLn3p3U0P++LMjT8DuET6fOuqfhefraHTQRaNnGScQG61f4Qq54DbEefZZqZk2si
	 pnewAoFdphTticBAVwJSB8j+dlwukZblyaxTDmDwsgfrQg/SarzVDo2OEvYHHJFcZ4
	 iatq9UOsOBaKNg4N8cZJrDahhL03W2/Q9Ei1t6IP425rQzrt6VZ8AX1rXJ1UdzwmQv
	 0bjx7cs5D6LaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 11/20] drm/amdkfd: Fix mode1 reset crash issue
Date: Thu,  3 Apr 2025 15:19:04 -0400
Message-Id: <20250403191913.2681831-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit f0b4440cdc1807bb6ec3dce0d6de81170803569b ]

If HW scheduler hangs and mode1 reset is used to recover GPU, KFD signal
user space to abort the processes. After process abort exit, user queues
still use the GPU to access system memory before h/w is reset while KFD
cleanup worker free system memory and free VRAM.

There is use-after-free race bug that KFD allocate and reuse the freed
system memory, and user queue write to the same system memory to corrupt
the data structure and cause driver crash.

To fix this race, KFD cleanup worker terminate user queues, then flush
reset_domain wq to wait for any GPU ongoing reset complete, and then
free outstanding BOs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 99e2aef52ef26..bc01c5173ab9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -36,6 +36,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1114,6 +1115,17 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	p->kobj = NULL;
 }
 
+/*
+ * If any GPU is ongoing reset, wait for reset complete.
+ */
+static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+{
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++)
+		flush_workqueue(p->pdds[i]->dev->adev->reset_domain->wq);
+}
+
 /* No process locking is needed in this function, because the process
  * is not findable any more. We must assume that no other thread is
  * using it any more, otherwise we couldn't safely free the process
@@ -1127,6 +1139,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
 
+	/*
+	 * If GPU in reset, user queues may still running, wait for reset complete.
+	 */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	/* Signal the eviction fence after user mode queues are
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
-- 
2.39.5



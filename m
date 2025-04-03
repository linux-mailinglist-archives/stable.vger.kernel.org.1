Return-Path: <stable+bounces-128018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1787A7AE2B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6469F3B1106
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7981FDE2B;
	Thu,  3 Apr 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmZhy8YV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6A1FDA89;
	Thu,  3 Apr 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707774; cv=none; b=jVB2qGrm3UzGIenvCxc9HmLVjfk6XqaVcPXdMNeVvd42nZ29n+KZWSJ6BDa01WPXeGflfwizP/PRwMC2ql2Z1g3l0H0H3zCzxN51hiRjlaauu220SoQVrYrnctwy7a7lLNPhjMq2aFS0hmM76wSOfjEMGpg+/9IDqkJjwuNxf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707774; c=relaxed/simple;
	bh=TziropcmlcEQtE2tYqfRyuWVQKMkyXaxjKkkuUMecb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+PXedZnApcbgOaDtzW489jTmc2C0OFO5wYt+sC/Dh2rrYuW5UXPeGzorjY2QDdRUwJnwh/Rt7hNUdvUS0boQs4CPnnc0Zem5B5icfMfOZAQa+/vBpE8URSEqrZva9CPDcZZYrc68pG0fcHdIwAHCD8vNWLUDx8/gZ+LtcXuQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmZhy8YV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D03C4CEE8;
	Thu,  3 Apr 2025 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707774;
	bh=TziropcmlcEQtE2tYqfRyuWVQKMkyXaxjKkkuUMecb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmZhy8YVo+r8dvr24XmO2xIocoeW6+6BZBYV3sxb+1miWhc1KsuQ4D6hw6ph71oX3
	 t8LsLIRtfx/V6bsbAC4Ri3ecbE/REQLiwIwjwT8majFlV4MyPLCod1ZWQmCESkiWFH
	 PLwuP+6BvXQP02WORS/aPjV982PL3ScmwTYfR5SiQhFyZQ/aQ8lu6WNRka87VKOAfY
	 90vaVOAwD9ImdKKqo7UVd3f1lCxgBjrAfVr5pvu+sCy+KflvhpVKuxPWSpKop7wjMH
	 1PRhkVUYqjuYkw0FI7tZzfU0uOiNYhbhh8KMy4HuQaqo8kaIMgzY6jzHzOjyiHa+yb
	 q4onmduBZvzUg==
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
Subject: [PATCH AUTOSEL 6.13 19/37] drm/amdkfd: Fix mode1 reset crash issue
Date: Thu,  3 Apr 2025 15:14:55 -0400
Message-Id: <20250403191513.2680235-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index edfe0b4788f44..211e268d10ab9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1140,6 +1141,17 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
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
@@ -1154,6 +1166,11 @@ static void kfd_process_wq_release(struct work_struct *work)
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



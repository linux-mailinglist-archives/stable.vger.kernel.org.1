Return-Path: <stable+bounces-3934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687E803FA4
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59AB281204
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125535F0B;
	Mon,  4 Dec 2023 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/iSupNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697335EFA
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F825C433C8;
	Mon,  4 Dec 2023 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722086;
	bh=kGmYZKKHc1s6cB5eQD5BL2iS9W5aMoe4n0+Po34UR8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/iSupNOxv7bi7dV4w6aEkxxc9GfsGdhfhhwAlb1ssPhx3bB1S8bBU7MhhZFGZbqt
	 NEIWHnuhOO/Kzf6i3WBUjrqhqGrHL85tPSeoHaSdbeIzE7e+horYUsqJUlJhVcKYqs
	 NAhstG2oBR9Pw17tSA1FYg10yk6rzhn4RfPabzh6zValHSbIo0iU9AS4otkg47ejvC
	 B+DLSuCKBbwbsQjXybsaHsOBu2z+Ayu/+eIMAovNi6QQBtRaBmI6SUOEvbrToBciS3
	 IBs2xQfMLFTtVg55GDCZQ1bn2Tn8hoWg600253qXCK8tiiFZ8vtD7OPETaQC4P/Eb0
	 6LtIjqJPp7bZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 27/32] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Date: Mon,  4 Dec 2023 15:32:47 -0500
Message-ID: <20231204203317.2092321-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: ZhenGuo Yin <zhenguo.yin@amd.com>

[ Upstream commit 72838777aa38352e20301e123b97110c456cd38e ]

[Why]
Memory leaks of gang_ctx_bo and wptr_bo.

[How]
Free gang_ctx_bo and wptr_bo in pqm_uninit.

v2: add a common function pqm_clean_queue_resource to
free queue's resources.
v3: reset pdd->pqd.num_gws when destorying GWS queue.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index adb5e4bdc0b20..7d0f887d99558 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -169,16 +169,43 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
+				     struct process_queue_node *pqn)
+{
+	struct kfd_node *dev;
+	struct kfd_process_device *pdd;
+
+	dev = pqn->q->device;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return;
+	}
+
+	if (pqn->q->gws) {
+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+		pdd->qpd.num_gws = 0;
+	}
+
+	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		if (pqn->q->wptr_bo)
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+	}
+}
+
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-		    !pqn->q->device->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+		if (pqn->q)
+			pqm_clean_queue_resource(pqm, pqn);
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
@@ -460,22 +487,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 
-		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-			    !dev->kfd->shared_resources.enable_mes)
-				amdgpu_amdkfd_remove_gws_from_process(
-						pqm->process->kgd_process_info,
-						pqn->q->gws);
-			pdd->qpd.num_gws = 0;
-		}
-
-		if (dev->kfd->shared_resources.enable_mes) {
-			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
-			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-
-		}
+		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.42.0



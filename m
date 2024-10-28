Return-Path: <stable+bounces-88419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78D9B25E8
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F277D1C2040E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298918E744;
	Mon, 28 Oct 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sDsRgUWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C818DF68;
	Mon, 28 Oct 2024 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097289; cv=none; b=p/OR6k5ZnD6dP3dTqLN4bZFSlJTe0BCaQQ2sjEa9VVFsDaU4vYQrcXJIUFZBhPdJuejvaBr+gXxlzE03WlYMOVCtLBtdxIrvnKnjaRxcv06iQE9dHt2y2MfxYFTMV2n6U7xNmOpgl40AG0PdiszfDtugewAACoUNt3aVxyKKRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097289; c=relaxed/simple;
	bh=ODY50/aNALJ6i4V5K883hLR2CcRhg2oYzN7b96qIBaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eitShd9KUepq4ObruTrCBwNzwyC/QS1MGWkgWDikDCOQrFhVrUs98PvBgAjS3TZhbO9KEFQIL/nPvjTK8d6NRny2Gmps1BTycwmBcrEOtRYC1bdVGiOpk8rfd+xnvXnSOh/7wLpSi+XPg1ZinjtCHbrj5s18vkBi5QkJkt6ES/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sDsRgUWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774EAC4CEC3;
	Mon, 28 Oct 2024 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097288;
	bh=ODY50/aNALJ6i4V5K883hLR2CcRhg2oYzN7b96qIBaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDsRgUWF7se1k2nXBzj40v+wHLoBNL4wKd15JuY3tckkcorFyOW9Wxmo008rNNNi6
	 gKXJw3z6Zms3WtcOjHwfLoBJSEgb3cOp+8QxQYD9q+0Z/xIjo99xM5YAJO+7Wbrfzr
	 rT8uTH56vTWik0v74TJ/ZqKq+77xPBhYA/NH61qM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Jack Xiao <Jack.Xiao@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/137] drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring
Date: Mon, 28 Oct 2024 07:24:26 +0100
Message-ID: <20241028062259.537106797@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit e7457532cb7167516263150ceae86f36d6ef9683 ]

This patch addresses a double unlock issue in the amdgpu_mes_add_ring
function. The mutex was being unlocked twice under certain error
conditions, which could lead to undefined behavior.

The fix ensures that the mutex is unlocked only once before jumping to
the clean_up_memory label. The unlock operation is moved to just before
the goto statement within the conditional block that checks the return
value of amdgpu_ring_init. This prevents the second unlock attempt after
the clean_up_memory label, which is no longer necessary as the mutex is
already unlocked by this point in the code flow.

This change resolves the potential double unlock and maintains the
correct mutex handling throughout the function.

Fixes below:
Commit d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue
submission"), leads to the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1240 amdgpu_mes_add_ring()
	warn: double unlock '&adev->mes.mutex_hidden' (orig line 1213)

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
    1143 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
    1144                         int queue_type, int idx,
    1145                         struct amdgpu_mes_ctx_data *ctx_data,
    1146                         struct amdgpu_ring **out)
    1147 {
    1148         struct amdgpu_ring *ring;
    1149         struct amdgpu_mes_gang *gang;
    1150         struct amdgpu_mes_queue_properties qprops = {0};
    1151         int r, queue_id, pasid;
    1152
    1153         /*
    1154          * Avoid taking any other locks under MES lock to avoid circular
    1155          * lock dependencies.
    1156          */
    1157         amdgpu_mes_lock(&adev->mes);
    1158         gang = idr_find(&adev->mes.gang_id_idr, gang_id);
    1159         if (!gang) {
    1160                 DRM_ERROR("gang id %d doesn't exist\n", gang_id);
    1161                 amdgpu_mes_unlock(&adev->mes);
    1162                 return -EINVAL;
    1163         }
    1164         pasid = gang->process->pasid;
    1165
    1166         ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
    1167         if (!ring) {
    1168                 amdgpu_mes_unlock(&adev->mes);
    1169                 return -ENOMEM;
    1170         }
    1171
    1172         ring->ring_obj = NULL;
    1173         ring->use_doorbell = true;
    1174         ring->is_mes_queue = true;
    1175         ring->mes_ctx = ctx_data;
    1176         ring->idx = idx;
    1177         ring->no_scheduler = true;
    1178
    1179         if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
    1180                 int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
    1181                                       compute[ring->idx].mec_hpd);
    1182                 ring->eop_gpu_addr =
    1183                         amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
    1184         }
    1185
    1186         switch (queue_type) {
    1187         case AMDGPU_RING_TYPE_GFX:
    1188                 ring->funcs = adev->gfx.gfx_ring[0].funcs;
    1189                 ring->me = adev->gfx.gfx_ring[0].me;
    1190                 ring->pipe = adev->gfx.gfx_ring[0].pipe;
    1191                 break;
    1192         case AMDGPU_RING_TYPE_COMPUTE:
    1193                 ring->funcs = adev->gfx.compute_ring[0].funcs;
    1194                 ring->me = adev->gfx.compute_ring[0].me;
    1195                 ring->pipe = adev->gfx.compute_ring[0].pipe;
    1196                 break;
    1197         case AMDGPU_RING_TYPE_SDMA:
    1198                 ring->funcs = adev->sdma.instance[0].ring.funcs;
    1199                 break;
    1200         default:
    1201                 BUG();
    1202         }
    1203
    1204         r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
    1205                              AMDGPU_RING_PRIO_DEFAULT, NULL);
    1206         if (r)
    1207                 goto clean_up_memory;
    1208
    1209         amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
    1210
    1211         dma_fence_wait(gang->process->vm->last_update, false);
    1212         dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
    1213         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1214
    1215         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    1216         if (r)
    1217                 goto clean_up_ring;
                         ^^^^^^^^^^^^^^^^^^

    1218
    1219         ring->hw_queue_id = queue_id;
    1220         ring->doorbell_index = qprops.doorbell_off;
    1221
    1222         if (queue_type == AMDGPU_RING_TYPE_GFX)
    1223                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
    1224         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    1225                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    1226                         queue_id);
    1227         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    1228                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    1229                         queue_id);
    1230         else
    1231                 BUG();
    1232
    1233         *out = ring;
    1234         return 0;
    1235
    1236 clean_up_ring:
    1237         amdgpu_ring_fini(ring);
    1238 clean_up_memory:
    1239         kfree(ring);
--> 1240         amdgpu_mes_unlock(&adev->mes);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    1241         return r;
    1242 }

Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Suggested-by: Jack Xiao <Jack.Xiao@amd.com>
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bfaf1883605fd0c0dbabacd67ed49708470d5ea4)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9a4cbfbd5d9e5..3feb792c210d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1038,8 +1038,10 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 
 	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
+	if (r) {
+		amdgpu_mes_unlock(&adev->mes);
 		goto clean_up_memory;
+	}
 
 	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
 
@@ -1072,7 +1074,6 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	amdgpu_ring_fini(ring);
 clean_up_memory:
 	kfree(ring);
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
-- 
2.43.0





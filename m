Return-Path: <stable+bounces-65930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236D94AD9C
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015E61F212E2
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28813664E;
	Wed,  7 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+Q5NgXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94E84D0F
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046648; cv=none; b=KPs1BEtZrTarJi+jAek9mdtaFx2RGtF7n/YuHUlIQqtLccj5BFOiDcNeaW9IRVR9PaNsmpDZGWi6DaDJyWw5z32JAUWEthMds9oHuQ5aLQfGwq2wi8E1/fkFH28SiATQqS+Bd7JUY5EG8bdbHgTrFV0HBCr08axnefTXwQBTH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046648; c=relaxed/simple;
	bh=E2enmt31UZhVAWEGkBMRSyUhCB0FwtsK1zpFNz/jAJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlB+Idff5x9vs/wyo6/I2aOrdTSvsS0DKSPBPZRMiFw7HrH1EvFiQfCCxNx22F9j2e1HkI+mcj16hwTyXlVIodygHE9I2nb7jZRNXaL+vNDtkT1f374tvuKmFjUCBlSlc0M6+uv8IIhIXZtq6UkNix5PLBqcn0DZtqrmXMGjiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+Q5NgXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB255C32781;
	Wed,  7 Aug 2024 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046647;
	bh=E2enmt31UZhVAWEGkBMRSyUhCB0FwtsK1zpFNz/jAJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+Q5NgXpImcWSfk+ngPEVwhqgkfMc7KqYa3d772Bc9PtCY8HUD0RSSdWX1HJQBsl3
	 y3uag/rZpZ4NOMOWEeO4VDC/EVlzBvZnUbbQ3uOk5HPxY9a2V23h5FfIFJbNRVsxcG
	 aMuc9Vcrj00QU/+FouLPwJw1Li1uKi3z6W1FZUdefQCQ0fyesqUTV7k8L2xqZ4DUnp
	 NhTfEkupodS+R254QPBOcsbzcKUAapx0pGhSUBBzhkGHhGmABsbM0lGv9tyamxwYh0
	 lSdRoBCQeMvpEJTf0o067n9ginkrfbzr/uWbEn76GqNhqAmQEwbStJu7VSNUTiYemX
	 UP75MV4KibRog==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.6.y] nouveau: set placement to original placement on uvmm validate.
Date: Wed,  7 Aug 2024 18:03:42 +0200
Message-ID: <20240807160341.2476-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080722-overlying-unmasking-3eb7@gregkh>
References: <2024080722-overlying-unmasking-3eb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

When a buffer is evicted for memory pressure or TTM evict all,
the placement is set to the eviction domain, this means the
buffer never gets revalidated on the next exec to the correct domain.

I think this should be fine to use the initial domain from the
object creation, as least with VM_BIND this won't change after
init so this should be the correct answer.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240515025542.2156774-1-airlied@gmail.com
(cherry picked from commit 9c685f61722d30a22d55bb8a48f7a48bb2e19bcc)
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2bbcdc649e86..3d41e590d471 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1320,6 +1320,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 
 		drm_gpuva_for_each_op(va_op, op->ops) {
 			struct drm_gem_object *obj = op_gem_obj(va_op);
+			struct nouveau_bo *nvbo;
 
 			if (unlikely(!obj))
 				continue;
@@ -1330,8 +1331,9 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			if (unlikely(va_op->op == DRM_GPUVA_OP_UNMAP))
 				continue;
 
-			ret = nouveau_bo_validate(nouveau_gem_object(obj),
-						  true, false);
+			nvbo = nouveau_gem_object(obj);
+			nouveau_bo_placement_set(nvbo, nvbo->valid_domains, 0);
+			ret = nouveau_bo_validate(nvbo, true, false);
 			if (ret) {
 				op = list_last_op(&bind_job->ops);
 				goto unwind;
-- 
2.45.2



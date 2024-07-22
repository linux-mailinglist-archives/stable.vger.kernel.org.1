Return-Path: <stable+bounces-60715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4059393CA
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAFC1C2171E
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361F171068;
	Mon, 22 Jul 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SxmM8uWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85C17083F
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673809; cv=none; b=u7H1u1XMSachf9o5rVX+WaLrAsUPRZah0kC5muOKvtMouNbr46Kt9oP4ZNbgqCPBTm93QRTicFwfc8fjpw9vh0l77UweMhfnLs4GscPzKSVVk5NmSid8SvtnGcRiqIPmhKc6GzMzi/uFTjxC0Xn852Voo9MoU2ognsWSBe/K3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673809; c=relaxed/simple;
	bh=YHzqrAdloR6U56aPhAmQrH0b7xWUAEW4c7b27neLdLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SruY4B2Og0buX2t7ljvi2T5AFFVG+e0Lu93rMAM7CynZrWrnuV7WeF2b42jR3M3eL1/n2nkxzH269PlE53C1JhYh0xE79WZfbByRo0oBAZ6HTSoQTJFpqKGDctiKPe893jy36xcrUX3a4IzTFPph2Tj+DoLtl0/UhRlYMEADq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SxmM8uWI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f323f084eso285081385a.3
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721673804; x=1722278604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=SxmM8uWI8o93EIsKkfUIahrFLI8e48Wze3IysJxDKCO9ZESnanldLjWvYJOS+hrpSy
         5LJWYvskvuv+roiDWo+c+8ueSVNBZVzbRekaJjYgvXVcCN1r8zqqCLbChJ+r5lfmz80S
         /5AlX4IeAvBbAKfur9WTdKMYYI7X978a0qnQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673804; x=1722278604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=TBKQilyA+nr4IqU06om5ytei0hl+RsbNVCCHijzHNd0Kh0+L38pFNczi9SmnYgxr2l
         TwmlQhID2WvBLhctYO8iumzwo9c3IL5hAY1E45DpoLZvy5nmSjiWYWbPNrSpYQd0BmUr
         9e7RT/jsb5npTuOAOc83WOvhnB6qHTV4e/56k8uO+H8LwidpG+bCNkhmet4/IDWbdi0g
         nAV5AJHupQ+K7DwJekbJ6DX72+qc9v/iVkU+5KyqzIYDvNFfsWmCuiZQx1wVqluGfja3
         jDd1ynDb3n2AIlnI+k8tCTcICvOMUavY6fl/kxwE1A83XTUd5FsmOWAh1jsZAmTWVGB6
         T4VA==
X-Forwarded-Encrypted: i=1; AJvYcCXsRS3NcXR4U3eb9mBYl6HZZhPVd08XL5HH7XqTAJ+zL8r+n0AkTNjwA80O5ryT3HEX2KrJ9GFhS160L8BFYbbWNMZz2N/n
X-Gm-Message-State: AOJu0YwvM4VoNa/Agznd7Vcffp1eyqxukIQP06TYs5C1dZBFRstRUJyT
	eGO0w1wKcrx4fP58g6aEZXJDnluFwobklNRGt7KGkpCmTDdtU8iB1Y7hJH04IQ==
X-Google-Smtp-Source: AGHT+IFF/GbzZPq76eDZtucxkmDivWerAfkitA5HZ2DK3idQSjKvXTXA7UuPHqhVfUTIICxlmpmRTQ==
X-Received: by 2002:a05:6214:5093:b0:6b7:6544:c004 with SMTP id 6a1803df08f44-6b96106e06emr110345866d6.1.1721673804048;
        Mon, 22 Jul 2024 11:43:24 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acafdb01sm38261466d6.129.2024.07.22.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:43:23 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
Date: Mon, 22 Jul 2024 14:41:13 -0400
Message-ID: <20240722184313.181318-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722184313.181318-1-zack.rusin@broadcom.com>
References: <20240722184313.181318-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a version of the fence ops that on release doesn't remove
the fence from the pending list, and thus doesn't require a lock to
fix poll->fence wait->fence unref deadlocks.

vmwgfx overwrites the wait callback to iterate over the list of all
fences and update their status, to do that it holds a lock to prevent
the list modifcations from other threads. The fence destroy callback
both deletes the fence and removes it from the list of pending
fences, for which it holds a lock.

dma buf polling cb unrefs a fence after it's been signaled: so the poll
calls the wait, which signals the fences, which are being destroyed.
The destruction tries to acquire the lock on the pending fences list
which it can never get because it's held by the wait from which it
was called.

Old bug, but not a lot of userspace apps were using dma-buf polling
interfaces. Fix those, in particular this fixes KDE stalls/deadlock.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 2298e804e96e ("drm/vmwgfx: rework to new fence interface, v2")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 5efc6a766f64..588d50ababf6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -124,13 +123,13 @@ static void vmw_fence_obj_destroy(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
-
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
-	spin_lock(&fman->lock);
-	list_del_init(&fence->head);
-	--fman->num_fence_objects;
-	spin_unlock(&fman->lock);
+	if (!list_empty(&fence->head)) {
+		spin_lock(&fman->lock);
+		list_del_init(&fence->head);
+		spin_unlock(&fman->lock);
+	}
 	fence->destroy(fence);
 }
 
@@ -257,7 +256,6 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
-
 /*
  * Execute signal actions on fences recently signaled.
  * This is done from a workqueue so we don't have to execute
@@ -355,7 +353,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -403,7 +400,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 				      u32 passed_seqno)
 {
 	u32 goal_seqno;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -413,7 +410,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_fence_goal_write(fman->dev_priv,
-- 
2.43.0



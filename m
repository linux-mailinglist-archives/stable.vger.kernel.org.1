Return-Path: <stable+bounces-60566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6393509C
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221F21C2132B
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134214375A;
	Thu, 18 Jul 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZQoaUu/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121662F877
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319765; cv=none; b=i5hbuVtNaAP0OopAcCbctKVmRntbsNidmHo9GVe2tH2HkVb1ipzEwwfbNs1aWdLhXdXj7O7giJdR3QmmTS2OTh9yekBjRDY+kZRBgffDuVS1IDznOiHJh4YCfW3dHSvYpAZAvk1hPAgc2hPOWLfWJbkOD8lCStyqsw3JCgOYPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319765; c=relaxed/simple;
	bh=YHzqrAdloR6U56aPhAmQrH0b7xWUAEW4c7b27neLdLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJRyqwhf//m4uTYndQlRPZpcGksDXKRhoxA80vrQfZf+1N1iQi0iftIdKyx/gyNSKWtYIJ/nh+wVUC/J+AyrnKWtgUF6+gep3crTmotZaAln0D+kMnTfE/fE5F9WKUSXKipTFn3SOS+swTG8K+cOnxJkZ7s0f3JQVfpDFDqj3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZQoaUu/4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79ef8e0c294so35739385a.1
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721319763; x=1721924563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=ZQoaUu/43NLjhJlwp6kDmUr9nybHRuhg4bO/e+c0HbbngxdprNCwMx+4y9WIqhKkJ5
         e0lSXg2k8mX8gkvr93rRjO15LZ2DsjX6hDyht1oy9cHdq5rGZUUnuFv5qEqH6RJiAoE/
         dWMKdsFj6NnzROWdepPaoY+s68I6bzdFR3+KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721319763; x=1721924563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=ahsYjYh3TlZDGSwlDFjra+Xih6IvuqilpMY/PPXBz/mP5WqYAaXP2Zbj41Pwq63kBF
         YOX1USF5nUu2PJPDGITLrhvRwv+kc1h6J75mk+mef2tJvUoTYXWjXoQBh70whmVEkkq3
         sQ0mDTuVxTmXkVBK5/qpioPxD878G5AtktV9maCoONHkckueApS45xTG0cNcfymbvLyI
         umlvW3QEvHElzK5CluIrl34izqQsC948I+YmvNBdo15BV+uNu4ujp0Ouq3O01o/qQ4V3
         WkXyvMZ1CeNl1bPaPDc7uZRMEShL5xM5pAqxHAtQE70qSi21FbpejsGE8POA2wWCmd/N
         SE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6X9bK9O0lx5eBnRyzhQZ8EYc6ubo8nCGxeyyHuGCbntO8p0zYxZztcfSIKCJ50XxwG60JdPMdXBI3QhpPXtKgqess3rY
X-Gm-Message-State: AOJu0YxLywTwxM5Aan/t9iA84MjutjWpRtQAI7W2gKCYXnuRjD8ZLcXI
	tfJ7gclrb1h4+826bZ4Zg0WxMBYKk1BBIwZkKqeDG7JRNnq/y4Y5NEbf6043CA==
X-Google-Smtp-Source: AGHT+IEdl8+RC76OQ/SK31nHszE9Isn3wn4hK4Trz7TXZp/OrJK0xyKEU1+KUSPfdLdKypd2qSoYYA==
X-Received: by 2002:a05:620a:4481:b0:79f:12e9:1e51 with SMTP id af79cd13be357-7a193af1430mr250841485a.5.1721319762918;
        Thu, 18 Jul 2024 09:22:42 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1938f8ae8sm39988285a.70.2024.07.18.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:22:42 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
Date: Thu, 18 Jul 2024 12:21:41 -0400
Message-ID: <20240718162239.13085-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718162239.13085-1-zack.rusin@broadcom.com>
References: <20240718162239.13085-1-zack.rusin@broadcom.com>
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



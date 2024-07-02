Return-Path: <stable+bounces-56296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9891ECEB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B107B217D0
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928CD28D;
	Tue,  2 Jul 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R0Vv3Gdu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635DC129
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719886380; cv=none; b=u+k4GoR1tET9J2lp4W2wghmzxiihBkwFZ2rSS9qEB8k6sub8/VI5O+2Y/2cd8LmXuc/PosqYuKic7NTeaq7MyRzwanpA/fatx+koak9J7wQjMWPHzEX1EEGTi/lCGjFQ3C81GoP5APXgEfSam/akMdz/aCpvoDh6Xjb5Q4TdfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719886380; c=relaxed/simple;
	bh=YHzqrAdloR6U56aPhAmQrH0b7xWUAEW4c7b27neLdLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWZ6pO8gECpyn9GuAb7vbzSJD3udpFmoYemgi1YfCs2xsnsDeJFrtgCFyTaEfHAwuNWEuyA7Ef2WWIlb+ZoovRvkOuYHvaiUbLAeyfbyf4H1Fg29wBVPAZTUzRr02gEoEhE9naU5ih2cYcsxZfdJ/pW2UmmaAidQI7V/0ZiYHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R0Vv3Gdu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5d42758a7so525496d6.2
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719886377; x=1720491177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=R0Vv3Gdu7k8ezSrGabgIb99dB4i7b3p2etqcOpA+P4FRoxhXbDH4xXPILJBsWtogbp
         plKHLQkrK2yPqFE/pfns2vQYs+KSrera+iBZRG0hX6fTWtZiExGWALm8DOSLZUMr9o9S
         +fS9i8aqS+WDP1IstCck0QQShFZKk9ELb8O7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719886377; x=1720491177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Q+WtxgLGLDV4vft3U4bEIvX489UvKjK9odMCfURBQ=;
        b=Br0BZPNs1z7hZPGsUQBXyUPJq+0muMsD2LsmNvuo4wx8NxO1DYE52UDrz0Vu/390V4
         +5BxFCTqk7SK3U7a3O/GDmJTlle4kR/yv2yZqKWGOvrjFXvqwtgLpINLBiQocADpLAB1
         7FSONf4eUSAw6t8tr4i2cSBqEkssd6ikumLtWiGmqXFH6bF8WHyfySJLUKt3GfCZB178
         zXlZl35x+9G2xkqK2By0q8O3vuKJuKD1/St8Y8tCOcozpgWQmwC4V/yLUpnQN/mAycO/
         qDnTaCQ0KTJzdMLabFXb7jPePjszsw06853fqpJL4DePSNuNtEINCHeqrzG3Ux/ihICh
         xChw==
X-Forwarded-Encrypted: i=1; AJvYcCUHpqsSZbKsY/qSTKaH79NVur/YnY6trl1QreAuVv/0nUXrQ+MCoobr0M6fIoTumggukAIBaekup1O1dg7WQBLFvqWgKD4f
X-Gm-Message-State: AOJu0Yx+ThWD4UNxUOOaAJaBEyxKYKAk5IKHXgdjiJLuq5DGc8tgE+10
	fI4yxiJRYjmk7fK8sVSd+tv2mrMg0Ex/a5l9nLCjkIgfGpcIr20II2l4OyjY/g==
X-Google-Smtp-Source: AGHT+IGkfFiZLS1eY1teEvJp8VZMDP+EIvWeyyO5foWoZDpHQ9zeFwX1pqSQXaNInlRBbr6dco1E4A==
X-Received: by 2002:a05:6214:5196:b0:6b5:d663:bb53 with SMTP id 6a1803df08f44-6b5d663bd86mr1834756d6.5.1719886377475;
        Mon, 01 Jul 2024 19:12:57 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5bcf1acc0sm21799366d6.44.2024.07.01.19.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 19:12:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
Date: Mon,  1 Jul 2024 22:11:28 -0400
Message-ID: <20240702021254.1610188-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702021254.1610188-1-zack.rusin@broadcom.com>
References: <20240702021254.1610188-1-zack.rusin@broadcom.com>
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



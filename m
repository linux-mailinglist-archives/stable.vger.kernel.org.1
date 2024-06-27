Return-Path: <stable+bounces-55912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF687919EB3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7661C21628
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49291C6B7;
	Thu, 27 Jun 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EHfBnyol"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269C1A702
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466499; cv=none; b=g20e/mirHLLF4DDaZ4c1i0qsfgVB831jAI4Nw9dqjj+OUNvObPhRR1Qf9WLh1GHxDIYqTClhM3+uiNLHV2vTwgLgvVhNr8677NuFuvoBz0Vu631B2O8uhta/2w900cMwqBB8g0bbAOiVDQXQQk06X6yX/xJioNR5t6HiDoNOeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466499; c=relaxed/simple;
	bh=nthP+biiEJlJXqpV1SvSr2v3iZwtre1CKIpMvPmPeBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmnHKwkKQagYdp0Q7kcQoxu6Uhge3XxIgIbav3/YGsQzgeoP74v/28GjxUjjlliU3xmC8XLoY4Id1EqN1u/PIVLejc0j4GfC0+6nU7SV9O0pVHkCWpJf2DmzNQtfBFRVbs1BEZ+be3+86/rZ+kR+E/zf1CUI7MLx2/Vi2ES49co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EHfBnyol; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-444fe697f61so17096391cf.3
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 22:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719466497; x=1720071297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK+XwEE01O9MKbEeRLGG6iMONNez/yjAzdrVbw7Inj4=;
        b=EHfBnyolkmCz/bKVTfhX9tvSrK/EXXKgy47Y7gsIeDcqM8hp3xonHGar+9akq5OFFW
         I8nTpnNUMcH/99Aokz587M5liqCXAfkepIm59WVIiGVzLL/DNIqlULC6AY4HMgQittJg
         YUCSAxtAjdytgkx9vLXRa/xyHsODhkb2u8HxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719466497; x=1720071297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK+XwEE01O9MKbEeRLGG6iMONNez/yjAzdrVbw7Inj4=;
        b=eTSQfqHEBLjWSO2Ia2xrjxU1PD9IJCjP8w03Is36fR4nSF4fOv5YWd0GZ6IEU66nzw
         nXgMlHoHzEqptgnaS0a15tQHY35pbZGXnXuJUN/tRc05cb5ZnFopwQH8lkCyJFGsBlYq
         X/jUo+UMR/4v9m5TWtSJnBNJNOmurlLcdPByjeK88k2HrE2r4mDbatxGsIm6aCxLtsva
         uRE01Cl/3WtU5U1DY88uQKuCtNhbGJVddTcGn32gvkrdr4s5Pv4GtZVODRmH0RjBjCJR
         kIxfZiOQyE7TAvF0CSE3LaiM6VsxXeLKdj9eJ5vdK6CfyISfIzzv93b3SDaRZ+WF1Z2s
         4GIg==
X-Forwarded-Encrypted: i=1; AJvYcCXXX67szcNmJt3e6s0SFlqO+Kpa2UynK+8Lc2i/XdhKrjns++WDKBHnHN+i5h9X7NHqTaCWfQWAroviSod86Z4eCC++3Aek
X-Gm-Message-State: AOJu0Yz7sFYwiQz5Xsd5qvZECaVVRCgDa7QD8uKbQpSWrndN77KlsJic
	fWL8iZfVPA2uQGOzllKXviX1qbIJygqGgXZ55/MU1aKOyx/oZ4YsodJJZ3tGTg==
X-Google-Smtp-Source: AGHT+IHp5/i0t5sk4CoNslu9Wp27s7TFeESY5oQsJH6qvvjuav3XPhaIgZjEunVznE4PpUJvExi+LA==
X-Received: by 2002:a05:622a:3cc:b0:446:33d8:791a with SMTP id d75a77b69052e-4463d50cb74mr20782831cf.50.1719466495848;
        Wed, 26 Jun 2024 22:34:55 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44641eebfa0sm2716971cf.48.2024.06.26.22.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 22:34:55 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/vmwgfx: Fix a deadlock in dma buf fence polling
Date: Thu, 27 Jun 2024 01:34:49 -0400
Message-Id: <20240627053452.2908605-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240627053452.2908605-1-zack.rusin@broadcom.com>
References: <20240627053452.2908605-1-zack.rusin@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 5efc6a766f64..76971ef7801a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -120,16 +119,23 @@ static void vmw_fence_goal_write(struct vmw_private *vmw, u32 value)
  * objects with actions attached to them.
  */
 
-static void vmw_fence_obj_destroy(struct dma_fence *f)
+static void vmw_fence_obj_destroy_removed(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
 
+	WARN_ON(!list_empty(&fence->head));
+	fence->destroy(fence);
+}
+
+static void vmw_fence_obj_destroy(struct dma_fence *f)
+{
+	struct vmw_fence_obj *fence =
+		container_of(f, struct vmw_fence_obj, base);
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
 	spin_lock(&fman->lock);
 	list_del_init(&fence->head);
-	--fman->num_fence_objects;
 	spin_unlock(&fman->lock);
 	fence->destroy(fence);
 }
@@ -257,6 +263,13 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
+static const struct dma_fence_ops vmw_fence_ops_removed = {
+	.get_driver_name = vmw_fence_get_driver_name,
+	.get_timeline_name = vmw_fence_get_timeline_name,
+	.enable_signaling = vmw_fence_enable_signaling,
+	.wait = vmw_fence_wait,
+	.release = vmw_fence_obj_destroy_removed,
+};
 
 /*
  * Execute signal actions on fences recently signaled.
@@ -355,7 +368,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -403,7 +415,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 				      u32 passed_seqno)
 {
 	u32 goal_seqno;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -413,7 +425,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_fence_goal_write(fman->dev_priv,
@@ -471,6 +483,7 @@ static void __vmw_fences_update(struct vmw_fence_manager *fman)
 rerun:
 	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (seqno - fence->base.seqno < VMW_FENCE_WRAP) {
+			fence->base.ops = &vmw_fence_ops_removed;
 			list_del_init(&fence->head);
 			dma_fence_signal_locked(&fence->base);
 			INIT_LIST_HEAD(&action_list);
@@ -662,6 +675,7 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 					 VMW_FENCE_WAIT_TIMEOUT);
 
 		if (unlikely(ret != 0)) {
+			fence->base.ops = &vmw_fence_ops_removed;
 			list_del_init(&fence->head);
 			dma_fence_signal(&fence->base);
 			INIT_LIST_HEAD(&action_list);
-- 
2.40.1



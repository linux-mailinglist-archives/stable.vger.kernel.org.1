Return-Path: <stable+bounces-249490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKDnE44eDGqoWgUAu9opvQ
	(envelope-from <stable+bounces-249490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:25:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1497579F91
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35E643018D60
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011183E169D;
	Tue, 19 May 2026 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPjgBraT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C963E1683
	for <stable@vger.kernel.org>; Tue, 19 May 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178994; cv=none; b=Gav5TYC+GC+7HJVP4cfpT4roSqmVZFqh6GOaXf9fy5t6p8+s0juKuxrW6gYtI+LEPOP7yeIUZ6urbcTpPylkib+SCU6rwi9wCBUwnrGYg/2+ZvHu1eeAKRwjHK2Ecbx/24o8X5U/tIrQ1CE7kbE8BRu+qxjGWsQWjCCNzZVzews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178994; c=relaxed/simple;
	bh=P2aRkSF/wE8PSlTzoEmkJdge0lfompjr7htI4yHRBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwDXTLH/RKFLqMFhpWYoNHsq2rct/kZtYKnFHSwkUU+X/ORN2vxxMsg+SawwwJVoDtrwHzeqXvlosXfU1vcLQ9/M28vMit8vrydrB8AFfecYabj0WlEhthCo8uQEOgNo6bCG0ehJS2+z54VXB4o9VdyyAyPeAuh0yJiIgLannoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPjgBraT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c82471904fcso1361728a12.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779178992; x=1779783792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw+HXkNbB/u5QBrnahLqduKfToHyIm0xf5S3V5dfPlI=;
        b=WPjgBraT3Kn8yrWLNF+aw83uM0JzIon7hILVmYH9ImDLk7crTFS/Yuf8VKacG2YBgT
         IWagw26T7830cevrAxnlduP62HYU7An0LkfGgLyLv1T0C3EVq9nvBPt+cwG2BsyiKAXZ
         8V/SINQ+JuYPtdtZPy5SX5kiH+4K+sbGOnNdAUiar/4eeUA9NZ2LjXtiijHfNel/71/+
         OCqHX1Pi9/Go2ugb+6x2e5NidBKiMFK0SXA05/6aR4TQujjOu0YfqWUsitZsksOvuwn4
         5y/0wdNtTQhk08m5fBoULQs7tgmdx8cJfci0IherwUKDs7Y/b40+H1dJBXTnxCvJJyvl
         s6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178992; x=1779783792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw+HXkNbB/u5QBrnahLqduKfToHyIm0xf5S3V5dfPlI=;
        b=iqxmgeiX/BQugSa0EOLEgzwAWGEB45TumQ8CX3TMoQxUI5oBj/piJBPpASXPLe2kpJ
         5EbOaE+gBu8kzTWzMZHTOhIOuhwC6xAPpqK/QIEof81AiGxgRfMDd1EM5uMMJjBjc3Im
         EOn3+/ORmbBjsda7CqW4pMSOPZ0FcremuyOFnU0IhngdOyv1tu3aJtlYZ8brKSyrYucF
         iOrCFwHpH6Uczz4CgGifVKFUm/KQMDPQJ9yuMKkO991Q3cYBtQZV8atuM00lit4ZDtwU
         AZx2lfmVXDNCP0/Rz//p+J5+7FxEec6IRglPzYz+1tbRaQNyi4ah+HPrlcFXzqY/Q/it
         Q0Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/4md0M7sF6ins7vMgzrCbYCPDCqdALXGPpgHzmxpHEDKVM+vb67dMqzgtb5AugJ0oW2ekcsik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5t8zPPCh9+1CT/UY29L7ma50dwVoGDDJBz110WQBhw1QEq4C
	EoYbmtWycXd07FIIbZGy7L554idagUxz7x6PjB191SpvWbpZKNawlFRW
X-Gm-Gg: Acq92OHd6LmZO7Vvk+CTuX33Zgvi8lbixL0q7wJy9CCqZ2jkgFOaNJJ240TMU9z2g0P
	KhfKIAn9TFHsL1scrRAl/+HMkVaXI2HeY5Gbj/P/XP3HZMzxpzQizQOvompecJKkjk8LiXz7gxD
	9mbefuL3IqsyIGpgwy1HF6w33pykovBlo18HWVxiG3TKaUyOZyGNiqjzEE28GUkNQwNBQZVgs0u
	tTdYXN9nC/qEG7xdOrkikIJwhEuczUqUgQPdVhBZc82ELvpk56zch5TDUDjpQIYVR/i2sYLjPUP
	lXyV7G0KEdaLtsTCaT/MKFQ0Jif9PrxS+oFr15DnrxNgmjirb5dQQCXCRZLHsbbrHusGRZHNOTu
	2aSSggFccLODYdL8v6Vu/styMocaBtmJBi2ob0qUrRd30k0Czk41uD0P+RhBK2N4gpoaVZXcUGh
	5zm6LuvZBNsDUJQDkALPrrTf81R8rPcFvnJUyaN0+BdHJ5Fa2++p/KHewaO9kkbcdu7gWF4sTL/
	toyKkpjaNx6O6A=
X-Received: by 2002:a17:90b:4b8c:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-36951b8280dmr18284305a91.17.1779178992328;
        Tue, 19 May 2026 01:23:12 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:d693:97f:df7:b062])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695126feabsm13019156a91.6.2026.05.19.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:23:11 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4] drm/virtio: use uninterruptible resv lock for plane updates
Date: Tue, 19 May 2026 13:52:47 +0530
Message-ID: <20260519082247.34470-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,collabora.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E1497579F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush() lock
the framebuffer BO's dma_resv via virtio_gpu_array_lock_resv() and
ignore its return value. The function can fail with -EINTR from
dma_resv_lock_interruptible() (signal during lock wait) or with
-ENOMEM from dma_resv_reserve_fences() (fence slot allocation),
leaving the resv lock not held. The queue path then walks the object
array and calls dma_resv_add_fence(), which requires the lock held;
with lockdep enabled this trips dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer
   virtio_gpu_cursor_plane_update
   drm_atomic_helper_commit_planes
   drm_atomic_helper_commit_tail
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_update_plane
   __setplane_atomic
   drm_mode_cursor_universal
   drm_mode_cursor_common
   drm_mode_cursor_ioctl
   drm_ioctl
   __x64_sys_ioctl

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

Both call sites run inside the .atomic_update plane callback, which
DRM atomic helpers do not allow to fail (by the time it runs, the
commit has been signed off to userspace and there is no clean
rollback path). Moving the lock acquisition to .prepare_fb was
rejected because the broader lock scope deadlocks against other BO
locking paths in the same atomic commit.

Introduce virtio_gpu_lock_one_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible(). This
eliminates the -EINTR failure mode -- the realistic syzbot trigger
-- without extending the lock hold across the commit. The helper
locks a single BO and rejects nents > 1 with -EINVAL; both fix
sites lock exactly one BO.

Use it from virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case from dma_resv_reserve_fences() by freeing
the objs and skipping the plane update for that frame. The
framebuffer BOs touched here are not shared with other contexts
and lock contention is expected to be brief, so the loss of
signal-interruptibility is acceptable.

Other callers of virtio_gpu_array_lock_resv() (the ioctl paths)
continue to use the interruptible variant.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v4: Rename the helper to virtio_gpu_lock_one_resv_uninterruptible()
    and reject objs->nents > 1 with -EINVAL. The v3 helper's
    multi-object branch used drm_gem_lock_reservations(), which is
    interruptible, contradicting the "uninterruptible" name; both
    fix sites lock a single BO so the multi-object path is dropped.
    (Dmitry Osipenko)
v3: Drop the prepare_fb/cleanup_fb approach from v2 (it deadlocked
    against virtio_gpu_resource_flush(), which also locks the BO in
    the same atomic commit). Instead add an uninterruptible variant
    of the resv lock helper and use it in both
    virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush().
    (Dmitry Osipenko)
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The v1 approach of silently skipping the cursor update on lock
    failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 17 +++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..2f3531950aa4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -317,6 +317,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f22dc5c21cd4..435d37d36034 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -238,6 +238,23 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents != 1)
+		return -EINVAL;
+
+	dma_resv_lock(objs->objs[0]->resv, NULL);
+
+	ret = dma_resv_reserve_fences(objs->objs[0]->resv, 1);
+	if (ret) {
+		virtio_gpu_array_unlock_resv(objs);
+		return ret;
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..652352424744 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -215,7 +215,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, objs,
 					      vgplane_st->fence);
@@ -459,7 +462,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0



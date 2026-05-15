Return-Path: <stable+bounces-247593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ0rA6PdBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6654BAC5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B353052CA9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A177423A81;
	Fri, 15 May 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIxoi3v0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BC406281
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834444; cv=none; b=XW86AtICSbGVK/SblgzQ8aY/yHn+8apuYKLW90CMPHKW2lZlkcBG0nYqy6JJrT9TkttRDMqkHQ8H7P+69FsTJOIV4+Z98Ohexlgs396hmatxTBbugTN3Txbf8Lef6VhATvCUoS1wuQpNie1SpC95sffJ7ltlmaCzzR/AJAc9u30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834444; c=relaxed/simple;
	bh=bMjgEAA1AihAMMTwD1pxLHmMxEIVCiAxGqmaIQ/5jHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8JmyHsx1hEtyyj87spEpxHjz4WjfiWyvUCoJK4TyQn71N2abVucSRP70M0kaKk68paU2IFTCacwZUOJAtRoh2lx6gS6isR1+0P0rkDYhgUIPDscsH52LXJYe+pPWjOKIVGpRgw+VOgXdbfj+fMiJ62N51HIEVE//oVuFtNRdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIxoi3v0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-369576666d5so237653a91.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834442; x=1779439242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
        b=hIxoi3v06tCCvrj4Y5gfes8QrUX17ZVk3XzUo9S3xnShclLaLuJSVaaLLkQm9a6MMH
         24WVS6BJzXggjBJvm2HMLVWH2xAi5Z/eGKB8bhZgxyF8toyGoz9zujUFKJyg0ZecrIPS
         Hly/MNkpUhJjUfAIdwMRhQD+/NXLdimAc6cg3BU4lB21ozT9kULL273mKR8AMh17cTRz
         iSSJDggNIQJMacAKaYY8uU85BWC8D6RfZJRVQn/yGw6WsGca/qx6skJ5rHLbaH+tD636
         hwfWyyPyRhGuyQZMTkjXi3AqqOQFaWKV30T0FC3SOi0QDzqnrXxeEIFdyE7vIuempjUX
         zJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834442; x=1779439242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
        b=NWE/Jd3Up+J34YQfM9fAXhwrkey2rIGZ5f5RL+56Q07jWUraUx8qomPE/Ko/88tg6w
         4KB7DRcoXDymUHI3V99CyC4K1yeLvmrQrCJ0Pzfq7htZpQZ00vlM7pMEk1SGO2xfgISL
         YjXU5fXaGpL2FZGPgXYxxv7OVzthA+JRkTEDr2C+snlDRpKDIRYCHkmOQxg9yb2DZAc8
         WYM32NzZAtKm1n5+L7o2x92fGX5e4ibRuZ4VRMhWLmzqF+DDR1fnmU/lHveDkZUrykmn
         KojOMX46V6M/sZ/yNa0+tTz47noqc6ywB4eqwX/z1a87BprRuONFVrpIg+l7RTPHt5Tb
         JKMw==
X-Forwarded-Encrypted: i=1; AFNElJ+mtzJrKHIOZYce8c+57m6GhD5oEqnFFN9rMkfWcuHOBdFPB/3oidWO50JK9vlJq8gpyYeh7WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+kgDBd5KhMJkMfdxJYEkvlSoRNdxwofHGH+3kdysTTFpyE8s
	sZBKrb7x+0t11xZ+eRN3scONK0x8zhI4peasnSkVbcW6nCIFQW/a6JbQ
X-Gm-Gg: Acq92OHqmWMh+vqRz9xAbSVRR3bT149yh9OFNroeCITNbaznvEij6eZHpg+k29wGam1
	1aM/ksREABkBGOZZX62wu4W9pZXGNtQQvIEDQd+1tn/cHOuQ2n+88OYtBnazuXxocGEGii8R0Xs
	GWoVtE1uxmxU/+zd3PNTuhNa69zXAjf+gpqCuUoi+sru03/J88S8S3T68ooVOh9J+qjPoUfYH2K
	cCJXydeDTXC3wAoePHzlwN/R4alHgW7U+x4AVT21DslNFwrClkeKHu6qr1MtiPnLiw3u//TEUbi
	dS9bQ8s7D3ctkLgp0KLBYn3gARofMV0UO/B3XGaUP5V99a2q3xFYAyYMCNXnAzsk4/1SbbgRz1A
	r2BmwDYcj/frnU8DUUAxbQ03MGRD0txfNj4W84QOVbOqNgt90hjD9K2yPa+8KR7FLQkHB88ZBn+
	yDdn2oLvJX3nbdVK67zNAxRzsNsrBTKBgHhodqo9Y5bMpYIKNvuC6/GBWVaGS7G5d9wnFVwe0c2
	OugjQc=
X-Received: by 2002:a17:90b:134b:b0:368:78da:803 with SMTP id 98e67ed59e1d1-36951a01748mr3017625a91.12.1778834441878;
        Fri, 15 May 2026 01:40:41 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ad23:b1a5:6537:1208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36956535742sm637091a91.3.2026.05.15.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:40:41 -0700 (PDT)
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
Subject: [PATCH v3] drm/virtio: use uninterruptible resv lock for plane updates
Date: Fri, 15 May 2026 14:10:30 +0530
Message-ID: <20260515084030.21986-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EB6654BAC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-247593-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,collabora.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Action: no action

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
rollback path). Moving the lock acquisition to .prepare_fb (v2) was
rejected because the broader lock scope deadlocks against other
BO locking paths in the same atomic commit.

Introduce virtio_gpu_array_lock_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible() on the
nents==1 path. This eliminates the -EINTR failure mode -- the
realistic syzbot trigger -- without extending the lock hold across
the commit. Use it from both virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case by freeing the objs and skipping the plane
update for that frame. The framebuffer BOs touched here are not
shared with other contexts and lock contention is expected to be
brief, so the loss of signal-interruptibility is acceptable.

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
v3: Per maintainer feedback on v2 (lockup caused by the broader
    lock scope in prepare_fb conflicting with other BO locking in
    the same atomic commit): drop the prepare_fb/cleanup_fb
    approach, introduce an uninterruptible variant of
    virtio_gpu_array_lock_resv(), and use it in both
    virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush().
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The previous approach of silently skipping the cursor update on
    lock failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..43a7eb568e15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -317,6 +317,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f22dc5c21cd4..08c4b7ef8d44 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -238,6 +238,30 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	unsigned int i;
+	int ret = 0;
+
+	if (objs->nents == 1) {
+		dma_resv_lock(objs->objs[0]->resv, NULL);
+	} else {
+		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
+						&objs->ticket);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < objs->nents; ++i) {
+		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
+		if (ret) {
+			virtio_gpu_array_unlock_resv(objs);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ef118cb4f0fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -215,7 +215,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
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
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0



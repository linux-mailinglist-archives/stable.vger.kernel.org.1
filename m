Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A879D12A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjILMe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjILMe6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 08:34:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9A9F
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 05:34:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8711F32009D0;
        Tue, 12 Sep 2023 08:34:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 08:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1694522093; x=1694608493; bh=JZ93IAwtwK
        p1AQn6xqxrLdOKNEWIml0xz57Snv9BtLY=; b=A6yCQOhBvfzo0XFP71Fr7sJ2pG
        8QKLOCRLDL1dCfJ3AjK0hPpGoaHc5Krl6ikwRA98J5DXclo8VWTGC8QrvP+ktFsb
        TWMv7jrUWTDzt+V29B0bnwAk/BSL6l0XIJdGX4E9yHWYY+h5ggC2/BZ08z31fixM
        vuI+9fk2STlp1qilmUEJAzFCMceiFbMK1tkng/BJa/gDApyJGRroV2JcM0g9z98U
        KPkGSs3Mjla6gbtdohDYotl2BSO1h8QbHsntLsy4Uj27pCf/DfCsaA33fDqXKXjK
        cy6ziL6iRdON2JviqpKA5I4pGPDED6o66AJ1rJnzgB8fw3oMxSr4NH6uT3oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694522093; x=1694608493; bh=JZ93IAwtwKp1A
        Qn6xqxrLdOKNEWIml0xz57Snv9BtLY=; b=QyeKgAj2YPGzY1aU4rpOEkH6ru5Kd
        nC4ACkwFXue5XhAxFY31LlM7u/Qz4YVAoou23EcJYMvKdZI76k4/bwZ/qj2Sc81V
        FPW9Em6tjHwpppw5YTOliQGHsDiVJapjUno4u3Mg6Azclf4u3l4tIG8wdPXOCf53
        Pxpt//57fuawcvpArKU1kBGgdRbsrmMX3SV0d65rwL5hnwhGxZ8Vy9j1sKP6/USW
        1XdJ3QL1Gz+DAeKSh/jnF8XPgS1VUH9EUgbs8yj+pUReox0N7F3jmKx6Y7VQYo4b
        3Y5NDNDpFt9QtNIBJN3hV6GpBpoQ5e+GR8GFmISUqC28X8kb9d0yuqMsA==
X-ME-Sender: <xms:7FoAZUwGMFBwC_4pV-rvlLzlgchqw9kRgIRKqXgBoUxAbAdJ1INCmQ>
    <xme:7FoAZYQSIUgzblZPwxiEMfiBxRN8W2QP1PfwQHN-RE6S_Daj7eKU9icgtpbS71Gb0
    prrKYkR_uuqYYxweA>
X-ME-Received: <xmr:7FoAZWXSx-1c6-qda3Xckf0lwdbb84VJFAM19vxaDUJhj1g98LvWGlMU2djtzVF7jYhfTX6Oo55XtTYl8n8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepjeekue
    fhhfejjeetheduveffgeehveduteeffedtiedtfeehkefgheeuhfetgffhnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:7FoAZSi_GpX21Mv_X_k32adlryBq3vqrzg9YICMFLNq6AE2OrAuPUw>
    <xmx:7FoAZWAYRamHtdQfu-t15ge0q6G7joovBa4W1WWVirOstDUAsiROJg>
    <xmx:7FoAZTI9uF_Xzwb9z9ZFa7_hCVZX9Z-J2cF8kcahwcogkT5VbOr0AA>
    <xmx:7VoAZX6HS2lu5ZN99ZxJh5XZiDTT8gUWHyCGmR2Dwa2H8z8wyUDtkA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 08:34:52 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 2674685F3; Tue, 12 Sep 2023 12:34:50 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     stable@vger.kernel.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Alyssa Ross <hi@alyssa.is>
Subject: [PATCH 6.5.y] drm/virtio: Conditionally allocate virtio_gpu_fence
Date:   Tue, 12 Sep 2023 12:34:34 +0000
Message-ID: <20230912123433.893380-2-hi@alyssa.is>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gurchetan Singh <gurchetansingh@chromium.org>

We don't want to create a fence for every command submission.  It's
only necessary when userspace provides a waitable token for submission.
This could be:

1) bo_handles, to be used with VIRTGPU_WAIT
2) out_fence_fd, to be used with dma_fence apis
3) a ring_idx provided with VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
   + DRM event API
4) syncobjs in the future

The use case for just submitting a command to the host, and expecting
no response.  For example, gfxstream has GFXSTREAM_CONTEXT_PING that
just wakes up the host side worker threads.  There's also
CROSS_DOMAIN_CMD_SEND which just sends data to the Wayland server.

This prevents the need to signal the automatically created
virtio_gpu_fence.

In addition, VIRTGPU_EXECBUF_RING_IDX is checked when creating a
DRM event object.  VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK is
already defined in terms of per-context rings.  It was theoretically
possible to create a DRM event on the global timeline (ring_idx == 0),
if the context enabled DRM event polling.  However, that wouldn't
work and userspace (Sommelier).  Explicitly disallow it for
clarity.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # edited coding style
Link: https://patchwork.freedesktop.org/patch/msgid/20230707213124.494-1-gurchetansingh@chromium.org
(cherry picked from commit 70d1ace56db6c79d39dbe9c0d5244452b67e2fde)
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 30 ++++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index cf3c04b16a7a..1d010c66910d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -64,13 +64,9 @@ static int virtio_gpu_fence_event_create(struct drm_device *dev,
 					 struct virtio_gpu_fence *fence,
 					 u32 ring_idx)
 {
-	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct virtio_gpu_fence_event *e = NULL;
 	int ret;
 
-	if (!(vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
-		return 0;
-
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
 	if (!e)
 		return -ENOMEM;
@@ -164,18 +160,30 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fence *out_fence;
+	bool drm_fence_event;
 	int err;
 
 	memset(submit, 0, sizeof(*submit));
 
-	out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
-	if (!out_fence)
-		return -ENOMEM;
+	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) &&
+	    (vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
+		drm_fence_event = true;
+	else
+		drm_fence_event = false;
 
-	err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-	if (err) {
-		dma_fence_put(&out_fence->f);
-		return err;
+	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
+	    exbuf->num_bo_handles ||
+	    drm_fence_event)
+		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
+	else
+		out_fence = NULL;
+
+	if (drm_fence_event) {
+		err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+		if (err) {
+			dma_fence_put(&out_fence->f);
+			return err;
+		}
 	}
 
 	submit->out_fence = out_fence;

base-commit: 3766ec12cf894667026786fef355bb998c263f03
-- 
2.41.0


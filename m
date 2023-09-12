Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ACC79D12C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjILMge (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 08:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjILMgd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 08:36:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526659F
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 05:36:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 918BD32009D6;
        Tue, 12 Sep 2023 08:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 08:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1694522188; x=1694608588; bh=6tpxg9lFv6
        ndlucNOLLgETehaZ1cEPRblL0hl0iiHN4=; b=ItGb6yauy7KWSucpm3AOBLABd0
        fUpjse8hc8gtbZ2IzXbXZz+fHlErah2+cCQiTyVLk2G9RSo5XtOFJ3V4+g58xHMa
        Y3DoXKQcw8yQ44obGd30KyBENXJOSjwEWco3+iqHElBFNhobK8Jt6iVkGkAwHnh8
        um5A4OHVxChaKGbLntIhuxQa6+Rd33WyVm8nLNyaKwAbVQLuROhhTJ/4Gec4ujpU
        fG1pAD2Dn8Gk2wvYaNsHJPuZCkV+0gShOaTy7GwyZFbd0p/NPHFDOPOpl2Og1koa
        2fq0IadwUzeREROXduvC4mOYE3FvB372z/nbGPW0Bo1ljhHRHzMHvh4qwmhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694522188; x=1694608588; bh=6tpxg9lFv6ndl
        ucNOLLgETehaZ1cEPRblL0hl0iiHN4=; b=sfOsai2bAe9RVMqVR6BXITmdVf5kF
        QuOSD1XF5MEyQPtkKWiDGIPlqKuS8xLPMGvO08qEmUcLpwSVhMDCzghNro0XDOK8
        LXA3B2sBiI7m/Er+joltBgAY5uxTsnp0KNx5s7zw0mL+uHNNymCMGESqrYt5ZsVJ
        kjpNDwskrcdqFLZxa3sB44+UXMpBUaGqtYV8JbhmgwS0Y1Zvud8La+mUrQy5abB9
        rKdWZ1+p1RgUicI9cjHOG77gNv6cRQA49nDIkBFt6hR4QU8Sj68luu1GMommZZYV
        StI3USq6Vv0W8hT8T6uNWnaoUqAju4Aw5Al+fZhcs6QjNFxT6hlTpm2vQ==
X-ME-Sender: <xms:S1sAZT7rp3UVs_c3UJbsetc6pwt9OGLDjIz79YMXXpujNM2P-XXdnw>
    <xme:S1sAZY759t45UqVWaFNmG6eNIiuaF6l-03e6fdV9Glg8p5SHvuE6ZegdxJzacJktG
    VIgeW0agm91C3dRKg>
X-ME-Received: <xmr:S1sAZactpv3TJmCLH-Qoobx4N1zdHMFG-OJWHFRodscW7vf2-H2nT-o0bAmav-bZ9iAOX3ZaHehSkMYT1UM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepjeekue
    fhhfejjeetheduveffgeehveduteeffedtiedtfeehkefgheeuhfetgffhnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:S1sAZULmnHme3s-a1Yu0IRcEisALVirUtA1Ff2i02HUn74lOpV0lHQ>
    <xmx:S1sAZXIayXv8A7oKg8OG0xwmonekvb68QA1Y1OAbgimcuLu71YwcBA>
    <xmx:S1sAZdxKYSB-5HkXwHll_BBn2IU1Iz0mPTvzJVH9KNg05iG-_JStXA>
    <xmx:TFsAZdi3HYEvVr_CBiYLRVSApWtx0S7LjRIcYOCYA6CvcePFWtQdzA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 08:36:27 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 8CB7085F5; Tue, 12 Sep 2023 12:36:26 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     stable@vger.kernel.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Alyssa Ross <hi@alyssa.is>
Subject: [PATCH 6.1.y,6.4.y] drm/virtio: Conditionally allocate virtio_gpu_fence
Date:   Tue, 12 Sep 2023 12:35:34 +0000
Message-ID: <20230912123534.893716-1-hi@alyssa.is>
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
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 30 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index da45215a933d..bc8c1e9a845f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -43,13 +43,9 @@ static int virtio_gpu_fence_event_create(struct drm_device *dev,
 					 struct virtio_gpu_fence *fence,
 					 uint32_t ring_idx)
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
@@ -121,6 +117,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct virtio_gpu_fence *out_fence;
+	bool drm_fence_event;
 	int ret;
 	uint32_t *bo_handles = NULL;
 	void __user *user_bo_handles = NULL;
@@ -216,15 +213,24 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			goto out_memdup;
 	}
 
-	out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
-	if(!out_fence) {
-		ret = -ENOMEM;
-		goto out_unresv;
-	}
+	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) &&
+	    (vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
+		drm_fence_event = true;
+	else
+		drm_fence_event = false;
 
-	ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-	if (ret)
-		goto out_unresv;
+	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
+	    exbuf->num_bo_handles ||
+	    drm_fence_event)
+		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
+	else
+		out_fence = NULL;
+
+	if (drm_fence_event) {
+		ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+		if (ret)
+			goto out_unresv;
+	}
 
 	if (out_fence_fd >= 0) {
 		sync_file = sync_file_create(&out_fence->f);

base-commit: f60d5fd5e950c89a38578ae6f25877de511bb031
-- 
2.41.0


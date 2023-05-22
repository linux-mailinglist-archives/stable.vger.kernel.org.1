Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6670C777
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjEVT35 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjEVT3z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99F119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF8CC628EB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4CCC433EF;
        Mon, 22 May 2023 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783791;
        bh=9fRzOBzKY291XYpQRoelvNJbIx6XAFqYv/8NKID3o24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=octwoQhO3lyLvcAyDE57aiH7YR7aXVUBCnJVNCe7MDAwzqc6Kw6lb7LekK+XZQtdc
         cqdYv8SH22C0fkwhaDGlK3fZ3rqd0kgO6AKbvUxU1ftDIebHtZPbVWPD0QMGb/+GYy
         ST8WegUFf0ZXNJ/ezKfPv10FN24dv1lqa6vpk2yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, pinkperfect2021@gmail.com,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 163/292] drm/msm: Fix submit error-path leaks
Date:   Mon, 22 May 2023 20:08:40 +0100
Message-Id: <20230522190410.040283447@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 68dc6c2d5eec45515855cce99256162f45651a0b ]

For errors after msm_submitqueue_get(), we need to drop the submitqueue
reference.  Additionally after get_unused_fd() we need to drop the fd.
The ordering for dropping the queue lock and put_unused_fd() is not
important, so just move this all into out_post_unlock.

v2: Only drop queue ref if submit doesn't take it
v3: Fix unitialized submit ref in error path
v4: IS_ERR_OR_NULL()

Reported-by: pinkperfect2021@gmail.com
Fixes: f0de40a131d9 drm/msm: ("Reorder lock vs submit alloc")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/536073/
Link: https://lore.kernel.org/r/20230509203041.440619-1-robdclark@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index d8c9d184190bb..d6162561141c5 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -709,7 +709,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_file_private *ctx = file->driver_priv;
-	struct msm_gem_submit *submit;
+	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
@@ -756,13 +756,15 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
 		if (out_fence_fd < 0) {
 			ret = out_fence_fd;
-			return ret;
+			goto out_post_unlock;
 		}
 	}
 
 	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds);
-	if (IS_ERR(submit))
-		return PTR_ERR(submit);
+	if (IS_ERR(submit)) {
+		ret = PTR_ERR(submit);
+		goto out_post_unlock;
+	}
 
 	trace_msm_gpu_submit(pid_nr(submit->pid), ring->id, submit->ident,
 		args->nr_bos, args->nr_cmds);
@@ -945,11 +947,20 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (has_ww_ticket)
 		ww_acquire_fini(&submit->ticket);
 out_unlock:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	msm_gem_submit_put(submit);
+	if (ret && (out_fence_fd >= 0))
+		put_unused_fd(out_fence_fd);
+
+	if (!IS_ERR_OR_NULL(submit)) {
+		msm_gem_submit_put(submit);
+	} else {
+		/*
+		 * If the submit hasn't yet taken ownership of the queue
+		 * then we need to drop the reference ourself:
+		 */
+		msm_submitqueue_put(queue);
+	}
 	if (!IS_ERR_OR_NULL(post_deps)) {
 		for (i = 0; i < args->nr_out_syncobjs; ++i) {
 			kfree(post_deps[i].chain);
-- 
2.39.2




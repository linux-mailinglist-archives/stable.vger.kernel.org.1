Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B948E75CDE6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGUQPm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGUQP1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE34223
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714CC61D25
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ABCC433C7;
        Fri, 21 Jul 2023 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956092;
        bh=Tnx13kqMBfRMyWaxR7sW2CwdK2gp+0xy10lJUb/9w4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5W+/xoE0dMZYISBvL37O9jhdUBapmmt12lvGL4MJZ6EhPYEFg8MehQyhTR1qZwMy
         Ta3KVp5NaAr9+dFBeTTDFYqK+Df3DW+CqCEKNBDq9wEvMJVrd3QMIiCjsxNh4zz3RK
         wpRuQWKJaootkRWTwHmLrsLlMMXTZJUoZvBaTCtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 101/292] drm/nouveau: bring back blit subchannel for pre nv50 GPUs
Date:   Fri, 21 Jul 2023 18:03:30 +0200
Message-ID: <20230721160533.133092186@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit 835a65f51790e1f72b1ab106ec89db9ac15b47d6 ]

1ba6113a90a0 removed a lot of the kernel GPU channel, but method 0x128
was important as otherwise the GPU spams us with `CACHE_ERROR` messages.

We use the blit subchannel inside our vblank handling, so we should keep
at least this part.

v2: Only do it for NV11+ GPUs

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/201
Fixes: 4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230526091052.2169044-1-kherbst@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c |  1 +
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c  | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index e648ecd0c1a03..3dfbc374478e6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,6 +90,7 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		if (cli)
 			nouveau_svmm_part(chan->vmm->svmm, chan->inst);
 
+		nvif_object_dtor(&chan->blit);
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index e06a8ffed31a8..bad7466bd0d59 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -53,6 +53,7 @@ struct nouveau_channel {
 	u32 user_put;
 
 	struct nvif_object user;
+	struct nvif_object blit;
 
 	struct nvif_event kill;
 	atomic_t killed;
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 7aac9384600ed..40fb9a8349180 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -375,15 +375,29 @@ nouveau_accel_gr_init(struct nouveau_drm *drm)
 		ret = nvif_object_ctor(&drm->channel->user, "drmNvsw",
 				       NVDRM_NVSW, nouveau_abi16_swclass(drm),
 				       NULL, 0, &drm->channel->nvsw);
+
+		if (ret == 0 && device->info.chipset >= 0x11) {
+			ret = nvif_object_ctor(&drm->channel->user, "drmBlit",
+					       0x005f, 0x009f,
+					       NULL, 0, &drm->channel->blit);
+		}
+
 		if (ret == 0) {
 			struct nvif_push *push = drm->channel->chan.push;
-			ret = PUSH_WAIT(push, 2);
-			if (ret == 0)
+			ret = PUSH_WAIT(push, 8);
+			if (ret == 0) {
+				if (device->info.chipset >= 0x11) {
+					PUSH_NVSQ(push, NV05F, 0x0000, drm->channel->blit.handle);
+					PUSH_NVSQ(push, NV09F, 0x0120, 0,
+							       0x0124, 1,
+							       0x0128, 2);
+				}
 				PUSH_NVSQ(push, NV_SW, 0x0000, drm->channel->nvsw.handle);
+			}
 		}
 
 		if (ret) {
-			NV_ERROR(drm, "failed to allocate sw class, %d\n", ret);
+			NV_ERROR(drm, "failed to allocate sw or blit class, %d\n", ret);
 			nouveau_accel_gr_fini(drm);
 			return;
 		}
-- 
2.39.2




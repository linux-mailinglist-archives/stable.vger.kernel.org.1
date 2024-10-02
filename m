Return-Path: <stable+bounces-78894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A368098D576
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583FB288AAD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E91D0174;
	Wed,  2 Oct 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J65pBJo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA131CFECF;
	Wed,  2 Oct 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875838; cv=none; b=IPAbHDAAj1WddiEJJmjVDQZw86HtZB9xU1BFlhOdLjc3k7g6j6sWFKgGC7/+D5tfhbuaMW3e+NrDVSRHSmIh0ffkGDKMbO+7Z3Yf3yIDTM0eCSwwl/XPUi2gnc8F+OntG1A4XyqAJ61xJoQdIFu7fXy27PeFwgom5ImODJ2WlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875838; c=relaxed/simple;
	bh=XhOzhJ7Xq7zQ/Srly2qIp7kY5cUKn4NWV6nchL6cFPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM4Oz6UZe9Q5LK7jjnjND+aImp5xm0Km6xDkFhQwLl9YQHnOg3Ece5ast1cujidevedZ/NyhxBlFvF1kiEY2DVKLWaoOBzg9QT/YNshaI/4Rbe/uZH5HXz34Dg69rIlJaSyF+76qhTJSOFD4ctI0Vx/rexY1BFBT1twz873xB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J65pBJo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ED4C4CEC5;
	Wed,  2 Oct 2024 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875838;
	bh=XhOzhJ7Xq7zQ/Srly2qIp7kY5cUKn4NWV6nchL6cFPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J65pBJo+aW0PaNUCRy58DGT7RbQ4BxHRKpP4MZ3GMiUdoxR/NqJQziJVU1JkIoSlc
	 02j8IY7MsSY6KsHPMpwnQOOp3vqsVaH81lG4S3AoHHhfkt19wcRMVKg8wBBgCYd6f5
	 KgoDurzd01kv/M3ovb6I7RXuXbiylM8p+zGKh5Kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	CK Hu <ck.hu@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 221/695] drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()
Date: Wed,  2 Oct 2024 14:53:39 +0200
Message-ID: <20241002125831.280888141@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[ Upstream commit fe30bae552ce27b9fefe0b12db1544e73d07325f ]

In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
generate instructions to cmdq_handle, such as:
  state->pending_config
  mtk_crtc->pending_planes
  plane_state->pending.config
  mtk_crtc->pending_async_planes
  plane_state->pending.async_config

These configuration flags may be set to false when a GCE IRQ comes calling
ddp_cmdq_cb(). This may result in missing prepare instructions,
especially if mtk_crtc_update_config() with the flase need_vblank (no need
to wait for vblank) cases.

Therefore, the mtk_crtc->config_updating flag is set at the beginning of
mtk_crtc_update_config() to ensure that these configuration flags won't be
changed when the mtk_crtc_ddp_config() is preparing instructions.
But somehow the ddp_cmdq_cb() didn't use the mtk_crtc->config_updating
flag to prevent those pending config flags from being cleared.

To avoid missing the configuration when generating the config instruction,
the config_updating flag should be added into ddp_cmdq_cb() and be
protected with spin_lock.

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240827-drm-fixup-0819-v3-1-4761005211ec@mediatek.com/
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240827-drm-fixup-0819-v3-2-4761005211ec@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 6f34f573e127e..d7f0926f896d6 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -69,6 +69,8 @@ struct mtk_crtc {
 	/* lock for display hardware access */
 	struct mutex			hw_lock;
 	bool				config_updating;
+	/* lock for config_updating to cmd buffer */
+	spinlock_t			config_lock;
 };
 
 struct mtk_crtc_state {
@@ -106,11 +108,16 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 
 static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
+	unsigned long flags;
+
 	drm_crtc_handle_vblank(&mtk_crtc->base);
+
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
 		mtk_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
@@ -308,12 +315,19 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	struct mtk_crtc *mtk_crtc = container_of(cmdq_cl, struct mtk_crtc, cmdq_client);
 	struct mtk_crtc_state *state;
 	unsigned int i;
+	unsigned long flags;
 
 	if (data->sta < 0)
 		return;
 
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
+	if (mtk_crtc->config_updating) {
+		spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+		goto ddp_cmdq_cb_out;
+	}
+
 	state->pending_config = false;
 
 	if (mtk_crtc->pending_planes) {
@@ -340,6 +354,10 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 		mtk_crtc->pending_async_planes = false;
 	}
 
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
+ddp_cmdq_cb_out:
+
 	mtk_crtc->cmdq_vblank_cnt = 0;
 	wake_up(&mtk_crtc->cb_blocking_queue);
 }
@@ -569,9 +587,14 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0, pending_async_planes = 0;
 	int i;
+	unsigned long flags;
 
 	mutex_lock(&mtk_crtc->hw_lock);
+
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = true;
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
 	if (needs_vblank)
 		mtk_crtc->pending_needs_vblank = true;
 
@@ -625,7 +648,10 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
 	}
 #endif
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
@@ -1068,6 +1094,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
 	mutex_init(&mtk_crtc->hw_lock);
+	spin_lock_init(&mtk_crtc->config_lock);
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	i = priv->mbox_index++;
-- 
2.43.0





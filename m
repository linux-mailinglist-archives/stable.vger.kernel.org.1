Return-Path: <stable+bounces-63752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA3941B28
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C71B27D40
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A1187FF6;
	Tue, 30 Jul 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1Z1IoP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8614831F;
	Tue, 30 Jul 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357837; cv=none; b=DZrivIKu0mFCzdbFxfh1BG698IdWt30TUbn+G03bJrC/hjIllRDXUMmqvZihrhuwasieeViF6KiTqz0bzNDmA81j0FakwRMTwvqPOzbhAoLZBBrWIH/by/PQu+RyIJUF7QqU8VLVnt8zSKku8oUh2jNmAE6NxzRKwJZyzuD7qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357837; c=relaxed/simple;
	bh=SazqBY3eW76BRWMVJVAheYxyFRemqkkchU11ocv+H+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijhScOC0wxrrx3QX3EQGu5rvSRR35vFNo1RpzcS1b/BLMz6YUvhaq3g/JS6+ywHP3frcgKdRUChlS3YIum6j69uTYBGOdLxWLYaJ8QnpIjC/NaIQPHjrmy7Nm9IIVNNcKN81oXm5jlBpg+XpeTll4Q84HyYqjzEioFs1zowyNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1Z1IoP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F4EC32782;
	Tue, 30 Jul 2024 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357837;
	bh=SazqBY3eW76BRWMVJVAheYxyFRemqkkchU11ocv+H+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w1Z1IoP0QUPGwQJfnPOxi+vyinaEu0UMuFRzmD2UTcxdCymB1FCi/SnFKp+debEeT
	 88TfdDjNbxeaXgVCV7YZQGvsGYnVkR6zJ1k6KAQVGi6BkkvK9MzOVxUHGmtJlD20Ns
	 GQewxinZo3egKCecxma3UX5Wno2kmd8UiRUNZlOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 297/809] Revert "drm/msm/dpu: drop dpu_encoder_phys_ops.atomic_mode_set"
Date: Tue, 30 Jul 2024 17:42:53 +0200
Message-ID: <20240730151736.324992918@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 35322c39a653c775670f0713fb96ccc2cd91a747 ]

In the DPU driver blank IRQ handling is called from a vblank worker and
can happen outside of the irq_enable / irq_disable pair. Using the
worker makes that completely asynchronous with the rest of the code.
Revert commit d13f638c9b88 ("drm/msm/dpu: drop
dpu_encoder_phys_ops.atomic_mode_set") to fix vblank IRQ assignment for
CMD DSI panels.

Call trace:
 dpu_encoder_phys_cmd_control_vblank_irq+0x218/0x294
  dpu_encoder_toggle_vblank_for_crtc+0x160/0x194
  dpu_crtc_vblank+0xbc/0x228
  dpu_kms_enable_vblank+0x18/0x24
  vblank_ctrl_worker+0x34/0x6c
  process_one_work+0x218/0x620
  worker_thread+0x1ac/0x37c
  kthread+0x114/0x118
  ret_from_fork+0x10/0x20

Fixes: d13f638c9b88 ("drm/msm/dpu: drop dpu_encoder_phys_ops.atomic_mode_set")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/595065/
Link: https://lore.kernel.org/r/20240522-dpu-revert-ams-v2-1-b37825d708e1@linaro.org
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 ++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  5 +++
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 32 +++++++++++--------
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  | 13 ++++++--
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   | 11 ++++++-
 5 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index cf7d769ab3b95..708657598cce4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1200,6 +1200,8 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 		phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[i]);
 
 		phys->cached_mode = crtc_state->adjusted_mode;
+		if (phys->ops.atomic_mode_set)
+			phys->ops.atomic_mode_set(phys, crtc_state, conn_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 002e89cc17058..30470cd15a484 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -69,6 +69,8 @@ struct dpu_encoder_phys;
  * @is_master:			Whether this phys_enc is the current master
  *				encoder. Can be switched at enable time. Based
  *				on split_role and current mode (CMD/VID).
+ * @atomic_mode_set:		DRM Call. Set a DRM mode.
+ *				This likely caches the mode, for use at enable.
  * @enable:			DRM Call. Enable a DRM mode.
  * @disable:			DRM Call. Disable mode.
  * @control_vblank_irq		Register/Deregister for VBLANK IRQ
@@ -93,6 +95,9 @@ struct dpu_encoder_phys;
 struct dpu_encoder_phys_ops {
 	void (*prepare_commit)(struct dpu_encoder_phys *encoder);
 	bool (*is_master)(struct dpu_encoder_phys *encoder);
+	void (*atomic_mode_set)(struct dpu_encoder_phys *encoder,
+			struct drm_crtc_state *crtc_state,
+			struct drm_connector_state *conn_state);
 	void (*enable)(struct dpu_encoder_phys *encoder);
 	void (*disable)(struct dpu_encoder_phys *encoder);
 	int (*control_vblank_irq)(struct dpu_encoder_phys *enc, bool enable);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 489be1c0c7046..95cd39b496688 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -142,6 +142,23 @@ static void dpu_encoder_phys_cmd_underrun_irq(void *arg)
 	dpu_encoder_underrun_callback(phys_enc->parent, phys_enc);
 }
 
+static void dpu_encoder_phys_cmd_atomic_mode_set(
+		struct dpu_encoder_phys *phys_enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state)
+{
+	phys_enc->irq[INTR_IDX_CTL_START] = phys_enc->hw_ctl->caps->intr_start;
+
+	phys_enc->irq[INTR_IDX_PINGPONG] = phys_enc->hw_pp->caps->intr_done;
+
+	if (phys_enc->has_intf_te)
+		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_intf->cap->intr_tear_rd_ptr;
+	else
+		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_pp->caps->intr_rdptr;
+
+	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
+}
+
 static int _dpu_encoder_phys_cmd_handle_ppdone_timeout(
 		struct dpu_encoder_phys *phys_enc)
 {
@@ -280,14 +297,6 @@ static void dpu_encoder_phys_cmd_irq_enable(struct dpu_encoder_phys *phys_enc)
 					  phys_enc->hw_pp->idx - PINGPONG_0,
 					  phys_enc->vblank_refcount);
 
-	phys_enc->irq[INTR_IDX_CTL_START] = phys_enc->hw_ctl->caps->intr_start;
-	phys_enc->irq[INTR_IDX_PINGPONG] = phys_enc->hw_pp->caps->intr_done;
-
-	if (phys_enc->has_intf_te)
-		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_intf->cap->intr_tear_rd_ptr;
-	else
-		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_pp->caps->intr_rdptr;
-
 	dpu_core_irq_register_callback(phys_enc->dpu_kms,
 				       phys_enc->irq[INTR_IDX_PINGPONG],
 				       dpu_encoder_phys_cmd_pp_tx_done_irq,
@@ -318,10 +327,6 @@ static void dpu_encoder_phys_cmd_irq_disable(struct dpu_encoder_phys *phys_enc)
 	dpu_core_irq_unregister_callback(phys_enc->dpu_kms, phys_enc->irq[INTR_IDX_UNDERRUN]);
 	dpu_encoder_phys_cmd_control_vblank_irq(phys_enc, false);
 	dpu_core_irq_unregister_callback(phys_enc->dpu_kms, phys_enc->irq[INTR_IDX_PINGPONG]);
-
-	phys_enc->irq[INTR_IDX_CTL_START] = 0;
-	phys_enc->irq[INTR_IDX_PINGPONG] = 0;
-	phys_enc->irq[INTR_IDX_RDPTR] = 0;
 }
 
 static void dpu_encoder_phys_cmd_tearcheck_config(
@@ -698,6 +703,7 @@ static void dpu_encoder_phys_cmd_init_ops(
 		struct dpu_encoder_phys_ops *ops)
 {
 	ops->is_master = dpu_encoder_phys_cmd_is_master;
+	ops->atomic_mode_set = dpu_encoder_phys_cmd_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_cmd_enable;
 	ops->disable = dpu_encoder_phys_cmd_disable;
 	ops->control_vblank_irq = dpu_encoder_phys_cmd_control_vblank_irq;
@@ -736,8 +742,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(struct drm_device *dev,
 
 	dpu_encoder_phys_cmd_init_ops(&phys_enc->ops);
 	phys_enc->intf_mode = INTF_MODE_CMD;
-	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
-
 	cmd_enc->stream_sel = 0;
 
 	if (!phys_enc->hw_intf) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index ef69c2f408c3e..636a97432d517 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -356,6 +356,16 @@ static bool dpu_encoder_phys_vid_needs_single_flush(
 	return phys_enc->split_role != ENC_ROLE_SOLO;
 }
 
+static void dpu_encoder_phys_vid_atomic_mode_set(
+		struct dpu_encoder_phys *phys_enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state)
+{
+	phys_enc->irq[INTR_IDX_VSYNC] = phys_enc->hw_intf->cap->intr_vsync;
+
+	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
+}
+
 static int dpu_encoder_phys_vid_control_vblank_irq(
 		struct dpu_encoder_phys *phys_enc,
 		bool enable)
@@ -699,6 +709,7 @@ static int dpu_encoder_phys_vid_get_frame_count(
 static void dpu_encoder_phys_vid_init_ops(struct dpu_encoder_phys_ops *ops)
 {
 	ops->is_master = dpu_encoder_phys_vid_is_master;
+	ops->atomic_mode_set = dpu_encoder_phys_vid_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_vid_enable;
 	ops->disable = dpu_encoder_phys_vid_disable;
 	ops->control_vblank_irq = dpu_encoder_phys_vid_control_vblank_irq;
@@ -737,8 +748,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(struct drm_device *dev,
 
 	dpu_encoder_phys_vid_init_ops(&phys_enc->ops);
 	phys_enc->intf_mode = INTF_MODE_VIDEO;
-	phys_enc->irq[INTR_IDX_VSYNC] = phys_enc->hw_intf->cap->intr_vsync;
-	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
 
 	DPU_DEBUG_VIDENC(phys_enc, "created intf idx:%d\n", p->hw_intf->idx);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index d3ea91c1d7d2e..356dca5e5ea94 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -404,6 +404,15 @@ static void dpu_encoder_phys_wb_irq_disable(struct dpu_encoder_phys *phys)
 		dpu_core_irq_unregister_callback(phys->dpu_kms, phys->irq[INTR_IDX_WB_DONE]);
 }
 
+static void dpu_encoder_phys_wb_atomic_mode_set(
+		struct dpu_encoder_phys *phys_enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state)
+{
+
+	phys_enc->irq[INTR_IDX_WB_DONE] = phys_enc->hw_wb->caps->intr_wb_done;
+}
+
 static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
 		struct dpu_encoder_phys *phys_enc)
 {
@@ -640,6 +649,7 @@ static bool dpu_encoder_phys_wb_is_valid_for_commit(struct dpu_encoder_phys *phy
 static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
 {
 	ops->is_master = dpu_encoder_phys_wb_is_master;
+	ops->atomic_mode_set = dpu_encoder_phys_wb_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_wb_enable;
 	ops->disable = dpu_encoder_phys_wb_disable;
 	ops->wait_for_commit_done = dpu_encoder_phys_wb_wait_for_commit_done;
@@ -685,7 +695,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_wb_init(struct drm_device *dev,
 
 	dpu_encoder_phys_wb_init_ops(&phys_enc->ops);
 	phys_enc->intf_mode = INTF_MODE_WB_LINE;
-	phys_enc->irq[INTR_IDX_WB_DONE] = phys_enc->hw_wb->caps->intr_wb_done;
 
 	atomic_set(&wb_enc->wbirq_refcount, 0);
 
-- 
2.43.0





Return-Path: <stable+bounces-70648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC9960F58
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CA51C21048
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6F1C6F46;
	Tue, 27 Aug 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EI19m6aT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F431C6F43;
	Tue, 27 Aug 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770607; cv=none; b=dXQRP95/pz9h3KG7XMht1uVbw77mpWku1NsAt/pDi5K2/dEfszWk7WviaZFgwV/GYGiHy2jjsjX4x+lOaZ85BEpP+iQQsxdFzTCTSLBPz0Fcsi/k0p1wxvkv8JTvGhTEE++wiU9cgA2+aks5vQnFQWDcu/2TBII1UbYWIEVAju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770607; c=relaxed/simple;
	bh=QNrnfKu36pSK91mCzn4vQ+uTbQDEm+Ow9XcOGeZ7yT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vrmv5dvKWLjginaHyaOMsCJst5XuAl2NQqXKoOjJJSuQQuxRWHhA/KYUJf2oW3sgstUQhLPFnqgLyfArFEUPxJGSOMixEAye0cGMzU2Y/skJc3ictKvoLcsjOJHBPzSiaVWchhwCxWEIPsynXZY2ReejDWmxqQ08Th7Wlynhl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EI19m6aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076FDC4FE02;
	Tue, 27 Aug 2024 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770607;
	bh=QNrnfKu36pSK91mCzn4vQ+uTbQDEm+Ow9XcOGeZ7yT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EI19m6aTTHpW8Fca6AmWzp7UoeZGt2pVn2L0RZt11KgecTc2WBop2uGZ7TJ7UDp/H
	 QXahUGOPmyO7mX/aRDrHp7vwZexFxf0oorP7QE0LP2Z8Hej7j44yskhYiC9cRktfdd
	 Ie1cufVyrRBDTkCY/plIehJM8HHk/Zwb4+B+jUdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 279/341] drm/msm/dpu: use drmm-managed allocation for dpu_encoder_phys
Date: Tue, 27 Aug 2024 16:38:30 +0200
Message-ID: <20240827143854.016594009@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 73169b45e1ed296b4357a694f5fa586ac0643ac1 ]

Change struct allocation of encoder's phys backend data to use
drmm_kzalloc(). This removes the need to perform any actions on encoder
destruction.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/570051/
Link: https://lore.kernel.org/r/20231201211845.1026967-12-dmitry.baryshkov@linaro.org
Stable-dep-of: aedf02e46eb5 ("drm/msm/dpu: move dpu_encoder's connector assignment to atomic_enable()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  9 ++++----
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  8 ++++---
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 15 ++++---------
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  | 13 ++++--------
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   | 21 ++++---------------
 5 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index e454b80907121..781adb5e2c595 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2172,6 +2172,7 @@ static void dpu_encoder_early_unregister(struct drm_encoder *encoder)
 }
 
 static int dpu_encoder_virt_add_phys_encs(
+		struct drm_device *dev,
 		struct msm_display_info *disp_info,
 		struct dpu_encoder_virt *dpu_enc,
 		struct dpu_enc_phys_init_params *params)
@@ -2193,7 +2194,7 @@ static int dpu_encoder_virt_add_phys_encs(
 
 
 	if (disp_info->intf_type == INTF_WB) {
-		enc = dpu_encoder_phys_wb_init(params);
+		enc = dpu_encoder_phys_wb_init(dev, params);
 
 		if (IS_ERR(enc)) {
 			DPU_ERROR_ENC(dpu_enc, "failed to init wb enc: %ld\n",
@@ -2204,7 +2205,7 @@ static int dpu_encoder_virt_add_phys_encs(
 		dpu_enc->phys_encs[dpu_enc->num_phys_encs] = enc;
 		++dpu_enc->num_phys_encs;
 	} else if (disp_info->is_cmd_mode) {
-		enc = dpu_encoder_phys_cmd_init(params);
+		enc = dpu_encoder_phys_cmd_init(dev, params);
 
 		if (IS_ERR(enc)) {
 			DPU_ERROR_ENC(dpu_enc, "failed to init cmd enc: %ld\n",
@@ -2215,7 +2216,7 @@ static int dpu_encoder_virt_add_phys_encs(
 		dpu_enc->phys_encs[dpu_enc->num_phys_encs] = enc;
 		++dpu_enc->num_phys_encs;
 	} else {
-		enc = dpu_encoder_phys_vid_init(params);
+		enc = dpu_encoder_phys_vid_init(dev, params);
 
 		if (IS_ERR(enc)) {
 			DPU_ERROR_ENC(dpu_enc, "failed to init vid enc: %ld\n",
@@ -2304,7 +2305,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 			break;
 		}
 
-		ret = dpu_encoder_virt_add_phys_encs(disp_info,
+		ret = dpu_encoder_virt_add_phys_encs(dpu_kms->dev, disp_info,
 				dpu_enc, &phys_params);
 		if (ret) {
 			DPU_ERROR_ENC(dpu_enc, "failed to add phys encs\n");
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index f91661a698882..99997707b0ee9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -281,22 +281,24 @@ struct dpu_encoder_wait_info {
  * @p:	Pointer to init params structure
  * Return: Error code or newly allocated encoder
  */
-struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
+struct dpu_encoder_phys *dpu_encoder_phys_vid_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p);
 
 /**
  * dpu_encoder_phys_cmd_init - Construct a new command mode physical encoder
+ * @dev:  Corresponding device for devres management
  * @p:	Pointer to init params structure
  * Return: Error code or newly allocated encoder
  */
-struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(
+struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p);
 
 /**
  * dpu_encoder_phys_wb_init - initialize writeback encoder
+ * @dev:  Corresponding device for devres management
  * @init:	Pointer to init info structure with initialization params
  */
-struct dpu_encoder_phys *dpu_encoder_phys_wb_init(
+struct dpu_encoder_phys *dpu_encoder_phys_wb_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p);
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 718421306247f..548be5cf07be8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -13,6 +13,8 @@
 #include "dpu_trace.h"
 #include "disp/msm_disp_snapshot.h"
 
+#include <drm/drm_managed.h>
+
 #define DPU_DEBUG_CMDENC(e, fmt, ...) DPU_DEBUG("enc%d intf%d " fmt, \
 		(e) && (e)->base.parent ? \
 		(e)->base.parent->base.id : -1, \
@@ -564,14 +566,6 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
 	phys_enc->enable_state = DPU_ENC_DISABLED;
 }
 
-static void dpu_encoder_phys_cmd_destroy(struct dpu_encoder_phys *phys_enc)
-{
-	struct dpu_encoder_phys_cmd *cmd_enc =
-		to_dpu_encoder_phys_cmd(phys_enc);
-
-	kfree(cmd_enc);
-}
-
 static void dpu_encoder_phys_cmd_prepare_for_kickoff(
 		struct dpu_encoder_phys *phys_enc)
 {
@@ -737,7 +731,6 @@ static void dpu_encoder_phys_cmd_init_ops(
 	ops->atomic_mode_set = dpu_encoder_phys_cmd_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_cmd_enable;
 	ops->disable = dpu_encoder_phys_cmd_disable;
-	ops->destroy = dpu_encoder_phys_cmd_destroy;
 	ops->control_vblank_irq = dpu_encoder_phys_cmd_control_vblank_irq;
 	ops->wait_for_commit_done = dpu_encoder_phys_cmd_wait_for_commit_done;
 	ops->prepare_for_kickoff = dpu_encoder_phys_cmd_prepare_for_kickoff;
@@ -752,7 +745,7 @@ static void dpu_encoder_phys_cmd_init_ops(
 	ops->get_line_count = dpu_encoder_phys_cmd_get_line_count;
 }
 
-struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(
+struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p)
 {
 	struct dpu_encoder_phys *phys_enc = NULL;
@@ -760,7 +753,7 @@ struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(
 
 	DPU_DEBUG("intf\n");
 
-	cmd_enc = kzalloc(sizeof(*cmd_enc), GFP_KERNEL);
+	cmd_enc = drmm_kzalloc(dev, sizeof(*cmd_enc), GFP_KERNEL);
 	if (!cmd_enc) {
 		DPU_ERROR("failed to allocate\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index aec3ca4aa0fb7..ab26e21871235 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -11,6 +11,8 @@
 #include "dpu_trace.h"
 #include "disp/msm_disp_snapshot.h"
 
+#include <drm/drm_managed.h>
+
 #define DPU_DEBUG_VIDENC(e, fmt, ...) DPU_DEBUG("enc%d intf%d " fmt, \
 		(e) && (e)->parent ? \
 		(e)->parent->base.id : -1, \
@@ -441,12 +443,6 @@ static void dpu_encoder_phys_vid_enable(struct dpu_encoder_phys *phys_enc)
 		phys_enc->enable_state = DPU_ENC_ENABLING;
 }
 
-static void dpu_encoder_phys_vid_destroy(struct dpu_encoder_phys *phys_enc)
-{
-	DPU_DEBUG_VIDENC(phys_enc, "\n");
-	kfree(phys_enc);
-}
-
 static int dpu_encoder_phys_vid_wait_for_vblank(
 		struct dpu_encoder_phys *phys_enc)
 {
@@ -684,7 +680,6 @@ static void dpu_encoder_phys_vid_init_ops(struct dpu_encoder_phys_ops *ops)
 	ops->atomic_mode_set = dpu_encoder_phys_vid_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_vid_enable;
 	ops->disable = dpu_encoder_phys_vid_disable;
-	ops->destroy = dpu_encoder_phys_vid_destroy;
 	ops->control_vblank_irq = dpu_encoder_phys_vid_control_vblank_irq;
 	ops->wait_for_commit_done = dpu_encoder_phys_vid_wait_for_commit_done;
 	ops->wait_for_vblank = dpu_encoder_phys_vid_wait_for_vblank;
@@ -697,7 +692,7 @@ static void dpu_encoder_phys_vid_init_ops(struct dpu_encoder_phys_ops *ops)
 	ops->get_frame_count = dpu_encoder_phys_vid_get_frame_count;
 }
 
-struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
+struct dpu_encoder_phys *dpu_encoder_phys_vid_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p)
 {
 	struct dpu_encoder_phys *phys_enc = NULL;
@@ -707,7 +702,7 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
 		return ERR_PTR(-EINVAL);
 	}
 
-	phys_enc = kzalloc(sizeof(*phys_enc), GFP_KERNEL);
+	phys_enc = drmm_kzalloc(dev, sizeof(*phys_enc), GFP_KERNEL);
 	if (!phys_enc) {
 		DPU_ERROR("failed to create encoder due to memory allocation error\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index a81a9ee71a86c..0a45c546b03f2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -8,6 +8,7 @@
 #include <linux/debugfs.h>
 
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 
 #include "dpu_encoder_phys.h"
 #include "dpu_formats.h"
@@ -546,20 +547,6 @@ static void dpu_encoder_phys_wb_disable(struct dpu_encoder_phys *phys_enc)
 	phys_enc->enable_state = DPU_ENC_DISABLED;
 }
 
-/**
- * dpu_encoder_phys_wb_destroy - destroy writeback encoder
- * @phys_enc:	Pointer to physical encoder
- */
-static void dpu_encoder_phys_wb_destroy(struct dpu_encoder_phys *phys_enc)
-{
-	if (!phys_enc)
-		return;
-
-	DPU_DEBUG("[wb:%d]\n", phys_enc->hw_wb->idx - WB_0);
-
-	kfree(phys_enc);
-}
-
 static void dpu_encoder_phys_wb_prepare_wb_job(struct dpu_encoder_phys *phys_enc,
 		struct drm_writeback_job *job)
 {
@@ -655,7 +642,6 @@ static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
 	ops->atomic_mode_set = dpu_encoder_phys_wb_atomic_mode_set;
 	ops->enable = dpu_encoder_phys_wb_enable;
 	ops->disable = dpu_encoder_phys_wb_disable;
-	ops->destroy = dpu_encoder_phys_wb_destroy;
 	ops->atomic_check = dpu_encoder_phys_wb_atomic_check;
 	ops->wait_for_commit_done = dpu_encoder_phys_wb_wait_for_commit_done;
 	ops->prepare_for_kickoff = dpu_encoder_phys_wb_prepare_for_kickoff;
@@ -671,9 +657,10 @@ static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
 
 /**
  * dpu_encoder_phys_wb_init - initialize writeback encoder
+ * @dev:  Corresponding device for devres management
  * @p:	Pointer to init info structure with initialization params
  */
-struct dpu_encoder_phys *dpu_encoder_phys_wb_init(
+struct dpu_encoder_phys *dpu_encoder_phys_wb_init(struct drm_device *dev,
 		struct dpu_enc_phys_init_params *p)
 {
 	struct dpu_encoder_phys *phys_enc = NULL;
@@ -686,7 +673,7 @@ struct dpu_encoder_phys *dpu_encoder_phys_wb_init(
 		return ERR_PTR(-EINVAL);
 	}
 
-	wb_enc = kzalloc(sizeof(*wb_enc), GFP_KERNEL);
+	wb_enc = drmm_kzalloc(dev, sizeof(*wb_enc), GFP_KERNEL);
 	if (!wb_enc) {
 		DPU_ERROR("failed to allocate wb phys_enc enc\n");
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0





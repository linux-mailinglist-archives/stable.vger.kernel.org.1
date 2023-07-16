Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF15755645
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjGPUtT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjGPUtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4081993
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F67E60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE803C433C8;
        Sun, 16 Jul 2023 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540535;
        bh=I+3OQkLs442Tg4i9RReKM4Qa60xNpw0cpAap41heIeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TM4oHZv0/ReUK72QepgD4b1JL/hN+268bvidg7zPB07JRtlyJFAEPbJfx8jWgGRT5
         FvdKnX1r4HU+9zrZwRMKXflZcNUa90+HqOdUewbQRAgJjUH73i7NSOgaGsrAgQZk2W
         A2S3mqQ4ZsG9sBRU78L5FV20ZkGOxiaDElVU8mas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 397/591] media: amphion: initiate a drain of the capture queue in dynamic resolution change
Date:   Sun, 16 Jul 2023 21:48:56 +0200
Message-ID: <20230716194934.189414617@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 076b6289b2c12d76fab248659896682830fa7766 ]

The last buffer from before the change must be marked
with the V4L2_BUF_FLAG_LAST flag,
similarly to the Drain sequence above.

initiate a drain of the capture queue in dynamic resolution change

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vdec.c     | 7 ++++---
 drivers/media/platform/amphion/venc.c     | 4 ++--
 drivers/media/platform/amphion/vpu_v4l2.c | 5 +++--
 drivers/media/platform/amphion/vpu_v4l2.h | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 4918547793dc1..c08b5a2bfc1df 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -229,6 +229,7 @@ static void vdec_handle_resolution_change(struct vpu_inst *inst)
 
 	vdec->source_change--;
 	vpu_notify_source_change(inst);
+	vpu_set_last_buffer_dequeued(inst, false);
 }
 
 static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state state, u32 force)
@@ -264,7 +265,7 @@ static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
 		return;
 
 	if (vdec->eos_received) {
-		if (!vpu_set_last_buffer_dequeued(inst)) {
+		if (!vpu_set_last_buffer_dequeued(inst, true)) {
 			vdec->eos_received--;
 			vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
 		}
@@ -517,7 +518,7 @@ static int vdec_drain(struct vpu_inst *inst)
 		return 0;
 
 	if (!vdec->params.frame_count) {
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 		return 0;
 	}
 
@@ -556,7 +557,7 @@ static int vdec_cmd_stop(struct vpu_inst *inst)
 	vpu_trace(inst->dev, "[%d]\n", inst->id);
 
 	if (inst->state == VPU_CODEC_STATE_DEINIT) {
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 	} else {
 		vdec->drain = 1;
 		vdec_drain(inst);
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 37212f087fdd9..e8cb22da938e6 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -468,7 +468,7 @@ static int venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd
 	vpu_inst_lock(inst);
 	if (cmd->cmd == V4L2_ENC_CMD_STOP) {
 		if (inst->state == VPU_CODEC_STATE_DEINIT)
-			vpu_set_last_buffer_dequeued(inst);
+			vpu_set_last_buffer_dequeued(inst, true);
 		else
 			venc_request_eos(inst);
 	}
@@ -888,7 +888,7 @@ static void venc_set_last_buffer_dequeued(struct vpu_inst *inst)
 	struct venc_t *venc = inst->priv;
 
 	if (venc->stopped && list_empty(&venc->frames))
-		vpu_set_last_buffer_dequeued(inst);
+		vpu_set_last_buffer_dequeued(inst, true);
 }
 
 static void venc_stop_done(struct vpu_inst *inst)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 590d1084e5a5d..a74953191c221 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -100,7 +100,7 @@ int vpu_notify_source_change(struct vpu_inst *inst)
 	return 0;
 }
 
-int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst, bool eos)
 {
 	struct vb2_queue *q;
 
@@ -116,7 +116,8 @@ int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
 	vpu_trace(inst->dev, "last buffer dequeued\n");
 	q->last_buffer_dequeued = true;
 	wake_up(&q->done_wq);
-	vpu_notify_eos(inst);
+	if (eos)
+		vpu_notify_eos(inst);
 	return 0;
 }
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 795ca33a6a507..000af24a06ba0 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -26,7 +26,7 @@ struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32
 void vpu_v4l2_set_error(struct vpu_inst *inst);
 int vpu_notify_eos(struct vpu_inst *inst);
 int vpu_notify_source_change(struct vpu_inst *inst);
-int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst, bool eos);
 void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
 bool vpu_is_source_empty(struct vpu_inst *inst);
-- 
2.39.2




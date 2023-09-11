Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994879BABF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbjIKU5L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjIKOOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:14:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BDEDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD635C433C7;
        Mon, 11 Sep 2023 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441661;
        bh=7GAZNmN6y9LueGpK70YcXC+Q1W8lhJB5vaP1smqYbpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eklWwgSPfqHxpfvHFabIToX7EEvYFsX8+2gGv4xi8HuudLah7jw+9A0IR5G9mDbAZ
         R5IIeg+CkZcEi6ILKuXuYB49tKi0Namab8pX8Nlr46dTfuXXKsH9pN/8mCQk86hCYd
         e36oXMrLEaMo6VMYZ7KN/d3ydGb0Z0SOTE7MlKU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 465/739] media: amphion: reinit vpu if reqbufs output 0
Date:   Mon, 11 Sep 2023 15:44:24 +0200
Message-ID: <20230911134704.138005297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 73e3f09292a0492a3fe0f87a8170a74f12624c5e ]

according to v4l2 stateful decoder document 4.5.1.3. State Machine,
the state should change from seek to initialization
if call VIDIOC_REQBUFS(OUTPUT, 0).

so reinit the vpu decoder if reqbufs output 0

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vdec.c     | 2 --
 drivers/media/platform/amphion/vpu_v4l2.c | 7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 6515f3cdb7a74..56c4deea4494d 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -1453,9 +1453,7 @@ static void vdec_release(struct vpu_inst *inst)
 {
 	if (inst->id != VPU_INST_NULL_ID)
 		vpu_trace(inst->dev, "[%d]\n", inst->id);
-	vpu_inst_lock(inst);
 	vdec_stop(inst, true);
-	vpu_inst_unlock(inst);
 }
 
 static void vdec_cleanup(struct vpu_inst *inst)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 021235e1c1446..0f6e4c666440e 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -489,6 +489,11 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 	for (i = 0; i < cur_fmt->mem_planes; i++)
 		psize[i] = vpu_get_fmt_plane_size(cur_fmt, i);
 
+	if (V4L2_TYPE_IS_OUTPUT(vq->type) && inst->state == VPU_CODEC_STATE_SEEK) {
+		vpu_trace(inst->dev, "reinit when VIDIOC_REQBUFS(OUTPUT, 0)\n");
+		call_void_vop(inst, release);
+	}
+
 	return 0;
 }
 
@@ -773,9 +778,9 @@ int vpu_v4l2_close(struct file *file)
 		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
 		inst->fh.m2m_ctx = NULL;
 	}
+	call_void_vop(inst, release);
 	vpu_inst_unlock(inst);
 
-	call_void_vop(inst, release);
 	vpu_inst_unregister(inst);
 	vpu_inst_put(inst);
 
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5979BCD3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbjIKVk3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjIKOOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:14:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076FDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319CC433C8;
        Mon, 11 Sep 2023 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441672;
        bh=jN9KlSnRKI82cAjrhrzOJ1d1ZNBmO3Hq6loWBhrmFxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLvS3erR9cO9G56f9A0TFEdu9Whs0p3NFUZ+iPN5HSACyasgDe3r0tOqDPBDLkjt7
         H+/G+Oat9m61QeRqS8zeV1SWNhZTcqYrlGYmm+rbSS7w/m5Tzewge12nssb7r9+6af
         dHqEnc2/O2ae/8VUgkGGiHSw9ZtOlJEjv9HTg8SU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 469/739] media: amphion: decoder support display delay for all formats
Date:   Mon, 11 Sep 2023 15:44:28 +0200
Message-ID: <20230911134704.246448089@linuxfoundation.org>
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

[ Upstream commit b69713f502027150ecc08e663fa1804d78b3ef42 ]

the firmware only support low latency mode for h264,
but firmware will notify an event to driver
when one frame is decoded,
if V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE is enabled,
and V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY is set to 0,
driver can display the decoded frame immediately.

Fixes: ffa331d9bf94 ("media: amphion: decoder implement display delay enable")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vdec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 60f3a73c6a8ad..eeb2ef72df5b3 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -742,6 +742,21 @@ static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
 	vdec->decoded_frame_count++;
+	if (vdec->params.display_delay_enable) {
+		struct vpu_format *cur_fmt;
+
+		cur_fmt = vpu_get_format(inst, inst->cap_format.type);
+		vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
+		for (int i = 0; i < vbuf->vb2_buf.num_planes; i++)
+			vb2_set_plane_payload(&vbuf->vb2_buf,
+					      i, vpu_get_fmt_plane_size(cur_fmt, i));
+		vbuf->field = cur_fmt->field;
+		vbuf->sequence = vdec->sequence++;
+		dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
+
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+		vdec->display_frame_count++;
+	}
 exit:
 	vpu_inst_unlock(inst);
 
@@ -769,14 +784,14 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	struct vpu_format *cur_fmt;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
-	u32 sequence;
 	int i;
 
 	if (!frame)
 		return;
 
 	vpu_inst_lock(inst);
-	sequence = vdec->sequence++;
+	if (!vdec->params.display_delay_enable)
+		vdec->sequence++;
 	vpu_buf = vdec_find_buffer(inst, frame->luma);
 	vpu_inst_unlock(inst);
 	if (!vpu_buf) {
@@ -795,13 +810,17 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
 			inst->id, vbuf->vb2_buf.index, frame->id);
 
+	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_READY && vdec->params.display_delay_enable)
+		return;
+
 	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_DECODED)
 		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id, frame->id);
+
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
 	for (i = 0; i < vbuf->vb2_buf.num_planes; i++)
 		vb2_set_plane_payload(&vbuf->vb2_buf, i, vpu_get_fmt_plane_size(cur_fmt, i));
 	vbuf->field = cur_fmt->field;
-	vbuf->sequence = sequence;
+	vbuf->sequence = vdec->sequence;
 	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
-- 
2.40.1




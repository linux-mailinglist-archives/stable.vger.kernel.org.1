Return-Path: <stable+bounces-204938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FDCF5A36
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07B830223F8
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB132DECBA;
	Mon,  5 Jan 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc9lGJ4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8E285CA7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647893; cv=none; b=bPoXkVMWoJhul8Cz2xfcuHOf1CTKvsULdzNnJHLfi8fUEMY2t4FfBDYfQC9feot91EbDmZoaDYCTt0+wAwGqsOgzOoJ6dg4eRgtd9Nqsfy+sMMuVkZOSmRstL/1FPajkv7+i5qBjMLuzqMvkEBjdXWJUfKDNuV4VhXQsHoAMmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647893; c=relaxed/simple;
	bh=R3Ih5UA8c7z1IUE1FTFaFxF17qhKOVqnVR7OH8Yro2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAahqkcLSpinINTgr/3ZOa9SM/14xiWYsJiNAhJifKKAR0N5dhw3wxl7LBiFQVfaaZTDxw1g/9LKrHrafSSjyPyKVhQD9vtFDYjrMdaTRgsnOeqhoLcLvRCKwMwcnrL9e3HmqXuWHY/5xZe3UqVIZXZZ63gEt9w+R4C/Bqw0Qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc9lGJ4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62589C16AAE;
	Mon,  5 Jan 2026 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647892;
	bh=R3Ih5UA8c7z1IUE1FTFaFxF17qhKOVqnVR7OH8Yro2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc9lGJ4VlRDN17TZ8x9hEkBuJKKth2bGIhWgIGxeNdXhJAPV98pWlqQ7GAN60DjQd
	 SMNVRyP8/HmBJIla9rwdVSy5RljpEEtuqJbhHVSxYavPUTI16/Agi/ylDWONzVVP6U
	 vIXfQA0iWvKB9wt76poqRfvh1XP81VsQUIGXYVfYDUA8odiWhzf3c8vCTdB6KWvoYu
	 7SMpc/SnHR2+OnLCegUrnir81nut25MaoaeyBJiu9BT/PWBM3mugbguZQOBVgA7Ev8
	 goSIQblEV+Fg68gDT2op3oFkV3CMkI2TBZIzYasx8xLmVgTUIHCaPXTfs1Fm5DDeUv
	 aPQeXD1FJAXXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] media: amphion: Remove vpu_vb_is_codecconfig
Date: Mon,  5 Jan 2026 16:18:09 -0500
Message-ID: <20260105211809.2802485-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105211809.2802485-1-sashal@kernel.org>
References: <2026010509-cardstock-selection-ef9d@gregkh>
 <20260105211809.2802485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Qian <ming.qian@oss.nxp.com>

[ Upstream commit 634c2cd17bd021487c57b95973bddb14be8002ff ]

Currently the function vpu_vb_is_codecconfig() always returns 0.
Delete it and its related code.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_malone.c | 23 +++------------------
 drivers/media/platform/amphion/vpu_v4l2.c   | 10 ---------
 drivers/media/platform/amphion/vpu_v4l2.h   | 10 ---------
 3 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 4fbf179d98dc..8418dd5ea253 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1320,22 +1320,18 @@ static int vpu_malone_insert_scode_vc1_g_seq(struct malone_scode_t *scode)
 {
 	if (!scode->inst->total_input_count)
 		return 0;
-	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
-		scode->need_data = 0;
 	return 0;
 }
 
 static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 {
-	struct vb2_v4l2_buffer *vbuf;
 	u8 nal_hdr[MALONE_VC1_NAL_HEADER_LEN];
 	u32 *data = NULL;
 	int ret;
 
-	vbuf = to_vb2_v4l2_buffer(scode->vb);
 	data = vb2_plane_vaddr(scode->vb, 0);
 
-	if (scode->inst->total_input_count == 0 || vpu_vb_is_codecconfig(vbuf))
+	if (scode->inst->total_input_count == 0)
 		return 0;
 	if (MALONE_VC1_CONTAIN_NAL(*data))
 		return 0;
@@ -1356,8 +1352,6 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
-	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
-		scode->need_data = 0;
 	if (scode->inst->total_input_count)
 		return 0;
 	scode->need_data = 0;
@@ -1543,7 +1537,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	scode.vb = vb;
 	scode.wptr = wptr;
 	scode.need_data = 1;
-	if (vbuf->sequence == 0 || vpu_vb_is_codecconfig(vbuf))
+	if (vbuf->sequence == 0)
 		ret = vpu_malone_insert_scode(&scode, SCODE_SEQUENCE);
 
 	if (ret < 0)
@@ -1579,7 +1573,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	 * This module is currently only supported for the H264 and HEVC formats,
 	 * for other formats, vpu_malone_add_scode() will return 0.
 	 */
-	if ((disp_imm || low_latency) && !vpu_vb_is_codecconfig(vbuf)) {
+	if (disp_imm || low_latency) {
 		ret = vpu_malone_add_scode(inst->core->iface,
 					   inst->id,
 					   &inst->stream_buffer,
@@ -1626,7 +1620,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
 			   struct vpu_inst *inst, struct vb2_buffer *vb)
 {
 	struct vpu_dec_ctrl *hc = shared->priv;
-	struct vb2_v4l2_buffer *vbuf;
 	struct vpu_malone_str_buffer __iomem *str_buf = hc->str_buf[inst->id];
 	u32 disp_imm = hc->codec_param[inst->id].disp_imm;
 	u32 size;
@@ -1640,16 +1633,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
 		return ret;
 	size = ret;
 
-	/*
-	 * if buffer only contain codec data, and the timestamp is invalid,
-	 * don't put the invalid timestamp to resync
-	 * merge the data to next frame
-	 */
-	vbuf = to_vb2_v4l2_buffer(vb);
-	if (vpu_vb_is_codecconfig(vbuf)) {
-		inst->extra_size += size;
-		return 0;
-	}
 	if (inst->extra_size) {
 		size += inst->extra_size;
 		inst->extra_size = 0;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index e122603b37e8..f54f2042430a 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -342,16 +342,6 @@ struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst)
 	if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
 		return NULL;
 
-	while (vpu_vb_is_codecconfig(src_buf)) {
-		v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
-		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
-		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
-
-		src_buf = v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
-		if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
-			return NULL;
-	}
-
 	return src_buf;
 }
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 064f61773f62..4ec7f0b44172 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -38,14 +38,4 @@ static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
 	else
 		return &inst->cap_format;
 }
-
-static inline int vpu_vb_is_codecconfig(struct vb2_v4l2_buffer *vbuf)
-{
-#ifdef V4L2_BUF_FLAG_CODECCONFIG
-	return (vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG) ? 1 : 0;
-#else
-	return 0;
-#endif
-}
-
 #endif
-- 
2.51.0



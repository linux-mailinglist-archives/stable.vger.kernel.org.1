Return-Path: <stable+bounces-204927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880FCF5999
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B1D13033642
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34662D8379;
	Mon,  5 Jan 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX/qeiDW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DD2D7DE2
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647136; cv=none; b=JCe3jpEdx6LgpP8J9zxAUW5BxZOrvtUka8mc+jxOvgtAsD3DWP9yGIOUQy4Sn6l+JHblSmKZtc4Mw8CmQfR7xPKfjtwjpBLpbcVKFB0r1zIDqg2aEn2p9zhbhcfbyFfLyXj9cy4OJHb3mBg+pP2DefnK7K8curSRyjHHYy+xlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647136; c=relaxed/simple;
	bh=4HaqLv+MdiTD8Aryypsc4bv7n4avsx1yzwqY6bTaArI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS/AZweHVkRD71GSmgkpAPb0+NQZfPgVc64uU8SouS7a3J53fa8Sa6yKUlEiN+p9D3tfNY7M53bZctYnW18Sr6B8N5j3RaknbZj5hx3dbfaKqphe8b5UPtBaHjSRFf0nRpVipflICNvNLScA5KuqAPVmXFHsp1dONog+RSIdD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX/qeiDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6B7C19422;
	Mon,  5 Jan 2026 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647136;
	bh=4HaqLv+MdiTD8Aryypsc4bv7n4avsx1yzwqY6bTaArI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VX/qeiDWswDs8+JFgPaPAouRkoJd26FATQrFivgiGDdeUE/+iTDlUaqcQSjhqoMIY
	 6I3IhagCkSH3KSFGCZEDdmKPedpAOkiHA6FX4JX49XD9vIcntWzBYNB0YmPHWYb4BO
	 5PaEATUygU/j/9k4YZLbjFuJpt/5Aa0DofcAYz70WhzyPJ0qJpgJEd0hBlKHmEXeF3
	 7JyrYARw4RqjWRElCX5iRNTBSohkobZH9OHyNS7c1LAFqp5xs3BEMTgocBGxH4EavS
	 qRKx1ByGurMB1qP4hKsGYFgJDXCLiHa8I7E5mXIW8Q/ngnS+NQTA8p5YSvQRzZhGy8
	 4OABsIu7cSPzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] media: amphion: Remove vpu_vb_is_codecconfig
Date: Mon,  5 Jan 2026 16:05:32 -0500
Message-ID: <20260105210532.2800255-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105210532.2800255-1-sashal@kernel.org>
References: <2026010508-varnish-estimate-f594@gregkh>
 <20260105210532.2800255-1-sashal@kernel.org>
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
index ba63eeb18e69..7e87681ac6e3 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1315,22 +1315,18 @@ static int vpu_malone_insert_scode_vc1_g_seq(struct malone_scode_t *scode)
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
@@ -1351,8 +1347,6 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
-	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
-		scode->need_data = 0;
 	if (scode->inst->total_input_count)
 		return 0;
 	scode->need_data = 0;
@@ -1538,7 +1532,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	scode.vb = vb;
 	scode.wptr = wptr;
 	scode.need_data = 1;
-	if (vbuf->sequence == 0 || vpu_vb_is_codecconfig(vbuf))
+	if (vbuf->sequence == 0)
 		ret = vpu_malone_insert_scode(&scode, SCODE_SEQUENCE);
 
 	if (ret < 0)
@@ -1574,7 +1568,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	 * This module is currently only supported for the H264 and HEVC formats,
 	 * for other formats, vpu_malone_add_scode() will return 0.
 	 */
-	if ((disp_imm || low_latency) && !vpu_vb_is_codecconfig(vbuf)) {
+	if (disp_imm || low_latency) {
 		ret = vpu_malone_add_scode(inst->core->iface,
 					   inst->id,
 					   &inst->stream_buffer,
@@ -1621,7 +1615,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
 			   struct vpu_inst *inst, struct vb2_buffer *vb)
 {
 	struct vpu_dec_ctrl *hc = shared->priv;
-	struct vb2_v4l2_buffer *vbuf;
 	struct vpu_malone_str_buffer __iomem *str_buf = hc->str_buf[inst->id];
 	u32 disp_imm = hc->codec_param[inst->id].disp_imm;
 	u32 size;
@@ -1635,16 +1628,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
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
index a277acefe653..2b6b37731d05 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -349,16 +349,6 @@ struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst)
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
index 4a87b06ae520..da9945f25e32 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -39,14 +39,4 @@ static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
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



Return-Path: <stable+bounces-204666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91BCF3222
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD253056558
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B35330335;
	Mon,  5 Jan 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGW8DcBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947742F261F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610830; cv=none; b=sNs1MPWdUEJ+nrWqXyjN6+GGWxhufjy6sTaKCNVeHFQ0BEuyVryyDaBopirSyAQPr/Umf9xrzaPZDHdL0gx6G1HcaIySk6NpfHIyQ8WLdzYZAYmgcsH/mFZ89AbpDm6TN366GoE+ndX/A6z4ia1jdI/F4G3Jwra2IosGnMDK+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610830; c=relaxed/simple;
	bh=4TwCGurACZUKFFOxpZmlY4IBcqkzB/ydnvdDpMVj0ls=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sXK/L1Vc97I7eJtVsSx3TS/9EZVk6L6iKjv+SiEUqTIOodQPAFDLtwieBRLM/8L/nSR9m4liETHRDLmfty0meCmlBU2Dd56HrDfBHwok0F01FNtJkmdctvoSa4TJN5de0zFUjpyFyTrNzp8iYZxj8UN4fJAryhz5jn/M3QeFds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGW8DcBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BC6C19424;
	Mon,  5 Jan 2026 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610830;
	bh=4TwCGurACZUKFFOxpZmlY4IBcqkzB/ydnvdDpMVj0ls=;
	h=Subject:To:Cc:From:Date:From;
	b=BGW8DcBGD4rxzaPBMpoL0O8pCLt7DrfmydiqoN7asTF//1VhcV/6GTRW8qsBWinCx
	 1S/Nif8w0HSrHDRNoqWyK8CpM1pZSX3jvYuQGrIpp3oEUNHtCW3Cwq2IpuO/qU230V
	 +FgROiVQ8dim2cv4QT8to5/N1bTCWMogg2Cz8/Z8=
Subject: FAILED: patch "[PATCH] media: amphion: Remove vpu_vb_is_codecconfig" failed to apply to 5.10-stable tree
To: ming.qian@oss.nxp.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:00:10 +0100
Message-ID: <2026010510-charger-angelic-e41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 634c2cd17bd021487c57b95973bddb14be8002ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010510-charger-angelic-e41b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 634c2cd17bd021487c57b95973bddb14be8002ff Mon Sep 17 00:00:00 2001
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Tue, 16 Sep 2025 14:08:53 +0800
Subject: [PATCH] media: amphion: Remove vpu_vb_is_codecconfig

Currently the function vpu_vb_is_codecconfig() always returns 0.
Delete it and its related code.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index ba688566dffd..80802975c4f1 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1337,22 +1337,18 @@ static int vpu_malone_insert_scode_vc1_g_seq(struct malone_scode_t *scode)
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
@@ -1373,8 +1369,6 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
-	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
-		scode->need_data = 0;
 	if (scode->inst->total_input_count)
 		return 0;
 	scode->need_data = 0;
@@ -1560,7 +1554,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	scode.vb = vb;
 	scode.wptr = wptr;
 	scode.need_data = 1;
-	if (vbuf->sequence == 0 || vpu_vb_is_codecconfig(vbuf))
+	if (vbuf->sequence == 0)
 		ret = vpu_malone_insert_scode(&scode, SCODE_SEQUENCE);
 
 	if (ret < 0)
@@ -1596,7 +1590,7 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 	 * This module is currently only supported for the H264 and HEVC formats,
 	 * for other formats, vpu_malone_add_scode() will return 0.
 	 */
-	if ((disp_imm || low_latency) && !vpu_vb_is_codecconfig(vbuf)) {
+	if (disp_imm || low_latency) {
 		ret = vpu_malone_add_scode(inst->core->iface,
 					   inst->id,
 					   &inst->stream_buffer,
@@ -1643,7 +1637,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
 			   struct vpu_inst *inst, struct vb2_buffer *vb)
 {
 	struct vpu_dec_ctrl *hc = shared->priv;
-	struct vb2_v4l2_buffer *vbuf;
 	struct vpu_malone_str_buffer __iomem *str_buf = hc->str_buf[inst->id];
 	u32 disp_imm = hc->codec_param[inst->id].disp_imm;
 	u32 size;
@@ -1657,16 +1650,6 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
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
index fcb2eff813ac..511881a131b7 100644
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



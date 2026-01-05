Return-Path: <stable+bounces-204926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F9CF5996
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C841530318FB
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011B2D77FF;
	Mon,  5 Jan 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH+GLdhk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166326F28A
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647136; cv=none; b=RelDyKzwlmn4ATio8hyHErzCsG6NtS7xwtbHFqKanz128LeUtQ7Icqf7WKnaE21XngNRGWS8hKamSrrNsCIDlApLXl09NUKpJiAn2kFLr3B9fa4KRMSt6B4v1rllf9EgjOxapQLbIjn612gRTkA/zPhRB5gK5AiHkXmEfmBFOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647136; c=relaxed/simple;
	bh=LckIVPF9bS23jD3O6sPEFXr4MrAgz9FcaXVG59nb9oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2U0wfmvznPDI83IfyHBwsTYY+2MdXtym9Ed/bkbdv5BSyaUWaHe1nfGi54g17aLk0MfxTqeO4/AXR0eocuoxY4iYPjrCpghr+sfjnHnEDN1TrJMFqmHQF83GJjfzYu6phi61duhjZNjF2e0pjGUrXamksw10NngPxrczCurka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH+GLdhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3554C16AAE;
	Mon,  5 Jan 2026 21:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647135;
	bh=LckIVPF9bS23jD3O6sPEFXr4MrAgz9FcaXVG59nb9oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vH+GLdhkpVe3/7Hy+VcGPRsS8Zuu0BFNk/o5ZzuDK2CjE3Z/GzFMJH02Ehzp2dMei
	 iQT/jph70cBKTdBq7op+l1845iARFbjD9Qi/w36akFEzIojQ+OrOyBI1pdTTTQ910O
	 u+QcDkijbQPNHVHp8dSOS+4dRlnZOEj29i8GDNYnx7Xiuu6HjLd+LPuxERWD2NDh81
	 zK6KFhE0jKgYKxuKweUORXNAA4Ea8LyFN7l0siL/5fdtTEr8p9FPhmu5SEGkjzwAvU
	 jGXU7P6MzRaVsx0wzf3N7l9urhPWXfYtHIx4auSGoZ6VpQglbiRGgSr6ZjKp5PF3pW
	 Y5jmaLfByxnrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] media: amphion: Make some vpu_v4l2 functions static
Date: Mon,  5 Jan 2026 16:05:31 -0500
Message-ID: <20260105210532.2800255-2-sashal@kernel.org>
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

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit 5d1e54bb4dc6741284a3ed587e994308ddee2f16 ]

Some functions defined in vpu_v4l2.c are never used outside of that
compilation unit. Make them static.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: 634c2cd17bd0 ("media: amphion: Remove vpu_vb_is_codecconfig")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 12 +++++++++---
 drivers/media/platform/amphion/vpu_v4l2.h |  8 --------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 7f66bfef2abb..a277acefe653 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -24,6 +24,11 @@
 #include "vpu_msgs.h"
 #include "vpu_helpers.h"
 
+static char *vpu_type_name(u32 type)
+{
+	return V4L2_TYPE_IS_OUTPUT(type) ? "output" : "capture";
+}
+
 void vpu_inst_lock(struct vpu_inst *inst)
 {
 	mutex_lock(&inst->lock);
@@ -42,7 +47,7 @@ dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no)
 			vb->planes[plane_no].data_offset;
 }
 
-unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no)
+static unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no)
 {
 	if (plane_no >= vb->num_planes)
 		return 0;
@@ -81,7 +86,7 @@ void vpu_v4l2_set_error(struct vpu_inst *inst)
 	vpu_inst_unlock(inst);
 }
 
-int vpu_notify_eos(struct vpu_inst *inst)
+static int vpu_notify_eos(struct vpu_inst *inst)
 {
 	static const struct v4l2_event ev = {
 		.id = 0,
@@ -562,7 +567,8 @@ static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
 		call_void_vop(inst, on_queue_empty, q->type);
 }
 
-void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state)
+static void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type,
+				   enum vb2_buffer_state state)
 {
 	struct vb2_v4l2_buffer *buf;
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 56f2939fa84d..4a87b06ae520 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -26,15 +26,12 @@ void vpu_skip_frame(struct vpu_inst *inst, int count);
 struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst, u32 type, u32 sequence);
 struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32 idx);
 void vpu_v4l2_set_error(struct vpu_inst *inst);
-int vpu_notify_eos(struct vpu_inst *inst);
 int vpu_notify_source_change(struct vpu_inst *inst);
 int vpu_set_last_buffer_dequeued(struct vpu_inst *inst, bool eos);
-void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
 bool vpu_is_source_empty(struct vpu_inst *inst);
 
 dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
-unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
 static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
 {
 	if (V4L2_TYPE_IS_OUTPUT(type))
@@ -43,11 +40,6 @@ static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
 		return &inst->cap_format;
 }
 
-static inline char *vpu_type_name(u32 type)
-{
-	return V4L2_TYPE_IS_OUTPUT(type) ? "output" : "capture";
-}
-
 static inline int vpu_vb_is_codecconfig(struct vb2_v4l2_buffer *vbuf)
 {
 #ifdef V4L2_BUF_FLAG_CODECCONFIG
-- 
2.51.0



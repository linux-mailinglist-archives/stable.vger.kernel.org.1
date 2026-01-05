Return-Path: <stable+bounces-204943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4EFCF5AEA
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42D9301F250
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB4302163;
	Mon,  5 Jan 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHg2qnip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F32EB5B8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648747; cv=none; b=j1MuaQQNXZgOnJ+QUVHTjFgsA5kNcr8A2EMP1ebeYAwLLkPLtW7fLWg2RnIYYINxxhHJSCgqIXFLSzUjU7OdiO3nNHVcwemM/DJk+y1HmKKmPgngcjWxmuxMtCbepxYJV6ome8ZeuJfzY7p1pQVAllnk++lBZA1tuujNFlgLlPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648747; c=relaxed/simple;
	bh=3YANPYHaEyvBXvI//EeFIXhMT03jUQIzmeu/WuyMFH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j98nH2se3G6nZu8CNkhuw+DG/qityXqWMzphVnYgW/EPvPmenso0g1GEH75w4S/QVgU3HzBYX4cwiOZ/wJ2U0TC5cUzv0M56w2ruN+V5lWVa1ebCAeSRfHlOOkxMEk5oQucj9KWNnW72GU8OiMdIDECdyTB/BnBpzusRRfDyjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHg2qnip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEFFC116D0;
	Mon,  5 Jan 2026 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767648747;
	bh=3YANPYHaEyvBXvI//EeFIXhMT03jUQIzmeu/WuyMFH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHg2qnipwTycwt0KT+6hypSKKi3wW5gO1X/aGrAhSRlJcdL1K+4U84FVZtMw2X4TA
	 alZKGPJ2kenf2yTbfhf+rlMRl2glYC1FSlD98SCqNXHWF4AtA7yM5po1FS+ItaIcgQ
	 gv8rG3yrKjlNLThy+qlCM+cDkb2d1l8tsaLNKLVR7Rv7iaz9KEjPxiS3WM9qLA/8ON
	 qZyvwXjfyoLrcOGh1OI69+c4KcwBstM98JDv3nsbD4rZ7oiY6nMtO/Dora2IX/b9dt
	 XNY/rcWT28voWQAEc+A8UVZcyD7HMd2Z35XpE6bxH8z43hXcH0MDTkEIgeRttQ+L2G
	 VtT44xVu1VH8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] media: amphion: Add a frame flush mode for decoder
Date: Mon,  5 Jan 2026 16:32:22 -0500
Message-ID: <20260105213224.2805653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010509-celibacy-showman-a2e1@gregkh>
References: <2026010509-celibacy-showman-a2e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Qian <ming.qian@oss.nxp.com>

[ Upstream commit 9ea16ba6eaf93f25f61855751f71e2e701709ddf ]

By default the amphion decoder will pre-parse 3 frames before starting
to decode the first frame. Alternatively, a block of flush padding data
can be appended to the frame, which will ensure that the decoder can
start decoding immediately after parsing the flush padding data, thus
potentially reducing decoding latency.

This mode was previously only enabled, when the display delay was set to
0. Allow the user to manually toggle the use of that mode via a module
parameter called low_latency, which enables the mode without
changing the display order.

Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Stable-dep-of: 634c2cd17bd0 ("media: amphion: Remove vpu_vb_is_codecconfig")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_malone.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 6b37453eef76..8ef0772cb9e4 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -27,6 +27,10 @@
 #include "vpu_imx8q.h"
 #include "vpu_malone.h"
 
+static bool low_latency;
+module_param(low_latency, bool, 0644);
+MODULE_PARM_DESC(low_latency, "Set low latency frame flush mode: 0 (disable) or 1 (enable)");
+
 #define CMD_SIZE			25600
 #define MSG_SIZE			25600
 #define CODEC_SIZE			0x1000
@@ -1527,7 +1531,15 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 
 	vpu_malone_update_wptr(str_buf, wptr);
 
-	if (disp_imm && !vpu_vb_is_codecconfig(vbuf)) {
+	/*
+	 * Enable the low latency flush mode if display delay is set to 0
+	 * or the low latency frame flush mode if it is set to 1.
+	 * The low latency flush mode requires some padding data to be appended to each frame,
+	 * but there must not be any padding data between the sequence header and the frame.
+	 * This module is currently only supported for the H264 and HEVC formats,
+	 * for other formats, vpu_malone_add_scode() will return 0.
+	 */
+	if ((disp_imm || low_latency) && !vpu_vb_is_codecconfig(vbuf)) {
 		ret = vpu_malone_add_scode(inst->core->iface,
 					   inst->id,
 					   &inst->stream_buffer,
-- 
2.51.0



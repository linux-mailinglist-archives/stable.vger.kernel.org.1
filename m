Return-Path: <stable+bounces-204925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A008CF5993
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4808F307BD0C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B8280A52;
	Mon,  5 Jan 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUwaC1Yi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2C26F28A
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647134; cv=none; b=jSHyx550w75+Bi60w9Cqu6b9f0T7zAwxOUylk3+ehaveEksbPk2WKQnleeK5RiNeuiQZe6Nf5HBkU7UFiayV9fTCNdYl86Z+mdJe249iGIbVzKNq9qnsTKxDLMh1Lb8FawtyQctNWDanPKL0wgFh69TsOevov0QsMyHebzvgjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647134; c=relaxed/simple;
	bh=AiL97s7dRYE4UmLuaAMUEyY6nN+4AobVVMKC0d0zYDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgakpgzHifIVAWPGmowRisqCJFyA6F+H+G0l+L77/Ct2ko9I67p5Jf9zoVt0xft58pX92gWzOofnDnpbmsw3DnZ1dwfTJNocv+vMDI9IJvsMOMae1S2MV+DW5B/wFhs42B3rBtN35kaTWpgtlYd/RVwN5Al/u2gdwO6ayzyYzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUwaC1Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC82C116D0;
	Mon,  5 Jan 2026 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647134;
	bh=AiL97s7dRYE4UmLuaAMUEyY6nN+4AobVVMKC0d0zYDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUwaC1YiOGFW8evXn7Hd8d8do2L41kxzlktvm7gpSgVblQSrWNoYdcir/Fos9YSuL
	 GWcwO6X6PwePEbNm9BV0WO3Ie3ONaE9d5bxugBLZcY6qCTSmTlssgtdT+jp+H+OkwW
	 307PLe9vWkHfkYBYBpYe/mG1Mjt7yWUrtcDtxf3qrFm/G+LJyQGKvo3tEi8RCh3/nW
	 pfLmigfYfqBsvGm108xAO2qYgkP0kXRuQnYeT+eWDbgG/I+mF6tdjUZf97q09rF+HF
	 eo3vRGL83sZPc5EiSE+b3G8m9C7UoKzqUl3Zp/wQ2Q3ffP6Er5XnxNEXqtUNQhlnEZ
	 uCGnM30DET7RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] media: amphion: Add a frame flush mode for decoder
Date: Mon,  5 Jan 2026 16:05:30 -0500
Message-ID: <20260105210532.2800255-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010508-varnish-estimate-f594@gregkh>
References: <2026010508-varnish-estimate-f594@gregkh>
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
index 4769c053c6c2..ba63eeb18e69 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -25,6 +25,10 @@
 #include "vpu_imx8q.h"
 #include "vpu_malone.h"
 
+static bool low_latency;
+module_param(low_latency, bool, 0644);
+MODULE_PARM_DESC(low_latency, "Set low latency frame flush mode: 0 (disable) or 1 (enable)");
+
 #define CMD_SIZE			25600
 #define MSG_SIZE			25600
 #define CODEC_SIZE			0x1000
@@ -1562,7 +1566,15 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 
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



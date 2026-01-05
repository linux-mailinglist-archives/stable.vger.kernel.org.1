Return-Path: <stable+bounces-204936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB255CF5A30
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3D24301F00E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6552BE051;
	Mon,  5 Jan 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpqFMEPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF895285CA7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647891; cv=none; b=blpfISaj8tT1dyam8QFXv6qygAujFHS7OQ8I5L/Tjzu1lYxHRWIXE/majiL33zHJCqOrzy7jh1Oz4cIYtBtPh19rbcNDwrR2BmZhSIUKiqJ0J3D+91K10U9wO1cCONzuh81OqH1eqWlwuJSforqIDXLaipXan4C0AeQ53Vcb5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647891; c=relaxed/simple;
	bh=6u8tUuiQDp3RT9F5ttz7qoNT2rNXiq7/JT9iOjZWUbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsBU7LNMtO52lEPtTxDXns7uZEor1gOiTQTWaFqX5SZo4NJPH6XxUivDAwY9PPyYJ/4KKg6MymN+09wzWRN0oTLDWxYNtbajEbU270kBZPq+MArpfkfpVDtCKCauPy9wul0EnaFB9Z6mXpxrnLCwG5z1YUgDh5Ibb1DYmB+u+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpqFMEPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAFAC19422;
	Mon,  5 Jan 2026 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647891;
	bh=6u8tUuiQDp3RT9F5ttz7qoNT2rNXiq7/JT9iOjZWUbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpqFMEPgv7qOqkYEfaQeOzwMZdZ6KCX/1inJSnmcEHgotlcROz4Nc340ah0ik2LfC
	 DtWfcQm6Z3HAhQvthONLh/Hhvl7HRWemwC88LAO24Q659ltDKWnCBFqxR1feikSSSc
	 SnO0JBFY+lltYl4EmvimfeSAjG+K8X8S9RF151j+Ixh8J87aIU0QbrM31OEjfcyggF
	 2yZWuMsqcJp5Ttq1VTcXSf/Fr8RckZpEz+Kyz0OKQ+dVDgFLpyljRALYccguwHG6gq
	 uiN4oybeKCJZtQ+KIjTEdbVPvU44tBAXVvaoqTIvt270kY4un1L8au7GulHCP0gOxb
	 x8OlDvC6yacPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] media: amphion: Add a frame flush mode for decoder
Date: Mon,  5 Jan 2026 16:18:07 -0500
Message-ID: <20260105211809.2802485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010509-cardstock-selection-ef9d@gregkh>
References: <2026010509-cardstock-selection-ef9d@gregkh>
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
index d3425de7bccd..4fbf179d98dc 100644
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
@@ -1567,7 +1571,15 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 
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



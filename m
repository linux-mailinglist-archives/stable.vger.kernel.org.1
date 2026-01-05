Return-Path: <stable+bounces-204657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252DCF3213
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D3C30533BE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CE32ED31;
	Mon,  5 Jan 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSTZY12b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697D32E14D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610756; cv=none; b=hLqKOm1AyGdHZpyxB+aEm1+GFb8Rn4ITistRHkuOwEEfAlgstn8AAY4/7MN4gF1yKEtOALrnOPlNGJqP2ibw1B7LjkNBOm5Zwzgf/Bdnhr0MOerJJGzrxmKXn8PtAqkNIFFaZylRRNIqRuTxkjNI/JhLeRWatG+PBheuVet+hbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610756; c=relaxed/simple;
	bh=YsHU+LsOkW/tg9fZTWMqijbrP1J4SIRg6x6Oah/DTNc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ie4dYLDvOr2QxqK8wyQk0yqsnWMolPGycFFful/1ZPsE7n74uLQENjW75jv3Hn4YIhIOGQiqhHghK8px6u5bfdTfLYz/Cp1mgiPomTqAuXRTMkBuwv0aIgnYWE/2baEUvJ+M/igIYvysqaFWQBXFu3fDM2PU0yRtRyXLQjXyk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSTZY12b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33EFC116D0;
	Mon,  5 Jan 2026 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610755;
	bh=YsHU+LsOkW/tg9fZTWMqijbrP1J4SIRg6x6Oah/DTNc=;
	h=Subject:To:Cc:From:Date:From;
	b=iSTZY12bRt4bGtlSks4Z5piN2Y7pDCgtac/9MXboDCqdvy55AXPDGQ21YssiTw5Ps
	 +XfwJ+oVAHMfqvoLVQ9+/fbrgZ+wGvdCR+yKDFOAPcyCqz67b5GLy2uPWIwMNrOkvU
	 ObV7Y7oTuYDGjtMpjn0Mu8x0u8BQrCgLc1EEffB8=
Subject: FAILED: patch "[PATCH] media: verisilicon: Protect G2 HEVC decoder against invalid" failed to apply to 5.15-stable tree
To: nicolas.dufresne@collabora.com,benjamin.gaignard@collabora.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:59:11 +0100
Message-ID: <2026010511-molasses-woven-927b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 47825b1646a6a9eca0f90baa3d4f98947c2add96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010511-molasses-woven-927b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47825b1646a6a9eca0f90baa3d4f98947c2add96 Mon Sep 17 00:00:00 2001
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Date: Mon, 22 Sep 2025 14:43:39 -0400
Subject: [PATCH] media: verisilicon: Protect G2 HEVC decoder against invalid
 DPB index

Fix the Hantro G2 HEVC decoder so that we use DPB index 0 whenever a
ninvalid index is received from user space. This protects the hardware
from doing faulty memory access which then leads to bus errors.

To be noted that when a reference is missing, userspace such as GStreamer
passes an invalid DPB index of 255. This issue was found by seeking to a
CRA picture using GStreamer. The framework is currently missing the code
to skip over RASL pictures placed after the CRA. This situation can also
occur while doing live streaming over lossy transport.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
index f066636e56f9..e8c2e83379de 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
@@ -283,6 +283,15 @@ static void set_params(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &g2_apf_threshold, 8);
 }
 
+static u32 get_dpb_index(const struct v4l2_ctrl_hevc_decode_params *decode_params,
+			 const u32 index)
+{
+	if (index > decode_params->num_active_dpb_entries)
+		return 0;
+
+	return index;
+}
+
 static void set_ref_pic_list(struct hantro_ctx *ctx)
 {
 	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
@@ -355,8 +364,10 @@ static void set_ref_pic_list(struct hantro_ctx *ctx)
 		list1[j++] = list1[i++];
 
 	for (i = 0; i < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; i++) {
-		hantro_reg_write(vpu, &ref_pic_regs0[i], list0[i]);
-		hantro_reg_write(vpu, &ref_pic_regs1[i], list1[i]);
+		hantro_reg_write(vpu, &ref_pic_regs0[i],
+				 get_dpb_index(decode_params, list0[i]));
+		hantro_reg_write(vpu, &ref_pic_regs1[i],
+				 get_dpb_index(decode_params, list1[i]));
 	}
 }
 



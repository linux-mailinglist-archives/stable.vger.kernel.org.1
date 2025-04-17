Return-Path: <stable+bounces-132939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3BA91881
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE4119E252B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80A21C162;
	Thu, 17 Apr 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MamclEIM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163E1898FB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883949; cv=none; b=H4FdIBhHmHl/sFvjcYGJHdnJe5STmcZlgDKEDUqTEitbizVVO3tFfOFdtogo4iQMfZav6+aOs2s09m2NACPma96xhDOkhnbTMtqoqW4IUyrWDOrKGaXlh4va75eIdQbsLCjgucROkTQqAA/MXcisVV9FCmO0WaJTzgjoSHC9Rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883949; c=relaxed/simple;
	bh=t97hmx7u6DKvT+4Bh94LiPtzmoNtffAiIA/m0MB1Y4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eMKW+z50iRtduDFvMQVrTSOgXESXrTPT4gMFiymK0AELAYLjCMBIUaJ0cQ6bOwJXGDJeuaFJ0JE6vFiIndC7JB9oTr8iAgvcVW/BZ4TBkTWiOQlAvLW/Alkxp0ZWbYgBGidJchfQIIozVVwqcpGV5CMKS0gx30oUDllJIBvZZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MamclEIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E4C4CEE4;
	Thu, 17 Apr 2025 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744883948;
	bh=t97hmx7u6DKvT+4Bh94LiPtzmoNtffAiIA/m0MB1Y4s=;
	h=Subject:To:Cc:From:Date:From;
	b=MamclEIMA/npmRRrRc63S4X25gR1P3W0HF93MJ23hhxMeVyDpciBbUfFvaP1RdYtt
	 3tntNCOREhlD9yHYNy8J41amGMVTy/d8tsJBoptkddyMgDzxXjD4hfl3+wSELhIERc
	 6caChanPPhGVuPjPiss/qtWuV16Uphp8045zSHY0=
Subject: FAILED: patch "[PATCH] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional" failed to apply to 5.10-stable tree
To: arnd@arndb.de,acourbot@google.com,hverkuil@xs4all.nl,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 11:58:57 +0200
Message-ID: <2025041757-suffix-chevron-2444@gregkh>
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
git cherry-pick -x 07df4f23ef3ffe6fee697cd2e03623ad27108843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041757-suffix-chevron-2444@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07df4f23ef3ffe6fee697cd2e03623ad27108843 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Oct 2024 15:21:10 +0000
Subject: [PATCH] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional
 warning

This is one of three clang warnings about incompatible enum types
in a conditional expression:

drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c:597:29: error: conditional expression between different enumeration types ('enum scp_ipi_id' and 'enum ipi_id') [-Werror,-Wenum-compare-conditional]
  597 |         inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
      |                                    ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~~

The code is correct, so just rework it to avoid the warning.

Fixes: 0dc4b3286125 ("media: mtk-vcodec: venc: support SCP firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@google.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
index f8145998fcaf..8522f71fc901 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
@@ -594,7 +594,11 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
-	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
+	if (is_ext)
+		inst->vpu_inst.id = SCP_IPI_VENC_H264;
+	else
+		inst->vpu_inst.id = IPI_VENC_H264;
+
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
 
 	ret = vpu_enc_init(&inst->vpu_inst);



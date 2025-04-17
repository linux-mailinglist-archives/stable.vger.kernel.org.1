Return-Path: <stable+bounces-132938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D199A91880
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB4919E24FA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AA225A59;
	Thu, 17 Apr 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSuELuLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545921898FB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883940; cv=none; b=bOcBDk7JhnmSMtfpaG2dEhieALJRyHSWz3yF6DA/AumGE9xQyDhDyIPR96QMLOZ+1uOSTt1Kr2NJJqrEpdgYhz0nS7taNSdDjmE60jUBGmdsjDYaTpMErQ6svk7wLh6MfW3YDTEfmTGdvtgapQkpcGXd5iLecuOjGk+0Yhef6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883940; c=relaxed/simple;
	bh=24X1U19KByiE9GsSO/R7hZd/iepYxWX2BpR/6bGa7P8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AHDdZtV1gb51lCQHiCK/puiQ+R2WOTqqTo5HV/1bPfTwltFm0Rt02+dOrEyYJWWpgIaRzkJtBH7i9uJNuFQRfn3HLChc1KUbGJEy6+tHIZ/cVdq3dVVYMIk/hUuI8x2e/dVs4UkljKnTqvLk0lF44Z8KSKNeVHGhEjQqmR08bKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSuELuLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8356C4CEE4;
	Thu, 17 Apr 2025 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744883940;
	bh=24X1U19KByiE9GsSO/R7hZd/iepYxWX2BpR/6bGa7P8=;
	h=Subject:To:Cc:From:Date:From;
	b=YSuELuLKiWTmSxV+cU7gUsopJFJq0smWrWR03Qi+ZMcw52IdhnCN+8K42lNOKkH5i
	 X2B9oLemWo73f+oVXnfx4IgWYcAtDGwLIVBTh/YedyYvFObKsYO3UHwKknVJpu8aOT
	 TDDlZqzetT+SHabfAebv0LBzVhSir3NZcgRat1gY=
Subject: FAILED: patch "[PATCH] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional" failed to apply to 5.15-stable tree
To: arnd@arndb.de,acourbot@google.com,hverkuil@xs4all.nl,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 11:58:52 +0200
Message-ID: <2025041752-utensil-affront-c113@gregkh>
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
git cherry-pick -x 07df4f23ef3ffe6fee697cd2e03623ad27108843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041752-utensil-affront-c113@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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



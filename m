Return-Path: <stable+bounces-68980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0439534E0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72BA289538
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFC19FA99;
	Thu, 15 Aug 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AyviLQSL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AD63D5;
	Thu, 15 Aug 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732281; cv=none; b=Ji2e4PqVyZeb3N9so9+Q7/Q2E+MlfUfpDv+NraNJethZnfvL8bk/NTsG7g+nzhN6m1dR2aoKXcXZqdraOVrJxlZFz1eI8dbKyvZpuw5X2ympXqsQPpx8D8hvEAops2o2LasxV/k+uGnZNekIJ2r1k9HcPICUFEn7TEL40Hplxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732281; c=relaxed/simple;
	bh=gOrxdRKLrx1CVJqMW9aLAIIRCGf0itMZzPX4O52BZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy0N7+dlLO7Xy0QepkfxarX87qdUQXjupgPZFZRpMj0Oas4snvZLsSckSqzazgKtBUqhvmGTyN+Zt154r9Fsl76ZxtA1IrJC/vi2MeCQiELyHB/wIc3JvClbb9VytJ3LZ1WX323nvT2qYAHsNvFfLoJfuoKiRFX03EtEeBDnylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AyviLQSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB99C32786;
	Thu, 15 Aug 2024 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732280;
	bh=gOrxdRKLrx1CVJqMW9aLAIIRCGf0itMZzPX4O52BZX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyviLQSLreqxz/5KiIMIp2L5Z9CIhWduJ7AIBnluBZz5LoEoIo9rjMOlQzN/NiUYs
	 Nd19G1xZueWY9OmhN+/qhVn+iIbsay7JhrBS/P9whbBM1y5K5tVpoMNtnEjJcv3aNP
	 9n63j/NttDCQ+mvu6D0os6a6JgtryFZzUrO/fu9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.10 131/352] media: venus: fix use after free in vdec_close
Date: Thu, 15 Aug 2024 15:23:17 +0200
Message-ID: <20240815131924.320388606@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

commit a0157b5aa34eb43ec4c5510f9c260bbb03be937e upstream.

There appears to be a possible use after free with vdec_close().
The firmware will add buffer release work to the work queue through
HFI callbacks as a normal part of decoding. Randomly closing the
decoder device from userspace during normal decoding can incur
a read after free for inst.

Fix it by cancelling the work in vdec_close.

Cc: stable@vger.kernel.org
Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/vdec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1587,6 +1587,7 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_get(inst);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);




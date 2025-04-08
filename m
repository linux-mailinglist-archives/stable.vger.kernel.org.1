Return-Path: <stable+bounces-129496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87434A7FFD3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16011188BCB1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABBE264A76;
	Tue,  8 Apr 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBUAOJmv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DA263C90;
	Tue,  8 Apr 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111186; cv=none; b=i7U8Vm0M7StuBs/YtL0h/85lLE3Nr06WAiBU5faEaKc60u2huQxUulfrZhcfitOE50XefyCOrdQBsfjq/qToTvZ8wAAS3jfXLSChzZVrTRjmjqPuJYwAiGc3m90pHMg3TFuAekRA4dBz5P9u1cmuWw84ulObhOr3LhoX28JDsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111186; c=relaxed/simple;
	bh=X4t2rE0JXxkxIx9b3gGkxMZmh1jF2pDC3V2gFpQR4io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXESbofQQ8rsPtWxIQjveqA990bW6o+iQgNIZklMxBT81tUXRHW9geW0k2wKEMYjeU7fU/T/H+bflAcxNZg3Bx8IsT/ZWDys3FIqHqvwAY2v6/FD01Y0hTtwB1nXOsvve5gqENArl2JRuv0A8MiItx7Eu5UdB0CnCr7EpOVLPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBUAOJmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26327C4CEE5;
	Tue,  8 Apr 2025 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111186;
	bh=X4t2rE0JXxkxIx9b3gGkxMZmh1jF2pDC3V2gFpQR4io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xBUAOJmvW4FS1JNMe8Hh4pRdZ5yaSrlZ2GXFW1r1Z6dmjA9DW6aGs+Jt77OXGGmV+
	 KV4dGGJTPg3F4VqoMl2WY9FqSBxIBEksW88ZIiGiXMq+UWsoiiT/iClwjk0g4BjKOV
	 IltdNtoaiChrwIpAno1ftd8PTSpMz6bZPHrMclKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 301/731] drm/msm/dpu: Remove arbitrary limit of 1 interface in DSC topology
Date: Tue,  8 Apr 2025 12:43:18 +0200
Message-ID: <20250408104921.279071676@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit d245ce568929e30f650e260631f7ad14970d7c2c ]

When DSC is enabled the number of interfaces is forced to be 1, and
documented that it is a "power-optimal" layout to use two DSC encoders
together with two Layer Mixers.  However, the same layout (two DSC
hard-slice encoders with two LMs) is also used when the display is
fed with data over two instead of one interface (common on 4k@120Hz
smartphone panels with Dual-DSI).  Solve this by simply removing the
num_intf = 1 assignment as the count is already calculated by computing
the number of physical encoders within the virtual encoder.

Fixes: 7e9cc175b159 ("drm/msm/disp/dpu1: Add support for DSC in topology")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Patchwork: https://patchwork.freedesktop.org/patch/637649/
Link: https://lore.kernel.org/r/20250217-drm-msm-initial-dualpipe-dsc-fixes-v3-3-913100d6103f@somainline.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 88591b6f9e350..e3555765eefb1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -686,20 +686,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
 
 	if (dsc) {
 		/*
-		 * Use 2 DSC encoders and 2 layer mixers per single interface
+		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
 		 * when Display Stream Compression (DSC) is enabled,
 		 * and when enough DSC blocks are available.
 		 * This is power-optimal and can drive up to (including) 4k
 		 * screens.
 		 */
-		if (dpu_kms->catalog->dsc_count >= 2) {
+		WARN(topology.num_intf > 2,
+		     "DSC topology cannot support more than 2 interfaces\n");
+		if (intf_count >= 2 || dpu_kms->catalog->dsc_count >= 2) {
 			topology.num_dsc = 2;
 			topology.num_lm = 2;
 		} else {
 			topology.num_dsc = 1;
 			topology.num_lm = 1;
 		}
-		topology.num_intf = 1;
 	}
 
 	return topology;
-- 
2.39.5





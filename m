Return-Path: <stable+bounces-219035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ1kKhxWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A31901B7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61F6E3067138
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B82C11EF;
	Wed, 25 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jB/vjHNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C802C08AB;
	Wed, 25 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983953; cv=none; b=q2qadmcPMllzVEyDMTeHwo7F3bmFLVQ4a0LIyWL4TlpubcxPxjif5gn7QtTZ9/xKpswYLOXRwNfECdAFGcGmDO9rhRTSkEWek9wvcJ5DvMcxEQnpRCJr1kne1LEqc3YHSGeWvLgN0cRDJWVSSIEUMkLZBet1SW0bgp3OGrOi/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983953; c=relaxed/simple;
	bh=WxsSRcGtSho5ZNd66cyWXk/6m5MJmR/BYqdDobh6aXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+k0ek4Mi8i+20HcLuy2sjLuJ24xDK7M4mt9H2iyD5vGehIAmuu54wOMc3jvG8P561D93N5KGqzZNFDcVkPmOkN3BvNxtoFeDkMOVsXQugcHGAIKjCjDJo8gMWRLjvpuXclP4joAV86DM1Weema7l1KbBDktk533fbcqIEIDUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jB/vjHNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240F8C116D0;
	Wed, 25 Feb 2026 01:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983953;
	bh=WxsSRcGtSho5ZNd66cyWXk/6m5MJmR/BYqdDobh6aXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB/vjHNQ/aqXZb17SL9l6SxOFbd1I4zKnsvnhIJBfJzRmI34IpSyhhVD+NCodpOgk
	 0LINiZf6WDA9LxgnsC0po8WXJkCBOGN3jevzD4c1Qqx6c9R16Rslzfb3QBFtPuZWXY
	 GRVds+t8HhNTC2yYUoV1EoVcoSzxpU7UIhyeSL/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Val Packett <val@packett.cool>
Subject: [PATCH 6.18 212/641] drm/msm/dpu: program correct register for UBWC config on DPU 8.x+
Date: Tue, 24 Feb 2026 17:18:58 -0800
Message-ID: <20260225012354.080888049@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219035-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,patchwork.freedesktop.org:url,packett.cool:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6F6A31901B7
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 5dcec3fc1311c277369a4bdf8b292781e5cc91fd ]

Since DPU 8.0 there is a separate register for the second rectangle,
which needs to be programmed with the UBWC config if multirect is being
used. Write pipe's UBWC configuration to the correct register.

Fixes: 100d7ef6995d ("drm/msm/dpu: add support for SM8450")
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/699277/
Link: https://lore.kernel.org/r/20260119-msm-ubwc-fixes-v4-3-0987acc0427f@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 25 ++++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index b66c4cb5760c9..6ff4902fce08e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -72,6 +72,8 @@
 #define SSPP_EXCL_REC_XY_REC1              0x188
 #define SSPP_EXCL_REC_SIZE                 0x1B4
 #define SSPP_EXCL_REC_XY                   0x1B8
+#define SSPP_UBWC_STATIC_CTRL_REC1         0x1c0
+#define SSPP_UBWC_ERROR_STATUS_REC1        0x1c8
 #define SSPP_CLK_CTRL                      0x330
 
 /* SSPP_SRC_OP_MODE & OP_MODE_REC1 */
@@ -215,7 +217,7 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 	u32 chroma_samp, unpack, src_format;
 	u32 opmode = 0;
 	u32 fast_clear = 0;
-	u32 op_mode_off, unpack_pat_off, format_off;
+	u32 op_mode_off, unpack_pat_off, format_off, ubwc_ctrl_off, ubwc_error_off;
 
 	if (!ctx || !fmt)
 		return;
@@ -225,10 +227,21 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 		op_mode_off = SSPP_SRC_OP_MODE;
 		unpack_pat_off = SSPP_SRC_UNPACK_PATTERN;
 		format_off = SSPP_SRC_FORMAT;
+		ubwc_ctrl_off = SSPP_UBWC_STATIC_CTRL;
+		ubwc_error_off = SSPP_UBWC_ERROR_STATUS;
 	} else {
 		op_mode_off = SSPP_SRC_OP_MODE_REC1;
 		unpack_pat_off = SSPP_SRC_UNPACK_PATTERN_REC1;
 		format_off = SSPP_SRC_FORMAT_REC1;
+
+		/* reg wasn't present before DPU 8.0 */
+		if (ctx->mdss_ver->core_major_ver >= 8) {
+			ubwc_ctrl_off = SSPP_UBWC_STATIC_CTRL_REC1;
+			ubwc_error_off = SSPP_UBWC_ERROR_STATUS_REC1;
+		} else {
+			ubwc_ctrl_off = SSPP_UBWC_STATIC_CTRL;
+			ubwc_error_off = SSPP_UBWC_ERROR_STATUS;
+		}
 	}
 
 	c = &ctx->hw;
@@ -281,24 +294,24 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 		switch (ctx->ubwc->ubwc_enc_version) {
 		case UBWC_1_0:
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
-			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+			DPU_REG_WRITE(c, ubwc_ctrl_off,
 					fast_clear | (ctx->ubwc->ubwc_swizzle & 0x1) |
 					BIT(8) |
 					(hbb << 4));
 			break;
 		case UBWC_2_0:
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
-			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+			DPU_REG_WRITE(c, ubwc_ctrl_off,
 					fast_clear | (ctx->ubwc->ubwc_swizzle) |
 					(hbb << 4));
 			break;
 		case UBWC_3_0:
-			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+			DPU_REG_WRITE(c, ubwc_ctrl_off,
 					BIT(30) | (ctx->ubwc->ubwc_swizzle) |
 					(hbb << 4));
 			break;
 		case UBWC_4_0:
-			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+			DPU_REG_WRITE(c, ubwc_ctrl_off,
 					MSM_FORMAT_IS_YUV(fmt) ? 0 : BIT(30));
 			break;
 		}
@@ -327,7 +340,7 @@ static void dpu_hw_sspp_setup_format(struct dpu_sw_pipe *pipe,
 	DPU_REG_WRITE(c, op_mode_off, opmode);
 
 	/* clear previous UBWC error */
-	DPU_REG_WRITE(c, SSPP_UBWC_ERROR_STATUS, BIT(31));
+	DPU_REG_WRITE(c, ubwc_error_off, BIT(31));
 }
 
 static void dpu_hw_sspp_setup_pe_config(struct dpu_hw_sspp *ctx,
-- 
2.51.0





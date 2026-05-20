Return-Path: <stable+bounces-251449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK75CfT8DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:27:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1415962DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BCD7321FCD4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19074364EB0;
	Wed, 20 May 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWFBRsYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA2346E5E;
	Wed, 20 May 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298010; cv=none; b=A8dPh0r+knfDwZNgoF59iPqQzWCDH95xOdAivtxUTJnWorGR/Bmmo5QN9BetMseicmZk/zVbq4pysWnlr8DNVPR3Ce/V59BdACcTExdJHl1sppJede/GFtW7d/wbrN7V0n1u9QfoeaoRaRBXh2VabrAP5FNnQWPrF3A8In2FElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298010; c=relaxed/simple;
	bh=hCfqbR27pjxfU6tlCDQ0oJtpdMAufznvxNNYQZoNR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVlnwhTtBwMPvhgDgX+Xrp4ivVKtmU0EWI3jlJR2EWdEgnsdiLoN72zYe+Tw7PcghZL6+qsHMxRgh6jLbOTYaJQCQTwbhjZr+PB5P+WBH7MtKKSd6dtV1ii/69woK8nBm/8GEGvqOrKZpiF2HU7bQV08aoOcFAwe3Nry2OzvYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWFBRsYM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F24D1F00897;
	Wed, 20 May 2026 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298009;
	bh=yadGzIpurOUkUBXEIH08AQadRxCoc/7SSPAzFE3CRgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWFBRsYMkw3HvMu1AjDril/zC1y/SOaGq48qyuYNjfIyhhlpUX8xGWiLG/n5qfsZp
	 EYLIM/+cjcX/Y6UUJeE0bjy2EhHrzakvXv8Oaz3o9zLxvJcHbMcTFEeSgf6+g4t8yV
	 7hH5C+k7ZzDm5sqpS2EYAWaOFyh/kmEO4mRq6B6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Alexander Koskovich <akoskovich@pm.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 247/957] drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
Date: Wed, 20 May 2026 18:12:10 +0200
Message-ID: <20260520162139.899979983@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251449-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,patchwork.freedesktop.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,pm.me:email]
X-Rspamd-Queue-Id: 3F1415962DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Koskovich <akoskovich@pm.me>

[ Upstream commit 913a709dea0eff9c7b2e9470f8c8594b9a0114ab ]

The MSM8998 DSI controller is v2.0.0 as stated in commit 7b8c9e203039
("drm/msm/dsi: Add support for MSM8998 DSI controller"). The value was
always correct just the name was wrong.

Rename and reorder to maintain version sorting.

Fixes: 7b8c9e203039 ("drm/msm/dsi: Add support for MSM8998 DSI controller")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Patchwork: https://patchwork.freedesktop.org/patch/713717/
Link: https://lore.kernel.org/r/20260324-dsi-rgb101010-support-v5-3-ff6afc904115@pm.me
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 ++--
 drivers/gpu/drm/msm/dsi/dsi_cfg.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index fed8e9b67011c..cdcf0cab7aaa2 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -306,10 +306,10 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 		&msm8996_dsi_cfg, &msm_dsi_6g_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_4_2,
 		&msm8976_dsi_cfg, &msm_dsi_6g_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_0_0,
+		&msm8998_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_1_0,
 		&sdm660_dsi_cfg, &msm_dsi_6g_v2_host_ops},
-	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_0,
-		&msm8998_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_1,
 		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_3_0,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 38f303f2ed04c..4d760ffd8b4a8 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -19,8 +19,8 @@
 #define MSM_DSI_6G_VER_MINOR_V1_3_1	0x10030001
 #define MSM_DSI_6G_VER_MINOR_V1_4_1	0x10040001
 #define MSM_DSI_6G_VER_MINOR_V1_4_2	0x10040002
+#define MSM_DSI_6G_VER_MINOR_V2_0_0	0x20000000
 #define MSM_DSI_6G_VER_MINOR_V2_1_0	0x20010000
-#define MSM_DSI_6G_VER_MINOR_V2_2_0	0x20000000
 #define MSM_DSI_6G_VER_MINOR_V2_2_1	0x20020001
 #define MSM_DSI_6G_VER_MINOR_V2_3_0	0x20030000
 #define MSM_DSI_6G_VER_MINOR_V2_3_1	0x20030001
-- 
2.53.0





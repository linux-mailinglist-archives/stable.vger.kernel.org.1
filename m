Return-Path: <stable+bounces-251752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOroKNPzDWoF5AUAu9opvQ
	(envelope-from <stable+bounces-251752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:48:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11839594989
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3540305375E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D2B36D9EA;
	Wed, 20 May 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9ycv3b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499593F2117;
	Wed, 20 May 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298801; cv=none; b=dCSjVWVSK+YUsb0mc/6JZ++X6kiUCGMrJvLguCywsLOHjv85ZkAQMcXc89m4va5TZCdmngvNpK/uBEQp2ndRLTpeS4af/J+oWkBfq+5MU6s58OWEOM0U0pG0Ett2qpwKhpD6c+iIIOzVR+lA2Aq/1ocV+2e7R7maHn7CW4GzJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298801; c=relaxed/simple;
	bh=VsqeauCm7gsivg8qBDOEHbIo6qtX0so8HtPTfv8lwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA98NV8rlgOR8mu5h8AcsfUx/KogVnZS3vexk0wrzSq76I5s/VtH9VKnofoQ0PdPJo4bnDTE3EkXABJrvGpy8kQwuaTgwiCrbNIOT6XQy/sx83OdszDulDyR4Xjxtb8/g18xcowM3LYKLJRN90zgE7JqMn7XrTlRthr5xGBfLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9ycv3b0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257741F000E9;
	Wed, 20 May 2026 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298798;
	bh=WBXlaRzBpcIpuexciI5yI6vBPUPUpHyu0pT6zpclJjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9ycv3b0AvOOvghb5wB04HD1sS7cR1WJvNcMz4/iMZoXy7v+UcS0vR9g53qspNlIH
	 pG+YAw4M5ti4dmcK5ifoO2Ms1QLnX2vWuWwyfBzSLlu4AuTjAOx5lseIvr8m60Ut4W
	 RcqSOLdps9PB3QacnfQZ7EBYt/hS42g0/p40XhY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 548/957] clk: qcom: gcc-glymur: Add video axi clock resets for glymur
Date: Wed, 20 May 2026 18:17:11 +0200
Message-ID: <20260520162146.416087773@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251752-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 11839594989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taniya Das <taniya.das@oss.qualcomm.com>

[ Upstream commit 1c8ce43e1e07ecc531fb517f95620ed85e998608 ]

The global clock controller video axi reset clocks are required by
the video SW driver to assert and deassert the clock resets during
their power down sequence. Hence add these clock resets.

Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260202-glymur_videocc-v2-3-8f7d8b4d8edd@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-glymur.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-glymur.c b/drivers/clk/qcom/gcc-glymur.c
index 17e860307fa10..eff3248d483ad 100644
--- a/drivers/clk/qcom/gcc-glymur.c
+++ b/drivers/clk/qcom/gcc-glymur.c
@@ -8508,6 +8508,7 @@ static const struct qcom_reset_map gcc_glymur_resets[] = {
 	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x3201c, 2 },
 	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32044, 2 },
 	[GCC_VIDEO_BCR] = { 0x32000 },
+	[GCC_VIDEO_AXI0C_CLK_ARES] = { 0x32030, 2 },
 };
 
 static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
-- 
2.53.0





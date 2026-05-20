Return-Path: <stable+bounces-250757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHi8LGP3DWpd5AUAu9opvQ
	(envelope-from <stable+bounces-250757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430F5952E6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF9A38088D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78C3A16B6;
	Wed, 20 May 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgoD9se1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4634EF05;
	Wed, 20 May 2026 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296238; cv=none; b=EYg1x/bh28L+4tMj0LmGsQmOjEN9SUeqyh4oMpGqLw5VVduxmpFUGhQi2kvPM9Cb41TxGlIRlvGII1pZ4Mh2n9gSy79Sow0d1PQGvRTeZDKZM8BDN3K248ADKHb7C+Z+kafRLkZvDQvA/GNw77KiFXl7p+jIU1IY+MvarYNObSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296238; c=relaxed/simple;
	bh=U+zRW6qQuntHLqka3aGtjqbPC42t9RnnFnsKLgcxMRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3adlsdvmVYj4bWBbeQ+YaxUywwSmsEILtPdSmXPya2/XVzLNdvdJ5iqTHSG6G23edOAHZUUeIdb2X1WeOD69OlV+WSCGc0pBOF7Ytm9JeIjutEz3+9o8YDokyXOcFhcbKrLo21qlpznVqpPCYcMF4g3xkIc6Ik8JbvXzkSnxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgoD9se1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9D61F00893;
	Wed, 20 May 2026 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296236;
	bh=jLxQ9Pao5qIfqPKixwI6jvEuiyTffzqAD8LA9CNkSOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JgoD9se1hYNjCWokcPixuD9oK/VBW/G+EZCQ0grdXZKuF03mDnVZ9RFwGz1OZDWtI
	 dbQiKGX8k/uhrL0u3QnHa91L3Cl7yqaQA74uvzxbYSbOfhTYYAGAPAozcbImD5ppQL
	 Fx0DO5YMi7T3J1IqdI77JPVaWIV+Fk02bxrxBbb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0722/1146] clk: imx8mq: Correct the CSI PHY sels
Date: Wed, 20 May 2026 18:16:12 +0200
Message-ID: <20260520162204.544004647@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250757-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,msgid.link:url,i.mx:url]
X-Rspamd-Queue-Id: 1430F5952E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit d16f57caa78776e6e8a88b96cb2597797b376138 ]

According to i.MX 8M Quad Reference Manual (Section 5.1.2 Table 5-1)
MIPI_CSI1_PHY_REF_CLK_ROOT and MIPI_CSI2_PHY_REF_CLK_ROOT have
SYSTEM_PLL2_DIV3 available as their second source, which corresponds
to sys2_pll_333m rather than sys2_pll_125m.

Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://patch.msgid.link/20260128-imx8mq-csi-clk-v1-1-ac028ed26e8c@puri.sm
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index f70ed231b92d6..cedc8a02aa1f0 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -237,7 +237,7 @@ static const char * const imx8mq_dsi_esc_sels[] = {"osc_25m", "sys2_pll_100m", "
 static const char * const imx8mq_csi1_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
 					      "sys2_pll_1000m", "sys3_pll_out", "audio_pll2_out", "video_pll1_out", };
 
-static const char * const imx8mq_csi1_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_csi1_phy_sels[] = {"osc_25m", "sys2_pll_333m", "sys2_pll_100m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
 
 static const char * const imx8mq_csi1_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
@@ -246,7 +246,7 @@ static const char * const imx8mq_csi1_esc_sels[] = {"osc_25m", "sys2_pll_100m",
 static const char * const imx8mq_csi2_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
 					      "sys2_pll_1000m", "sys3_pll_out", "audio_pll2_out", "video_pll1_out", };
 
-static const char * const imx8mq_csi2_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_csi2_phy_sels[] = {"osc_25m", "sys2_pll_333m", "sys2_pll_100m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
 
 static const char * const imx8mq_csi2_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
-- 
2.53.0





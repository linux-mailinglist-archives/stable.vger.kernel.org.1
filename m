Return-Path: <stable+bounces-258455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCvcDqInG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8906110FF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D42D7301F788
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD33AFCE3;
	Sat, 30 May 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRhlPkh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4232340A6F;
	Sat, 30 May 2026 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164407; cv=none; b=eJNo94+6r1oTWZdnDaNcjpmXh4Blwt/NQeC0B3DU7/yAqIjwrwR8OUbygj70JUx6v1Q2BIxYQN5VM/R3Xlwz397nNmELibS2/1TemuZlv9aw0UNwTzdvlVozcmL9jZunPk64bGm2dZ5FUZ8MF3o6sA+KQWY6UaTxE6rTq0poQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164407; c=relaxed/simple;
	bh=K4XN7NrIaYZ2rmrx3qkdTAeACVajk4xJhlc5a0Xpavo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHCwlDIWH+mQoI3Qh/3xOyxbZnrYNWbl7RyFO3k64TXvFkRwbBFaKkZtjBERMa49eOE1/NTMo72R8hFXz30tFS6u1AZYeB7V4KpPzS1YYXL+t1sth52XDLnkYe+bTQcjBEGYcQPW4ztAQQXa9rWaSAfCAhIKuTPWPkLDL5vn/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRhlPkh3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D811F00893;
	Sat, 30 May 2026 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164406;
	bh=GjSnCtoxx0a3vuT4tOB7pH93fDcShRZgXvWRT9u2+VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yRhlPkh3iwNxp6BDnGZRbPpNw+4s6AkC/5+uE2IgejcQJzNfn5cvlSNIDpL2x4zFC
	 V5CIvMzxmmDLdOT+0XAtJWOdzCn9OFaTcVl/2RhD/V+nnxGNtqGOklnygOIczd20z7
	 ek9lW8XEMKydUsHsXOtZn6FDipLr7wKgP5h5JA/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 545/776] clk: imx8mq: Correct the CSI PHY sels
Date: Sat, 30 May 2026 18:04:19 +0200
Message-ID: <20260530160254.257124066@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258455-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BC8906110FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 791f6bdd88b8a..46c4fedd4d9f7 100644
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





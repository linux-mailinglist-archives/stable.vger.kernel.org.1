Return-Path: <stable+bounces-212684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AgcH/OLemkE7gEAu9opvQ
	(envelope-from <stable+bounces-212684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:21:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C0A987B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD44730305CD
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92A34320C;
	Wed, 28 Jan 2026 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQSoHS92"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD10342C92
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638836; cv=none; b=FP0qAER1SH6I8lI3T4YmOuWSdb/ExarZZuKFc8Wgw4vSlmnDaqBbzP/0Tq2SWlxaHK+toxECWee2ezhLxWudpwq40n4XIlCEaq5DWcRgz9W7ZLwo4Rt9jin3uzKhe4kegjrf5eOKr2nWf4FlPo+egUAyxtbEN2M/0tZz17JruJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638836; c=relaxed/simple;
	bh=VtIN9N7/9XBOEXBamCpOHFwcc6M4Qe04yZURBZoMJSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYFrSRF5mL2lVuMC/FyNp+IAPF8c61krjD/VHrU57eVOCqgXm/r0ViaiwP39fREsGnhx6i94Zj/Q+BuT0sNVRwMbTy+IgK9No39hCz06yE4E0h6l/9oi8DjtC1DjaRU/Qm3m0qFJeUue1zA1/I4vVJaWfIKSeESshG2iPiWessE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQSoHS92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FC0C4CEF1;
	Wed, 28 Jan 2026 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638835;
	bh=VtIN9N7/9XBOEXBamCpOHFwcc6M4Qe04yZURBZoMJSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQSoHS92MrTCmE98WDry0yyvsdexFFHO6+efRxHihtrLlxyf7Zld8SY2PlG60fBpA
	 xAKrhbDAv97cl/qIuU4qtC85JMciCRzxHH9wNEluNA7y++xqRtm97jmzDW5KvrWT7F
	 6TpQhvvf+tvfOYaTErwD8ZHkVzA6FpepM8kodoOaiq2C/rkdHuaHMiEKlmqVqHVYSP
	 Xjp6Nbze0FS8G/ReSzgaQAVsI7pTmkEG/BYuYNz7ex5oqOpr+0oyRaetR4hx3brtwI
	 jvmqHioN+Any0WBMIFwKwrB1OaMX+6KSFUFZtWrUDux/B4aMua+SZ5zUoENCv1Sbji
	 0yiL9jxMPzJKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Qian <ming.qian@oss.nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
Date: Wed, 28 Jan 2026 17:20:33 -0500
Message-ID: <20260128222033.2800495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012709-declared-threefold-0e87@gregkh>
References: <2026012709-declared-threefold-0e87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212684-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A7C0A987B
X-Rspamd-Action: no action

From: Ming Qian <ming.qian@oss.nxp.com>

[ Upstream commit 3de49966499634454fd59e0e6fecd50baab7febd ]

For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
and clock enable bits, but is ungated and reset together with the VPUs.
So we can't reset G1 or G2 separately, it may led to the system hang.
Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
Let imx8mq_vpu_power_notifier() do really vpu reset.

Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 00879615a7015..a430c14ce16d3 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -810,22 +810,25 @@ static int imx8mq_vpu_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+/*
+ * For i.MX8MQ, the ADB in the VPUMIX domain has no separate reset and clock
+ * enable bits, but is ungated and reset together with the VPUs.
+ * Resetting G1 or G2 separately may led to system hang.
+ * Remove the rst_mask and clk_mask from the domain data of G1 and G2,
+ * Let imx8mq_vpu_power_notifier() do really vpu reset.
+ */
 static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[] = {
 	[IMX8MQ_VPUBLK_PD_G1] = {
 		.name = "vpublk-g1",
 		.clk_names = (const char *[]){ "g1", },
 		.num_clks = 1,
 		.gpc_name = "g1",
-		.rst_mask = BIT(1),
-		.clk_mask = BIT(1),
 	},
 	[IMX8MQ_VPUBLK_PD_G2] = {
 		.name = "vpublk-g2",
 		.clk_names = (const char *[]){ "g2", },
 		.num_clks = 1,
 		.gpc_name = "g2",
-		.rst_mask = BIT(0),
-		.clk_mask = BIT(0),
 	},
 };
 
-- 
2.51.0



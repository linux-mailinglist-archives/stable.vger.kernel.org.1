Return-Path: <stable+bounces-225901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBgsNJxHuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:22:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE52A9C38
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5695130DF406
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF743BED51;
	Tue, 17 Mar 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgJGRbQE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187728E00
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749841; cv=none; b=Ccx47vT5oW8yZUNqEWrN3RC3rj3JC4c0nJR0TAbTTJ2lMsx8C+Uai2I5ACqKRiMDAqR/M6nFDDsZGo9amvPVmZFEPoDP0AiTsuAaj38W0i5oLD87fNNrVkA5PtS9jAvLpX8WQQphRY9FjM62rhmDwZ/tFt3Kw9+J6CMnvDkUO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749841; c=relaxed/simple;
	bh=9uRl5U3jU5QiKIKO5y/qljmAC2hT1l0MsJC11CbM5Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmemAFV6uiDqZfMmXOonqi1TRx8VY/0k4wVJ26FfSwfc28QwcUOcdLnvdVH0wuRMKsY/zbSU2vGhqwBLJpkAcxrZss+uExNmq6QQYduCrS0j/U1YVldHkvlZSXFbGr7zJP/ivBHqG8+dulxCmxW3CkkTofYl092ul+r3xeup1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgJGRbQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF16DC19425;
	Tue, 17 Mar 2026 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749841;
	bh=9uRl5U3jU5QiKIKO5y/qljmAC2hT1l0MsJC11CbM5Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgJGRbQEPZ/VhvFZDbKBNNtDuqoPZTMoFj8/nS9enXO0XNmphFrRxElW2b2uUwdrQ
	 XV3iLpYiA6NlEArMKNWjhVf/exd5idRF8gOC+uhuq/KezCdxFkjN6cSwBPmowpYUXt
	 AMkXESagP2OEZlKSw88C5YBKcxjKV+BbcTDd8cQ7NAyEWc32zd/FxEuY+aAkf9Mzec
	 JCRpAVy0gyIZUNouOk55FyVvXnWts/S1XgYxLEbmJeAZZ8Ew7KYhlmxNKIyirU+h2M
	 4sQBL6j/DAHlotSonbaxPrw1L12jsKwXANjLgSxOzpB3mywdKgMbscuJQyQbF5TvNh
	 f+b895yo+WYBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mmc: dw_mmc-rockchip: Add memory clock auto-gating support
Date: Tue, 17 Mar 2026 08:17:17 -0400
Message-ID: <20260317121718.140381-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317121718.140381-1-sashal@kernel.org>
References: <2026031758-blob-blot-0711@gregkh>
 <20260317121718.140381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225901-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72CE52A9C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit ff6f0286c896f062853552097220dd93961be9c4 ]

Per design recommendations, the memory clock can be gated when there
is no in-flight transfer, which helps save power. This feature is
introduced alongside internal phase support, and this patch enables it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 6465a8bbb0f6 ("mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 9b17490554d7d..3d1ec1ced6f62 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -18,6 +18,8 @@
 #define RK3288_CLKGEN_DIV		2
 #define SDMMC_TIMING_CON0		0x130
 #define SDMMC_TIMING_CON1		0x134
+#define SDMMC_MISC_CON			0x138
+#define MEM_CLK_AUTOGATE_ENABLE		BIT(5)
 #define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
 #define ROCKCHIP_MMC_DEGREE_MASK	0x3
 #define ROCKCHIP_MMC_DEGREE_OFFSET	1
@@ -469,6 +471,7 @@ static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
 
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
 	int ret, i;
 
 	/* It is slot 8 on Rockchip SoCs */
@@ -493,6 +496,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 			dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
 	}
 
+	if (priv->internal_phase)
+		mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
+
 	return 0;
 }
 
-- 
2.51.0



Return-Path: <stable+bounces-225883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO21JlNEuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:08:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D3E2A98B4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B587303FDF7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B013AC0CF;
	Tue, 17 Mar 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZm89670"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCB1C69D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749095; cv=none; b=cXti+RHJc7WV2yS2PLIyPuHCV913HSp/Db8pbHQmksHP30Kzd+9QH6WgLW72cmUvNDuE67kdA6cPtg578DTJperXUntMcnRRD3w3VF9iJ3/RTr++LNZioEnpTF8b2iIMktCHs6m/D9LrWoiKi6Q7DVgWTS7klbX3TjgMaxULlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749095; c=relaxed/simple;
	bh=XQ05WKrnUQdqIdcihTXbyUYM+2ARd8BuL+bA5y1hbPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0uUsQdrPcv/C5vAerCVE+tInrF9cDM/3PSHhLthU+ZlPPSuxwVBf9bFiXCGrdnE9zJsIyKd/g9ILnxvwnGt194mD6L0D/o9Ty6kM0ObnKNf0syM6fdG75wuqFrp+tD7BweYaXSC5B7n6Z5vqaJ+oZn5+F5XvGAon7wAhXXvhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZm89670; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9612C4CEF7;
	Tue, 17 Mar 2026 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749095;
	bh=XQ05WKrnUQdqIdcihTXbyUYM+2ARd8BuL+bA5y1hbPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZm89670m8XpF7UVcEvuLS2DXxXTNKVXzm0c1CvKfyfaiSu5L1PazqBoqcsCtjawz
	 x/egESnKpbvZYU9nqLkUfkDZgUNxIkxgLq0HivYXS1c3f72xTGlKIjh2Wld5diQEff
	 gB4YMzRc28iWTO0wJY+tXGBPRn29HlrgBd5ulmmopTKFQ42R5SgTal0a9uQFVzLCVJ
	 jDt/C17Pb7YTK0eluXW4C8O9TYJ4Wefi7A8tPrvY0oiSFAPvu4FsPctqu06cx64cQe
	 FbvGHToRF25VqBLDujQONzZ7uYygH3aF03VIyOp7jUukJLSjTcQ5xwqOBnWFVhCDfD
	 Kcc9muKGbsY8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mmc: dw_mmc-rockchip: Add memory clock auto-gating support
Date: Tue, 17 Mar 2026 08:04:52 -0400
Message-ID: <20260317120453.135633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031723-prologue-devotee-9062@gregkh>
References: <2026031723-prologue-devotee-9062@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225883-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,rock-chips.com:email]
X-Rspamd-Queue-Id: 04D3E2A98B4
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
index 681354942e974..62c68cda1e214 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -19,6 +19,8 @@
 #define RK3288_CLKGEN_DIV		2
 #define SDMMC_TIMING_CON0		0x130
 #define SDMMC_TIMING_CON1		0x134
+#define SDMMC_MISC_CON			0x138
+#define MEM_CLK_AUTOGATE_ENABLE		BIT(5)
 #define ROCKCHIP_MMC_DELAY_SEL		BIT(10)
 #define ROCKCHIP_MMC_DEGREE_MASK	0x3
 #define ROCKCHIP_MMC_DEGREE_OFFSET	1
@@ -470,6 +472,7 @@ static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
 
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
 	int ret, i;
 
 	/* It is slot 8 on Rockchip SoCs */
@@ -494,6 +497,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 			dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
 	}
 
+	if (priv->internal_phase)
+		mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
+
 	return 0;
 }
 
-- 
2.51.0



Return-Path: <stable+bounces-94858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF39D6FBB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0343C162249
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FE1F940B;
	Sun, 24 Nov 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJzTiRfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2E1E00B0;
	Sun, 24 Nov 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452835; cv=none; b=XwAuagdb04HjE7OsnbLCom8gQoiLqKms90TJFSJKke0maBriIb7hsouwJkQMlDG5GLhpT6ho6JmTCC1T80ZuJCiBvUr6yvBYEkJ44gFcXus/IhQMLN2yCSXb/Dgs0CqlT8aQ8w0Xdke99GSTjFCdB9FKqkXrns903qNnE5xqUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452835; c=relaxed/simple;
	bh=cJcv5ATerOqHRrqC8Sut9kB2yJ2kCCaPo0YASFDYuZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBe54Qv1EXM7CdSzD8Ow+rcTYvJi2qqQgdjzXHoSsE8g/zp6aicT9PKqlMtNBeXeaKSH0ZfteKtVbK1yJn5crW8alCprCa3npctpTI4iNhGR4owr+i06WgY7oUhbwmgfdvdzG7/tqJ+xBXtodmtTFc3vk+Tqq9StpzbkJT5QONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJzTiRfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50FC4CED1;
	Sun, 24 Nov 2024 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452835;
	bh=cJcv5ATerOqHRrqC8Sut9kB2yJ2kCCaPo0YASFDYuZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJzTiRfOpp0geavRZZiaPBAw3BP+C1+7nveqKgxvDBhYJTbucKFVVE0uwQq8ak36g
	 AF2wdctTWBnorN0doiIRW1p8tRuvXbsojNu7KdDEoecJ5Fyy+7piaaRo43xGFD/M7N
	 1GlK3JhszfXnKHYAoIg1FcYA3PAttYB6qVJbAXBNd1V4i9saO0SygaHRWLYrMIVJCs
	 d5RMM6zVjlY2U6Ib0PUZgOm3w5UdWlPwegc+vJ4lAe8h/wttrMHo58CSjNtT49TbNQ
	 xhs7kBD9RsNDXp84h9jez5iA0qdBTb5I0SMZJNhV1BFzrB9TncNj5apyP6PXQCE7Cv
	 wENWZMf6eZMgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 10/16] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
Date: Sun, 24 Nov 2024 07:52:28 -0500
Message-ID: <20241124125311.3340223-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125311.3340223-1-sashal@kernel.org>
References: <20241124125311.3340223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 4dede2b76f4a760e948e1a49b1520881cb459bd3 ]

Enable SDHCI_QUIRK_NO_LED for i.MX7ULP, i.MX8MM, i.MX8QXP and
i.MXRT1050. Even there is LCTL register bit, there is no IOMUX PAD
for it. So there is no sense to enable LED for SDHCI for these SoCs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240923062016.1165868-1-peng.fan@oss.nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3b8030f3552af..e4e9b84f210b2 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -235,6 +235,7 @@ struct esdhc_platform_data {
 
 struct esdhc_soc_data {
 	u32 flags;
+	u32 quirks;
 };
 
 static const struct esdhc_soc_data esdhc_imx25_data = {
@@ -306,10 +307,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 static struct esdhc_soc_data usdhc_imxrt1050_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
@@ -318,6 +321,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
 			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx8mm_data = {
@@ -325,6 +329,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 struct pltfm_imx_data {
@@ -1664,6 +1669,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	imx_data->socdata = device_get_match_data(&pdev->dev);
 
+	host->quirks |= imx_data->socdata->quirks;
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
-- 
2.43.0



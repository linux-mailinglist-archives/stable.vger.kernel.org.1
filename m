Return-Path: <stable+bounces-94820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E696D9D7214
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E7AB25246
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5C1EABAA;
	Sun, 24 Nov 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqALUym5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A41D63D8;
	Sun, 24 Nov 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452625; cv=none; b=Vdj6/W8lxZfJEBks3oIX+YGzRhUhakxRX1ybbqrBLWCmolUBuFJFKZJSioTXxIyDHObOqi16g3lGnUTX8i076Xfaz7nHmtmb4EbaDoCoTheK+yOOc3P4lBNGkS4b+xlICWtKUWijXz4uknu7TI1mU+ReJHRu/n3ZeFsK/ITILTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452625; c=relaxed/simple;
	bh=Q3vJFI8VEQ+dQP8mtJd2dsAUO29gicA9uABtQSdl9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4hIB+2HcqaPBSioLEHsfkj1f/9y92kwcmNcXKhZBixERIuyRfobJN/ws0p188wtFJIQsskieRyF61jp0GbR1ZNXCGntKxwJuV1G8yT7Pm0O1DJwg7kWX4vRoSCY39kF79ZerE9EToFeDfCjy5rhY6ItoDhJOC2S3/+NJ+01w38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqALUym5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097B1C4CED1;
	Sun, 24 Nov 2024 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452625;
	bh=Q3vJFI8VEQ+dQP8mtJd2dsAUO29gicA9uABtQSdl9/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqALUym5NCAJad2wOVNljvX8jLzSTEqmUHfyaFBLfk3cMg+6P/aeF1yWKcgMZqDoC
	 7Mk5gQygYTM87FXQ9DuAA5JJO5nazHCtciDgRDZpvyveCDZev+qWjZL8nDEDtMpQcC
	 Ztd1CPHwGlgBdNv9/X1Sv6jnd3wrJ28rIGt7WYkxS0B7zQ9RmS8iUFj9wuW7E0gIq2
	 qET0YPDOuZ8Cwdu484q2ofGt5KcZuSt23uv2bqzIDUyRBPGuyEnX/kGOpTZKJgviJj
	 XSS7FKaDASqGwj9C3XoZIbhdZM62JDY7UM8MVSv9LhtKRTqv5x9CnkLnFJejHK/yrn
	 6vHvTSvF5RIvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 15/23] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
Date: Sun, 24 Nov 2024 07:48:26 -0500
Message-ID: <20241124124919.3338752-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124919.3338752-1-sashal@kernel.org>
References: <20241124124919.3338752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 8f0bc6dca2b04..ef3a44f2dff16 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -238,6 +238,7 @@ struct esdhc_platform_data {
 
 struct esdhc_soc_data {
 	u32 flags;
+	u32 quirks;
 };
 
 static const struct esdhc_soc_data esdhc_imx25_data = {
@@ -309,10 +310,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
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
@@ -321,6 +324,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
 			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx8mm_data = {
@@ -328,6 +332,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 struct pltfm_imx_data {
@@ -1687,6 +1692,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	imx_data->socdata = device_get_match_data(&pdev->dev);
 
+	host->quirks |= imx_data->socdata->quirks;
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
-- 
2.43.0



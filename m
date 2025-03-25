Return-Path: <stable+bounces-126394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E7A700BC
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851E519A2829
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAFB269D1E;
	Tue, 25 Mar 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPepClee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9021E5B91;
	Tue, 25 Mar 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906142; cv=none; b=juVkP0bZfKK1bPgEz3GRCO2ZHgNsQ9cBABjcIkcRBxucdOU4Nudc9TW89LHhX+5hbakfW+XOuwg4ULN756oWl7MfEhLcCfNjE6coXJmGFzpTFD7n/7s+s5VMtP94fOp01iIh6sZBVg6RknTxw9v5phTMxenRokbnRM/bJThnIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906142; c=relaxed/simple;
	bh=1n+ejCyj9qm7lmo7gP6TkF+nw8Kb8PCKZN8kJqw0byI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkOKSXshwk91u/FlipOZIiWDEtIX5sjoThpKLGIVTuXXq+rTIUSpiJ8nCzQJpAIioo1LVI83gj4l2FTaNOpa8P2uJdrGT1EYwjbOmzKGMck6xdgBGTPCd5Xpe0RBzX10wbIHTvn4Rwxl7jJX4srceNn7vWRgY1j4D0oDzGOUK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPepClee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B4C4CEE4;
	Tue, 25 Mar 2025 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906142;
	bh=1n+ejCyj9qm7lmo7gP6TkF+nw8Kb8PCKZN8kJqw0byI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPepCleeNHkYqzU/0NKc4oCYKDIcoTuNf54D0U+Yv+hOS6fvzj+ioDEw2YJdgZmTu
	 Yrwj/GdLMyLA5B4zZNH4ifuSSt43hwy3KwHdhBhGu/1PC9vs+UDDHoW7YC6QBqzsoa
	 2ozg+dwxLIKzxHsdjmJ0rhxrxATUCjg6nKnpmL70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Felsch <m.felsch@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 07/77] soc: imx8m: Unregister cpufreq and soc dev in cleanup path
Date: Tue, 25 Mar 2025 08:22:02 -0400
Message-ID: <20250325122144.498603904@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
References: <20250325122144.259256924@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit cf7139aac463880cbd5c5e999c118fbe91631411 ]

Unregister the cpufreq device and soc device when resource unwinding,
otherwise there will be warning when do removing test:
sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
Hardware name: NXP i.MX8MPlus EVK board (DT)

Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
Cc: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/soc-imx8m.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index e66c73cc02871..064188a0870b0 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -192,9 +192,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
 	"unknown"
 
+static void imx8m_unregister_soc(void *data)
+{
+	soc_device_unregister(data);
+}
+
+static void imx8m_unregister_cpufreq(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	struct platform_device *cpufreq_dev;
 	const struct imx8_soc_data *data;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
@@ -239,11 +250,22 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
+	ret = devm_add_action(dev, imx8m_unregister_soc, soc_dev);
+	if (ret)
+		return ret;
+
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		if (IS_ERR(cpufreq_dev))
+			return dev_err_probe(dev, PTR_ERR(cpufreq_dev),
+					     "Failed to register imx-cpufreq-dev device\n");
+		ret = devm_add_action(dev, imx8m_unregister_cpufreq, cpufreq_dev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.39.5





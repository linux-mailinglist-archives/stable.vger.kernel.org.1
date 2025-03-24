Return-Path: <stable+bounces-125972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D5A6E49D
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DF2188BB55
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB541A08CA;
	Mon, 24 Mar 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FbDwT0Kp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CC188A3A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849265; cv=none; b=pIjN+AXS/lZu9uTUXujo6oFiDRIUHQiWE6LnkFKBkzqAmTdZMcB1eBRhMo0NsT9xyufv8ydWsWyzvn/xW4376WHVX/I56dEpm3nNiGRxDBfqBKzMh2LU8sEal4ebWf7bX3831aZFz0gRoGHTn9ilFSWrh3n2lqQb7AU2DPNcR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849265; c=relaxed/simple;
	bh=Y/fGKeukbRRdYd9HAdrqdc+Ww5vxvuN8L0TDWLKeyb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JNgIoAtM/fnLHS17XCwSWPiuHJbD97lhDToF4VSRwZCVoxw3TTmMZYm3AYRKVRohgXad4F0uDIsI649CEdLjOHoaUcfniAgjOMT6OiU0iGLm78fgXxL2/OKlHUW7pppwi0NemcdZcUhEEzjLwGcv+otDrXyr3hH0O/kt2HVYch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FbDwT0Kp; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1170762fac.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742849263; x=1743454063; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTCHPcQcF05vSjvDkbTHLywGzk90qemE1sdRxR2q4NM=;
        b=FbDwT0KpaTzB3bscRkoMlm+7NHWdHu2tQCYDNVZ42/Q3NSyFA4Lm/FPDzhw4ovsxbR
         RNVXoNesnOC+maOYCYJstPFXMt8Kq2g2oDOB88hyr/qG+irZcAucwY+7N5raOE7rWycf
         xFCpGEI/mVUy//LWZUm94LqFqzkW54yO9rXQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849263; x=1743454063;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTCHPcQcF05vSjvDkbTHLywGzk90qemE1sdRxR2q4NM=;
        b=YtL6RkgE+j2662tvhP6DaUZxVCLrGRtcswoUud10GvZuzF/+T844uQUkRwTdvUZHcL
         DXdN72GwaT44WbwercRp4wVntdElXcsdjdi/mZEytFC19nWdlF5yjAwoAFDtSuaEuiCG
         sKDyovhc18OKNEVoCWOLyIe2juxtLUimMfEEhYehIgbpaUnMSpbg5ptmecKqt9KFEd+x
         OSBLSbWExcvho1EAY558WXEXMP0rsn1WJLHzVSZ533iYANwaPYBlj7aF6tRvXjiCLhZm
         9ttj8dGGCEKP3UkyDBCBWLiovj5zRtt/vrJZPQtVMbjwKFfqHeY3vze2o1a6xe+SXu4U
         G8xg==
X-Gm-Message-State: AOJu0YzGNy73/qvvSAabB5cVx9Dk4mFAnkCPhNAjY3XgeL/kWPLDQUDh
	j8J7Jl/Ibwi+13wu+AIVQaVJOBABXpN8gAg8OdAQv8y9AbJ/Xqgx0m8MtzvYMcLdhmgCBIeqQkC
	YghwEAsxMsI7sgLFJdYaU8SoGH9XS13rCq1aw4eC2kl4rtl5WU8AXzfmlb0X8HA88DFVY+7OU0F
	Ss6rVIfgwFVHR/99otsM/sSM2xTeCWjabpxYjzB9Ue88M=
X-Gm-Gg: ASbGncsNVWyeoFOPVS6kQEDWde1BSSPHooJ8c3NXjJkT769TTtf5gT/ODeLHRCcyCet
	WtUgTvpxpiB6QtlTMgvIppk82hxTL5bXnESwed7N7tNC2QNg+vbAZw8lsUtLmEPqW2YyQTxKIS0
	GBj8ISvgd/O8sLkGKBSvVT0AlYgXjwIprhSPre/ALqpUqvQdWVNDbwn86s14ygbzALKu55v0CQd
	7GjU6+x+Qv/LcynxfYCmPv6j5NxkYeM3dXpPYhDSDMn6f5cD+kwbNXKDZLX8aVUV+V0q7zTjv59
	maBI+o1J1tLX77xeOFtq/1I+U+P6mAS5luNMIQSlhs9XecHPSp+73jvzX9Od9cidtsjkyE2QoTl
	rzNar
X-Google-Smtp-Source: AGHT+IFpv3dghzDMqGhpgnv4NzpxRACpnDRXx35I8NKo2CkBQEInslUiejPDgKMWwry7LWraQHOiuw==
X-Received: by 2002:a05:6871:3291:b0:2c2:3e54:553 with SMTP id 586e51a60fabf-2c780516238mr9723695fac.28.1742849262596;
        Mon, 24 Mar 2025 13:47:42 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f6825sm2181080fac.43.2025.03.24.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:47:41 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.10.y 1/4] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date: Mon, 24 Mar 2025 16:46:36 -0400
Message-Id: <20250324204639.17505-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2025032414-unsheathe-greedily-1d17@gregkh>
References: <2025032414-unsheathe-greedily-1d17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Kamal Dasu <kdasu.kdev@gmail.com>

 [ upstream commit 97904a59855c7ac7c613085bc6bdc550d48524ff ]

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz. The
driver will need to get the clock and increase it's default rate
and override the caps register, that still indicates a max of 100MHz.
The new clock will be named "sdio_freq" in the DT node's "clock-names"
list. The driver will use a DT property, "clock-frequency", to
enable this functionality and will get the actual rate in MHz
from the property to allow various speeds to be requested.

Cc: stable@vger.kernel.org
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220520183108.47358-3-kdasu.kdev@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 4d42b1810ace..8fb23b122887 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -32,6 +32,8 @@
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
+	struct clk *base_clk;
+	u32 base_freq_hz;
 };
 
 struct brcmstb_match_priv {
@@ -251,9 +253,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	u32 actual_clock_mhz;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
+	struct clk *base_clk;
 	int res;
 
 	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
@@ -331,6 +335,35 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (device_property_read_u32(&pdev->dev, "clock-frequency",
+				     &priv->base_freq_hz) != 0)
+		goto add_host;
+
+	base_clk = devm_clk_get_optional(&pdev->dev, "sdio_freq");
+	if (IS_ERR(base_clk)) {
+		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+		goto add_host;
+	}
+
+	res = clk_prepare_enable(base_clk);
+	if (res)
+		goto err;
+
+	/* set improved clock rate */
+	clk_set_rate(base_clk, priv->base_freq_hz);
+	actual_clock_mhz = clk_get_rate(base_clk) / 1000000;
+
+	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
+	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
+	/* Disable presets because they are now incorrect */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+
+	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
+		actual_clock_mhz);
+	priv->base_clk = base_clk;
+
+add_host:
 	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
@@ -341,6 +374,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 err:
 	sdhci_pltfm_free(pdev);
 err_clk:
+	clk_disable_unprepare(base_clk);
 	clk_disable_unprepare(clk);
 	return res;
 }
@@ -352,11 +386,44 @@ static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_brcmstb_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	clk_disable_unprepare(priv->base_clk);
+	return sdhci_pltfm_suspend(dev);
+}
+
+static int sdhci_brcmstb_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = sdhci_pltfm_resume(dev);
+	if (!ret && priv->base_freq_hz) {
+		ret = clk_prepare_enable(priv->base_clk);
+		if (!ret)
+			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
+	}
+
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops sdhci_brcmstb_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_brcmstb_suspend, sdhci_brcmstb_resume)
+};
+
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sdhci_pltfm_pmops,
+		.pm	= &sdhci_brcmstb_pmops,
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-- 
2.17.1



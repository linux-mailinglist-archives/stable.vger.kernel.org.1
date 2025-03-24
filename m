Return-Path: <stable+bounces-125982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E3A6E673
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 23:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D5D3AAC12
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037B1DC998;
	Mon, 24 Mar 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NrWn3LYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D69189520
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854371; cv=none; b=gSPbCxiwg6KU9qbqZN/boTt+JRx0pMrc76PPVROhXsKvcwWJGzw3Fnz0vQxBabjeCfmVaErXQVNuqG/90yGGCHvfkRXQSy2OnhKpROvIMyWxVjpIBpJHeECUjQY9Too6zGnD6LjNvIl6DqSflxPpP6gN/26q6KiDBQ93/5a5NZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854371; c=relaxed/simple;
	bh=Y/fGKeukbRRdYd9HAdrqdc+Ww5vxvuN8L0TDWLKeyb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qi2mB96CsVtsp4vjfaxR/Hf10OSfBUZnfyWwQIzCokKkaFRtFcYdjg3u9dJxJJDfCTGnqn0IQQiXufPZbvb9vnnuKxzNEpUEEyYYghLpqa+qzonQ9zJWzUnxdwBw3R+Y2AAEL18gw4IoXhMKceQjGAkaSGz6NzeUpKHAy3qo1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NrWn3LYK; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-601a46ee19fso2573115eaf.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742854368; x=1743459168; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTCHPcQcF05vSjvDkbTHLywGzk90qemE1sdRxR2q4NM=;
        b=NrWn3LYKl2C7591lZY0FaAlKD009jnc0E+ren5PqdbZdkjyBljVHZIbZ3h8Cr0PaGl
         fw1ZtF7Cnw5Ya9e2w5IWyKdXj6zSQh0JPzEWLlqon17sttRkxe2lXIWowSKO7ZBQ9Csp
         DTgvB1jHi3yEGvwXISHZlF66caUXkQvvjF6wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854368; x=1743459168;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTCHPcQcF05vSjvDkbTHLywGzk90qemE1sdRxR2q4NM=;
        b=AOhEjByy2YAlbsbnrNrlcgtPkEOCGh7wHzrWMkI9YrQZBAoJtRQFuI9i6s21DhvUSA
         pxUuyvnPnEXzn0GfbOwJdy9HxBMFK+Y9RQbnpHlS+IsVhFCDyFO0gFnBVJQGfM5pXiaD
         vTesKAkI3np1nfMpjz9mb6u0gGL+MzKd1YsjWAvsWcCgyfVSaD3csXm+b+XQdRY0iWTf
         lX0JI002SDZobTflBhjYhIrteUA2NxzjHe9jzyn/f8zcnAFru9rqdpSe3guNk1bOOCOh
         i0NkyFfiXS15mDRh9xvoGqtqI7hMhQt5xNkgh8JT2HpyWrMwkNB8q4XiABv744CYM/4h
         VuSA==
X-Gm-Message-State: AOJu0YxLUrwq2/zac9mvGrtyWDhqmMlK9JP2zaxixd0dev3Dx/UkLrdH
	qX+FRe6SoRR2ZjfBzM43u02pC8owvQ2kTFFkr/yDLa38y2rrv/kr5Fv3eNd3x9+/P27znY3hAwN
	aX+jstccZjMkIuIdV5+Q2Cno5dqcm9LV0Y0TUD+zsEjrpyTVmqYwt89f3Jv0lAShURiNekS3q3e
	TpbPDy9BPtuoEX4EXzcIH2heDT8ZJbdZJd+37MG2eFI9Q=
X-Gm-Gg: ASbGnctGrnwZr6Up0+0bOzNTXWKq8wj8PkDxGUo1uol36mAMe+X2hxm3lTsXlQHsdMw
	Y4xgAiM6uGXujNb1nOYNQtphLPQKXr6pcAMq07iD59bvxX+ToDjfkzLnzG2cc/z5BdMLtnfiRy0
	peQ/cVQ5qObDZjy8KKHCNsATFq6EKwwOnLEWSFNUqMcT1XD9dzBE6HUolgbLPtp/l9pIntcuqJi
	AvPKBT8UCh4nxnpqakKXZzVIdStg37YVgFqceebqS0/+8fEgRmgSj7hWQY9EHoJW+cbLSK/NzFa
	t7hcU0/2CIg8WMamfNyBkZbTQTXdgT/M43X3x3+kccponBUX6aYoV66Hjcx4CcNtY17FuUB79P+
	PmslB
X-Google-Smtp-Source: AGHT+IF9biM9bbDLT+IWEsHu118rwmPRbJgkTM7+K1Jxnzakgl0mD5PHBkGx2GOUSR3KDRmCv9LZcA==
X-Received: by 2002:a05:6870:46a8:b0:2c2:3ae9:5b9c with SMTP id 586e51a60fabf-2c7801fe4d5mr9886008fac.2.1742854368194;
        Mon, 24 Mar 2025 15:12:48 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f4105sm2217555fac.47.2025.03.24.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:12:47 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 5.15.y 1/4] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date: Mon, 24 Mar 2025 18:12:33 -0400
Message-Id: <20250324221236.35820-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2025032413-email-washer-d578@gregkh>
References: <2025032413-email-washer-d578@gregkh>
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



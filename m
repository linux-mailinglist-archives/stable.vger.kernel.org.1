Return-Path: <stable+bounces-121362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E590A56549
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2283177714
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E020E32B;
	Fri,  7 Mar 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afCquojl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0920F090
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343372; cv=none; b=e2jHT3Iafp5QAKwj/WEorDcvaNUCKNDqWqB3l334Rq9O/37sFae6IeVPS+V/3kUeTso7b5KWCZJxlgHhhtjQ2MNGeIWIFDtPQMauI1DcR/yul0A8eTjK5Ha78S7MxaaBPxi6nkCDC3KVdgP1T6CmSgDSDUWdo3S/5IKZdqojYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343372; c=relaxed/simple;
	bh=5hPOCM1S1pmc1S8RzEq8t8D72yqSF8b6KhQM50bjrdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhC2xodNcFEIUX+qLdm9q14EW5iYtNzGKqUOkT7aSGmmEXe2qlK19Yb2MlAf8nRjerfjnJIvfbhIaCrLh0Zps/rru5/kdSr8SjpSR6e2tmhMx1n0RiXoOcwKFwd2NAsV+eejOBV2kC7Qsds2JwDRWrqS4pk6vHeAN5uDH/oECVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afCquojl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so13889905e9.3
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 02:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741343368; x=1741948168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOc5JswKnDA4H+vLGsg75xhpVAwF1vf0JvXpUApvXDs=;
        b=afCquojl8Gqjpq7ModT6DGq6jmrtWmZH8mu/4V8MbCc7N6xRdLmgHjUUBZOWdt5skl
         9oWgttfAGHatrcIPjRW0jryVwWL/r/qP0Lg4X4CNFdrwA2R5qlKDlf1q17GXO1taY0Xs
         8GUMT4FaCuD7NWQlHy8PXLfvogeDlWBt1B0h4H0k2rox7VtgWM+G4R5o37XqKEGCPjvZ
         vLDBnTR+Rwk4c894YU50ON0eeAYtX05+XV3k84w5WomAQ8DprgJ8AtH75pra/c8Oup+L
         XIj4lrO7DWPv9qYgsGNrfKIpvEgYUM0O3zlnJBVbJgLfaZP6MVumgg2KZXBm8477yJO+
         9SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343368; x=1741948168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOc5JswKnDA4H+vLGsg75xhpVAwF1vf0JvXpUApvXDs=;
        b=DQGgxOL1FlSWI6W28YU3X6my1CyuRBmO4wfC0MsZtIdzl5RWAZQVrx9CR8ZY7Ng9ao
         2XEKAI9jjItxo/eEVoyQNV2r9wGv//a665PTb5rDYyEosRT53n5VaFLZSj3fysGx6WnE
         0eIUma/wPe29jBELnxV2GgqkBhwyCzxIdb2OsN0t/TkcKHGpwwESkESDuPnjwzDo3fBl
         qpH2uFaHdbeBkpZSg8Rala5VpCixdyHgRI2+D/yFNrmNaGjEk/ZoQfTBX6zdcuTfkZ+1
         JEcx7fhfogDM2ytIubOulWcvJKSFZ6QwmNZY/uW8xFYS3JBWFLR2ZGy6Ezvvh0yYWyfO
         b07A==
X-Forwarded-Encrypted: i=1; AJvYcCXOH7kRA+Kah8/3g1mdhLUDm3/GYjycHd7Z3n0JfpNAFbyHLlUV+PrF5mrOHFTx8LZKYIDvSAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywD1fpRwosHMG9sl6eT0xkL423AVpIQcXWemywE+w468uwgAed
	lVLyDmm7Pm7UEKfG6z2smO9HjKTEMAKPh9fv7Etx8JSkyQDl55nRGLHsF+am35Mp/zDzEXXm/Gg
	X
X-Gm-Gg: ASbGnctNfSwry6qNMHuogdKn6vb9yVwr8klZPIqYS8kKjYN2UqEWL6FRtd/iJsrneiv
	51nTIaotO4rD1T7+0AsyK/AvUOQJsB/AhdsjJxSLbCuOknBus2oWDdmdiU29YKRHesgqWvazA6R
	L+64XVd9pKS5vTeOTvttvbnU5pfOBxGA7Dl2aNOPB5IDcuDF+XfiRVUmemmYpxiyE9uwf9AyIMj
	OUzwNuPldyJAEHB0gvtnyAJRfUshkBWF5iyiRfr3xZJ9uGDDlDEr691mwpExbWme1y+7E5X/GdM
	r5JRPQCkwVEMdzPc0Mu0sjja7DnltcTWr3wNjCEHd2e5bxhi3Ka/wl0GKvfZ4D70VruVMc7rbmY
	=
X-Google-Smtp-Source: AGHT+IEDjIydZyO8tevIfkIq4dv+j9dQjTmzyABCpR96qJ7XQw5e0qvvubHLPigP0m6YKTDQV3Lu3A==
X-Received: by 2002:a05:600c:5857:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43c6de39734mr18301675e9.2.1741343368303;
        Fri, 07 Mar 2025 02:29:28 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0461sm49192955e9.4.2025.03.07.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:29:27 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 07 Mar 2025 10:29:07 +0000
Subject: [PATCH v4 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-pinctrl-fltcon-suspend-v4-3-2d775e486036@linaro.org>
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
In-Reply-To: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7443;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=5hPOCM1S1pmc1S8RzEq8t8D72yqSF8b6KhQM50bjrdw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnysqALrYS4PAAAK03uKqVFDBA1lA/Q4rTqdKug
 ndPT2Rx3AOJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8rKgAAKCRDO6LjWAjRy
 usflD/9oI20ugy/mZ2pMSJJTiyGUQP7ZbgMDGHZCKXWK5L+JJAwnG8LDkGVfe5R3IeoifLxtf8J
 Fi+svFPN+9afcfIMcOM8FIRjtjihtqw6Q/P9jaO0+MNqioD+KajVnNniijLUVEW0WYoSPPod7L2
 wnhI/I44YRydoLoUSCiT9KGQRT+SuYXAve5a3YMbux7JUQjRiER1b1BiQ8MzILAFrznAT9uo3p8
 kLcPNDnJSG635E8Ko5W9Jz7haXhMponBYVbRxAZ+TkDhyC6VSJDN6tyZcDuRpgR+16vuxt9tDDK
 6q00TDduCjyTOlrSbcExqq6Hfv3Dgkn5YgoKiWe0hQs8dsM8yhGZ5OX6t2PgnFbtf+vK78M6KdQ
 MkzYrrYyxXfLf1Omwst6kQRvJazjKJF+cRCdWFU0iK62216TXPD2tYSKyD1P6C8E/MvOH3yU2UY
 KUNz5p8QoHTQFVnad5SBSWg43mWU1SS84Ro+oyGqXq4WrtVNINKucNufg/U0Z5QAbhU9B9poYYw
 Ov+bDmf5MMAYqogI/izBx6tIG7Nk3VDF6KtylbRtRCZi+W068z5vnrNcdWA4QYmZzrpQ2fuE/fH
 0iZ+nckrxNZpuO+NZOQJB8JG1nhQXL1ghoEZa2G13QQ/2g85Mtvdz8AJp4i6tUIZFH4mOIT0Wfx
 jtsbirq6sNP5bTg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

gs101 differs to other SoCs in that fltcon1 register doesn't
always exist. Additionally the offset of fltcon0 is not fixed
and needs to use the newly added eint_fltcon_offset variable.

Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configuration")
Cc: stable@vger.kernel.org
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes since v2:
* make it clear exynos_set_wakeup(bank) is conditional on bank type (Andre)
* align style where the '+' is placed (Andre)
* remove unnecessary braces (Andre)
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 24 ++++-----
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 70 ++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  2 +
 3 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 57c98d2451b54b00d50e0e948e272ed53d386c34..fca447ebc5f5956b7e8d2f2d08f23622095b1ee6 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -1455,15 +1455,15 @@ static const struct samsung_pin_ctrl gs101_pin_ctrl[] __initconst = {
 		.pin_banks	= gs101_pin_alive,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_alive),
 		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (FAR_ALIVE) */
 		.pin_banks	= gs101_pin_far_alive,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_far_alive),
 		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (GSACORE) */
 		.pin_banks	= gs101_pin_gsacore,
@@ -1477,29 +1477,29 @@ static const struct samsung_pin_ctrl gs101_pin_ctrl[] __initconst = {
 		.pin_banks	= gs101_pin_peric0,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_peric0),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (PERIC1) */
 		.pin_banks	= gs101_pin_peric1,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_peric1),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume	= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (HSI1) */
 		.pin_banks	= gs101_pin_hsi1,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_hsi1),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (HSI2) */
 		.pin_banks	= gs101_pin_hsi2,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_hsi2),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	},
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 75b9ab19e4e8f81bf85cd75573485b7f2e717e7b..5f0045d03346600557fa6735bad709897c71935c 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -798,6 +798,40 @@ void exynos_pinctrl_suspend(struct samsung_pin_bank *bank)
 		exynos_set_wakeup(bank);
 }
 
+void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	const void __iomem *regs = bank->eint_base;
+
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
+				       + bank->eint_offset);
+
+		save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + bank->eint_fltcon_offset);
+
+		/* fltcon1 register only exists for pins 4-7 */
+		if (bank->nr_pins > 4)
+			save->eint_fltcon1 = readl(regs +
+						EXYNOS_GPIO_EFLTCON_OFFSET
+						+ bank->eint_fltcon_offset + 4);
+
+		save->eint_mask = readl(regs + bank->irq_chip->eint_mask
+					+ bank->eint_offset);
+
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save fltcon0 %#010x\n",
+			 bank->name, save->eint_fltcon0);
+		if (bank->nr_pins > 4)
+			pr_debug("%s: save fltcon1 %#010x\n",
+				 bank->name, save->eint_fltcon1);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
+	} else if (bank->eint_type == EINT_TYPE_WKUP)
+		exynos_set_wakeup(bank);
+}
+
 void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
@@ -816,6 +850,42 @@ void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
 		exynos_set_wakeup(bank);
 }
 
+void gs101_pinctrl_resume(struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+
+	void __iomem *regs = bank->eint_base;
+	void __iomem *eint_fltcfg0 = regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		     + bank->eint_fltcon_offset;
+
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_ECON_OFFSET
+			       + bank->eint_offset), save->eint_con);
+
+		pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
+			 readl(eint_fltcfg0), save->eint_fltcon0);
+
+		/* fltcon1 register only exists for pins 4-7 */
+		if (bank->nr_pins > 4)
+			pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
+				 readl(eint_fltcfg0 + 4), save->eint_fltcon1);
+
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->irq_chip->eint_mask
+			       + bank->eint_offset), save->eint_mask);
+
+		writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
+		       + bank->eint_offset);
+		writel(save->eint_fltcon0, eint_fltcfg0);
+
+		if (bank->nr_pins > 4)
+			writel(save->eint_fltcon1, eint_fltcfg0 + 4);
+		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
+		       + bank->eint_offset);
+	}
+}
+
 void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 35c2bc4ea488bda600ebfbda1492f5f49dbd9849..773f161a82a38cbaad05fcbc09a936300f5c7595 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -225,6 +225,8 @@ void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank);
 void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank);
 void exynos_pinctrl_suspend(struct samsung_pin_bank *bank);
 void exynos_pinctrl_resume(struct samsung_pin_bank *bank);
+void gs101_pinctrl_suspend(struct samsung_pin_bank *bank);
+void gs101_pinctrl_resume(struct samsung_pin_bank *bank);
 struct samsung_retention_ctrl *
 exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		      const struct samsung_retention_data *data);

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



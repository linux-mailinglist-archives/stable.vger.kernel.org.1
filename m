Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4E7E6972
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 12:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjKILUZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjKILUY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 06:20:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D552D5E
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 03:20:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40859c466efso4889255e9.3
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699528820; x=1700133620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cavHVFQJ8PuwkxFyTFM+8LZM+EGSpdqZcaFZ4JxFv24=;
        b=VqXCCZpdpLUggHfPfSJ3lpJeiMUPXeDq52DMwPPO6JZL2diU5xdEzJey1pxB8CqV8e
         Vt504GkPy3OPP1NyO0ccINbWgCA4gzMRm5OQjmc74zshpAIObvRxrRL+MbPBx2xmrGYT
         BXEUHsm6XperJBlmBH8XfRR4FiIHnjdl8sHyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699528820; x=1700133620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cavHVFQJ8PuwkxFyTFM+8LZM+EGSpdqZcaFZ4JxFv24=;
        b=Y1XYgY+xYfR8i3muwJf77YgsqNwVT8DaaJeStI0IkZiMGgTon7+e6D1wrclcChQWjv
         EslPEBi3h5/AL/D0NGHvuOKmQ42cn4mrUOU5OWNAODUvV7WCPbWsOH3p+2Us9DpiAo4U
         De6p+OHghLrTgOaARVT2CxWBBcxwmORVMXkz1wBFnNeH6AvYKhJ79eBYrOnn6/7+pT14
         R2VbTwO/5URLVd5JlposR4z1sIhJGxGRA/3u5VyCzonVO52nKJdLnWKu8xpiXSXGjtUR
         l1D1NWO+3aB5FWLahX+pmrWsssOCojZ0kQLPIixD1+B1VCk49Ll1uX6zKpajvWAKcyya
         dZYw==
X-Gm-Message-State: AOJu0YwQgoLc24VNLQ8Ws+JvDh+qczW8GHmzUXaHJlxRy11GGJ7iW6g9
        zg4dlduE0yHveIbz/W8WFAM/Hnju9XkJOadob+U=
X-Google-Smtp-Source: AGHT+IFIoKr4jf0DscVS8+8kKDG9HyfDOFkGaLnalGFWGoyHWVF/fIEqh8WekzQytB0dT3wDRD3ArA==
X-Received: by 2002:a05:600c:4181:b0:408:39d3:a26b with SMTP id p1-20020a05600c418100b0040839d3a26bmr4133544wmh.40.1699528820536;
        Thu, 09 Nov 2023 03:20:20 -0800 (PST)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c44c600b00401d8181f8bsm1755732wmo.25.2023.11.09.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:20:20 -0800 (PST)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sven van Ashbrook <svenva@google.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
Date:   Thu,  9 Nov 2023 11:19:34 +0000
Message-ID: <20231109111934.4172565-1-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

To address IO performance commit f9e5b33934ce
("mmc: host: Improve I/O read/write performance for GL9763E")
limited LPM negotiation to runtime suspend state.
The problem is that it only flips the switch in the runtime PM
resume/suspend logic.

Disable LPM negotiation in gl9763e_add_host.
This helps in two ways:
1. It was found that the LPM switch stays in the same position after
   warm reboot. Having it set in init helps with consistency.
2. Disabling LPM during the first runtime resume leaves us susceptible
   to the performance issue in the time window between boot and the
   first runtime suspend.

Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d83261e857a5..ce91d1e63a8e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -220,6 +220,9 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+					      bool enable);
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -1281,6 +1284,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	if (ret)
 		goto cleanup;
 
+	/* Disable LPM negotiation to avoid entering L1 state. */
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	return 0;
 
 cleanup:
@@ -1323,7 +1329,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
-#ifdef CONFIG_PM
 static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1349,6 +1354,7 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
+#ifdef CONFIG_PM
 static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
-- 
2.42.0.869.gea05f2083d-goog


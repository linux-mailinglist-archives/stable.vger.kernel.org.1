Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698F07F400B
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 09:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKVIYk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 03:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjKVIYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 03:24:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90185A4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 00:24:35 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b58d96a3bbso3773356b6e.1
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700641474; x=1701246274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92ZgxHLdCIbcicSbtVImEwWXjimAebvhsyMcb1QuDq8=;
        b=AJwERodlSSYZXNNh9q5GBi8B0MIQceAL0wC83jBszEexcQD1Z2jRe98QvCNkebUrRT
         q/hGh7JuSZ+IMqpsGqOUe8domKhpn76wKT0QeS29uo2pTEm8xoaEf6httLUR9Wxr0wHX
         7IU06OYTHQxW52py3Qg/7ZBacl6d9HXijhW9A8B7gPmiwxhDN56BJXntx2hv24sRCdXW
         I05BRNCZ1w8tvDnEhUP1JdhH5v7a/vz3S8BCoNfLywHZUof/7GjYP4S932+0R0xHCcXL
         g0zepORzJ6lJh/UVREqZ3dDwUo0CqbAzYSwvTibGeByBwVIaOVXdmKJvkybTeYWSBmeq
         YvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641474; x=1701246274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92ZgxHLdCIbcicSbtVImEwWXjimAebvhsyMcb1QuDq8=;
        b=ea3GK+zWd5ILP7+ma5sWCPJfLUtFszEueoyqH3j4LnGz+d1rXum5XxiDsSfld4+0ak
         y275P26KP+7DcAPwAti5aL1mEbsGkdBRBq31fuRXBq5GqxcYubRvquiE6uLWNe0lVES0
         AXTK8ZyFECSMRZv4/J9nysft1KKYI1IZsqA9WgTfn7LCZIchFCNzGofkeXUHB2GEhqld
         EGV2vGc9KfYrPQLk5YO0T8Pb96fJy7YCXdQX0dVoKU0I4hzEyk88p/tY7vh6dZ3Bxbv1
         nQBWAimM4cKARfneegKj+S3HPBS7AQ+QAinAfz3DVGGvqSdOlJwKpypdfFQVopwJe6Oj
         mnRQ==
X-Gm-Message-State: AOJu0YzbfzIIGohuJMTAjI9T7KNqC8/MVz2a+G+inS7eNpsJNEbm6Imz
        xyclrLbqzTkHnuLXXvmQyrT+yf2sN/JvBg==
X-Google-Smtp-Source: AGHT+IFPRApNfd1ar24MTvJ8+/GuZpYOBngdqfGT7WdE+oFgI7xX+xcStuei2T8PaeUbmmkf63TNNQ==
X-Received: by 2002:a05:6808:152c:b0:3b8:3dc5:6b91 with SMTP id u44-20020a056808152c00b003b83dc56b91mr1428935oiw.58.1700641474657;
        Wed, 22 Nov 2023 00:24:34 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e35d-f8a8-feb6-dcbb-a8f8-aefb.emome-ip6.hinet.net. [2001:b400:e35d:f8a8:feb6:dcbb:a8f8:aefb])
        by smtp.gmail.com with ESMTPSA id gu4-20020a056a004e4400b006934a1c69f8sm9259970pfb.24.2023.11.22.00.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:24:34 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     stable@vger.kernel.org
Cc:     Victor Shih <victor.shih@genesyslogic.com.tw>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kai-Heng Feng <kai.heng.geng@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1.y] mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
Date:   Wed, 22 Nov 2023 16:23:51 +0800
Message-Id: <20231122082351.5574-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023112041-creasing-democrat-d805@gregkh>
References: <2023112041-creasing-democrat-d805@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Due to a flaw in the hardware design, the GL9755 replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9755
PCI config. Therefore, the replay timer timeout must be masked.

Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2")
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231107095741.8832-3-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 85dd3af64965c1c0eb7373b340a1b1f7773586b0)
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index c580ba089a26..8de20062d7ab 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -148,6 +148,9 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
+#define PCI_GLI_9755_CORRERR_MASK				0x214
+#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -689,6 +692,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	value &= ~PCI_GLI_9755_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
+	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+
 	gl9755_wt_off(pdev);
 }
 
-- 
2.25.1


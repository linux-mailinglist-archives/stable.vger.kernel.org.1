Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A37D6C8E
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjJYNAq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbjJYNAo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 09:00:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51B390
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 06:00:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5652532b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238840; x=1698843640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBEwFvY7A0Gjt/uGwV7Ad9RZEpWO878DTXchrP8q7sQ=;
        b=EEhz0UMDkhZ2eOmZeQjckv8P5v377syHwE/1UgnQjaLQoEtkhbafzWUYT5wiYeVlD8
         eHbD3yFHe7Zao93woWsrQ7LycLi+Koq6DHIHRSoUenSWy83uS4eykUphw0A+vxKkafgm
         GDUL3A3DQq/vvtN/T/Kido7s8G88GMhKueCCvlAAWiZFTnyaWdYAZJ2tjlgl/hBLMAmc
         PioDvAzsxScPRLJjbwYx2NqgJS3uqYxJmVFTfUQiuQRg4TqEol6KUvy5cCxhgqUIY916
         spFzLiX+lVoMBLHAdetuSeyE+GT0XonoXybsvao+cWQUroA7hxj477VQfG8dAUNJ939h
         xTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238840; x=1698843640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBEwFvY7A0Gjt/uGwV7Ad9RZEpWO878DTXchrP8q7sQ=;
        b=nEucNLrdYExT23dh2UC5ze3J8kPdicnqccm/IY1OlPOP+ULjh4XIyqOQPBiDr2S0AU
         CCujdenUYyuAS578rJKzN2G66rhD8vtDhlagE5hIlCWIM1scp0GjLDOCKGjemR+NRCuc
         RV/jkeVkXB6cW0V/Br37tP5eOAgkv0HnySMXn9cZHfbsME10PA6FY/XEw43iUYyxLrnI
         nzh3A+8plKm+trQPP43wRjZjarUTMc+tEKBDSM/xlsE/mjq2bA2AaHUP5x1HSV9FxD1/
         O5eiG8tUW8weOpJAj70tQpdb0iiq1gvV5KFZYlFtQRjYEFIE71FLKsuaL5N9dDCiR481
         xVMw==
X-Gm-Message-State: AOJu0YziGjCP3RmMlKqizMc3QF/fbxKpfQHpvbayHEBDz4nlzc3BNSXd
        pPos2tzsiPV5Lk6ZAzZNeh4e
X-Google-Smtp-Source: AGHT+IEVkUngxZRdSdjSL45GkWy53SYUx/kkkQQJqxN8PbAX2hJu8E/SqYXD38Jqrf69Wz2Bmuv59Q==
X-Received: by 2002:a05:6a21:778d:b0:16b:8498:d9bc with SMTP id bd13-20020a056a21778d00b0016b8498d9bcmr5327839pzc.62.1698238839655;
        Wed, 25 Oct 2023 06:00:39 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.120])
        by smtp.gmail.com with ESMTPSA id n11-20020aa7984b000000b00690d4464b95sm9616304pfq.16.2023.10.25.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:00:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
        fancer.lancer@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] PCI: qcom-ep: Implement write_dbi2() callback for writing DBI2 registers properly
Date:   Wed, 25 Oct 2023 18:30:29 +0530
Message-Id: <20231025130029.74693-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>
References: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DWC core driver exposes the write_dbi2() callback for writing to the DBI2
registers in a vendor specific way. On the Qcom EP plaforms, DBI_CS2 bit in
the ELBI region needs to be asserted before writing to any DBI2 registers
and deasserted once done. So let's implement the callback for the Qcom PCIe
EP driver so that the DBI2 writes are handled properly in the hardware.

Without this callback, DBI2 register writes like BAR size won't go through
and as a result, the default BAR size is set for all BARs.

Cc: stable@vger.kernel.org # 5.16+
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 32c8d9e37876..7da0599f70e7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -124,6 +124,7 @@
 
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
+#define ELBI_CS2_ENABLE				0xa4
 
 /* DBI registers */
 #define DBI_CON_STATUS				0x44
@@ -262,6 +263,21 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				 u32 reg, size_t size, u32 val)
+{
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	int ret;
+
+	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);
+
+	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "Failed to write DBI2 register (0x%x): %d\n", reg, ret);
+
+	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
+}
+
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
@@ -500,6 +516,7 @@ static const struct dw_pcie_ops pci_ops = {
 	.link_up = qcom_pcie_dw_link_up,
 	.start_link = qcom_pcie_dw_start_link,
 	.stop_link = qcom_pcie_dw_stop_link,
+	.write_dbi2 = qcom_pcie_write_dbi2,
 };
 
 static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
-- 
2.25.1


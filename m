Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B16FA3BC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEHJv1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjEHJvO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8291A10E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5DC621C0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF84C433EF;
        Mon,  8 May 2023 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539468;
        bh=AyIqHl5HGVNoN7dDCqy2G3Ay6Zr6W1k7BE0Wa+u0pHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APzEzD5eEBI7awfVqN1Wr3J/4EC/PPgakdclig5Gp8AVRbNhIXipffAHVAy8Bq9Vr
         q8C1/YDl5KrKbaea2eiTW1gX83n8V+3PhBSJCohfwR66rYrsbTmJFcUQkyvFpYtN9W
         Z23BB9VJ/75WDTjrSSNXz5XQyu+EkItJf0g1jU6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 6.1 027/611] PCI: qcom: Fix the incorrect register usage in v2.7.0 config
Date:   Mon,  8 May 2023 11:37:49 +0200
Message-Id: <20230508094422.619264869@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit 2542e16c392508800f1d9037feee881a9c444951 upstream.

Qcom PCIe IP version v2.7.0 and its derivatives don't contain the
PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT register. Instead, they have the new
PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2 register. So fix the incorrect
register usage which is modifying a different register.

Also in this IP version, this register change doesn't depend on MSI
being enabled. So remove that check also.

Link: https://lore.kernel.org/r/20230316081117.14288-2-manivannan.sadhasivam@linaro.org
Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: <stable@vger.kernel.org> # 5.6+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1276,11 +1276,9 @@ static int qcom_pcie_init_2_7_0(struct q
 	val &= ~REQ_NOT_ENTR_L1;
 	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-	}
+	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val |= BIT(31);
+	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 err_disable_clocks:



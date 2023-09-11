Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273BC79BB6A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbjIKWkG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbjIKOp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD512A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B024FC433C8;
        Mon, 11 Sep 2023 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443551;
        bh=1tv5lHnphvqCEYI4ai3v7Jx0SuaNthjjvbemHWnI/U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CH+ndZv6y5bI5JTSRVLd4IFEQv1AcPQy+fkgRkvKKqw6OkYycMG0JUC1H8bTQTDy/
         lEx27M1VDb+62g/35N5FkWYLahV5e3AGjiCfA9KzcAwReZnsAgFGFEJxnsI6+dxK16
         H5wkdZcA9FA3i+S/JHhksJ2ihhbRA9jpA6PWXS/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 417/737] PCI: qcom-ep: Switch MHI bus master clock off during L1SS
Date:   Mon, 11 Sep 2023 15:44:36 +0200
Message-ID: <20230911134702.259587267@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit b9cbc06049cb6b7a322d708c2098195fb9fdcc4c ]

Currently, as part of the qcom_pcie_perst_deassert() function, instead
of writing the updated value to clear PARF_MSTR_AXI_CLK_EN, the variable
"val" is re-read.

This must be fixed to ensure that the master clock supplied to the MHI
bus is correctly gated during L1.1/L1.2 to save power.

Thus, replace the line that re-reads "val" with a line that writes the
updated value to the register to clear PARF_MSTR_AXI_CLK_EN.

[kwilczynski: commit log]
Fixes: c457ac029e44 ("PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS")
Link: https://lore.kernel.org/linux-pci/20230627141036.11600-1-manivannan.sadhasivam@linaro.org
Reported-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea261..043b356d7d72d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -415,7 +415,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	/* Gate Master AXI clock to MHI bus during L1SS */
 	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
 	val &= ~PARF_MSTR_AXI_CLK_EN;
-	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
+	writel_relaxed(val, pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
 
-- 
2.40.1




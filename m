Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0C6FACF7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjEHL36 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjEHL3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D1831EDE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C6062E5A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03A9C433D2;
        Mon,  8 May 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545358;
        bh=PTKNeMfGnooxHlmJtU5iVCPw4+NIcAyiMp49q2fV4tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NGgb08PEyTvIP5XauticyAfpaehafb0LsIaDYW+hzZMYl5t8I10EpjORsoZPH1Fd
         JCIfQ4zwFyqv6icvGY+kpmLMepM45AfOfuP7Z0hAVd9abYUcA9tNVK5c0J2sFBldPy
         Vp8+Sd60e7+2TOmvXZ6I+LkUMiv+MEmK2ydHwIqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.15 014/371] PCI: qcom: Fix the incorrect register usage in v2.7.0 config
Date:   Mon,  8 May 2023 11:43:35 +0200
Message-Id: <20230508094812.631023934@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -1228,11 +1228,9 @@ static int qcom_pcie_init_2_7_0(struct q
 	val |= BIT(4);
 	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
 
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



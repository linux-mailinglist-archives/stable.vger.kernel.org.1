Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECD7BDE53
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376714AbjJINSU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377022AbjJINSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:18:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62959B4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:18:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C72CC433CC;
        Mon,  9 Oct 2023 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857497;
        bh=ZDkULb42HxhX/ExruO2lSRDwCb08l/7iqNrvAW7xiM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT5Zr3eKV1n7Sz0cxI4GOE9MSCKFRDi71s2eMKf8f2xfnRo2NqCfdKUXeGOKpzrQI
         bjxs7qDSEyJtm00Z70VkDhHthbXCQtey7D58YVVfiaWad0s++6dTs1a5+pLKXRxZSw
         Tr/hwlySvCVIlcj2bUwCRJWaV5pWdURJabr6q+fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robimarko@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 6.1 064/162] PCI: qcom: Fix IPQ8074 enumeration
Date:   Mon,  9 Oct 2023 15:00:45 +0200
Message-ID: <20231009130124.694765431@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

commit 6a878a54d0053ef21f3b829dc267487c2302b012 upstream.

PARF_SLV_ADDR_SPACE_SIZE_2_3_3 is used by qcom_pcie_post_init_2_3_3().
This PCIe slave address space size register offset is 0x358 but was
incorrectly changed to 0x16c by 39171b33f652 ("PCI: qcom: Remove PCIE20_
prefix from register definitions").

This prevented access to slave address space registers like iATU, etc.,
so the IPQ8074 PCIe controller was not enumerated.

Revert back to the correct 0x358 offset and remove the unused
PARF_SLV_ADDR_SPACE_SIZE_2_3_3.

Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
Link: https://lore.kernel.org/r/20230919102948.1844909-1-quic_srichara@quicinc.com
Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: stable@vger.kernel.org	# v6.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -40,7 +40,6 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -1148,8 +1147,7 @@ static int qcom_pcie_post_init_2_3_3(str
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);



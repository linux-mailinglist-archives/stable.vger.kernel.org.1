Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437ED761576
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjGYL3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjGYL3P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCCF3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:29:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EADB615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8250DC433C7;
        Tue, 25 Jul 2023 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284553;
        bh=a3hcMewglZdhXH8s3nHuRbB+e5hTddBl0XrKH1COQGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCDVuj680uhTS0IYifgH/mtorm86ma8L2Xx38fNKx/pnG0vne2U1WgN0osEgrbhsm
         hkysr907mvP1VvGBiZrQZFGRVKovp+ueQ35RfyRVGwhZ5Qsh7qv4Ju+oBBMMNrbpcY
         gJkgVK9QrfrDO1xEYLo8yeao4gi64gTVJAdazqqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.10 397/509] PCI: qcom: Disable write access to read only registers for IP v2.3.3
Date:   Tue, 25 Jul 2023 12:45:36 +0200
Message-ID: <20230725104611.936185910@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit a33d700e8eea76c62120cb3dbf5e01328f18319a upstream.

In the post init sequence of v2.9.0, write access to read only registers
are not disabled after updating the registers. Fix it by disabling the
access after register update.

Link: https://lore.kernel.org/r/20230619150408.8468-2-manivannan.sadhasivam@linaro.org
Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -771,6 +771,8 @@ static int qcom_pcie_get_resources_2_4_0
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0765C76172F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGYLps (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGYLpr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E2E3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4475E6169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523EDC433C8;
        Tue, 25 Jul 2023 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285545;
        bh=wAQTzoZ+ovgSO0+VsIDgM9apYuyYS96ZK7wXynhTEjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjg6zbj1NxgrIs27XdVXGC+QasFIuVhg1Nr2ng3x23tTG4IdVJ5/uWJ7246aZiwdy
         /56y+kaDOtTOF5XwWUe6BFHvkoej7jJjB94z15VgP/CypGRnkAQpcK6nS+vZHsB97W
         N7JNoX2MBgF3ap5X8p1TYoII/fpG49qwgT6sVr9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.4 243/313] PCI: qcom: Disable write access to read only registers for IP v2.3.3
Date:   Tue, 25 Jul 2023 12:46:36 +0200
Message-ID: <20230725104531.573381204@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
@@ -807,6 +807,8 @@ static int qcom_pcie_get_resources_2_4_0
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 



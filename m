Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6466FAA8C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEHLDx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEHLDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970A4C13
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35B362A48
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D80C433EF;
        Mon,  8 May 2023 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543744;
        bh=RYwn2FDu/hPflrlpPWCTINds9G4Ji7Sg9t2EgmZI/Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1W31xy18KmEvYZwxyipZf5ZvvA0jIJcOcDg1kQkp+W+Qjo6wSa4EsT4VeSkcPnBQ
         aY8nhLhZi+pqxXN/xR58nlfod1PsYBRXV4ZeuX7JY9/ao0iXK7C50mRKwvLt24qQG4
         WtIFhJYgA2l4hAFHiejNWhgF5JGa80yQUcer7smM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 188/694] arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:40:23 +0200
Message-Id: <20230508094438.527655016@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit e49eafefe5ab325e38dd074f2005076ffc271e54 ]

For 64KiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x10000. Hence, fix the bogus PCI addresses
(0x10200000, 0x20200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses and align
them in a single line.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-6-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 62d05d740646b..e8dad3ff4fcc7 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -780,10 +780,8 @@
 			phys = <&pcie_phy1>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x10000>,   /* downstream I/O */
-				 <0x82000000 0 0x10220000 0x10220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -844,10 +842,8 @@
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x20200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x20220000 0x20220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.39.2




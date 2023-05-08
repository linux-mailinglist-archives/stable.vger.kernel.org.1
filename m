Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD26FAA8F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjEHLD5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjEHLDN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF82BCF4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A208962A55
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95001C433D2;
        Mon,  8 May 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543750;
        bh=3d7aUN/wROWjWjdVYavZXATxOGPvsqX4g0TDZ7kkZxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/NoNvFIOawel0xMYKZ2ls57kwmC/YyYJ+TAK6sRSfHy8lpximJyxehh7ZBeMHIaC
         J+WaQRj6KmM4WUTPPx2S2aeKA1SKN47pb4wwZfwM0dsSKmEFTe8eP+R/Uxz9IWwO/m
         Hx4JVX1z4oFrqfXoZsJpp7pjI1epQ3jSmE1Zo/KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 190/694] arm64: dts: qcom: msm8996: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:40:25 +0200
Message-Id: <20230508094438.590851182@linuxfoundation.org>
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

[ Upstream commit cf0ac10feb17661987d0018eb9475dc03e2a2253 ]

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x0c200000, 0x0d200000, 0x0e200000) specified in the ranges property for
I/O region.

While at it, let's also align the entries.

Fixes: ed965ef89227 ("arm64: dts: qcom: msm8996: add support to pcie")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-8-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 905678e7175d8..66af9526c98ba 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1851,8 +1851,8 @@
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1905,8 +1905,8 @@
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1956,8 +1956,8 @@
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
 
 				device_type = "pci";
 
-- 
2.39.2




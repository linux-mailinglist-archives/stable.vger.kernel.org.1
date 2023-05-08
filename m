Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634A36FA74D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjEHK3N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjEHK3A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66410D7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BD56266D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DB3C433EF;
        Mon,  8 May 2023 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541738;
        bh=bWG60vcmr5IYQG7Ez/8WmtR1Wg8VcUmec2xnkiqGSeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/i7f4JJ2unkbsCVti2+7CkJYrk5n+EsRj8FtUa6QsPhDdrwD7MbBkFcvQtSdMWV3
         wJs05TuXtU4vZd1az3KFutGQ8j6nSZlmJ/jdAVb40TnpxcUdGynNZCQaP7mJ4azyOM
         +q9JNWYbXfyjdVAqrRzdf+xZOSWrI0FSt1zZvNZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 167/663] arm64: dts: qcom: sm8250: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:39:53 +0200
Message-Id: <20230508094433.902451305@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit e115a4495db687898b8d91d4f16c2cf55bbf167c ]

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x60200000, 0x40200000, 0x64200000) specified in the ranges property for
I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-9-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 927032863e2f1..d3f2f617047f1 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1807,8 +1807,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
@@ -1916,7 +1916,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
@@ -2024,7 +2024,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x64200000 0x0 0x64200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x64200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
 
 			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.2




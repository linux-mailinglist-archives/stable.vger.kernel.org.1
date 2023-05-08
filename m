Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0C6FA456
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjEHJ6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEHJ6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6B10A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C05611E3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F282C433D2;
        Mon,  8 May 2023 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539884;
        bh=xasVUBvf2Djlzzzusox5qgZpMY/YQZkp4P1+cVRuqNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIP766pHnlnk4oWZL3vTqNXJQCdgZNB8JfRwitLmW8eBtrfn80jShcKv56501k3os
         6mOdBq59ehBTyf6JSrXr34heuhLFsO+SWQjphMqYfQTw4A/tbUf38u/zNbqf3TmM2m
         C8RL6tNCX02HG0EGwQbam438HNiAe6j0RS33AD+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 167/611] ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:40:09 +0200
Message-Id: <20230508094427.766016963@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit 2540279e9a9e74fc880d1e4c83754ecfcbe290a0 ]

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI address
(0x40200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 187519403273 ("ARM: dts: ipq4019: Add a few peripheral nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-16-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b23591110bd2b..02e13d8c222a0 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -426,8 +426,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
-				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
+			ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.39.2




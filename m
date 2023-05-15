Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5A70393C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbjEORk3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbjEORkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F117963
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 401B462E02
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D6DC433D2;
        Mon, 15 May 2023 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172244;
        bh=X5RkzVY3AYGTQStlM0law5PGrTnwmPXOjqQcyo2A30k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbAVHeKKpGxvIGvMezb0BrAKlSe3cljAMrnaoOovc205tUlMkhoIAwcm468q429zn
         Y4hckA3LqUPaZDFlblAXPVtuNhzQyq8DIB2XXXjiU56um6f9/9PybvDZY2MZaGJkNp
         ad+cYFxRAw5B9TbUc4Him5UkIT2NqsI0QEYrVcsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 090/381] ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
Date:   Mon, 15 May 2023 18:25:41 +0200
Message-Id: <20230515161740.868555341@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

[ Upstream commit 0b16b34e491629016109e56747ad64588074194b ]

For 64KiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x10000. Hence, fix the bogus PCI addresses
(0x0fe00000, 0x31e00000, 0x35e00000) specified in the ranges property for
I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 93241840b664 ("ARM: dts: qcom: Add pcie nodes for ipq8064")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-17-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index f7ed87a35e34d..dca0ed6c8c8de 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -465,8 +465,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -516,8 +516,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x31e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x2e000000 0x2e000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -567,8 +567,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x35e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x32000000 0x32000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.39.2




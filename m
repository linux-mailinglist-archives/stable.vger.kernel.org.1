Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6966FA721
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjEHK2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjEHK1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB6D2EC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4536562630
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B85C433EF;
        Mon,  8 May 2023 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541626;
        bh=3TK63VG1uK1PZQkBjgQN8PfNH/JHskCpIbsgbRoGMYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKvgdwNyQfLL97TCA7AOekfXo11m0VP+8cTzmZx9dJ3dqUwZ2WLidVD6UR19Qb92Q
         UIThTBa8DfDzWXzbZN4AXchF3NlsAvWjslIrBdmv9WCMIrEweKJJdEAhWym8mrS8BV
         B2cFgna9AogdRR5mDHITbDOYVGoFUXNH8SuoJ2jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 168/663] arm64: dts: qcom: sc8280xp: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:39:54 +0200
Message-Id: <20230508094433.936709464@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit 89fe81c01715f81c3a7d371e9e5f7d7ae5bc557c ]

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x30200000, 0x32200000, 0x34200000, 0x38200000, 0x3c200000) specified in
the ranges property for I/O region.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-11-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8363e82369854..966dca906bf07 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -902,7 +902,7 @@
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x30200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1001,7 +1001,7 @@
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x32200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1098,7 +1098,7 @@
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x34200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1198,7 +1198,7 @@
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x38200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1295,7 +1295,7 @@
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
-- 
2.39.2




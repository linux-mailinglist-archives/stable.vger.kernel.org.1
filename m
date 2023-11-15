Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF47ECC46
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjKOT1v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjKOT1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF31B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6461AC433C8;
        Wed, 15 Nov 2023 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076466;
        bh=Jj1dHfZSfNkzcL1HC+oBB/e2erZHnqIyEPHRCjUsNYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNXOg4/oCCIe0tZ3NS3vXm00Km06EOhENtkxJ4AAtcVFiv0Cz4vAtNv6/7Bo6pmwL
         PwVMSGBITyVXSG2sr6JImr7SakJprY89PEE6Io1tdD+OhHujRIOdbuAXYaLvq08T6f
         YgxBpg9T2e2IgGIKAismhli/iGtUkj2obaiTwLAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 274/550] arm64: dts: qcom: msm8976: Fix ipc bit shifts
Date:   Wed, 15 Nov 2023 14:14:18 -0500
Message-ID: <20231115191619.739261956@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Skladowski <a39.skl@gmail.com>

[ Upstream commit 684277525c70f329300cc687e27248e405a4ff9e ]

Update bits to match downstream irq-bitmask values.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Link: https://lore.kernel.org/r/20230812112534.8610-8-a39.skl@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 753b9a2105edd..c97b22fb1dc21 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -303,7 +303,7 @@ adsp_smp2p_in: slave-kernel {
 	smp2p-modem {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 13>;
+		qcom,ipc = <&apcs 8 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -326,7 +326,7 @@ modem_smp2p_in: slave-kernel {
 	smp2p-wcnss {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 17>;
+		qcom,ipc = <&apcs 8 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;
@@ -428,9 +428,9 @@ smsm {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 8 12>;
+		qcom,ipc-1 = <&apcs 8 13>;
 		qcom,ipc-2 = <&apcs 8 9>;
-		qcom,ipc-3 = <&apcs 8 18>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
-- 
2.42.0




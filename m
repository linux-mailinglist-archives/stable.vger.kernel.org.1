Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE937ED57D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjKOVH2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjKOVHZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2CB1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED804C3279B;
        Wed, 15 Nov 2023 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081376;
        bh=FHpFAaZqwo88mPmCowwUhuPdeuOOM0yRAozqnR9IjrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZKhEqMtcb3+qfjs+k8SbxX1Rq7RUNsAwx3q5+xZcmJ3xVdC3zJzAjHuBAGP+WuFH
         mAcQnjrMh3AHdS1DdU993jhMAwrWoda3JrF/vZvZ7wzKjjyuYxpsegy0aZlknHm9sw
         DOFsxRm10xWIxMj72vWVKl0ApAho8yzpIifp1tr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/244] ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins
Date:   Wed, 15 Nov 2023 15:35:08 -0500
Message-ID: <20231115203555.283515840@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 0878fd86f554ab98aa493996c7e0c72dff58437f ]

Both the CN9130-CRB and CN9130-DB use the SPI1 interface but had the
pinctrl node labelled as "cp0_spi0_pins". Use the label "cp0_spi1_pins"
and update the node name to "cp0-spi-pins-1" to avoid confusion with the
pinctrl options for SPI0.

Fixes: 4c43a41e5b8c ("arm64: dts: cn913x: add device trees for topology B boards")
Fixes: 5c0ee54723f3 ("arm64: dts: add support for Marvell cn9130-crb platform")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 4 ++--
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 505ae69289f6d..ce49702dc4936 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -107,7 +107,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function = "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function = "spi1";
 		};
@@ -149,7 +149,7 @@ &cp0_sdhci0 {
 
 &cp0_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>,		/* control */
 	      <0x2000000 0x1000000>;	/* CS0 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index c00b69b88bd2f..c53253f668403 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -307,7 +307,7 @@ &cp0_sdhci0 {
 &cp0_spi1 {
 	status = "disabled";
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>;
 
 	spi-flash@0 {
@@ -371,7 +371,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function = "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function = "spi1";
 		};
-- 
2.42.0




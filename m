Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77346FA445
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjEHJ5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjEHJ5O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72B2D7E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB5D962263
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01EEC433D2;
        Mon,  8 May 2023 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539832;
        bh=CalO39fhQoU6gTzkbjmMQlUh2jijNIrK/LuKUu4t6Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDFlfzIsr3k6vzhrLFNMAduO/9tEs9BG/3cRV9lqGMnUNcZCy9ICwXFnG9cDeiQVc
         RkRyNnA0K8+fHCGE548cWpkDNH948HKOSBspd7A4XrBSDg4Ky9Gt6eIoynlZdxQR6b
         PzhtfqGu/tHav5rbEhcOB51mCNiM9XTOOfr00MGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 152/611] arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name
Date:   Mon,  8 May 2023 11:39:54 +0200
Message-Id: <20230508094427.206157468@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 5cca02449490e767289bda38db1577e2c375c084 ]

This fixes:
arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dtb: nand-controller@1800: interrupt-names:0: 'nand_ctlrdy' was expected
        From schema: Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dtb: nand-controller@1800: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
        From schema: Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/all/20230228144400.21689-1-zajec5@gmail.com/
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index dac9d3b4e91df..1d77ed2dd2226 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -532,7 +532,7 @@
 			reg = <0x1800 0x600>, <0x2000 0x10>;
 			reg-names = "nand", "nand-int-base";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "nand";
+			interrupt-names = "nand_ctlrdy";
 			status = "okay";
 
 			nandcs: nand@0 {
-- 
2.39.2




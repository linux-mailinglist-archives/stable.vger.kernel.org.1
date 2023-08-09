Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B587775D11
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjHILd1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjHILd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554851BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F2E63449
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052BAC433C7;
        Wed,  9 Aug 2023 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580805;
        bh=wj1wvRZqwv3FlKm248L3GE5DboYLg/+NDDWWN3AQAkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXho73hM7idg86jvW4JnY6qcA+9B2ozTu9nTBxkSvEkFhCrvCo05KPYLgyrDNNWPL
         88lQeltUyXZbEb0B+lwWSqaE3wsOMHwZutYnEx0/j5Q8eEasF0Nlznk3aQLMHPSzBt
         zsEWO3BK0kk5huVrNxZbYiVuokxdVSKVZ5PBmqxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 146/154] ARM: dts: imx6sll: Make ssi node name same as other platforms
Date:   Wed,  9 Aug 2023 12:42:57 +0200
Message-ID: <20230809103641.689420458@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 5da1b522cf7dc51f7fde2cca8d90406b0291c503 ]

In imx6sll.dtsi, the ssi node name is different with other
platforms (imx6qdl, imx6sl, imx6sx), but the
sound/soc/fsl/fsl-asoc-card.c machine driver needs to check
ssi node name for audmux configuration, then different ssi
node name causes issue on imx6sll platform.

So we change ssi node name to make all platforms have same
name.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: ee70b908f77a ("ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sll.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 39500b84673b9..cf81c7b949e62 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -272,7 +272,7 @@ uart2: serial@2024000 {
 					status = "disabled";
 				};
 
-				ssi1: ssi-controller@2028000 {
+				ssi1: ssi@2028000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
@@ -285,7 +285,7 @@ ssi1: ssi-controller@2028000 {
 					status = "disabled";
 				};
 
-				ssi2: ssi-controller@202c000 {
+				ssi2: ssi@202c000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
@@ -298,7 +298,7 @@ ssi2: ssi-controller@202c000 {
 					status = "disabled";
 				};
 
-				ssi3: ssi-controller@2030000 {
+				ssi3: ssi@2030000 {
 					compatible = "fsl,imx6sl-ssi", "fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.40.1




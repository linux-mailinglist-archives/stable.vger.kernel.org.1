Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D57775897
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHIKyR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHIKyC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DA3C3C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160FE6312B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25362C433C8;
        Wed,  9 Aug 2023 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578293;
        bh=CmD37yCS0W9/zt85kp8DbXO4L8Qr+ez1h2V1K9sTpeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghXryagp+yW7hcik+y9alU2fvYFsxYwH2+vYpUP9vwDdE57m4W+ZrbVWgJUNDwtjp
         Mxqhiw6hLeLzZjfV4MqmETHmvFYyRMTeiyQN/FsGZYio1PQsm21Eu2uEkng2GovL6E
         hjju9bW5PxKTtaOzm+05KofxOAHuViCu6sNBGG1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 158/165] ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node
Date:   Wed,  9 Aug 2023 12:41:29 +0200
Message-ID: <20230809103647.937448847@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit ee70b908f77a9d8f689dea986f09e6d7dc481934 ]

Property name "phy-3p0-supply" is used instead of "phy-reg_3p0-supply".

Fixes: 9f30b6b1a957 ("ARM: dts: imx: Add basic dtsi file for imx6sll")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 2873369a57c02..3659fd5ecfa62 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -552,7 +552,7 @@ usbphy2: usb-phy@20ca000 {
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
-				phy-reg_3p0-supply = <&reg_3p0>;
+				phy-3p0-supply = <&reg_3p0>;
 				fsl,anatop = <&anatop>;
 			};
 
-- 
2.40.1




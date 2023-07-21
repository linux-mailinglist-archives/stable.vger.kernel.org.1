Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017F875D21E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjGUS4O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjGUS4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678730CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C99861D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80227C433CA;
        Fri, 21 Jul 2023 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965771;
        bh=hcAYXXZQPoJgL3+0JZFYWEA7V9hPNsNmigqwxKUnsIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xqa1LY5jJAup7sxuz6T1pYnu3/GPAH2DSvtooAigNc6N6veuxUdXrT458J7br2FqF
         E3owFBpVShUIQMwnyY0Bw4jLjDY86zT0Eel44lfhZVEa/8j7wcAFiXn5AekTJkzhoS
         KY5ypDggzqbPE7ksjTjoeSgnlv7xjr0jSpUXJkno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/532] ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
Date:   Fri, 21 Jul 2023 18:00:13 +0200
Message-ID: <20230721160620.495219791@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit d3c8e2c5757153bbfad70019ec1decbca86f3def ]

There is no such property in the SPI controller binding documentation.
Also Linux driver doesn't look for it.

This fixes:
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
        From schema: Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230503122830.3200-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 30217948ef827..b4b73ab996264 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -542,7 +542,6 @@ spi@18029200 {
 				  "spi_lr_session_done",
 				  "spi_lr_overread";
 		clocks = <&iprocmed>;
-		clock-names = "iprocmed";
 		num-cs = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.39.2




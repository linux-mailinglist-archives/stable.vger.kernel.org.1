Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC70755243
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjGPUFr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGPUFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69473123
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DCC60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188DEC433C7;
        Sun, 16 Jul 2023 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537944;
        bh=6D6at4DN8sDR2JKmwQRiyoIa64rQsiTGgbcQvCDuOV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G44sDw0NKSZzhMUdQ7bBKzNGrmR9jQTraoJ+FTbUuuO9R9fOvTu+g78iyiLp+xlQm
         2VHTQZQJz9+OKXFCjCSRBgH8/1Q5CeZPYiuEYubdjk5E1BJZUFCRrSZafqPUYbboBJ
         RyZ48CrZed3IGI3XiTpm2PhI6fv2r+eJeAfWVuSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans-Frieder Vogt <hfdevel@gmx.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 247/800] ARM: dts: meson8b: correct uart_B and uart_C clock references
Date:   Sun, 16 Jul 2023 21:41:40 +0200
Message-ID: <20230716194954.838026998@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: hfdevel@gmx.net <hfdevel@gmx.net>

[ Upstream commit d542ce8d4769cdef6a7bc3437e59cfed9c68f0e4 ]

With the current device tree for meson8b, uarts B (e.g. available on pins
8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they
are relying on incorrect clocks. Change the references of pclk to the
correct CLKID, to allow use of the two uarts.

Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree schema validation")
Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 5979209fe91ef..5198f5177c2c1 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -740,13 +740,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8b-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8b-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
-- 
2.39.2




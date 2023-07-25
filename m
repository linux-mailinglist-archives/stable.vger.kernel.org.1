Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D472761434
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjGYLRN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjGYLQx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352A1FCA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B8D6168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64752C433C9;
        Tue, 25 Jul 2023 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283810;
        bh=kVJ1YJ8DwJweKEYSAFf5YV4fMTDB5iR5myI8JTn4aA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hl7OSgWPv+K3zSoxvgwOITFyCROhJKI3yYcCApg8mz+f0C9z1FYzfKTdKccd/hEpx
         r6O3UFJMVaPfxUiOQEn0stuthHBP8PeBNUwrsCV04TadYl77+MgbQNLuSAs9kMXSYI
         8J5fuqWzfdo47PVMFQV3JNNBiWkxG+exejwKtJYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH 5.10 131/509] ARM: dts: meson8: correct uart_B and uart_C clock references
Date:   Tue, 25 Jul 2023 12:41:10 +0200
Message-ID: <20230725104559.702815172@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 98b503c7fb13a17a47d8ebf15fa8f7c10118e75c ]

On Meson8 uart_B and uart_C do not work, because they are relying on
incorrect clocks. Change the references of pclk to the correct CLKID
(UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.

This was originally reported by Hans-Frieder Vogt for Meson8b [0], but
the same bug is also present in meson8.dtsi

[0] https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/

Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema validation")
Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/20230516203029.1031174-1-martin.blumenstingl@googlemail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 08533116a39ce..0d045add81658 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -611,13 +611,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
-- 
2.39.2




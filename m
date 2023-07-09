Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6464F74C2CB
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGILYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGILYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C8130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325A160C01
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6BFC433C8;
        Sun,  9 Jul 2023 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901886;
        bh=OEmjrOiVakU59k2XjO4Xk5TFA5tM34Om+iY7A+QtpqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMXxmNS81wf6H1EDeLJv45FFUgGbK0hWzs7S+YRcViH+UG83IWY4lwXAt5u9kKG06
         hlKODDNS2r10mbs0dMfcYJBsF6oOAsURRNmTSnRzHQAZ2tPSwwa21ubb2ffsL6jr7T
         L3J+vURQghOPHJtZ4/AZZZbSQLkU3QGM6f3n5lZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans-Frieder Vogt <hfdevel@gmx.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 179/431] ARM: dts: meson8b: correct uart_B and uart_C clock references
Date:   Sun,  9 Jul 2023 13:12:07 +0200
Message-ID: <20230709111455.378000793@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index d5a3fe21e8e7e..25f7c985f9ea1 100644
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




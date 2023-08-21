Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E032783219
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHUUI4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHUUI4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC5E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8E364A54
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B46C433C8;
        Mon, 21 Aug 2023 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648533;
        bh=7+WTvDMP3OayobXOcibiXEZpzllZvhQnqYomzB9IhkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2Z1npp4CHYtbdD7mibyx7H+dQfzmg71e3JFPIsvvCwkH4nZnUFeRwZI2uoDwR1PC
         l0JR0/AbrYVnmRCmFNdaNQPs3EQso+OlkhmEEU7GmqPciePCcIYcaha+F9t7vHcxk4
         05aeJAHHkSd4Yw9veYA8HPepI3yMB2Gfeoj/OhE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yogesh Hegde <yogi.kernel@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.4 209/234] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
Date:   Mon, 21 Aug 2023 21:42:52 +0200
Message-ID: <20230821194138.095360563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yogesh Hegde <yogi.kernel@gmail.com>

commit ebceec271e552a2b05e47d8ef0597052b1a39449 upstream.

This patch fixes an issue affecting the Wifi/Bluetooth connectivity on
ROCK Pi 4 boards. Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
on ROCK Pi 4 boards") introduced a problem with the clock configuration.
Specifically, the clock-names property of the sdio-pwrseq node was not
updated to 'lpo', causing the driver to wait indefinitely for the wrong clock
signal 'ext_clock' instead of the expected one 'lpo'. This prevented the proper
initialization of Wifi/Bluetooth chip on ROCK Pi 4 boards.

To address this, this patch updates the clock-names property of the
sdio-pwrseq node to "lpo" to align with the changes made to the bluetooth node.

This patch has been tested on ROCK Pi 4B.

Fixes: f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth on ROCK Pi 4 boards")
Cc: stable@vger.kernel.org
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
Link: https://lore.kernel.org/r/ZLbATQRjOl09aLAp@zephyrusG14
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -45,7 +45,7 @@
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
+		clock-names = "lpo";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable_h>;
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;



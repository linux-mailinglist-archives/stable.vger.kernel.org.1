Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02A7DD4F8
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376307AbjJaRqK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJaRqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32469C1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CF6C433C8;
        Tue, 31 Oct 2023 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774365;
        bh=5PycGoNx/KG4GheLANlSgJaeUphrJcJ0Bf5J9j4v2kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpYk9/Unmq9Iwlb6oqDL514eDrCxA/Baqzujnxc4IApAJoyC1TUsT+GQS5pGwtsUm
         mz4dnQWIjpjcdDK5A5erhNf9Fp+hw5NP+CukFYOMtKLlQe4lQQFg5c9hc2ff7AWV/0
         J3H+SMpv8iJAUrzNjyA8dXHE18adRYo63eAlCb0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christopher Obbard <chris.obbard@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.5 021/112] arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards
Date:   Tue, 31 Oct 2023 18:00:22 +0100
Message-ID: <20231031165901.974913796@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher Obbard <chris.obbard@collabora.com>

commit 8cd79b729e746cb167f1563d015a93fc0a079899 upstream.

Commit 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on
rk3399") modified i2s0 to switch the corresponding pins off when idle.
For the ROCK Pi 4 boards, this means that i2s0 has the following pinctrl
setting:

    pinctrl-names = "bclk_on", "bclk_off";
    pinctrl-0 = <&i2s0_2ch_bus>;
    pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;

Due to this change, i2s0 fails to probe on my Radxa ROCK 4SE and ROCK Pi
4B boards:

    rockchip-pinctrl pinctrl: pin gpio3-29 already requested by leds; cannot claim for ff880000.i2s
    rockchip-pinctrl pinctrl: pin-125 (ff880000.i2s) status -22
    rockchip-pinctrl pinctrl: could not request pin 125 (gpio3-29) from group i2s0-8ch-bus-bclk-off  on device rockchip-pinctrl
    rockchip-i2s ff880000.i2s: Error applying setting, reverse things back
    rockchip-i2s ff880000.i2s: bclk disable failed -22

A pin requested for i2s0_8ch_bus_bclk_off has already been requested by
user_led2, so whichever driver probes first will have the pin allocated.

The hardware uses 2-channel i2s so fix this error by setting pinctl-1 to
i2s0_2ch_bus_bclk_off which doesn't contain the pin allocated to user_led2.

I checked the schematics for all Radxa boards based on ROCK Pi 4 and this
change is compatible with all boards.

Fixes: 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Link: https://lore.kernel.org/r/20231013114737.494410-3-chris.obbard@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -493,6 +493,7 @@
 
 &i2s0 {
 	pinctrl-0 = <&i2s0_2ch_bus>;
+	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
 	rockchip,capture-channels = <2>;
 	rockchip,playback-channels = <2>;
 	status = "okay";



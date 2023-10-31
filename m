Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEB7DD3C8
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjJaRDD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJaRDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:03:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C7182
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65017C433C8;
        Tue, 31 Oct 2023 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771779;
        bh=JxzAxP7WBd+E4zgGOi5ii3i3Xd9suGaxc4RF5rbJvfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxXSTg2eH013HyYRm+3lF/4FdRSbp5ztrfykJe3POrJUTX3sqZFyTO2gy3h0XRbtW
         dGl6DSC8nAs3fH/IKBO44Wx0sFffl09csT1o76iEovc8ys6xVGSQ0vwvu4RcJiINos
         f3ZPlpRaDR74mzCgf+gf0mpWsjuMPdZ1SBd9wr74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christopher Obbard <chris.obbard@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.1 18/86] arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
Date:   Tue, 31 Oct 2023 18:00:43 +0100
Message-ID: <20231031165919.176856657@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher Obbard <chris.obbard@collabora.com>

commit 3975e72b164dc8347a28dd0d5f11b346af534635 upstream.

Commit 0efaf8078393 ("arm64: dts: rockchip: add i2s0-2ch-bus pins on
rk3399") introduced a pinctl for i2s0 in two-channel mode. Commit
91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
modified i2s0 to switch the corresponding pins off when idle.

Although an idle pinctrl node was added for i2s0 in 8-channel mode, a
similar idle pinctrl node for i2s0 in 2-channel mode was not added. Add
it.

Fixes: 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Link: https://lore.kernel.org/r/20231013114737.494410-2-chris.obbard@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2396,6 +2396,16 @@
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
 
+			i2s0_2ch_bus_bclk_off: i2s0-2ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
+
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
 					<3 RK_PD0 1 &pcfg_pull_none>,



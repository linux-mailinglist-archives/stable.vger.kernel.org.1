Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03667755294
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjGPUJc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGPUJb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164C9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E20CF60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F074EC433C8;
        Sun, 16 Jul 2023 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538169;
        bh=rJ54VsJpc/Chgin/VuG+dC3jgJlOjK1fMvUINC7qfbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4hCLeaQjj5aE8VJ+VDz+KT0q0Ts2sr2SYi+L/cLZ4z7p+QSIKHNIe0314xMozj34
         enisoFRF6eVJXC1GVN7bXTlBRkFdF2XvICigHe57PDpzlHbylKG7npPCjvdIEdSjtH
         /5QLTfMWts91J6hnNbBaXDbiX0x9Xq7RmfAeAPXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Morgan <macromorgan@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 356/800] arm64: dts: rockchip: Fix compatible for Bluetooth on rk3566-anbernic
Date:   Sun, 16 Jul 2023 21:43:29 +0200
Message-ID: <20230716194957.347470052@linuxfoundation.org>
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

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit a325956fa7048906e26a4535ac2e87e111788fe8 ]

The realtek Bluetooth module uses the same driver as the
realtek,rtl8822cs-bt and the realtek,rtl8723bs-bt, however by selecting
the 8723bs advanced power saving features are disabled that appear
to interfere with normal operation of the bluetooth module. This
change switches the compatible string to disable power saving. Without
this patch evtest of a paired bluetooth controller fails, with this
patch the controller operates as expected.

Fixes: b6986b7920bb ("arm64: dts: rockchip: Update compatible for bluetooth")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20230508160811.3568213-3-macroalpha82@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
index 8fadd8afb1906..ad43fa199ca55 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
@@ -716,7 +716,7 @@ &uart1 {
 	status = "okay";
 
 	bluetooth {
-		compatible = "realtek,rtl8821cs-bt", "realtek,rtl8822cs-bt";
+		compatible = "realtek,rtl8821cs-bt", "realtek,rtl8723bs-bt";
 		device-wake-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
-- 
2.39.2




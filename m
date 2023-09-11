Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C579B9A2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjIKWJA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbjIKOEs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB63CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:04:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D211C433C7;
        Mon, 11 Sep 2023 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441083;
        bh=HoCR6rTWDg4eCuSIpQainXQjJMMAdprbCvy7qCjb0sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTYOm/JOmH5k3W142E5vNC46V/yB88M2TgbOa0STjk4f6aKN05fA3WK8dhPUVu400
         LBUG+dn2QfWWXxRNEveXXYqqAbfg2kfqnfi0w23U9x/n0Vo+VTz72g/BofsrI2WPPW
         TapZlaMfV8r5KvQutoLswbF7lG9EGfxcfWk9gYcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 282/739] arm64: dts: rockchip: Enable SATA on Radxa E25
Date:   Mon, 11 Sep 2023 15:41:21 +0200
Message-ID: <20230911134658.998646536@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 2bdfe84fbd57a4ed9fd65a67210442559ce078f0 ]

The M.2 KEY B port can be used for WWAN USB2 modules or SATA drives.

Enable sata1 node to fix use of SATA drives on the M.2 slot.

Fixes: 2bf2f4d9f673 ("arm64: dts: rockchip: Add Radxa CM3I E25")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20230724145213.3833099-1-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
index f0e4884438e39..72ad74c38a2b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
@@ -99,6 +99,10 @@ vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
 	};
 };
 
+&combphy1 {
+	phy-supply = <&vcc3v3_pcie30x1>;
+};
+
 &pcie2x1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie20_reset_h>;
@@ -178,6 +182,10 @@ &pwm12 {
 	status = "okay";
 };
 
+&sata1 {
+	status = "okay";
+};
+
 &sdmmc0 {
 	bus-width = <4>;
 	cap-sd-highspeed;
-- 
2.40.1




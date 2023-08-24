Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6D787384
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjHXPDt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbjHXPDc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585CD1BCA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0D9671A3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077EDC433C8;
        Thu, 24 Aug 2023 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889405;
        bh=i/GK284GDr2wfTD3VvdtsqjZyd1h7uMlvVsmGn4n4as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIa/bfjdX88OTaPBQ7yZMdYHkd79LuEenxT4FXNYTQDDL6ALoH8AGmU+4ZtdPEDkN
         +eZpiuAJq6H78ugA+ENA0H+hKWqNAwcVNteBkETPcRKGT7fYpelBJ985JPOZaF9NWL
         hTJt/g4xuzG6oGFm8qWCMn32M1k0iYI5VdSSxlPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/135] arm64: dts: rockchip: fix supplies on rk3399-rock-pi-4
Date:   Thu, 24 Aug 2023 16:50:38 +0200
Message-ID: <20230824145031.042620920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

From: Vicente Bergas <vicencb@gmail.com>

[ Upstream commit 328c6112787bf7562dbea638840366cd197868d6 ]

Based on the board schematics at
https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi_4c_v12_sch_20200620.pdf
on page 18:
vcc_lan is not controllable by software, it is just an analog LC filter.
Because of this, it can not be turned off-in-suspend.

and on page 17:
vcc_cam and vcc_mipi are not voltage regulators, they are just switches.
So, the voltage range is not applicable.
This silences an error message about not being able to adjust the voltage.

Signed-off-by: Vicente Bergas <vicencb@gmail.com>
Link: https://lore.kernel.org/r/20201201154132.1286-2-vicencb@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 64df643391194..98f52fac13535 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -111,10 +111,6 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
 	};
 
 	vdd_log: vdd-log {
@@ -362,8 +358,6 @@
 				regulator-name = "vcc_cam";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -373,8 +367,6 @@
 				regulator-name = "vcc_mipi";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
-- 
2.40.1




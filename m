Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9787876F9
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbjHXRVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjHXRVa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F110D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64CD467100
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A049C433C7;
        Thu, 24 Aug 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897687;
        bh=JU2Vjr5COC8q5RM7ll24SUyvLt9hoTLjcmEJvV9jvKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Svx/xVxdVWwCwsNsBKwvx+vCd/YEEZlPsGN5jl5EesD2PITRGDTD+kk5O5KQNUu7/
         4kYdBxNtZwzjUAvVbPhZbnfjdkQUFk++cRsv5a0YnILsUq9HS4+yID0s6fuoQy3tye
         PciVnR7sNT2e0IVVsZ7dHXpFhF6+IFam/SjxtUBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/135] arm64: dts: rockchip: use USB host by default on rk3399-rock-pi-4
Date:   Thu, 24 Aug 2023 19:09:28 +0200
Message-ID: <20230824170621.435230353@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicente Bergas <vicencb@gmail.com>

[ Upstream commit e12f67fe83446432ef16704c22ec23bd1dbcd094 ]

Based on the board schematics at
https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi_4c_v12_sch_20200620.pdf
on page 19 there is an USB Type-A receptacle being used as an USB-OTG port.

But the Type-A connector is not valid for OTG operation, for this reason
there is a switch to select host or device role.
This is non-compliant and error prone because switching is manual.
So, use host mode as it corresponds for a Type-A receptacle.

Signed-off-by: Vicente Bergas <vicencb@gmail.com>
Link: https://lore.kernel.org/r/20201201154132.1286-4-vicencb@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 98f52fac13535..6dc6dee6c13e2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -671,7 +671,7 @@
 
 &usbdrd_dwc3_0 {
 	status = "okay";
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &usbdrd3_1 {
-- 
2.40.1




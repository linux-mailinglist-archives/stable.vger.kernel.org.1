Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3B7D3449
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjJWLiM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjJWLiL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD43F9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB2AC433C9;
        Mon, 23 Oct 2023 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061088;
        bh=Nel8p7MuBBYv3e1DwvBYosInTB2XyuGFPG7v1KMnFYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXkSct24tMpz/a/vvvxHHMLaZOmgVEVXCqhPqFHc05eHzf35s6LPkU48hvpTj2Trz
         pMC2EKAO/M1NlQ1+mAQWUg6noklcyIrRXttHKtfBnigGdKJLVphH8jCHtDJvhWWrXB
         fXrVt6dyfgk09YIgm3LECUI4fVAOfi+K6+bBA4fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 068/137] ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
Date:   Mon, 23 Oct 2023 12:57:05 +0200
Message-ID: <20231023104823.244487291@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 5ad37b5e30433afa7a5513e3eb61f69fa0976785 ]

On mapphone devices we may get lots of noise on the micro-USB port in debug
uart mode until the phy-cpcap-usb driver probes. Let's limit the noise by
using overrun-throttle-ms.

Note that there is also a related separate issue where the charger cable
connected may cause random sysrq requests until phy-cpcap-usb probes that
still remains.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 67c68c61ae029..2ac1ed8ad8197 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -640,6 +640,7 @@ &uart1 {
 &uart3 {
 	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x17c>;
+	overrun-throttle-ms = <500>;
 };
 
 &uart4 {
-- 
2.40.1




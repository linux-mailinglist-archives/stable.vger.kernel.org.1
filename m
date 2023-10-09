Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE457BDF91
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377080AbjJINbY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377077AbjJINbX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C20A3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBCCC433C9;
        Mon,  9 Oct 2023 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858280;
        bh=yJoP80vMppbAKhKIe04VSibyq+PHUW14iRY/VoUnka8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wizKG5hZds+/F2gFgknfeRcakv0H+BJcrbNU/hMcFw9x1u01TX46HwolZvlRHbkUL
         ZmwjLrBL9ZvBdWz1wtN55b2EW5g1G8HdnvkMM2DSw5FcAVlKxNtXCDR3DoQoB3bAYF
         W6g8MkXt4XGxX0wwTE+KbaTpnZSk05TvjtXVx6OU=
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
Subject: [PATCH 5.4 045/131] ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
Date:   Mon,  9 Oct 2023 15:01:25 +0200
Message-ID: <20231009130117.690945036@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ac08bda1569b06b7a62c7b4dd00d4c3b28ceaaec ]

Commit 0840242e8875 ("ARM: dts: Configure clock parent for pwm vibra")
attempted to fix the PWM settings but ended up causin an additional clock
reparenting error:

clk: failed to reparent abe-clkctrl:0060:24 to sys_clkin_ck: -22

Only timer9 is in the PER domain and can use the sys_clkin_ck clock source.
For timer8, the there is no sys_clkin_ck available as it's in the ABE
domain, instead it should use syc_clk_div_ck. However, for power
management, we want to use the always on sys_32k_ck instead.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: 0840242e8875 ("ARM: dts: Configure clock parent for pwm vibra")
Depends-on: 61978617e905 ("ARM: dts: Add minimal support for Droid Bionic xt875")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index a40fe8d49da64..f5dbc241aaf78 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -656,12 +656,12 @@
 /* Configure pwm clock source for timers 8 & 9 */
 &timer8 {
 	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 &timer9 {
 	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 /*
-- 
2.40.1




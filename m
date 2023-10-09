Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23FB7BE082
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbjJINk5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377330AbjJINk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09961B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44942C433C7;
        Mon,  9 Oct 2023 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858854;
        bh=SU9MKuIfLLFPgjzIz2tKG3QndDyA1QGua6/8yQJNouA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWFNZHeWp7rWxXkrCNSWKSZaLlH4t8Coa+4CeSznxHGRlbID8lW8LWzza0DV+RLWM
         0PLbHoIGc1VRR4gfkFg6JbXH18qQM5IIUu8HKS1mIoriCAHq70nz6mJwX4mJ911itO
         XgBEZZRU48h5gP7jfRbqhrLQ6SR2f/PsnBR6+ZpI=
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
Subject: [PATCH 5.10 093/226] ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
Date:   Mon,  9 Oct 2023 15:00:54 +0200
Message-ID: <20231009130129.199214947@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 6469b2feade8fd82d224dd3734e146536f3e9f0e ]

Fix "thermal_sys: cpu_thermal: Failed to read thermal-sensors cells: -2"
error on boot for omap3/4. This is caused by wrong addressing in the dts
for bandgap sensor for single sensor instances.

Note that omap4-cpu-thermal.dtsi is shared across omap4/5 and dra7, so
we can't just change the addressing in omap4-cpu-thermal.dtsi.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: a761d517bbb1 ("ARM: dts: omap3: Add cpu_thermal zone")
Fixes: 0bbf6c54d100 ("arm: dts: add omap4 CPU thermal data")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi |    3 +--
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi |    5 ++++-
 arch/arm/boot/dts/omap443x.dtsi          |    1 +
 arch/arm/boot/dts/omap4460.dtsi          |    1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -15,8 +15,7 @@ cpu_thermal: cpu_thermal {
 	polling-delay = <1000>; /* milliseconds */
 	coefficients = <0 20000>;
 
-			/* sensor       ID */
-	thermal-sensors = <&bandgap     0>;
+	thermal-sensors = <&bandgap>;
 
 	cpu_trips: trips {
 		cpu_alert0: cpu_alert {
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -15,7 +15,10 @@ cpu_thermal: cpu_thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <1000>; /* milliseconds */
 
-			/* sensor       ID */
+	/*
+	 * See 44xx files for single sensor addressing, omap5 and dra7 need
+	 * also sensor ID for addressing.
+	 */
 	thermal-sensors = <&bandgap     0>;
 
 	cpu_trips: trips {
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -72,6 +72,7 @@
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <0 20000>;
 };
 
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -89,6 +89,7 @@
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <348 (-9301)>;
 };
 



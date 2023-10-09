Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40277BE084
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377351AbjJINlC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377341AbjJINlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A422B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F9C433CB;
        Mon,  9 Oct 2023 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858857;
        bh=dG+YnAIz6i7K3AqNcFTNLJnJNoBzs+DttFV173++8lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeFqq5OzofJK7QW4djelBmw2xh5vM6WgWVqFz8gFTZ+yD4GnWpSQ+29IvQcqIyAhy
         /n6/f0ogaecWpMi5t00uRDKQJDi+jSZCByL2ZanfKjTmO4wrTGnEMM2e+muZA85ELy
         YWgxHhide9khQXFOpv97ZPJVVvQ7rYruZkhruEhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 094/226] ARM: dts: motorola-mapphone: Configure lower temperature passive cooling
Date:   Mon,  9 Oct 2023 15:00:55 +0200
Message-ID: <20231009130129.225140996@linuxfoundation.org>
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

[ Upstream commit 5c3db2d4d4ed747e714387362afe007e6ae5e2d3 ]

The current cooling device temperature is too high at 100C as we have a
battery on the device right next to the SoC as pointed out by Carl Philipp
Klemm <philipp@uvos.xyz>. Let's configure the max temperature to 80C.

As we only have a tshut interrupt and no talert interrupt on 4430, we have
a passive cooling device configured for 4430. However, we want the poll
interval to be 10 seconds instead of 1 second for power management. The
value of 10 seconds seems like plenty of time to notice the temperature
increase above the 75C temperatures. Having the bandgap temperature change
seems to take several tens of seconds because of heat dissipation above
75C range as monitored with a full CPU load.

Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Suggested-by: Carl Philipp Klemm <philipp@uvos.xyz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: ac08bda1569b ("ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 5f8f77cfbe59f..807042a293d0a 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -192,6 +192,14 @@
 	};
 };
 
+&cpu_thermal {
+	polling-delay = <10000>; /* milliseconds */
+};
+
+&cpu_alert0 {
+        temperature = <80000>; /* millicelsius */
+};
+
 &dss {
 	status = "okay";
 };
-- 
2.40.1




Return-Path: <stable+bounces-8619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A615A81F712
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83BE1C20DA9
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53A6AA4;
	Thu, 28 Dec 2023 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZSokmgC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA726FA1
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 10:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612CBC433C8;
	Thu, 28 Dec 2023 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703760706;
	bh=r168erayrVWB/r0EpasnIBfnfBi/PcJIe47J9JMHU/I=;
	h=Subject:To:Cc:From:Date:From;
	b=uZSokmgCMFgIX4D4BTEw0S9Kzsmnn1Xz2Ua4DfALGKllRFOkyXFXrY/ry/7aRs4fg
	 JpFfE+luUz6DpuNcCDJMuKcRDVAtBrEgun+kPxp7WFpck0oOFZZsBGtst8F8rQU6e2
	 lTCwJxUe7MrffAAGnywNNR5nKZJlES6tSAfa98rE=
Subject: FAILED: patch "[PATCH] ARM: dts: Fix occasional boot hang for am3 usb" failed to apply to 6.1-stable tree
To: tony@atomide.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 10:51:44 +0000
Message-ID: <2023122844-impending-deceiving-5f9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b6a51aab5f5f9f71d2fa16e8b4d530e1643dfcb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122844-impending-deceiving-5f9d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9b6a51aab5f5 ("ARM: dts: Fix occasional boot hang for am3 usb")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b6a51aab5f5f9f71d2fa16e8b4d530e1643dfcb Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 12 Dec 2023 15:50:35 +0200
Subject: [PATCH] ARM: dts: Fix occasional boot hang for am3 usb

With subtle timings changes, we can now sometimes get an external abort on
non-linefetch error booting am3 devices at sysc_reset(). This is because
of a missing reset delay needed for the usb target module.

Looks like we never enabled the delay earlier for am3, although a similar
issue was seen earlier with a similar usb setup for dm814x as described in
commit ebf244148092 ("ARM: OMAP2+: Use srst_udelay for USB on dm814x").

Cc: stable@vger.kernel.org
Fixes: 0782e8572ce4 ("ARM: dts: Probe am335x musb with ti-sysc")
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/ti/omap/am33xx.dtsi b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
index 1a2cd5baf402..5b9e01a8aa5d 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
@@ -359,6 +359,7 @@ usb: target-module@47400000 {
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>,
 					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-delay-us = <2>;
 			clocks = <&l3s_clkctrl AM3_L3S_USB_OTG_HS_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;



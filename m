Return-Path: <stable+bounces-148914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2133ACABD8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBD83B7937
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0511E1DEB;
	Mon,  2 Jun 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3BQQbyJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C11AC458
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857662; cv=none; b=ptHrP6DOn5JfCqPJXTtd/0hzbYKTGnEg+06s6SJze00GgoUSWVX9TBuLtscHVQqJgdN2UpEV6sUuWXedUjFq25k0KhEOp++fhIprr4LPGtJYuCFfkT8ArJGBS8N1Sdt5qf6naXSXYkDWB1pX67amcBD53Ub242bBAV0jZfNxfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857662; c=relaxed/simple;
	bh=6hsxjOhHZQw6HiON9dItuSfGc8/2RKxNDoEewi9nZKI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VziSSjFbXHe2g2Br5bnKVR3I8J5px6o4I/Wx2CZH6C+pgzHIbqVrEY42FfM46jOk2Sow9jl0MXze/Zaodtws2AyhjrX+jhmaUJjc98JH6WPyXcKRZHJ8H8loCDPOr608u/hfYWZgGfvgug3HmiY/jdUB9uxX81ObV4tubIX4dDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3BQQbyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC3C4CEEB;
	Mon,  2 Jun 2025 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857661;
	bh=6hsxjOhHZQw6HiON9dItuSfGc8/2RKxNDoEewi9nZKI=;
	h=Subject:To:Cc:From:Date:From;
	b=q3BQQbyJLqa/bcFXVpceSVqKN1H8WZAfZK4dTUHmnMGQ5B2M5y+UEIV29V+Rx6k2t
	 I8nV7wZOjqf2zudFlOB2H3Xnf4Kes+XyN+5phq2oKXz+GA5aFrjHuB09NMMANC4uFS
	 fm++7WlPfDZ+2OLlKzlZFGRpO2nQrBemhHCrnLvQ=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am62-main: Set eMMC clock parent to" failed to apply to 6.1-stable tree
To: jm@ti.com,bb@ti.com,nm@ti.com,u-kumar1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:47:30 +0200
Message-ID: <2025060230-sacrifice-vexingly-4e21@gregkh>
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
git cherry-pick -x 3a71cdfec94436079513d9adf4b1d4f7a7edd917
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060230-sacrifice-vexingly-4e21@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a71cdfec94436079513d9adf4b1d4f7a7edd917 Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Tue, 29 Apr 2025 11:33:35 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Set eMMC clock parent to
 default

Set eMMC clock parents to the defaults which is MAIN_PLL0_HSDIV5_CLKOUT
for eMMC. This change is necessary since DM is not implementing the
correct procedure to switch PLL clock source for eMMC and MMC CLK mux is
not glich-free. As a preventative action, lets switch back to the defaults.

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Udit Kumar <u-kumar1@ti.com>
Acked-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20250429163337.15634-2-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7d355aa73ea2..0c286f600296 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -552,8 +552,6 @@ sdhci0: mmc@fa10000 {
 		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 57 6>;
-		assigned-clock-parents = <&k3_clks 57 8>;
 		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;



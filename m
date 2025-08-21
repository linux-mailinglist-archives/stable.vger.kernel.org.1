Return-Path: <stable+bounces-172029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400EB2F9C0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7871CE3F6F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF4320CC7;
	Thu, 21 Aug 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYG06Iut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37A2DA76E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781543; cv=none; b=uBcZROa7kK2SAZ51dG0h6y2P7rMdRZuaY+KGgXTloSND6pwUKc5PPl4Z2YI7tIq9IMZRdAtezkhgxf0W4jOnseN6MSGZWs+xTcYfarvltpctDzuH8ZBN03oE9H8HfaG6tONuFXvLJ3wLnhueSQ+KVyWVCZzCWFUk6VenjRCLTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781543; c=relaxed/simple;
	bh=A/hRMEvJklhHa9t6SXX4hHwi08q+uC9hO0Xm1l91Y2k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NvHGcUy8gn3NBFMKJ6yiD3Rqps+pxxuuvqcX25VMtVOap2wnc6Mi4a4zVSnCw+GXHcC+QS5LToknEQuig2GBF0mhSy/WMYJXUmhTY5H2vK9fkAKJ8D3b9X8MxiAxenK8UWu0BNb4hEZRQH2FvvuPdywQniUwKlyPXGlbuQLoDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYG06Iut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323B1C4CEEB;
	Thu, 21 Aug 2025 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781543;
	bh=A/hRMEvJklhHa9t6SXX4hHwi08q+uC9hO0Xm1l91Y2k=;
	h=Subject:To:Cc:From:Date:From;
	b=sYG06IutNDn9FPgAon0+58viLIkgnXiCH0prQov+yaWr58k1HsEj1L7BAQwftNBZB
	 oTF5vqUjCiCsO82l/N1Ti5VhgbMaI5prF4w8gqOCNSAY2le5vRZdRblrSMo/lr2df7
	 05t3bIfCDh3Bmb1kR+fPJ8AAhaVdS6NKJ3kGhDOw=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR" failed to apply to 6.1-stable tree
To: jm@ti.com,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:05:19 +0200
Message-ID: <2025082119-deafness-faster-0127@gregkh>
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
git cherry-pick -x 265f70af805f33a0dfc90f50cc0f116f702c3811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082119-deafness-faster-0127@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 265f70af805f33a0dfc90f50cc0f116f702c3811 Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Mon, 7 Jul 2025 14:12:50 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR
 support

For eMMC, High Speed DDR mode is not supported [0], so remove
mmc-ddr-1_8v flag which adds the capability.

[0] https://www.ti.com/lit/gpn/am625

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/r/20250707191250.3953990-1-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 9e0b6eee9ac7..120ba8f9dd0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -553,7 +553,6 @@ sdhci0: mmc@fa10000 {
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;



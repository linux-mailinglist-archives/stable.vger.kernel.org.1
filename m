Return-Path: <stable+bounces-148915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C995ACABE0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4017B7BD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385E1E25F2;
	Mon,  2 Jun 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDjWWsLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F551E0E0B
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857701; cv=none; b=b5NTfqP53QO1YZ7z6vcw4AOawIGys9RQshz4DFoYfXV2IGp+fQ0VQT7mQ72MYY+YdvVCboqirJTAz9IdHmXnlxS8NYrBKE0Om6ZrqgGl7S1+uQycD0XaXIVcJSMLOY2/slhOHhARx1O2ifjikuY+Mvg9xKeW/vcCV8XIfIjsjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857701; c=relaxed/simple;
	bh=jKfmgQ16o/x/EUpD8JnM9mk/0mPc/T3QAB4O3aOqu0A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nDbpEezf9VrMOfHm/aNAhAbCPNBay5UY0mhZcNEgG7NrUHvtlTQEbmIBV0lnBvFHNzI1qDoKYURXf8HtdRR1S3Avr/zaapftf5cMs2O4CTii6LrKs++FwCwjzsSmn5HM60eosTJ3u0ntxBdcpV8F6v2G9JmnQGeHS56DDzvf6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDjWWsLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FADC4CEEB;
	Mon,  2 Jun 2025 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857701;
	bh=jKfmgQ16o/x/EUpD8JnM9mk/0mPc/T3QAB4O3aOqu0A=;
	h=Subject:To:Cc:From:Date:From;
	b=jDjWWsLGFCPsQibCU68o3bHWU1Oo9Y1u8vM5UKBKqV2TR0AHZwg7h5RBXU7U3uaaX
	 bBkSNPZZDXiybaxUc6SZhJ8Uypf8qUUGf42AvXoz1I/SN6AS4Ul4oQ3V1oG7UNEcFb
	 nKL80ZlFizNQnzbcvgQ0HCOGiCvAxlCTgSwipkCc=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0" failed to apply to 6.6-stable tree
To: jm@ti.com,m-shah@ti.com,nm@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:48:18 +0200
Message-ID: <2025060218-subdivide-smashing-0ef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f55c9f087cc2e2252d44ffd9d58def2066fc176e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060218-subdivide-smashing-0ef7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f55c9f087cc2e2252d44ffd9d58def2066fc176e Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Tue, 29 Apr 2025 12:30:08 -0500
Subject: [PATCH] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

For am65x, add missing ITAPDLYSEL values for Default Speed and High
Speed SDR modes to sdhci0 node according to the device datasheet [0].

[0] https://www.ti.com/lit/gpn/am6548

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429173009.33994-1-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 6d3c467d7038..b085e7361116 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -449,6 +449,8 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
 		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 		status = "disabled";



Return-Path: <stable+bounces-125917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E014AA6DEC0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB1188D89F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D67261366;
	Mon, 24 Mar 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p+LVti+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56337261579
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830306; cv=none; b=R+Yqvgbim/6xfop/BRxgGyWl635VMJaVgF8jCYRNdsmMZSvyX8fBrWuOZFBDTE1MyhOficB2YswnphXON2KdZ8HPb9XbaN7goMvQnY+78WCBUN3iZ/k50PFRJR4QOSckfdE6lvB008hDt7yRpXU4t3p5l6/WmisQjZ+iZL2per4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830306; c=relaxed/simple;
	bh=hDKkdqAad43mWzPlR2jmlaM5PX13dk02DlfxLoN12Hs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S/dtszXoI8Ir6tNCZvTh6N3X0dIuZx/osK09oRyq1dzZ+Vp6+qk+ldqx25IqPR08BujE4m+tMvPbQ5LcCZV4qEqK8obktiybz2toteqcGRRVDmIYPi7wZ1ledqUN21xbbCbn1ZqOBwt++OF5tEm/AubsOCfljH2nGK0o4NyvNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p+LVti+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91498C4CEDD;
	Mon, 24 Mar 2025 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830305;
	bh=hDKkdqAad43mWzPlR2jmlaM5PX13dk02DlfxLoN12Hs=;
	h=Subject:To:Cc:From:Date:From;
	b=p+LVti+SM3XF1jgAS7naR3P0wbIBR63pZqh3otTjIHhr8V5EtFNtt8ys2bMW5eSVC
	 MwKrKmUsjUibzougRjl61KuuG+Y0thwNXbSioODGwEq+TBepv1rAG8nowb3xVy4PCV
	 JygDGeJdYl68zyLP87sgIvzNhGDAJhq65BVlaniA=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S" failed to apply to 6.1-stable tree
To: justin@tidylabs.net,dsimic@manjaro.org,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:30:20 -0700
Message-ID: <2025032420-nag-conclude-f944@gregkh>
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
git cherry-pick -x 38f4aa34a5f737ea8588dac320d884cc2e762c03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032420-nag-conclude-f944@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38f4aa34a5f737ea8588dac320d884cc2e762c03 Mon Sep 17 00:00:00 2001
From: Justin Klaassen <justin@tidylabs.net>
Date: Tue, 25 Feb 2025 17:03:58 +0000
Subject: [PATCH] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

The u2phy1_host should always have the same status as usb_host1_ehci
and usb_host1_ohci, otherwise the EHCI and OHCI drivers may be
initialized for a disabled usb port.

Per the NanoPi R4S schematic, the phy-supply for u2phy1_host is set to
the vdd_5v regulator.

Fixes: db792e9adbf8 ("rockchip: rk3399: Add support for FriendlyARM NanoPi R4S")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Link: https://lore.kernel.org/r/20250225170420.3898-1-justin@tidylabs.net
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
index b1c9bd0e63ef..8d94d9f91a5c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
@@ -115,7 +115,7 @@ &u2phy0_host {
 };
 
 &u2phy1_host {
-	status = "disabled";
+	phy-supply = <&vdd_5v>;
 };
 
 &uart0 {



Return-Path: <stable+bounces-118748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D265A41ADF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC3616BFE4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E224A077;
	Mon, 24 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bURH8yoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA8241669
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392797; cv=none; b=B/kIv2JVkvtcSPgBPsgcox44ammvKVyKjsm1Zcc5kmq7Ir28yAKvbSEH/GBv97L/9tPOiJNpaG1Z6ZA/1ho96h72I7Mlu6zaO1G5ZMAmPMS7ebgJFdTR+ZSU+rceAQ9WRqrn9cZMi0Sg9yZjqDk+KYfxqx4tvojBFah7rumcZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392797; c=relaxed/simple;
	bh=4hoivPa/6DSWgZiLJUnEHE7MPoWXSQ7wM8TW4CDrOH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aXdb9eTlqEBBiq73Ogrg4MllRRdgTAfjVTB1lWPDyQSOT7Lg4Tz7aRLTHYyKHDHQzE5havMOQxiNQihuaUMkI3dGHs0HLCNM+EMSLa/7afHSjjIK+DpOpdOl0Z/Td6E2WZaVvf+eDS8DF7PEcSkVA8JEO0crEsoDgG3qD7B/KcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bURH8yoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18218C4CED6;
	Mon, 24 Feb 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392796;
	bh=4hoivPa/6DSWgZiLJUnEHE7MPoWXSQ7wM8TW4CDrOH8=;
	h=Subject:To:Cc:From:Date:From;
	b=bURH8yoBVsw8rVXUfRcS+QHEHFbekYbqplR09gAYkQblLF3btXAtRFajBZMJGNE2q
	 WTWgTdjnkUSpRDgHjpNLppEFUl/3oJq5X5+28Hgv/g+uUx+EM91ps1MmNh94ky8vA+
	 AkY5vZnVJwra7EZpJh62fuhOacS/Z9uOfimsexhE=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for" failed to apply to 6.12-stable tree
To: cnsztl@gmail.com,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:26:31 +0100
Message-ID: <2025022431-print-cure-5210@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a6a7cba17c544fb95d5a29ab9d9ed4503029cb29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022431-print-cure-5210@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6a7cba17c544fb95d5a29ab9d9ed4503029cb29 Mon Sep 17 00:00:00 2001
From: Tianling Shen <cnsztl@gmail.com>
Date: Sun, 19 Jan 2025 17:11:54 +0800
Subject: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts

In general the delay should be added by the PHY instead of the MAC,
and this improves network stability on some boards which seem to
need different delay.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20250119091154.1110762-1-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 67c246ad8b8c..ec2ce894da1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -17,8 +17,7 @@ / {
 
 &gmac2io {
 	phy-handle = <&yt8531c>;
-	tx_delay = <0x19>;
-	rx_delay = <0x05>;
+	phy-mode = "rgmii-id";
 	status = "okay";
 
 	mdio {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
index 324a8e951f7e..846b931e16d2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
@@ -15,6 +15,7 @@ / {
 
 &gmac2io {
 	phy-handle = <&rtl8211e>;
+	phy-mode = "rgmii";
 	tx_delay = <0x24>;
 	rx_delay = <0x18>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
index 4f193704e5dc..09508e324a28 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
@@ -109,7 +109,6 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
 	clock_in_out = "input";
-	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";



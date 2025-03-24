Return-Path: <stable+bounces-125916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDBA6DEBE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17D01887809
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E326157A;
	Mon, 24 Mar 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9Au8Qvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6526156B
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830304; cv=none; b=VnIhzM0VZVuRfjV5cUgzVHiF/oBkh0XvQrdfBqB1l69ZQV8xkWczUO0x1tUxpjJKaQRh0kf4UDQeh3Kzy+Us207iyhbDcfjowOMgv4uKp8EPA1teD9xaHdqnVN9xt/JnJA310uZv66Bv4iNsOfc+sf60s3YpYRYWNH0JEihH+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830304; c=relaxed/simple;
	bh=mGKYi0D8m1FICIOYgCitMvwYv4iqi0e8kDlmgCYPbT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tvMRbMzuQAV9HjCNolfTCLu9jCzE5OCshXXhWRM7CrvJFpse41cPo+kODa15imRIdm4Dt2yemPWh99d/vWtWqPNEcBSuhL6aK2dzYfNT1D0fr4Ap3AHxrLGKeGrj0ZYqB69TCFfMaXG43P41M9pWY7mXXaRmLI/Xo21i1Hl8nN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9Au8Qvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE45C4CEDD;
	Mon, 24 Mar 2025 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830303;
	bh=mGKYi0D8m1FICIOYgCitMvwYv4iqi0e8kDlmgCYPbT4=;
	h=Subject:To:Cc:From:Date:From;
	b=R9Au8Qvln4Ng9XSD2d/XWqYBgtEGsii9uRVuYVz+qPxqaEeoo1/4BrDnlG0idJblM
	 Qy8uCo8vLd4fCP8kuSiqeJNnx5TNru48izR6OIhuyjaRwItZ6IwEsGm+SiakpYIej6
	 +/N8OX+8sj4xr53CFip91p3K/5PV2qdWGHeGSvwI=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S" failed to apply to 6.6-stable tree
To: justin@tidylabs.net,dsimic@manjaro.org,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:30:19 -0700
Message-ID: <2025032419-glaucoma-ascertain-be6e@gregkh>
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
git cherry-pick -x 38f4aa34a5f737ea8588dac320d884cc2e762c03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032419-glaucoma-ascertain-be6e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



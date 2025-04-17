Return-Path: <stable+bounces-133045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B9A91AB7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AC1441BA0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012E23C8A2;
	Thu, 17 Apr 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3JVOrMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93D23C380
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889072; cv=none; b=kjeX8IT1IiLGIOzXubvoZ9NfkKQ6ni5PYLFWp7+vuVM+QSQ0YW53hIQAaxpGvfCzkKaZC08WgcfoAQjTp14Zm2UbqLo70dCj9Owp+5Fuh0D1mfRy9VYhaLhwH0ixcGMLQS8MJusalLfmkIfIRGyNzDr+uIPtWehjFb9AK6G48Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889072; c=relaxed/simple;
	bh=xgUsfhGUQonH+yOacFmSlZOLYZi5skWuZjxF1DajZUE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tMfNZjM4A+9c3DqtqlseqYpsjJIeuoRKDEfsE49JSdqRmHA8/D3DcGVMOebDGSxlH4SoUxOnhI1Dmm0cHLRmSrhpTGtvJFgPeBicREFQU7UTuO6eoiwZ8DzoknjWdchAiNus52Sm5KtEhbFazc4hVJhh/6LJhlh3vKYUX53xisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3JVOrMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38C3C4CEE4;
	Thu, 17 Apr 2025 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889072;
	bh=xgUsfhGUQonH+yOacFmSlZOLYZi5skWuZjxF1DajZUE=;
	h=Subject:To:Cc:From:Date:From;
	b=E3JVOrMgNuFtuFDPN3mfFLTBBWlqb0bNrGFvTUyICsPCJB1kYxolr0COQhTLx5OPY
	 ohPsQikxvDE1EOcJvocXkNSClJI4iXruJKagNaKw955Un1f7G31eCMrEmKD4BS4eAF
	 fI8wIDwuKaT30ODVmSc96qEeswvmV9rZkJinyR98=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix" failed to apply to 6.12-stable tree
To: s-vadapalli@ti.com,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:10:17 +0200
Message-ID: <2025041717-yanking-animating-97a7@gregkh>
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
git cherry-pick -x 38e7f9092efbbf2a4a67e4410b55b797f8d1e184
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041717-yanking-animating-97a7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38e7f9092efbbf2a4a67e4410b55b797f8d1e184 Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Fri, 28 Feb 2025 11:08:50 +0530
Subject: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix
 serdes_ln_ctrl reg-masks

Commit under Fixes added the 'idle-states' property for SERDES4 lane muxes
without defining the corresponding register offsets and masks for it in the
'mux-reg-masks' property within the 'serdes_ln_ctrl' node.

Fix this.

Fixes: 7287d423f138 ("arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://lore.kernel.org/r/20250228053850.506028-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 3b72fca158ad..1944616ab357 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -84,7 +84,9 @@ serdes_ln_ctrl: mux-controller@4080 {
 					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
 					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
 					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
-					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
+					<0x28 0x3>, <0x2c 0x3>, /* SERDES2 lane2/3 select */
+					<0x40 0x3>, <0x44 0x3>, /* SERDES4 lane0/1 select */
+					<0x48 0x3>, <0x4c 0x3>; /* SERDES4 lane2/3 select */
 			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
 				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,



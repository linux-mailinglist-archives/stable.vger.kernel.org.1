Return-Path: <stable+bounces-15975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39183E5D0
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEA1B20FC6
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9D250F4;
	Fri, 26 Jan 2024 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHgbOiiw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312625565
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309248; cv=none; b=upIOmNmnlVcrYzOa1L3dOhr8ugO0aEN/Kxbq02+iojuePZWAKxcmSyjfgW/OMX2ikjtUPiTrPJ/ky9su0fHxIpFjKleYtRmakHuAujnn7YzKA4csmH2/EEYdEWNMFSGeJiYE6d8f6tHlxdVfJ7EukneJ1E7+jCOuTA3QT0l9TfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309248; c=relaxed/simple;
	bh=zP5OjdDxp+SX/XOkCOPhw9jc6pHSA5rkPxJ5rZNqpsw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nQBaLpOPPHaZjmnV5WUxkifCCzJzH4tUjNiVDoWyDJYMPjHyNZkBDmH4IdbTEE2kzDS3a9lhKDpJoLgkmh7N1kB+NbF2O3ETtvgGUcmeyo9Kw0Oox8MnYGNP65yYbzaJBhhAy9KHMoe0ySsg0V8FvHVA6T6Kc9SL3nN6e4JXKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHgbOiiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D5C433C7;
	Fri, 26 Jan 2024 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309247;
	bh=zP5OjdDxp+SX/XOkCOPhw9jc6pHSA5rkPxJ5rZNqpsw=;
	h=Subject:To:Cc:From:Date:From;
	b=iHgbOiiwM/zd1LcWPbuugM7hLAOIFUfq1foVAqch5xwXUh5UHldiWcaYshVOKYuDk
	 4BEhuo7Awi5uJooQIBF/HgrZHhVmQEBe1F3Z2/IFfn8D5uedQX5k8nF0ophQLt0jRk
	 nMzQU07bSe4x4gjsdR8JNSFhvuJdIGDOOdniuy5U=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sc7180: fix USB wakeup interrupt types" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:47:26 -0800
Message-ID: <2024012626-ninja-ominous-1a86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9b956999bf725fd62613f719c3178fdbee6e5f47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012626-ninja-ominous-1a86@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9b956999bf72 ("arm64: dts: qcom: sc7180: fix USB wakeup interrupt types")
1e6e6e7a080c ("arm64: dts: qcom: sc7180: Use pdc interrupts for USB instead of GIC interrupts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b956999bf725fd62613f719c3178fdbee6e5f47 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 20 Nov 2023 17:43:23 +0100
Subject: [PATCH] arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
Cc: stable@vger.kernel.org      # 5.10
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231120164331.8116-4-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f0f0709718ac..4dcaa15caef2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2966,8 +2966,8 @@ usb_1: usb@a6f8800 {
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 8 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 9 IRQ_TYPE_LEVEL_HIGH>;
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 



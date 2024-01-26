Return-Path: <stable+bounces-15968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D883E5C5
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76C01C2158C
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AEC250F4;
	Fri, 26 Jan 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DspxtFjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C301C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309087; cv=none; b=X4p4KO9l5oIQgdorJcpFQmMSALft9Zz/YcIF6xoJNo4bZVfz5sWWstYxhiFATSLRCNusp/Vx6H3RHaBdKmCn3peYNJqkOFFCVCV5JhtVP3gaNDdHii3ikaqJrhhTDYUOdW3EIHIkKNa4KOxbJdquvccIlYuD8GMLPtC8dFlfVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309087; c=relaxed/simple;
	bh=O05L4niFc7zCmrpxVnfJQOz/vgFZallVm71Pg/4KyNw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c35l7wOBRt9fGzvFijyEQlLURaEEngybOMpjeNH+EmoW0sv94hPE8mTVBGV/+tqseJFD6VOgmnOd62zjdZDSo6YCZtP1jmlZiatbmQYcmAvURlHYlMawLa9CG0yqNMHvLc90UFB8Idkf/fVpNt54xq7QaRoolzcd8mH+bTAlDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DspxtFjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C1EC433F1;
	Fri, 26 Jan 2024 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309086;
	bh=O05L4niFc7zCmrpxVnfJQOz/vgFZallVm71Pg/4KyNw=;
	h=Subject:To:Cc:From:Date:From;
	b=DspxtFjAz2UkMvsex7z7sdtDhADe5uGNwt2Z7bdyWX0zk/HlPre9DH11MtiP/9mHK
	 OLpaJGWIPF6gytVJqfvhzip4kQYzL5xTcwC6AU8sdCjRvEy6ghItTyirfy1tX5tpjr
	 1RCkzd/8ropgx1oGXo0D0d1UhXybTc4HrwTEwk7U=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: fix USB wakeup interrupt types" failed to apply to 6.1-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:44:45 -0800
Message-ID: <2024012645-attic-doorstop-7a33@gregkh>
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
git cherry-pick -x d0ec3c4c11c3b30e1f2d344973b2a7bf0f986734
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012645-attic-doorstop-7a33@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0ec3c4c11c3b30e1f2d344973b2a7bf0f986734 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 20 Nov 2023 17:43:21 +0100
Subject: [PATCH] ARM: dts: qcom: sdx55: fix USB wakeup interrupt types

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
Cc: stable@vger.kernel.org      # 5.12
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231120164331.8116-2-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index f604a27f50be..0fe220408888 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -582,8 +582,8 @@ usb: usb@a6f8800 {
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 158 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 157 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 



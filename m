Return-Path: <stable+bounces-15969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E799883E5C6
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38AF282622
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ECC2556D;
	Fri, 26 Jan 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0EOHr+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FC1C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309089; cv=none; b=qgeOShoxAkuiRAo33VxfVQ3cihD8O2iVnTgMuXCVFwYLa8X+V1fKxJ2aclEjP53fFCyp08JKCeB8FV4YnurNxJt5QAi7bPHsPC3Vvw8DdANvoJrk8brVdrjjpoa6H/Qn48zxWoqWNs9jJZbZDG3S/fayElJLExYmnpo5r/WXGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309089; c=relaxed/simple;
	bh=qUT0wAEvYlpXm4O838VKrJNL4LkGEHJ8NgFnfQZgbAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WmzWKX/ZCrXGtTYXPlAzBC1KNE3IcDabeipaR/JiusbOu3FaOmCwuzPjuCpUVuADQATpXQ7fSfTmFa+RO0l1l+onkkr4eZnh5OLtX9erIMrilG4O8QiXLQlBJhYNMyyYg8Bqk3e0gTaeAAgnfN+PnZi7i4tkyit8qXWrkFnbYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0EOHr+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31491C433F1;
	Fri, 26 Jan 2024 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309089;
	bh=qUT0wAEvYlpXm4O838VKrJNL4LkGEHJ8NgFnfQZgbAs=;
	h=Subject:To:Cc:From:Date:From;
	b=j0EOHr+YQ82y9bL0633vxEYdlRwh9v+tMKId6EYErrEk0gJ80P78bp33FIK+SxmCy
	 wEMmbm/A6ZLgIPe9moJjUpElEy5rFBYGx1TpEcq4PGZKzhCh48L90P0U60tRIVD7wT
	 rVKeii1fWKgQsXbvh/cNq7gFyQn/cCHKexYKUgrs=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: fix USB wakeup interrupt types" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:44:48 -0800
Message-ID: <2024012648-balance-makeshift-23a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d0ec3c4c11c3b30e1f2d344973b2a7bf0f986734
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012648-balance-makeshift-23a6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 



Return-Path: <stable+bounces-15979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF183E62B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED27B23401
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B455E6E;
	Fri, 26 Jan 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ca69IqqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5F55E57
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310314; cv=none; b=ZJAkMUCiQY3SsHJ9UJkwxCfSbrxWO23llfOudsEiqs+mNVx8eQFuJ/g2FqQniweVVjB5Mcf6Gu1GdTaTVR+zY5jLRha17uh7YWj5sPi7Lqb3aYol1LbkPd/Dj34+82r+x90PIdv+NlXCqJLLGCyFkDEF7bUpoxBbtmoAnY/8mMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310314; c=relaxed/simple;
	bh=JHVGqbZ46BbMpJOLAkDpCFv+HpGtSboLE81nWOsrhAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JzHCXxyutNOsElcpFcU5OWiF6Ti7lfYNRdZ+Qig7h3vMv4jnPscg/tjxtseYYNsfCXtEzTfwcqSlAynNYISILBYNxK99lNt+9rArixeSP0iIM6Yw1Rc7b8MYvSaOkhHfBXl1CsOzoIF27P/6HdrZuopDduxb+xqhBcTBKmJUecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ca69IqqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32778C433C7;
	Fri, 26 Jan 2024 23:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310314;
	bh=JHVGqbZ46BbMpJOLAkDpCFv+HpGtSboLE81nWOsrhAk=;
	h=Subject:To:Cc:From:Date:From;
	b=ca69IqqADcazf0xN+ElDltJqNv2S53vpqyhkmdbWdKm6sET/q1e+/W4ZgintAwG6h
	 aKvEpL9yG6BXxXodgyiJMB6bq4Pf5UZsBpVIhF7BScwwG8CTMdGHz6HQvnwBeFtP6/
	 bAY2mIHFDjGDuM/mhQEnJFYQQmZpyMpi/swfK5Tk=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,jonathan@marek.ca,konrad.dybcio@linaro.org,quic_jackp@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:05:13 -0800
Message-ID: <2024012613-unsliced-alphabet-6d99@gregkh>
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
git cherry-pick -x 134de5e831775e8b178db9b131c1d3769a766982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012613-unsliced-alphabet-6d99@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

134de5e83177 ("arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts")
54524b6987d1 ("arm64: dts: qcom: sm8150: fix USB wakeup interrupt types")
0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 134de5e831775e8b178db9b131c1d3769a766982 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 13 Dec 2023 18:34:02 +0100
Subject: [PATCH] arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts

The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states and to be able to detect disconnect events, which requires
triggering on falling edges.

A recent commit updated the trigger type but failed to change the
interrupt provider as required. This leads to the current Linux driver
failing to probe instead of printing an error during suspend and USB
wakeup not working as intended.

Fixes: 54524b6987d1 ("arm64: dts: qcom: sm8150: fix USB wakeup interrupt types")
Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
Cc: stable@vger.kernel.org      # 5.10
Cc: Jack Pham <quic_jackp@quicinc.com>
Cc: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231213173403.29544-5-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 3283da81ee46..7f67d7d0cfff 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3547,10 +3547,10 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -3600,10 +3600,10 @@ usb_2: usb@a8f8800 {
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 



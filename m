Return-Path: <stable+bounces-15977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD083E627
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49954285171
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65055C36;
	Fri, 26 Jan 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwH+yI2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BB35F0C
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310236; cv=none; b=mK0Gc6LsGZptJrmCbIPJq+iaPxantkTC75DXeNI3ME807n7ZXuz8usBnJAoinQ8QDhy7SZYLCWHQ38dhQ6XzFpS5wZORJqy/T+UOUzkc6IVRhPY6n99yJCYkQL2df8zMN0BnpkAkVD8OuR8BPvZkCeM0udbD6UONr1+933tc0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310236; c=relaxed/simple;
	bh=CVyeaBPkYwas2h93kUHLbzQZdgT5N5FcGib6sruJn0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hk2ikIxMiBkGXM0K/7D2aenNH6/8u58d9ah/Ez09hjXKN9+sdvRvpYfmT/iSrArNWD0YSdUMLcl3Sv9QpX0ZRdHtICGHClxVkTgwa+IEsqv1ZgOUuff3WpogWPlup3uKgkgiXNzFUzbVMA0twfBcX0EeBPZTGFdhzSFCu3HOveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwH+yI2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74DFC433F1;
	Fri, 26 Jan 2024 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310235;
	bh=CVyeaBPkYwas2h93kUHLbzQZdgT5N5FcGib6sruJn0I=;
	h=Subject:To:Cc:From:Date:From;
	b=EwH+yI2I3zOI5dj5amK6txS2m/PjEE6DNt6ZvRXn8O1dNzdjbIJ/orUlSvHhkUBYp
	 SVW+gLcvWTs5xLPHjlYlfEMpYJnnlOP+1Nncdpr4Fl/G61P6qAhlkfVHoYMziudBPn
	 C5EhLI2S+3DMCwyfN9u0mMZ6AzUc4xplq7c6zw7M=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts" failed to apply to 6.1-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org,mani@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:03:54 -0800
Message-ID: <2024012654-thespian-marrow-a165@gregkh>
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
git cherry-pick -x de95f139394a5ed82270f005bc441d2e7c1e51b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012654-thespian-marrow-a165@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

de95f139394a ("ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts")
d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de95f139394a5ed82270f005bc441d2e7c1e51b7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 13 Dec 2023 18:31:30 +0100
Subject: [PATCH] ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts

The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states and to be able to detect disconnect events, which requires
triggering on falling edges.

A recent commit updated the trigger type but failed to change the
interrupt provider as required. This leads to the current Linux driver
failing to probe instead of printing an error during suspend and USB
wakeup not working as intended.

Fixes: d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")
Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
Cc: stable@vger.kernel.org	# 5.12
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231213173131.29436-3-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 8934bf4ad433..5347519f8357 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -580,10 +580,10 @@ usb: usb@a6f8800 {
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 158 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 157 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 



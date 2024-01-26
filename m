Return-Path: <stable+bounces-15982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7983E630
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42FC1F22B58
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85556466;
	Fri, 26 Jan 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NS/O0xqB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16221C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310405; cv=none; b=HqxtAkmI6fldxFohiMM26vmkiRr4PogOWzMqPhp9uMqIV6QthZBGactp3g75yCDel+jVFfaQEskHhBaC5mzSOmgC0Oif14Un31purdd1QKC5CwuipyVMGLrKeWL8nuDOeviG4+GWHxnZgaUvEauOAdUmRybYwfDgmyY4YtMwhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310405; c=relaxed/simple;
	bh=Wgc/5ZS0/KFT1rDU+F7gimTmTIfmfcbcQ6+7WfW+M9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RF0ahBSGrPPjuXmOUXbNUgEFk6a4a4jjkwH88AS2vI+1xbqoYc/FSwkfBuXFy/JHnVL/ufEKHfX/Q8cuJm7mD5yQCK6VWv86VAuWHwVbctzrtgmiioDxPyZ/BSqSxbyFRgy5FCNsLCGiSCKlI4c3cASkNDhNiEQwMqU7H1ERr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NS/O0xqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA2AC433C7;
	Fri, 26 Jan 2024 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310405;
	bh=Wgc/5ZS0/KFT1rDU+F7gimTmTIfmfcbcQ6+7WfW+M9k=;
	h=Subject:To:Cc:From:Date:From;
	b=NS/O0xqBHmGMD/nG3OjrU7Jy80vnuvA4V/3eIA22pSrTecOSp6MwGWN4c94GGvIYW
	 FW38JuKt4jgjb5ma/cmAg7bWeSub/e1icrNnI/Lgdnul5xAKze8bjw7lsI+ASxdEje
	 DLggtNjpOVSRzohGFiUqmawvUr6DUqs9/OsBgHVU=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: fix USB SS wakeup" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org,mani@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:06:44 -0800
Message-ID: <2024012644-margarine-oval-e77b@gregkh>
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
git cherry-pick -x 710dd03464e4ab5b3d329768388b165d61958577
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012644-margarine-oval-e77b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

710dd03464e4 ("ARM: dts: qcom: sdx55: fix USB SS wakeup")
de95f139394a ("ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts")
d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 710dd03464e4ab5b3d329768388b165d61958577 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 13 Dec 2023 18:31:31 +0100
Subject: [PATCH] ARM: dts: qcom: sdx55: fix USB SS wakeup

The USB SS PHY interrupt needs to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states.

Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
Cc: stable@vger.kernel.org	# 5.12
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231213173131.29436-4-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 5347519f8357..e233233c74ce 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -581,7 +581,7 @@ usb: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",



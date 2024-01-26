Return-Path: <stable+bounces-15973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B043983E5CB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D700B22083
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF75250F4;
	Fri, 26 Jan 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j3dsVMk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCB1C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309130; cv=none; b=CJLCiL5L98cYrvLpcoceNqHHUslg4SGcrPN10jB30jzQC0Qq7cQrBwVU26N5muIKwEtM8znwNpyap2GZoUfXHgfRiSOR/1ZZTZeFOD0B3V7T2mEkpz1Kf5UKShl8hi5rtHncoLU7YMu5FWGhYDp2XFDG5w/r97YMDQtEH95bSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309130; c=relaxed/simple;
	bh=04J2CpIc86S1MQj4uBs+1ztpchsUJAk7kIFzwB/fnY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fG9YgYne5RgFrJcDjTryb7BrlYFYPJrDi+6gRTInQme5oB8S2npv9sWD3NpBUvLxO+od6TgMwbMn3mlDoYdWlSzuLju2WV7MFyWJRM7BBJ6vTF9/hXxC+qHZrqt9SmuVG5KV0lgIuN7gjS7JkoxoloHCEUjydoL2uqnYKK1r+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j3dsVMk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A89C433F1;
	Fri, 26 Jan 2024 22:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309129;
	bh=04J2CpIc86S1MQj4uBs+1ztpchsUJAk7kIFzwB/fnY4=;
	h=Subject:To:Cc:From:Date:From;
	b=j3dsVMk0pElLCTUNNlRph8weZ8zvTih++iyWhs6vdwaMtGbPuVJzj5Swa9zZRHCxL
	 Zqfrad4t34cZQ1dngIU3w2JsmCKfLont+97wNglsU2z4NqDDxy5EiYNep5c9+kF9wr
	 vdRv+xxRJXN5WWtL1g/mFuiuBQM8ZkzwLj1sLeq8=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'" failed to apply to 6.1-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org,mani@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:45:28 -0800
Message-ID: <2024012628-reselect-imperial-504e@gregkh>
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
git cherry-pick -x cc25bd06c16aa582596a058d375b2e3133f79b93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012628-reselect-imperial-504e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cc25bd06c16a ("ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc25bd06c16aa582596a058d375b2e3133f79b93 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 13 Dec 2023 18:31:29 +0100
Subject: [PATCH] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'

The Qualcomm PDC interrupt controller binding expects two cells in
interrupt specifiers.

Fixes: 9d038b2e62de ("ARM: dts: qcom: Add SDX55 platform and MTP board support")
Cc: stable@vger.kernel.org      # 5.12
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231213173131.29436-2-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 0fe220408888..8934bf4ad433 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -607,7 +607,7 @@ pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
 			qcom,pdc-ranges = <0 179 52>;
-			#interrupt-cells = <3>;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupt-controller;
 		};



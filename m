Return-Path: <stable+bounces-61415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5C93C271
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F1282F3C
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376719AD51;
	Thu, 25 Jul 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V22zqOXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2B19AA74
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911868; cv=none; b=srQixrr9AWwteuWp17TiOwUtDR/zoDjuBcG4Z4Ub2KZ8j9IC73uKOqmL5cHg2/fgbL7X25/YqYR1FrpqwPA2u/XlZNdGJCnPOkG6BtngtAoOAs9qQOOP7Yuig8/YkHSGuXugRCxC76jvQwNL2A2qFbG1z5clmw9zG3H8IBYDH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911868; c=relaxed/simple;
	bh=uP0LxDQWO7lMWy1+Ua1JgSh8qdXKUHehZpoa9GyZ1UA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AYnCUH8vV6swt2BwEuwC5qFatfHeiVuJ7A0heZZtL+kYq1Ho2Y59Hwcfo1TI3w+SDzoTdQ4WMds8B3zy2YiwsQQRAvg7GlxiC7cPP4nZqw/2Ml3IQ9tk/A/3Fr0pptu7UXpnl+zDRYBZ0/c64qTIHt67pHnp4oP/haXPHcMA3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V22zqOXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D358AC32782;
	Thu, 25 Jul 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911868;
	bh=uP0LxDQWO7lMWy1+Ua1JgSh8qdXKUHehZpoa9GyZ1UA=;
	h=Subject:To:Cc:From:Date:From;
	b=V22zqOXQnfue6Ia9rehfm48g2wVOyk8ni+Yyil4AGWPa4PASPTRhA+MdfwPAQ03/O
	 eNlU9RU2cZc5yqs79vbXRWGxuRc8WihHq4MtMGTyIR9FME7XK+jSWDCbQuPW44HW8D
	 gTrBYiW0cMV8AvVnm4a8X/XWur8Iqj2ztbUxZ9zM=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode" failed to apply to 5.4-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:11 +0200
Message-ID: <2024072511-underfeed-acclaim-5e48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0046325ae52079b46da13a7f84dd7b2a6f7c38f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072511-underfeed-acclaim-5e48@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

0046325ae520 ("arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB")
b7efebfeb2e8 ("arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings")
ed9cbbcb8c6a ("arm64: dts: qcom: msm8998: drop USB PHY clock index")
1351512f29b4 ("arm64: dts: qcom: Correct QMP PHY child node name")
82d61e19fccb ("arm64: dts: qcom: msm8996: Move '#clock-cells' to QMP PHY child node")
095bbdd9a5c3 ("arm64: dts: qcom: ipq6018: Add pcie support")
63fa43224696 ("arm64: dts: qcom: sm8250: fix usb2 qmp phy node")
dc2f86369b15 ("arm64: dts: qcom: sm8250: Fix pcie2_lane unit address")
59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
e780fb318fe5 ("arm64: dts: qcom: sm8350: add USB and PHY device nodes")
e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
46a6f297d7dd ("arm64: dts: qcom: sm8250: Add USB and PHY device nodes")
0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
e7e41a207a3e ("arm64: dts: qcom: sm8250: add interconnect nodes")
71a2fc6e7b30 ("arm64: dts: qcom: sm8150: add interconnect nodes")
dff0f49cda84 ("arm64: dts: qcom: sm8250: Drop tcsr_mutex syscon")
5e09bc51d07b ("arm64: dts: ipq8074: enable USB support")
23a8903785b9 ("arm64: dts: qcom: sm8250: Add remoteprocs")
16951b490b20 ("arm64: dts: qcom: sm8250: Add TLMM pinctrl node")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0046325ae52079b46da13a7f84dd7b2a6f7c38f8 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:43 +0530
Subject: [PATCH] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode
 for USB

For Gen-1 targets like MSM8998, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for MSM8998 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 026dad8f5873 ("arm64: dts: qcom: msm8998: Add USB-related nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-4-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 99f811a57ac5..7f44807b1b97 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2144,6 +2144,7 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;



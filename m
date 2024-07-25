Return-Path: <stable+bounces-61411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B693C26A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83FF1C21380
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2719AD46;
	Thu, 25 Jul 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbSfECq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF819AA7C
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911854; cv=none; b=ZJSKwvk1Am8u6GCpnvRTHUFzURWCCjte7Y2p2g5cBgTjo4Sp9XAZPOJ+WrtrBRVRp4zG8g5XyHD2Q98W6LsDn0lsQp8pYDd42Ri6o/asiW7ZOtlSvzsYZ0K/qn8+2f0mB7epEInxXbKtusc+adPqsBnaRGe0uHsZrf7DxWeqYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911854; c=relaxed/simple;
	bh=UfC7A1qnNpMpIeluyj1d6MDisiVHFZAAtdyaPlfsVSI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GddakM1VBwmrLpnEZuG59QiSHWJNM0mcBG8W0Vqf5lqW6yMFuWMIZAMudfHEjos3gbPiVzPu3pG0nPqKd10537ZRW/j9AwkVpju8JEPP+n0iIE7X2xq/tYQni0KGmZSDUwFRVEdb/11J7DUQTr8qepNaNQ2E3jITzh/Ypz8QpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbSfECq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC92C4AF0B;
	Thu, 25 Jul 2024 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911854;
	bh=UfC7A1qnNpMpIeluyj1d6MDisiVHFZAAtdyaPlfsVSI=;
	h=Subject:To:Cc:From:Date:From;
	b=wbSfECq+O/gYfkgtFvgCpf62V2M0AQprTBtNhlqJaXjJqF07H2/G3Pc3UGTOMsn/6
	 OXgDy1fmFXKgocmNzLA/sFIOdX60PtL1rlUUAZRbwYPK6XZ1PlYKT+gLhvNLQwggkP
	 OZUSmn/S7DhgJQpFEeG7S0KXnMpa6tXPMmVAScf8=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode" failed to apply to 6.6-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:08 +0200
Message-ID: <2024072508-equipment-maturely-32e1@gregkh>
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
git cherry-pick -x 0046325ae52079b46da13a7f84dd7b2a6f7c38f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072508-equipment-maturely-32e1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0046325ae520 ("arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB")
b7efebfeb2e8 ("arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings")

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



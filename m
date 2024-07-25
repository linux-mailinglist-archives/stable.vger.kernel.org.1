Return-Path: <stable+bounces-61414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A132493C272
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD1B23375
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3766319B3C0;
	Thu, 25 Jul 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvImdHms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A219ADA1
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911865; cv=none; b=M0q/qKHMh14mF1z9wkjjAEtHCfi/6IiQYgfHpyUol+Re+2jGvZ0AsuFeXgNeo38uaefSwsQ+xvzG9n1z/UoPQFuFVKWKaGsKnI3Nl929QcSZAfnSI5+Nqr8brl9QXUow8FHDDcNEm0LKKufcgin6z8TdhxI8MTXNgS3HA/eJTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911865; c=relaxed/simple;
	bh=e5cso61+1f+ljsHAZEZMBCsieOexicHbmLP/gAjX8yI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TAnS0OI8i7ok8xtTlbgKBAKqcA5ahwOFiWMXI2aO61FN2b+byyBNRngPp4sdG+bGZ7tuT4u8gPDG+FAMdulzni+O6b9EnHxYIBE8UlgaCmlEOApvp3la+haHi7lhHeHgAXlZ3P+G5MvuO5iICGuy9diXr+dJ487Ue2Rmd2n6yP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvImdHms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE2C4AF0A;
	Thu, 25 Jul 2024 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911864;
	bh=e5cso61+1f+ljsHAZEZMBCsieOexicHbmLP/gAjX8yI=;
	h=Subject:To:Cc:From:Date:From;
	b=wvImdHmspTUzCKb0oTxIdqcq7omWx04sl9CEUkCbTDnQ8XyY98wtcq1J8wvoHgC7d
	 wEVzzA82XToTZeCZJ6R//ZzYB+fTP318sz/XJB4VvRId2VjfczFLpzp7EDausjlt2W
	 aBPIPnvZW35PEGOMfSlPBqozKcn0XiHRerXzS4M8=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode" failed to apply to 5.10-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:10 +0200
Message-ID: <2024072510-blade-spousal-6659@gregkh>
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
git cherry-pick -x 0046325ae52079b46da13a7f84dd7b2a6f7c38f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072510-blade-spousal-6659@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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



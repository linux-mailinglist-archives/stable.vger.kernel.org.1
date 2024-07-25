Return-Path: <stable+bounces-61403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4F93C258
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EA283856
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627C19AD4D;
	Thu, 25 Jul 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATNcQ7Hj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585419AD4E
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911730; cv=none; b=a1EIFdDEwQ5Sz91c7raKcZLMuchzaKTlm8kX4QGxjGgQ4xe9QKIp2i2b+wls6ChHKqyHjrtiafBHBHjparNbuEBv07bjlkqaSVYosghxnrXsT4VJW3k1Ps40ptMoXiMcedWoJfib/lfwHJaiGvqTNheA1miiU50Fovz4APiG7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911730; c=relaxed/simple;
	bh=3eQZCNSoq8hUnmaISzptRTP4fJawls+IGaLDcnYaDC0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SzOUeYZZu9zZsVQS5EZ+fG3TZL2O283WzBHcEbr85JQSqflmsgRrAeC5adgF5IgnBfJHUVvyz/8eZGvhBNRPYDI4EIvx7s+A+rvGKPWUhwRrCRyoT3ivmht6FHsTuxEZcaa32W804HUrNqXXLPiFZfY5F9KzAKQ10RH1dFzF/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATNcQ7Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C62BC32782;
	Thu, 25 Jul 2024 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911730;
	bh=3eQZCNSoq8hUnmaISzptRTP4fJawls+IGaLDcnYaDC0=;
	h=Subject:To:Cc:From:Date:From;
	b=ATNcQ7HjNNJNSTgx1v1t//9/MUkpAxmFtHH1CxcfIOCOUZigGQtilVFn0jmUVFVkU
	 3swZNJoElrIWxfv8JsFtrEC0JW3VADnrnAEwNmYmpVFV2RZu2nlm7WDFzefb7Vp4RO
	 m9+e3aQWqKPy7NFxvr2cmRoop2cDguARkk3voSsM=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sc7180: Disable SuperSpeed instances in" failed to apply to 5.15-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,dianders@google.com,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:47:45 +0200
Message-ID: <2024072545-supermom-stinky-b4f9@gregkh>
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
git cherry-pick -x 5b8baed4b88132c12010ce6ca1b56f00d122e376
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072545-supermom-stinky-b4f9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5b8baed4b881 ("arm64: dts: qcom: sc7180: Disable SuperSpeed instances in park mode")
ebb840b00b7f ("arm64: dts: qcom: sc7180: switch USB+DP QMP PHY to new style of bindings")
2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI nodes")
4a9f8f8f2ada ("arm64: dts: qcom: Add Acer Aspire 1")
39238382c499 ("arm64: dts: qcom: sc7180: Drop redundant disable in mdp")
43926a3cb191 ("arm64: dts: qcom: sc7180: Don't enable lpass clocks by default")
c28d9029f3b6 ("arm64: dts: qcom: sc7180-trogdor-wormdingler: use just "port" in panel")
88904a12fbcb ("arm64: dts: qcom: sc7180-trogdor-quackingstick: use just "port" in panel")
746bda7d9dd9 ("arm64: dts: qcom: sc7180-idp: use just "port" in panel")
603f96d4c9d0 ("arm64: dts: qcom: add initial support for qcom sa8775p-ride")
a45d0641d110 ("arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl")
f5b4811e8758 ("arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator off-on-time")
6be310347c9c ("arm64: dts: qcom: add SA8540P ride(Qdrive-3)")
2372bd2d5be6 ("arm64: dts: qcom: sc7180: change DSI PHY node name to generic one")
95dc5fd99972 ("arm64: dts: qcom: sc7180: Drop redundant phy-names from DSI controller")
a10b760b7402 ("arm64: dts: qcom: sc7180-trogdor: Split out keyboard node and describe detachables")
6afcee78b4a4 ("arm64: dts: qcom: sc7180: Add kingoftown dts files")
fb69f6adaf88 ("arm64: dts: qcom: sc7180: Add pazquel dts files")
9520fef90049 ("arm64: dts: qcom: sc7180: Add mrbland dts files")
c77a3d4a2bfa ("arm64: dts: qcom: sc7180: Add quackingstick dts files")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b8baed4b88132c12010ce6ca1b56f00d122e376 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Tue, 4 Jun 2024 11:36:58 +0530
Subject: [PATCH] arm64: dts: qcom: sc7180: Disable SuperSpeed instances in
 park mode

On SC7180, in host mode, it is observed that stressing out controller
results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instances in park mode for SC7180 to mitigate this issue.

Reported-by: Doug Anderson <dianders@google.com>
Cc: stable@vger.kernel.org
Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240604060659.1449278-2-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 52d074a4fbf3..9ab0c98cac05 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3066,6 +3066,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x540 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 				maximum-speed = "super-speed";



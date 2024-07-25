Return-Path: <stable+bounces-61418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F693C277
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45311B20C14
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F219AD49;
	Thu, 25 Jul 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q8kIjsRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEC19AD47
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911878; cv=none; b=REeA2gRWJ5LHEOGE2+8iTbUI+lCRev3LMvw7y+Wf9/Nl1IjP6i+D1fs49z2RQVCNEHwfThGl3w45rRCn1UG78SnNOir2w+ufppJbPhJNsULYZkCVt5t1x71QkdYTN3xgMX2gw+Ux4uqP26ynm3GGouVmhHrEgmI5YG62SkU04pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911878; c=relaxed/simple;
	bh=bHfoXTtKgsTlUwRWVOfxEZJTJWcotNfhgUlK6h/Ckuk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pMQ+QlO+CAvFwBN4SPmWlrGX3U/q4+eG8SZidLf81H94eMSek0c2sZzStRW/h2937B30dw9gICJm8fiPLYBqL/0yrYJ2b8SWQMb9+iUO25W3l3Rqp/VgWC3swEKzE3+ZeNhhQcrJ0nDaTUiRqIxwIiN6lxQliR/QR4O9k+ycF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q8kIjsRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7AC116B1;
	Thu, 25 Jul 2024 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911877;
	bh=bHfoXTtKgsTlUwRWVOfxEZJTJWcotNfhgUlK6h/Ckuk=;
	h=Subject:To:Cc:From:Date:From;
	b=q8kIjsRYRUPBXX9gqxgiRfZ9vmLx9FEHTyF7cHw/SRkzEF/ukEG0yMXMzXd9EvdN+
	 x+coD0q6lpAPcNUmliL2xU7oQzv+HJpGC4sG6upce0I5aquzCftANbAIwQffQnec6i
	 io5ewQw1mFdWXkI8NdLgp2efnwIVWgPOcWRuGT6M=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode" failed to apply to 5.15-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:52 +0200
Message-ID: <2024072552-twisty-harvest-26cd@gregkh>
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
git cherry-pick -x dc6ba95c6c4400a84cca5b419b34ae852a08cfb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072552-twisty-harvest-26cd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

dc6ba95c6c44 ("arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc6ba95c6c4400a84cca5b419b34ae852a08cfb5 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:42 +0530
Subject: [PATCH] arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode
 for USB

For Gen-1 targets like IPQ8074, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for IPQ8074 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 5e09bc51d07b ("arm64: dts: ipq8074: enable USB support")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-3-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 92682d3c9478..284a4553070f 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -666,6 +666,7 @@ dwc_0: usb@8a00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&ssphy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
@@ -715,6 +716,7 @@ dwc_1: usb@8c00000 {
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_1>, <&ssphy_1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;



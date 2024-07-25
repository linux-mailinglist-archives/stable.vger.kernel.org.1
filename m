Return-Path: <stable+bounces-61413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91193C26E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00871F22307
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172519AA6E;
	Thu, 25 Jul 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsWeypYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76F19AA66
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911861; cv=none; b=T5hR0Su8Ubo5qyBVju/CIl0khNKaOq6AgyhHuHvtbTgAKgWvmbBVjEH91GM4xha3or/ikKL9HJp3IMTmQj7ZpkX6aINrGREkzp70js9GU2ADgphnwQ4P8gYj9mXq/hIEk8Szizo4ZnTqtyrbCrP5vidJiEla6W9DBL8X/0XkLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911861; c=relaxed/simple;
	bh=1/K4B+lxi6fVp3UoYMCqagZoRwHr/gS3Lb6bx9opVts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LaBCTS2+ZO1xFxudr8vdWpz24ASzBcsV0dahAzaHSqGyKOFr4ESsxUm4xd5kmiCry7RLKIbb0bJmgieBlEgihF20+p9rUFF8JVjqvLpMQ55VMm7NMACGbWsru4AhvbFVPp74+3f+M9y+7Uuv+j3DB+5nLfLAyU4Sr+MzX/qyLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsWeypYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA93C4AF0C;
	Thu, 25 Jul 2024 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911861;
	bh=1/K4B+lxi6fVp3UoYMCqagZoRwHr/gS3Lb6bx9opVts=;
	h=Subject:To:Cc:From:Date:From;
	b=HsWeypYmvhrGIl18EdqSrKbLyyOvdxjk620zJP6GJiv1KLhtRB8OunBjsOcT/DbOZ
	 JaryRIZWD5bpmwxklWmtTr5WOZGeyIXCVpVasggd9bWSTCPIeQUAAzpaYxVhLWDrhN
	 7z2dUf4Iq9dpMp1ZmM5ja7O70F+wQbUqmBW/3sT4=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode" failed to apply to 6.1-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:09 +0200
Message-ID: <2024072508-musty-divisive-4413@gregkh>
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
git cherry-pick -x 0046325ae52079b46da13a7f84dd7b2a6f7c38f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072508-musty-divisive-4413@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



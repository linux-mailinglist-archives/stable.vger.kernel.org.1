Return-Path: <stable+bounces-61416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834593C274
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C2FB239B1
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7F19AA74;
	Thu, 25 Jul 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BC76kvAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9919AA79
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911871; cv=none; b=De3VvEvX25Yllu7Gv866igJ//TyVX+aTF0rPNRt3bi4SdeQNAFnRMdDdGGS01gmwXvjULQYiItWrbvkKeokLv0uiPh6PnJH/sB7z1VnVnqzS5eo/RrDt+4SdPuNhQr8yLJfUSmbwOMxuJVI1m1c5M3zH6owpdb4ynejQ/Gjo2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911871; c=relaxed/simple;
	bh=3PgQQIp5+9fexXnm8Abt8KT1J8V04PwogLiwp6+UVGU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q3twMSAKX2nh3fQLA1d8/Rqlpb4z4LJ2Vctronq9tXfy3TbZ9/lUvuq38iou/x6w7EjyVhaZa7AEDvQtPVmv2bkjUtRjAccepRHOcADNZqLY7RKzmZ6n7CdUSAhkJxPrDRqC/RLKQL8m4PJnXTwhU3qE7Raw/FqPEyRecA9bnX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BC76kvAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C2AC116B1;
	Thu, 25 Jul 2024 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911871;
	bh=3PgQQIp5+9fexXnm8Abt8KT1J8V04PwogLiwp6+UVGU=;
	h=Subject:To:Cc:From:Date:From;
	b=BC76kvAr/t8ZyvQ2WYrg/cr84KVZxI+dz4mGHC6KW7inF834X5IZOdKBJGd5f4/cw
	 jVTuiO2L8ZFgxhrCwOvdrCdaXAqEwUo6C6xVfNxEcSWdspl+Z1Z4ky8yGAWf7HkYjI
	 6oZHiKzpwPJ12/PlWec779J2wDoPeNWPZsie1ZNA=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode" failed to apply to 6.6-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:50:50 +0200
Message-ID: <2024072550-editor-edging-bfb4@gregkh>
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
git cherry-pick -x dc6ba95c6c4400a84cca5b419b34ae852a08cfb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072550-editor-edging-bfb4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



Return-Path: <stable+bounces-61426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D283A93C27E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BD61C21730
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F519AD5D;
	Thu, 25 Jul 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLGIBFU4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215413C907
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911902; cv=none; b=Rj8nMHHOHxP3ZFTOaVp1bpdt8mkgz5aXZHgn/4z0cZDRMHBgjVtunp/mBbNx7d9p80TohM+DpBxSkqeSSbyXpk3ZWPe3j7pnZbJYFnJVwmASScDxcW3+CDwaM7mJQxMxMWNIiGmXnri+2NX/rO69xyoW+Uu/liLnFUHQSvHKgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911902; c=relaxed/simple;
	bh=aIQKRKIgoWl/bEer9IHQKX94sBoYnp/xJBkqWmAweh4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UyO2+Iqiixu5LvsogCN3TT0ITbAcxBSPELvVmBjJWp9uzXjp22mZpE1LyilXdsD3Gt69fItkysqgke9lRgNWgcpN1LQ0dwjmR8bXP3KdmjDXI9MGLO+ZQDY7QRw4MwCEVlDb0+AkTwkhrr6lnEqfWDzrKs6V0dLtgyyDHHS9b9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLGIBFU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63BC116B1;
	Thu, 25 Jul 2024 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911902;
	bh=aIQKRKIgoWl/bEer9IHQKX94sBoYnp/xJBkqWmAweh4=;
	h=Subject:To:Cc:From:Date:From;
	b=iLGIBFU4UeLBBp5HM5UIMRCDbiQL3IiLBg41SwNgPPZq0modugWQVVULIgOm3r4AH
	 K5rY2hjD0eqEfUyOx6sFkGSF1LO2ms4v2Jb7qj6Yc2eAFTRaXkb5uim3m+Xcfs0ZPo
	 HOAxmchqQGZCE8FoxNdG8ma9c8urTNv5nVr1s0UQ=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for" failed to apply to 6.6-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:51:22 +0200
Message-ID: <2024072522-properly-jackpot-9fed@gregkh>
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
git cherry-pick -x 074992a1163295d717faa21d1818c4c19ef6e676
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072522-properly-jackpot-9fed@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

074992a11632 ("arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for USB")
a06a2f12f9e2 ("arm64: dts: qcom: qrb4210-rb2: enable USB-C port handling")
7e3a1f6470f7 ("arm64: dts: qcom: sm6115: drop pipe clock selection")
b3eaa47395b9 ("arm64: dts: qcom: sm6115: Hook up interconnects")
f6874706e311 ("arm64: dts: qcom: sm6115: switch UFS QMP PHY to new style of bindings")
ff753723bf39 ("arm64: dts: qcom: qrb4210-rb2: Enable MPSS and Wi-Fi")
cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
ba5f5610841f ("arm64: dts: qcom: sm6115: Add UART3")
27c2ca90e2f3 ("arm64: dts: qcom: qrb4210-rb2: don't force usb peripheral mode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 074992a1163295d717faa21d1818c4c19ef6e676 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:45 +0530
Subject: [PATCH] arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for
 USB

For Gen-1 targets like SM6115, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for SM6115 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-6-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index ac5f071a8db3..aec6ca5941c2 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1659,6 +1659,7 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+				snps,parkmode-disable-ss-quirk;
 
 				usb-role-switch;
 



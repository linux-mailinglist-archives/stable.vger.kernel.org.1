Return-Path: <stable+bounces-61420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF093C276
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CA41C21778
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93C19AD59;
	Thu, 25 Jul 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtCMZGYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F719AD55
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911883; cv=none; b=Fh6rk/Gc1iLB2KV96L2SVlID+zpKlPNOloOyb7Sv0uQyWc5GEba9VngCWmRot1kVwcTfHo5qbZc99iySJ3ra081xNfUpi2jU90Dr5sARGaWL4Csmf7cu2ZInyqrAlXAVBxKLxj0Wvj9LY+IQa7MtZ6iiW5E3vPrpOqXFwcj5MCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911883; c=relaxed/simple;
	bh=J/3OEuUgovcBm/72Fq5v/LfWA2PeN1QX21a1dMy6R1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MUrwgXaQeM+XaRVfVWt09RWpa0GbMvsVRcwuGO502q0fG82AnGxag+e+hjoqj3QTAy1DEZ+yITXHfzBXkrCnCcrVkIvzvQ5VDn1nA4+5ghWZ+brJZf0x4J+2tSrtcEZG3yVo3x3aDnSIw/1LIyxvruJakZC+jIUNQ4y5dFeqE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtCMZGYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550D1C116B1;
	Thu, 25 Jul 2024 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911883;
	bh=J/3OEuUgovcBm/72Fq5v/LfWA2PeN1QX21a1dMy6R1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=dtCMZGYkTzrx3UxCJHZERJa+0MRGBwpfFXbWJV00eWPlfVhW2ZmMiJoNNx/6HJP/t
	 En+MXMj8Ptoo5/SHyWXtqdPEsnUqQFAvdkBOy+k7nPgyLBmtX5JFvwq7+i5pIiZGkc
	 7KeB+t8VaeZVnCWVr+S6B2eQeatk+JZGiKLVNmd0=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for" failed to apply to 6.6-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:51:09 +0200
Message-ID: <2024072509-chive-tabby-a6f1@gregkh>
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
git cherry-pick -x cf4d6d54eadb60d2ee4d31c9d92299f5e8dcb55c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072509-chive-tabby-a6f1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

cf4d6d54eadb ("arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB")
ca5ca568d738 ("arm64: dts: qcom: sdm845: switch USB QMP PHY to new style of bindings")
a9ecdec45a3a ("arm64: dts: qcom: sdm845: switch USB+DP QMP PHY to new style of bindings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf4d6d54eadb60d2ee4d31c9d92299f5e8dcb55c Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:48 +0530
Subject: [PATCH] arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for
 USB

For Gen-1 targets like SDM845, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for SDM845 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-9-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 23b101bb3842..54077549b9da 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4138,6 +4138,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x740 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
@@ -4213,6 +4214,7 @@ usb_2_dwc3: usb@a800000 {
 				iommus = <&apps_smmu 0x760 0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_2_hsphy>, <&usb_2_qmpphy>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};



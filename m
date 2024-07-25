Return-Path: <stable+bounces-61421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9993C27A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E85B2148B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6E19AD56;
	Thu, 25 Jul 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbZq0976"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362019AD42
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911887; cv=none; b=PFHSO9ZmJVZhbNWhc9To1j4QhorBhqy2aKxHEw2+zyhKQrwjjsrN2Swmg9KjexKE4vjWC3tEeNIvy1H4y+c3tqJXSAPe6ButeKx8H/yDcivTBbDzyqIeaI9gOwsRgWSHKBomCN7MxpF3wXSfxjw/V6nnOdrc8qRNE0L77ApYXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911887; c=relaxed/simple;
	bh=j0Zwp8oqmM9FMz3IOoTR3Vf4oZI0t3T8r63Ge96YlrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CiMAL9o0AyWq0wGvHMOak62Mv7sOImuYhD1C7wOn8oIHlsrXGfbm9KyeOTacpgRIqYJ4KOENiDMOLr9mE7mG70BtLyGvzTsNuCzFf1LJGFeYY90qeYQp/AVWOq7emh4MIIx/foxvzhrRF8i6dOGFkwa0Jd9UqlSuYK3XGzSdbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbZq0976; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A1BC116B1;
	Thu, 25 Jul 2024 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911886;
	bh=j0Zwp8oqmM9FMz3IOoTR3Vf4oZI0t3T8r63Ge96YlrM=;
	h=Subject:To:Cc:From:Date:From;
	b=rbZq0976ss+FP8XkkkrAQyb0KbYhvyyJ9PbqLt4gnrz1fR/cNDHixIxSfgHfgVidw
	 3sF1hVyKQwT4gtO7OaIf2+bQnNCm3NSWgabSkHYDyoW8tzz072uCZEItifAZIg0Sq+
	 zLA1jLls502yA0/8jIsctxcQjNTIikIq47a8M/9I=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for" failed to apply to 6.1-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:51:10 +0200
Message-ID: <2024072510-await-likely-827c@gregkh>
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
git cherry-pick -x cf4d6d54eadb60d2ee4d31c9d92299f5e8dcb55c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072510-await-likely-827c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cf4d6d54eadb ("arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB")
ca5ca568d738 ("arm64: dts: qcom: sdm845: switch USB QMP PHY to new style of bindings")
a9ecdec45a3a ("arm64: dts: qcom: sdm845: switch USB+DP QMP PHY to new style of bindings")
8fe25ba3ffec ("arm64: dts: qcom: sdm845: rename labels for DSI nodes")
8721e18ca696 ("arm64: dts: qcom: enable dual ("bonded") DSI mode for DB845c")
39e0f8076f6f ("arm64: dts: qcom: sdm845-tama: Enable remoteprocs")
5dcc6587fde2 ("arm64: dts: qcom: sdm845-tama: Add display nodes")
e12482e68830 ("arm64: dts: qcom: sdm845-xiaomi-beryllium: drop invalid panel properties")
9f3c858ecde0 ("arm64: dts: qcom: sdm845-oneplus: drop invalid panel properties")
4ce03bb80fae ("arm64: dts: qcom: sdm845-tama: Add volume up and camera GPIO keys")
a1a685c312f5 ("arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl")
ea25d61b448a ("arm64: dts: qcom: Use plural _gpios node label for PMIC gpios")
67e75cfea375 ("arm64: dts: qcom: Add Lenovo Tab P11 (J606F/XiaoXin Pad) dts")
cb3920b50b4d ("arm64: dts: qcom: align LED node names with dtschema")
f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
0d97fdf380b4 ("arm64: dts: qcom: Add configuration for PMI8950 peripheral")
e07f41b0e1db ("arm64: dts: qcom: Add configuration for PM8950 peripheral")
108162894a5d ("arm64: dts: qcom: sdm845-*: Fix up comments")
4ba146dd8897 ("arm64: dts: qcom: sm6125-seine: Configure additional trinket thermistors")
7401035f2ef8 ("arm64: dts: qcom: sm6125-seine: Include PM6125 and configure PON")

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



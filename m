Return-Path: <stable+bounces-61423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDF93C279
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D72815B1
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809A19AA6F;
	Thu, 25 Jul 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1T0nXsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FD19AA59
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911893; cv=none; b=oPtL5Fp9Cx8W1Yu35Mb8LFBjp6e3Gfag85Cj2QAuFcFdNiSOfWdpQhNEtzqtYzT3v4Oo7PdzeYHkkFbLFeU4Ku9Y6a+zFTGG5SFmqfzMn3cRB/Rqv5aVhYyAzsPg/oSnBK2RLcq5BfAifHDK8cSMXfImriXnWZ3WN/M2ioOlijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911893; c=relaxed/simple;
	bh=iQqcJKImrkyFgrzPWNGDdJddV6M2Wh6SsDE7g8EBxOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RARBOPF4XSc/iYhNseHbEldZ1DucZnuQwINI1vYohLwIS4EPKMfpLG1JXf6Htmkh9IKWiOS2RnaH8sCswrXDuQVylvO0gcM+03BYx26PomoeYmu13cKJZ6vlpWFF28337G6E16r6AH7IlZKwJdZc80GFeAYrcbb1SxJ7uM3Sevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1T0nXsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748EDC116B1;
	Thu, 25 Jul 2024 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911893;
	bh=iQqcJKImrkyFgrzPWNGDdJddV6M2Wh6SsDE7g8EBxOQ=;
	h=Subject:To:Cc:From:Date:From;
	b=z1T0nXsMpX9ywGWnPfEP5I7Y2bRHCWH2iuNN6ds0BWfLoqtEMJIUIPsaOV7DtP1uZ
	 eFfBbs/jGtrX24FRD2V8Uf27/gIG0DF/m1KEiVGe83FuyYHaGrvY5rMlap9YGEPrC2
	 JlAaFoMCyNsC9bXPasRDw0rMXuYOjBqrpa9PDnlo=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for" failed to apply to 5.4-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:51:12 +0200
Message-ID: <2024072512-saline-founder-7ebe@gregkh>
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
git cherry-pick -x cf4d6d54eadb60d2ee4d31c9d92299f5e8dcb55c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072512-saline-founder-7ebe@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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



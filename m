Return-Path: <stable+bounces-61405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3693C260
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99460B232CD
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817119AA61;
	Thu, 25 Jul 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xlwv+LrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69274171E69
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911810; cv=none; b=o7z5jnEtITiMk/vYp/NxqvN1PtdQHQ6Pw7QOZ1P58Cujehr8CnCNg2y4CXk3JNwv0lr1AZSLRWXOrmy8URYWUTGsHswjpHJaBYYDQ3xhY+dv6BnV+iFevDKOs0CbuQhMiIgyVeP5m403hD33gw/i8J8Wz4mKn+qHRYaxuaWSYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911810; c=relaxed/simple;
	bh=MU5YJIQYmHY/mpksVwCBh0pwlv50IKYaX329ekPHV7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SaCO5WhARpGMeJW9XE/XFfQtZAIeFTTsZ/Ny58+vWyLiURv52PRnmGJUnOdwinqB+GFMYM/Jov0QhbVcTxKNah96ABEaOwQsv2e5/Cxac9LE33268j0I2t7t22N6wzsx5XaX0yoBVY0CA8K0E4lfdtUOT3Eo134UNLDkOOy7fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xlwv+LrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3855C116B1;
	Thu, 25 Jul 2024 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911810;
	bh=MU5YJIQYmHY/mpksVwCBh0pwlv50IKYaX329ekPHV7o=;
	h=Subject:To:Cc:From:Date:From;
	b=Xlwv+LrKkM2xkmcVn5G6RKAhba1Ik7A8vXW63jEfSk/vPPy3Ieoms8RQ98llbWM8/
	 KrXdXWr6a3KPQZC/x40de0fUz9kOxxVQYTf666wfJraq8ieHHGXbpJjZlcBQhuxVXB
	 YBSxXiny7hMo9qey+wXa4GZCgy3XbFvbaHTrIvIs=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sc7280: Disable SuperSpeed instances in" failed to apply to 6.6-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,dianders@google.com,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:48:13 +0200
Message-ID: <2024072513-magnify-deputize-f818@gregkh>
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
git cherry-pick -x 3d930f1750ce30a6c36dbc71f8ff7e20322b94d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072513-magnify-deputize-f818@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

3d930f1750ce ("arm64: dts: qcom: sc7280: Disable SuperSpeed instances in park mode")
36888ed83f99 ("arm64: dts: qcom: sc7280: switch USB+DP QMP PHY to new style of bindings")
70c4a1ca13b3 ("arm64: dts: qcom: sc7280: link usb3_phy_wrapper_gcc_usb30_pipe_clk")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d930f1750ce30a6c36dbc71f8ff7e20322b94d7 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Tue, 4 Jun 2024 11:36:59 +0530
Subject: [PATCH] arm64: dts: qcom: sc7280: Disable SuperSpeed instances in
 park mode

On SC7280, in host mode, it is observed that stressing out controller
results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instances in park mode for SC7280 to mitigate this issue.

Reported-by: Doug Anderson <dianders@google.com>
Cc: stable@vger.kernel.org
Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240604060659.1449278-3-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c3aaa09b8187..ba43fba2c551 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4232,6 +4232,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0xe0 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 				maximum-speed = "super-speed";



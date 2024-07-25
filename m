Return-Path: <stable+bounces-61410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE26C93C267
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DFC2839E7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3319AA69;
	Thu, 25 Jul 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LNDJSshu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AD19AA4F
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911851; cv=none; b=iP6Fg2BxmqI37aCT+eh+KsuTLgQZ0tDCwF11Ll8IE07frKCxvaK0GTEEKBd95pL/BXLPyG7b+lSkATI47MdWRwD6fEnSBVPvTDWLqfAQbWPlwkMzVxI9G9uC28/mnT2jgbPyIMJBhttFWEOzwy49fiqy5yE//XsqSMaFSgylIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911851; c=relaxed/simple;
	bh=e+nV/dbFAJRu6tZeVz7JHiNNHO87p5RisvDt1/eUkUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CuLWCYLdVOx8oZRpok+V1f+jrvUZz/zBAVJtQshz4i1LZbWrr6XUi4yiUAHXikULTYhAHThLvQYeUE8xVDQ3XvFgN8FEXQGPwG8YScNCHqasY2arMiUUsYpxJuFuN2Hg3F9HSDx2HhtaBq3qeh1mprAsfscohT/RzEjm6xkDSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LNDJSshu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13999C32782;
	Thu, 25 Jul 2024 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911851;
	bh=e+nV/dbFAJRu6tZeVz7JHiNNHO87p5RisvDt1/eUkUQ=;
	h=Subject:To:Cc:From:Date:From;
	b=LNDJSshuE5EFrUofSAnJXhyBL8w1R7ICsFFq3d0aRaK7h1dvNLkwEFDKLLymOTomD
	 rlAQGqZ/64/s14A6r79hkC4MNdRXaX82lemga3hYsBUMzH/9nPznmONDFktBT2KjWT
	 X3JWyRUvN1OkY//a75Tb4NyBW209FZbp/c6TE9L8=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for" failed to apply to 6.1-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:49:52 +0200
Message-ID: <2024072552-smock-demeanor-6259@gregkh>
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
git cherry-pick -x c5d57eb7d06df16c07037cea5dacfd74d49d1833
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072552-smock-demeanor-6259@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c5d57eb7d06d ("arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB")
5ed2b6388b31 ("arm64: dts: qcom: sm6350: Use specific qmpphy compatible")
347b9491c595 ("arm64: dts: qcom: sm6350: fix USB-DP PHY registers")
95fade4016cb ("arm64: dts: qcom: sm6350: drop bogus DP PHY clock")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5d57eb7d06df16c07037cea5dacfd74d49d1833 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:46 +0530
Subject: [PATCH] arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for
 USB

For Gen-1 targets like SM6350, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for SM6350 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 23737b9557fe ("arm64: dts: qcom: sm6350: Add USB1 nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-7-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 46e122c4421c..84009b74aee7 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1921,6 +1921,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 				usb-role-switch;



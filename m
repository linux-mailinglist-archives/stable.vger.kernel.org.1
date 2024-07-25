Return-Path: <stable+bounces-61408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C190F93C265
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D67D283945
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B319AD4A;
	Thu, 25 Jul 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBfkuFJo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244CB19AD42
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911845; cv=none; b=g4uk5g0lync+qdhznVPgccqJNnGw4HEyTznIYNPY53xWyYdzYumYtjEX5PWc2CnlW62yhcXZfqZ2kpzcsz9QBadboXtEphUBceSAcHs5jtBu9ZWABtTZA80YOxIX0X6/BhPR4prUQBjFUcXmgjiy9ZG8bk6MB4IxJI33acAAJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911845; c=relaxed/simple;
	bh=niAGQjMGariKsZSER07K/YTDmBgo0KQjQl/nIRl7w5A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tNQaSfhuntoA15vZ1vX6fRdavoBdBwoSR+NrBQtOCMzPIPjAMYVkUnkg5ViCrqIIMWik0JgdAjbHyaZso927ssdrzd6qhvoEy6x66cb84WKepzMXdo0BuHG7Hcw2BoMmSa0C73YxEwSjeDhFopf7pVQQIWDyIT5viP0jERzhRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBfkuFJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99663C116B1;
	Thu, 25 Jul 2024 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911845;
	bh=niAGQjMGariKsZSER07K/YTDmBgo0KQjQl/nIRl7w5A=;
	h=Subject:To:Cc:From:Date:From;
	b=xBfkuFJo5bII7dbXe3APkn6bj7b9wdNMEaev+coL9cXXCjsV29ytnK/9FGHCTpN6e
	 wZfGvWymK9PVVPw2ZWDR1qu973E73gtJPBSO0b45lwiL0lT5SajJ+mtjilktAf9Edb
	 m3BcBI4QtBevn1GsfyRZEupGlRwO7AwIvRfMRm24=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: msm8996: Disable SS instance in Parkmode" failed to apply to 5.4-stable tree
To: quic_kriskura@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:49:33 +0200
Message-ID: <2024072533-splurge-kung-54fa@gregkh>
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
git cherry-pick -x 44ea1ae3cf95db97e10d6ce17527948121f1dd4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072533-splurge-kung-54fa@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

44ea1ae3cf95 ("arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB")
d0af0537e28f ("arm64: dts: qcom: msm8996: Add missing DWC3 quirks")
50aa72ccb30b ("arm64: dts: qcom: msm8996: Sort all nodes in msm8996.dtsi")
86f6d6225e5e ("arm64: dts: qcom: msm8996: Pad addresses")
808844314309 ("arm64: dts: qcom: msm8996: Move regulator consumers to db820c")
75b77d6492eb ("arm64: dts: qcom: msm8996: Use node references in db820c")
f978d45b4aab ("arm64: dts: qcom: db820c: Move non-soc entries out of /soc")
d026c96b25b7 ("arm64: dts: qcom: msm8996: Disable USB2 PHY suspend by core")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44ea1ae3cf95db97e10d6ce17527948121f1dd4b Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <quic_kriskura@quicinc.com>
Date: Thu, 4 Jul 2024 20:58:47 +0530
Subject: [PATCH] arm64: dts: qcom: msm8996: Disable SS instance in Parkmode
 for USB

For Gen-1 targets like MSM8996, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for MSM8996 to mitigate this issue.

Cc: stable@vger.kernel.org
Fixes: 1e39255ed29d ("arm64: dts: msm8996: Add device node for qcom,dwc3")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240704152848.3380602-8-quic_kriskura@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2b20cedfe26c..0fd2b1b944a5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3101,6 +3101,7 @@ usb3_dwc3: usb@6a00000 {
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,is-utmi-l1-suspend;
+				snps,parkmode-disable-ss-quirk;
 				tx-fifo-resize;
 			};
 		};



Return-Path: <stable+bounces-163504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E6B0C01B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42C93B7D92
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDE28AAE6;
	Mon, 21 Jul 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPB0uARu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BA28C5A0
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089797; cv=none; b=ibaEMq6V6o48URX3Ett/iIzRTsIdlStMf6drj04gfb+5P0jN07vWKFySaSS8SN2HC9d8dMIQTd9dPQ2ROLfRk23PGNrzWgRJEjcT42djK4IgDZZbqQhpEoNCHcfB3PyHtds0UA3HeIbb7iHIhJ9Uw8z9J/yokWaXW+6Khkn6UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089797; c=relaxed/simple;
	bh=7DZi7v3aN3E3MGvRuiQ0NfHgJilaEWMkclUux35Xp6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cx+kUC6iFfy0gbzH9UXbN/kcM/7eySTlYSefwJUoqDGgvv56cvTyPYZPayLYtBkEjVj2zVBYaIkIiDvuskwb/DZ2pByYapNPDNO0QIUmJsr9ysnhuwbdDzCyEBQBplpyT6l6fNem2Cp2MOKPEJDuI1PmZ8lRXeDwumoEYaMSR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RPB0uARu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D927C4CEED;
	Mon, 21 Jul 2025 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089797;
	bh=7DZi7v3aN3E3MGvRuiQ0NfHgJilaEWMkclUux35Xp6I=;
	h=Subject:To:Cc:From:Date:From;
	b=RPB0uARuuFj0TvxBj/QtHFJ3ClcxfVVDuftdaJi7xcuMQ83A3SbUb3n4Jntot169G
	 Yduuc+F2B2plTDHtP+DsKB7tv3vWLesZTcvND5rssVfDGps3Fa+n7yZFtbTQVHL4DV
	 hxqWwR06ROtln0+lXdaPjerifCN71CyMhKmTavRo=
Subject: FAILED: patch "[PATCH] usb: dwc3: qcom: Don't leave BCR asserted" failed to apply to 6.15-stable tree
To: krishna.kurapati@oss.qualcomm.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,konrad.dybcio@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:23:14 +0200
Message-ID: <2025072114-domelike-overstuff-fe4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x ef8abc0ba49ce717e6bc4124e88e59982671f3b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072114-domelike-overstuff-fe4f@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef8abc0ba49ce717e6bc4124e88e59982671f3b5 Mon Sep 17 00:00:00 2001
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 18:59:00 +0530
Subject: [PATCH] usb: dwc3: qcom: Don't leave BCR asserted

Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
blocks any subsequent attempts of probing the device, e.g. after a probe
deferral, with the following showing in the log:

[    1.332226] usb30_prim_gdsc status stuck at 'off'

Leave the BCR deasserted when exiting the driver to avoid this issue.

Cc: stable <stable@kernel.org>
Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7334de85ad10..ca7e1c02773a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -680,12 +680,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = clk_bulk_prepare_enable(qcom->num_clocks, qcom->clks);
 	if (ret < 0)
-		goto reset_assert;
+		return ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -755,8 +755,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	dwc3_core_remove(&qcom->dwc);
 clk_disable:
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -771,7 +769,6 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
 }
 
 static int dwc3_qcom_pm_suspend(struct device *dev)



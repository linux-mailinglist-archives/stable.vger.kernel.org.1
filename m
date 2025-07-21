Return-Path: <stable+bounces-163503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBBB0C01A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CA7189F993
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0A218593;
	Mon, 21 Jul 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KC9l80Yf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894928B51F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089791; cv=none; b=r5zkJ4HDkAEXlHHzN7+GMLs3faY4ADpAIJaeVYqlr4gGeIu0qbKo6v4UcqIosdpmhqeNan6AeGfLfZWPlJ2XBXqUg7KDYflGcuUEnyU2OqC5YiK+XKhbQdrUB8Ef6Nh7M67X7TYVZ1EggwIJa/3DmQB62tFjAG6fy8pjDEr50oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089791; c=relaxed/simple;
	bh=qT3gJixQyqUjqGQy5FS+CaiC6lNU2zirJ3wkDw8lGmE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MQm4cKpOpSgAActaMSXPkO01uCvSiO9nvZcKavJSkBvMP8P3UwQoi88ziyRUZGcGP30/2Q5p1G7PH47jPQJg/DLTR3thug3ioxqFwkeo4ynNYQW1Rbj1fi2udeSz2h2bl8MwaYxR5hrxjJasiG7AFQ53cVjGuV0k7lm92t11x20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KC9l80Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9B8C4CEED;
	Mon, 21 Jul 2025 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089791;
	bh=qT3gJixQyqUjqGQy5FS+CaiC6lNU2zirJ3wkDw8lGmE=;
	h=Subject:To:Cc:From:Date:From;
	b=KC9l80YfIkYmW+5XcL7u21tXH8VGL0hwZ3DPY1dUCSufLG9MN7380IRx/JhT2xQ6y
	 Yn+BjNATRQPto56ajXLRUK9fOVse3r3RQY+FPdcoI1nmQPqeUEkWmQTWoIM/H2U4cQ
	 zNxCLHPqZZu4A0vPyUBZfoXBGIgl8qf2KdsnCFPg=
Subject: FAILED: patch "[PATCH] usb: dwc3: qcom: Don't leave BCR asserted" failed to apply to all-stable tree
To: krishna.kurapati@oss.qualcomm.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,konrad.dybcio@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:23:08 +0200
Message-ID: <2025072108-canned-impound-9ee7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the all-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-all.y
git checkout FETCH_HEAD
git cherry-pick -x ef8abc0ba49ce717e6bc4124e88e59982671f3b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072108-canned-impound-9ee7@gregkh' --subject-prefix 'PATCH all.y' HEAD^..

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



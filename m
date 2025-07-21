Return-Path: <stable+bounces-163600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A196B0C714
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC31418842A7
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7B2D12FF;
	Mon, 21 Jul 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG3j09FD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3828FFDB
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109918; cv=none; b=f7PdHqXiEdpK2ydGLKyF9FGm46J0oGkolWW9HcJpd9AYkdMmb/P6Qx2fSC6vkSNlbXOSaLR0Ky2+BDgP8pypUZnQkhJnP5A0dFw5WwT+a+hvD72+ox5gSBb6ZcW92rnXjmbxYIikxZanlrTh5/Rh7aelndAx9tKSMrPLhs1jvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109918; c=relaxed/simple;
	bh=s7G/A3E6m6eLf77ASQwqcymY1/NG5s2+2Y3NuWdntNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHLS/OsAChhk0XWDSYwddLChGv+itTkgl5HLDJbacbP1xhIVJ7fWghGeX6feoFjV50v3OLw7e+c+8M68MetN8JKAXOLeowqMf+Wcvh594asEZ28usLfrC3t8cR2xU1NhWiSB8eDInk56CHddJmij76RCMRam7fYvVcyspe77o9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG3j09FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2969FC4CEED;
	Mon, 21 Jul 2025 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753109916;
	bh=s7G/A3E6m6eLf77ASQwqcymY1/NG5s2+2Y3NuWdntNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG3j09FDeBDvn3OxVUfBxKvNOqAPrQi/N/tvtYZ9nCa/d0iJJxvlH6U6FY1/0myTb
	 fMxBdXTCeDyKy7jbuo7xa6BblcvQruuMSQDalsO+PEsM48eUDxffW6yis1e/YYz+vb
	 idRfIE9lwQRYCZMKdGvOpn2j/0M7myw5E26neBp5XC++uZa2WBaUjchQpqB1BOyAW0
	 5bmK0f8F8hkWduDR9j6SH6vKtOLMUQj0UbnhucPzUZjTr+y7BA+/Rd/QorKEnlSKMt
	 jC9vWVCmD7qLs1wA5qFADw4xuenlSRj9C+D8vN25Wq6wrIM4PCGTVla8HOxjSUsfVx
	 lsagW5Pf+bY6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 10:58:31 -0400
Message-Id: <20250721145831.849034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072114-domelike-overstuff-fe4f@gregkh>
References: <2025072114-domelike-overstuff-fe4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

[ Upstream commit ef8abc0ba49ce717e6bc4124e88e59982671f3b5 ]

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
[ adapted to individual clock management instead of bulk clock operations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 58683bb672e95..9b7485b84302d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -763,13 +763,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to get clocks\n");
-		goto reset_assert;
+		return ret;
 	}
 
 	qcom->qscratch_base = devm_platform_ioremap_resource(pdev, 0);
@@ -835,8 +835,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -857,8 +855,6 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
-
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 }
-- 
2.39.5



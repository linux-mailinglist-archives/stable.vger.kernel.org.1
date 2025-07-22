Return-Path: <stable+bounces-163651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDFB0D116
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 07:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AA16C4391
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838028A71D;
	Tue, 22 Jul 2025 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej+/9XtI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848A289825
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160666; cv=none; b=h5aWeLonplOzpCvCFF/ucyUjF6pZmRF8qPwXxx5C0fLq/2+7+p4Olt2KH7d2rQMOszNzYc3P+PLcuG0qNiFYfDMbrrzzhMpPWf7UavP9WNrSisLZnJPPq8H0oDLY7Y7/HS3hfI+Is1xwELMZu1lrqRbd/cb5c4QyIcEieU1dR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160666; c=relaxed/simple;
	bh=3BRitzodfXQGDTfzqQwVrgicxPANdq8waa55nM6HW7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAAf6yA1DTF05pF2/isLL4tD/qBxG4fJxnzNVsHi3Fk9WXITYeRlkuobO4QDmdNHbjjXWqBR5fePXk2Tyra0JWgq1owv+kg4IKc8WGdokny22sBg1JdYC5Nr56/jxghMyQTY1OY+Sm5xF5EbyPAHjnuzJUJL0FAOzLH9YLJeALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej+/9XtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD9C4CEEB;
	Tue, 22 Jul 2025 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160666;
	bh=3BRitzodfXQGDTfzqQwVrgicxPANdq8waa55nM6HW7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ej+/9XtInF6n+m5jiH6TKyvweKuEc3vGe6rDb4B4OOfqdP2fKQFrAQ2VOoEcJ5AgS
	 oEoFj5z+8Iz76wrFIc4HkUbl3fOJDCKIpMEkAJMH+iGrULEfDgh4f6QhrLhUuO4WMB
	 I0sWQ6WUM58sJuojtxmdAoB+k5XtoztGjLxES1+u5CeATH+J2BiosDNGJSvi5ogIRJ
	 q3HvHwdvU3N7wFuXSxjHLCHgmjgmr/gYMkqBs86C8t+pmqYlRb4mJCQVvNudlTMVAO
	 ulr5AFc8D45b8WT7hem6xPYjzWAk5xR1lBK/FntYDodMQDiXvwhexwzeFIZ5MPyeIi
	 tdInxA0+KHJUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y v2] usb: dwc3: qcom: Don't leave BCR asserted
Date: Tue, 22 Jul 2025 01:04:21 -0400
Message-Id: <20250722050421.895364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072117-left-ground-e763@gregkh>
References: <2025072117-left-ground-e763@gregkh>
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
[ adapted to individual clock management API instead of bulk clock operations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 742be1e07a01d..8be05c7fc98b8 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -615,13 +615,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err(dev, "failed to get clocks\n");
-		goto reset_assert;
+		return ret;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -700,8 +700,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -725,8 +723,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	}
 	qcom->num_clocks = 0;
 
-	reset_control_assert(qcom->resets);
-
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 
-- 
2.39.5



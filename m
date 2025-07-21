Return-Path: <stable+bounces-163609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D020B0C7D8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4018928D1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA92DECBD;
	Mon, 21 Jul 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkfY4joI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAB170A2B
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112599; cv=none; b=PJvMs/hrTW4aRKt79VBna6tXZq6cPejJKI5gKEx92RlEld+3LHt/7J3bJgSgpLAHfx+un2Vnnh5qNB5JnEpvcHUqsvbBWJgv5nD6L2/NjTJKDKNIdWJTn81Cm1NalCh0GqBRE64wTOIl8UEM+KVRxh9mhwUPA8HHSfK4jG1dPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112599; c=relaxed/simple;
	bh=X4BiQR8jeNJh9hfxi722lTJW5ssYwWOLlOuYG3yso9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjhpxb2fKN3ne5LlegOMAzAkaRtSzbo4UCk22n178+Db7/t4HWXc6CEgg4bYBJ76V70RKHfFmjIXWl6BpAfC8KNC4A0ZB0AZV5b2a7wa308hWXs+Uxqy+FiCp4q3eI3b2Wbrw+DrE7UvW/J3wEgdKU1WdqxbOftKn7Dh6N6pQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkfY4joI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A948C4CEED;
	Mon, 21 Jul 2025 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112598;
	bh=X4BiQR8jeNJh9hfxi722lTJW5ssYwWOLlOuYG3yso9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkfY4joI1V/kH11XRROh2rf1h8AwSzDnYvIoIB0EJTOPHn8YRRTajgklPOGQFkAwD
	 SE1C/j/26YXn3NavMdydW7J7UIULQ/Z0sVuOcUHSkJROQUmCr/lsgoPlokPOwtFiGO
	 Bwfy/cFFInMa69113FBgrassVRUZgLz8pzCqF8gQh+0pO3kqqaWO2oLNnxSKJwkZNp
	 Eod/mIC4p9J96a6HMPyGabT2OHxrJKaQyW/NVa7LoXCfYQyjOGN3ddfOyA4HkMj9oY
	 EfBJOmY7Ln8DvCsncDa+F4sqbYSIM6u/slTyncS2nQ4wtUPlJLPzt/SbDE31Yo6XxR
	 dnTgRUQ6CwLnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:43:14 -0400
Message-Id: <20250721154314.854246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072116-hunger-transpire-c34b@gregkh>
References: <2025072116-hunger-transpire-c34b@gregkh>
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
 drivers/usb/dwc3/dwc3-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 41ca893d2d46f..50b89d9618531 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -791,13 +791,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
@@ -898,8 +898,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -929,7 +927,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
 
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
-- 
2.39.5



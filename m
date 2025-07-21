Return-Path: <stable+bounces-163613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C23B0C815
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6254C544068
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5F2E03ED;
	Mon, 21 Jul 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU0Mwv/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BC2E03EA
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113076; cv=none; b=ge/ZpNZrIQpOJtDOnTRWOaX7mSGqR1ZiXwNmlNij0iqPXv+AjRWaFHGUc2+AUe5vTIwTzEcaXrjsuEnmR5GZC27KD53USX78XJ51Otgo+xHeUpNtrjpJBGI2pTock+6CcWEd5f8Tb/7stsNX5RJ+RkufJUxWbcy6PYBVUWWbGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113076; c=relaxed/simple;
	bh=JJ0vl4lhdUkrm2LZvyCTqeWsGTY6CUvWK0hOkT40xdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXU08YdnYmDDiQigLmcWepP5z0p1wc3hPig9FMO9HILhlQjHL+zUULdOyvVqFjY/CdyHQbaT7OSyZcVz7HZevhSlX/vLH5IZDpYCUsQm2FtJXtmy6WWrJpfD3MC3QGU8qKEBTlGypp3I9W81iQpOGpqsJ237+ae+cy0eRb+uMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU0Mwv/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82786C4CEED;
	Mon, 21 Jul 2025 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113075;
	bh=JJ0vl4lhdUkrm2LZvyCTqeWsGTY6CUvWK0hOkT40xdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU0Mwv/90nzBHKBqL8UhEDcZBSCJDzWcC1a2dimm5rQaYJtYDEzk2Jqto67Ms14Ga
	 2Jg1PJ3DRvgBUXkht4qMlnDvXIcCr90zA34qgrekswoAGDOvV/srDAyGSTJYNFlVmZ
	 ZUSrMDXDjOEDVuCHdW4YvrAurC31lxv/S6hKvWohwItzKqbxzA3+Dt2/NBoH/p28ne
	 nS54BOyX3LkR1oZJIT+W5YzRwOebNQPHygKzuzrqh9ICCWVwTlgFdqnZU1hpyQawAF
	 nO27Pmaxm1HjaA7lPUHGXxTBaIfdBfRrbvp2qjDtAk0rnoBkUfgdif4cLk26BZ/4JQ
	 1fFVzg6BNnb4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:51:09 -0400
Message-Id: <20250721155109.855693-1-sashal@kernel.org>
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
 drivers/usb/dwc3/dwc3-qcom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 742be1e07a01d..4874a6442c806 100644
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
@@ -725,7 +723,7 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	}
 	qcom->num_clocks = 0;
 
-	reset_control_assert(qcom->resets);
+	dwc3_qcom_interconnect_exit(qcom);
 
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
-- 
2.39.5



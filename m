Return-Path: <stable+bounces-163601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D92B0C75C
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF23AC26A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7892D63F9;
	Mon, 21 Jul 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhTy62yM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C02DE213
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111153; cv=none; b=SNCfzGYiftzfSysEoDVO6JL7JDW7Zm6J0HzuTdhdSY4v6/PXio+v7CBxUkGatJuYMwsPOi98spYMRu+RlNda2SrfvsNxbKsmmGGbQnqwi25evIt7DWumOAYGrvJz6XimU1TvODvkH8R4PMcK6Mk6+M1smMvdIhAl8sh+9ZbnnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111153; c=relaxed/simple;
	bh=/ggZ9+lEaXGaL25Nr/vjUQlONNouPk6i8egm346fcW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lne1+KrXrWcYlBrxiQjI5y/AoSkamduzq5PzsOfDa47mKT5nVFMuJYd9lE5RWUoNss7ukzPCJDCm9i4iR9sP3Sxk6iS1e9QSHTXDo3hw5VuNdFf/qtb1D4ppvec8Rr4nrjnFl7LVMC1V6EX+pkO/nGG5LCIJ5NyED67FE+DGckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhTy62yM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD6C4CEED;
	Mon, 21 Jul 2025 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111152;
	bh=/ggZ9+lEaXGaL25Nr/vjUQlONNouPk6i8egm346fcW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhTy62yMRjTEpXxyNuSjWDBIJA0SUSm0CoHEO39Paq5x9WruQri4RSv4diHeor1sc
	 0l+q+lKoI8XZTCo/49Wijb1Aj8AWwgEl/AuWFavwIprezBxKF8XM6/X3dpvfBMhibJ
	 dnnMESXhxg7hPyyUsxmQFMlH8MRQDhKterbSYnpHE3BmQEo1jKpytMAG3hDbPP7g4K
	 tdF2+SD+Z99Mg5pqZ9/Km85TrtY2iqloYj7xkA8DziHnfGUPSr2HL38nDw/mOviYdJ
	 U9j4u5/1Edyo1w2YvLnEL7WHTtx5/F2sqAj4tS+0H4mgIr4DZkOAO/0g+uofB8dz17
	 /wbTur8TikRsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:19:08 -0400
Message-Id: <20250721151908.851581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072115-flyer-refresh-17c6@gregkh>
References: <2025072115-flyer-refresh-17c6@gregkh>
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
index 82544374110b0..add808efb8716 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -854,13 +854,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -964,8 +964,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -995,8 +993,6 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
-
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 }
-- 
2.39.5



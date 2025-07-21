Return-Path: <stable+bounces-163602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB84B0C762
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5451716DD54
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BC2D9ED7;
	Mon, 21 Jul 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avsz4geH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E01C07D9
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111183; cv=none; b=AVpyhtUmKpDQ+LejDOx0OlsHSdBrSSrsTRZ0BJMhY6GVKOTa29YDTATa8iD8no/aZUtkatoof5xi9j8WshDpuMce+JTahwQMBXOLy2NnmCqA4XNT0T4sLtHREI+3E8XEJFAsW5bvhqC3R88g8Ygves6/OQ8LOfAeLUcnAWn6YmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111183; c=relaxed/simple;
	bh=uQ51VaMRwHuronYzdbWtRs7wG2bNVNzuqLuhcos209s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQH4kTNjmpnJo7E0tDXbpkTu9+GdnCkKt7n60XcvEQHRdql0c1CujbKYIWlTXIsoxs4nRz+vgWQaDPWdf1gOaq+i8ZQWk2A84WPAPlatP32Mp8MsftHvoXHJq5DyE/aJP24RtZ5R79uPfpf1OuO7TvLI0byDeswtIBRuTkVyMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avsz4geH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76442C4CEED;
	Mon, 21 Jul 2025 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111182;
	bh=uQ51VaMRwHuronYzdbWtRs7wG2bNVNzuqLuhcos209s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Avsz4geHhpC1mAxXmLPRG8NdgGAN/5zS6qJtDptyM+GDIE7DTgOBYLzDS/NtzkR1t
	 FoddoUYTwXDqndmbjyxg2x5kte3lyp0sjuDjQuNjkRBN5SYak00EScdHX5LnuuhxyK
	 ljcr1MR29FN2+zhgi210jz0gUP3AnOuUKvjovRhEYKWXPiV1Cxo10y4+5mhuFnkhlJ
	 rZ5TKSuNQ2A8zDRIff9bJ9vq8aswrGL3k4nqYyDGmuS0fFYGNGd8kttF0pKZsoxKTY
	 4ZDCPOFlmSiGyTts/ccmAcyjoK+/PMPaTreKluCCpxq2z3Z0KwjCZm5wZGE53KmCUE
	 gFCp6QhhAyV0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:19:38 -0400
Message-Id: <20250721151938.851670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072115-flap-plenty-751e@gregkh>
References: <2025072115-flap-plenty-751e@gregkh>
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
index c1d4b52f25b06..6c79303891d11 100644
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



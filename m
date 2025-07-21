Return-Path: <stable+bounces-163612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB95B0C806
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE373AF90A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12812DEA67;
	Mon, 21 Jul 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwPcqFtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151D26ACC
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112996; cv=none; b=lYEw0G2QLZg67+CWDDDtGUDnquq3E+X3mJrAvAze3q667FHBdxCX4jZemUW+B2FE2DEYJ07+5RZ6cMoOlNmQ0Re9P5Yu9ZqSb98Fao0ywrpcjIeDeitTV95yYymAVqkLrllO8KipaqsNTztNoe9bbdaGkb5YV4mXohHbloEJElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112996; c=relaxed/simple;
	bh=iItfR/dIrxV/ZSC2n9Gxta0VoNvfkqKgor/emQXJ4HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQpxN76rxNp1mncf7GwlP+YjeZTWRAgJQ2Q4cjNmgzly2U+Ii+J6/VAFdkSI9fqQcNypGIY6gIefEjLdGr+Z1x9wGZfIiUYU9sWdoZLHXv5Kt7f+jU+gclRD5Y/Hh1GerX67UN9p0119YyJMJ9JDkc6JndRTp9wIo+iXLPRn1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwPcqFtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F82C4CEED;
	Mon, 21 Jul 2025 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112995;
	bh=iItfR/dIrxV/ZSC2n9Gxta0VoNvfkqKgor/emQXJ4HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwPcqFtY+yoOHvMUjjoRwgXOuTcRMGX+rLOdzSYB4qCMmumI+jfHwpRiNMytboLei
	 WVnb9ULYLT1bpE34OqIScfpv/2RCIB5v9ynI1IveAcVcsjCiY+OFqDZfIuh1rixkXe
	 N2ELXTqCwP1eXfjBj6B8XH2R6OXVJBF0Gzr8ikIdnBbLyKADsXon1f/WrmqLNNCGgZ
	 1J4GtqttywAK1+OIS92DXPuhB1JAjdLEQ6A/TjojKY7WBIU7IMb5lktPRAhb5EGbYo
	 KOoTKuKrL36XJI0hAQysLBR+OvtBiRwSxDq9V7OEjJkIKnlUMpfw7GXFx+BmXp2wJM
	 pcoasmNWMlueA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:49:51 -0400
Message-Id: <20250721154951.855475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072117-tribesman-staleness-fcd2@gregkh>
References: <2025072117-tribesman-staleness-fcd2@gregkh>
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
index db3559a102077..d013d774edc13 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -786,13 +786,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
@@ -892,8 +892,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -921,7 +919,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
 
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
-- 
2.39.5



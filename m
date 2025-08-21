Return-Path: <stable+bounces-172200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEBB30087
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E617D0F5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193642E5432;
	Thu, 21 Aug 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7nryzDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33E2E5415
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795140; cv=none; b=iBV1U8Sk50y6uMmDwWfeOGSMd/jzObsq9QPJ6QbojpUIE1yl+UA+lefvBJ53ogXQrpNGDIZYbNWwOJ0apnxhfoloPxG6b0EppHyZTND3mce3vBf8rDg9N2SZnm+fyrWGsEsqzwOqZEj+RreCQqwjDsnoA9sahxq6qipDTScpMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795140; c=relaxed/simple;
	bh=rhHwTyZOIXw2UWGrCY1k6JiQ/4f6/OjeyWB+dbJTnWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBcHQ+FYcMbDEbUYrDFbxIvJ17YIZqAqoHOwnhIFvrvNOtSLuuKWnZWyVXOGQlRMxomKRCSJMKnimDBTssbuIHehoU5Aph/ZL0gWBDjHwTRO/mqNk6CvBlc7nMx0FpP3osL/dMRryzhw0lP3MZFTYmOudzA5eMhy2x29IexW/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7nryzDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA8CC4CEEB;
	Thu, 21 Aug 2025 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755795140;
	bh=rhHwTyZOIXw2UWGrCY1k6JiQ/4f6/OjeyWB+dbJTnWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7nryzDxCugVq/nR/LUukgK/2QaQs3LTJmR9zgGmAid7Cp6wPd1oTwVrDKg3YijmU
	 n82Mc1yA/WVtt4zu9vqGBJZTO0TQ7jjRnUIq1DAFfs5g3nTFB/z8eWlNASc3R7Z4nQ
	 lzi5530WUXJO0lz4oSKF8+26kXqomvsEFmvGtGS3OhfbWGrUudUJr9+rzsmM5I+XaO
	 kxdwF1H/7EPehV4GE/csCsuy/uwb7k0s7J5qL42srI+0iYaWavVA42MmcioxGBToij
	 BXnS9L0/wUcKKaJis/ISBFASCn9232Y3bgZTj91vkzM25n+c+UjbVw7/OyeEuJPeVT
	 OqUl8eui024sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Li Jun <jun.li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: dwc3: imx8mp: fix device leak at unbind
Date: Thu, 21 Aug 2025 12:52:17 -0400
Message-ID: <20250821165217.842711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082120-levitator-quarry-cce6@gregkh>
References: <2025082120-levitator-quarry-cce6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 086a0e516f7b3844e6328a5c69e2708b66b0ce18 ]

Make sure to drop the reference to the dwc3 device taken by
of_find_device_by_node() on probe errors and on driver unbind.

Fixes: 6dd2565989b4 ("usb: dwc3: add imx8mp dwc3 glue layer driver")
Cc: stable@vger.kernel.org	# 5.12
Cc: Li Jun <jun.li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 174f07614318..d721f45cec9a 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -243,7 +243,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -251,6 +251,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 err_node_put:
@@ -271,6 +273,8 @@ static int dwc3_imx8mp_remove(struct platform_device *pdev)
 	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 
-- 
2.50.1



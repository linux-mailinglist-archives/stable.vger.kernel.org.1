Return-Path: <stable+bounces-172104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB72B2FAD6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12051BC1C82
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE82DF702;
	Thu, 21 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUt3V6g/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C02EDD7D
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783167; cv=none; b=eYQJUIsUNAOJm4z9Ye2CQ9A7ONETSbi9w/mdQZaaY4+9bCtjFDF5Td1Mg5yWFy41nPNvcmiznDf0Xo8x4CD09GdKozIUGEG9jCPRXtxADM3EQisj3G1d5+hSpk1yVDbaWZ6v3Xkx8TpLCOp+JEG/kqpRIY3JsoGSCEr832V4CcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783167; c=relaxed/simple;
	bh=9tv8nktA2XSp56ndwwKTr7zkSL2n0KHFLFNp5YRYwAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6YLNtOXxnD+UAbffcohq2Pj3o0KOucctN3yKV5T5oB+9y8NDv3UAEXyEVOR/ia58kAzEUZXDBPXCpMgX2w6vRFNjcrpIwLdn/N4cjSlRiBbBKulEx/xYtRmIz3BSqG2a0+QupaIf+HocgDGD6xRMlhMnjbtybK3bi58B1pFKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUt3V6g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D6CC113CF;
	Thu, 21 Aug 2025 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755783167;
	bh=9tv8nktA2XSp56ndwwKTr7zkSL2n0KHFLFNp5YRYwAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUt3V6g/geTCdo1Q2uHhgUiwvtaHJVdf1X9/e+tJiZ8fRfCKyU11RHTXSmXjQkGe5
	 rLggFoADkfuat3qcR3eHgQZ2qKDyqYCii5ghr7IQX5i9lfuiqxhu/cV3euoHaWht8g
	 F5H5lDU4ecMS1CgP+nimj9MBbNNBAuKg5hUqOUkXeMxW9xqimAviG/HkeyuKqzTqpn
	 cf1qsR18UhVqkhEE5RfKvLbA8qNmcM0Skb6RVkBAaUl12lOVWn4GRHji8D+rOaTxm4
	 I8BPjZn+xcNA3zjuHkkQvmCtTcJMfUHiSkp2tFaK4T+K+RxVekH8kIXNj2py+BCbhl
	 wBRtMGqeh91CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: musb: omap2430: fix device leak at unbind
Date: Thu, 21 Aug 2025 09:32:43 -0400
Message-ID: <20250821133244.715359-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821133244.715359-1-sashal@kernel.org>
References: <2025082154-deferred-sneak-f740@gregkh>
 <20250821133244.715359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1473e9e7679bd4f5a62d1abccae894fb86de280f ]

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b9ab0c48e2ee..b4dd0747aee1 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	if (populate_irqs) {
@@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_control_otghs;
 		}
 
 		musb_res[i].start = res->start;
@@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
 		ret = platform_device_add_resources(musb, musb_res, i);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add IRQ resources\n");
-			goto err2;
+			goto err_put_control_otghs;
 		}
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.1



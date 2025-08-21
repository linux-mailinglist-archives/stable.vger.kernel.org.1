Return-Path: <stable+bounces-172194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D3B30010
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAA16E272
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916E2DE6E9;
	Thu, 21 Aug 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiF8Jwzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E692DD5E0
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793705; cv=none; b=t1nG2RbnzLniLXsGTYMmrV6powdIW0N+hB4fahaGEeGNTkdBmPgQONUj3IwapuR9lPvUEzNXHALSmKgBs+ucg/1TSaa6uKFdfVPOei/KML66qSoeVi9DYbBLpmFn59bYBSicrwYAYGGxkgwJ0BFyyJKDMBy/by+VZIncRHot4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793705; c=relaxed/simple;
	bh=+mmnfF1Czx2PVnVFHxz5ST3FBgBISaaZC7KAmGdkSb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNXiz7QkKlYaGuCviEhm4E+tUmJ9g/WbJ8SiomWD8oEQhYtl/Piw2VBhaJ7+hwUFZsv18iE/2clY6nd3ETx8HzS/tR2GtelHbK1Po7gNGhIspLAwOejek2Bdm8TGIbqGCIjVfJAjKuwwxDiFzfHMucg0rQ9KuGjcsArTYlDgGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiF8Jwzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3119C4CEEB;
	Thu, 21 Aug 2025 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793704;
	bh=+mmnfF1Czx2PVnVFHxz5ST3FBgBISaaZC7KAmGdkSb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiF8JwzviwWLcCDVzX5FqypkfOL5FQ00iyumZFaijIlZZxqzW+S7/sZyg81nNLNTj
	 YCrzd9gHsyvm59sO/i14pA4XHEGgbaHEAtcXHZIPv4JzJsD8W17fhlsHhzanL+xYLa
	 yeTdrVk+aXLbn6UJofOWyMYLREnO482S7RODOxbkOxquY/xXuk+8yM4hVC5hqNIZn0
	 o/jGe1ronKrPn+X4DTGYCglMUvANH0UeZ8ikd/BBMEeF+IfqfKIIx/LTRV+kHnlENk
	 FTq9JMj3G4ULG+YvMr6S6OJntC3hRoRC/bzITlCOG18z5CkoSZmZVUralvsSse6OU5
	 jhIYQtPTvxSaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Li Jun <jun.li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: dwc3: imx8mp: fix device leak at unbind
Date: Thu, 21 Aug 2025 12:28:22 -0400
Message-ID: <20250821162822.805636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082120-canteen-quickly-68c4@gregkh>
References: <2025082120-canteen-quickly-68c4@gregkh>
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
index a1e15f2fffdb..b53468c41f67 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -244,7 +244,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -252,6 +252,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 err_node_put:
@@ -272,6 +274,8 @@ static void dwc3_imx8mp_remove(struct platform_device *pdev)
 	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 
-- 
2.50.1



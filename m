Return-Path: <stable+bounces-164576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C00B10596
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C367017B350
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F913C8FF;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS08fcVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91718786A;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=K/iZ9Eyc5JV2mAgG1QG1yMiMQUCE8sHi4cTN4N5uFhr6jrC/C2XsOiw8lo/XQV3h6Lj4ri1R1UMyvNjdNAu2Bje1zQlqPpNElJtu6Pj/iS2CjmNG6XkCF5KTV6hHnrBzqkrFha7h7fJMeC13OvVzv9ojAfAU0niFZt1s1TDPCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=3sNEf2PDs0kL++sdmukPL9G4RGohNY9yUFg9AVXHkAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFzQtjYS2bhfypt/dviGSK+Ke7ECuZj8uSr4QHz/2ZvXO6azultFXTfN6ye7N5Oj+aFnAX9fw+2Q+x2zsSMCctJJ7v721nkNMbwSxbqMDQQYSqo+ke/HZhzLQ8CrxTr+G/dYGPfH6wAsZIBE2OMStLEzRFjBlZ7K4dOyiWsfDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS08fcVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E3C4CEF5;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348770;
	bh=3sNEf2PDs0kL++sdmukPL9G4RGohNY9yUFg9AVXHkAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS08fcVxGx1Ibg9N9flueoBZGpeBYs85Sc0dRYV0NBhocrBE2CADmMcqQD+7S03mx
	 EOyiAwCaJJPtJqcjOJ4/rEMom4tm7PsiBYgTO9kzODBKyYJ/Asc1q8tViQ/mB8AsP+
	 5caCNcr9R3XISWKd7DtxfxQnwRIIgT7Z+ibkSNMiMUONtydDmFryuL4xY62td8QS6c
	 KFRJS8JVT1aRx8gHjK1/uhq1vFcnTDQg9zaz2/enXkc7nRa9UOrE/d184uDfL+fKnr
	 sm2Z2Bvw1iLimSrifgLauYkgAECurdKjUulhc3W1VEVa8JDbT7lKNdat6yWygVqKej
	 9g+qayZ6X9i/Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6n-000000005Uv-2kta;
	Thu, 24 Jul 2025 11:19:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Li Jun <jun.li@nxp.com>
Subject: [PATCH 1/5] usb: dwc3: imx8mp: fix device leak at unbind
Date: Thu, 24 Jul 2025 11:19:06 +0200
Message-ID: <20250724091910.21092-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724091910.21092-1-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the dwc3 device taken by
of_find_device_by_node() on probe errors and on driver unbind.

Fixes: 6dd2565989b4 ("usb: dwc3: add imx8mp dwc3 glue layer driver")
Cc: stable@vger.kernel.org	# 5.12
Cc: Li Jun <jun.li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 3edc5aca76f9..bce6af82f54c 100644
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
 remove_swnode:
@@ -265,8 +267,11 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 static void dwc3_imx8mp_remove(struct platform_device *pdev)
 {
+	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 	device_remove_software_node(dev);
-- 
2.49.1



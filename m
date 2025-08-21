Return-Path: <stable+bounces-172207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F9B30189
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE95A1CC31FF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E83376AE;
	Thu, 21 Aug 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQNpFhM9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE82D63E1
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798914; cv=none; b=H0ylQJ/s6kaZ98BW7+jnPDqigZnPnlYNI6zxUC2eTVk2GowctsZKqkls42ckr9+dyd4eyzN3qcI9AcIVbxxWACU5+vnswAzt5SpueF2GodsCuYmDswiFJxLz1UQtbc70ghydM+t3V0hfZQB6Gk1zppx+vN7WNgSQp4SDqZEetJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798914; c=relaxed/simple;
	bh=IwZWan2BCDEgjjdDFOvgLN9M3CWVlSPdN7xkglfu7EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOgGKg5C/UOwSV7YRe20HAZEEbxCTJHyaXkW9KasSMAgDaEfXRybFReqRRmYLLkzQupkq53Sf5J/2GNMQk5lCgm8FqRK5gu6bSzjQQoQ72cnZGZxy849mYXI5Yider7oEBUowZW3zYBrPEInMRWB6Z278AHNMobOqjjhpYwIrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQNpFhM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1593C4CEEB;
	Thu, 21 Aug 2025 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755798914;
	bh=IwZWan2BCDEgjjdDFOvgLN9M3CWVlSPdN7xkglfu7EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQNpFhM9vKlqxWXZwXGsPZ/v95qni5SWS/Ss4DPIMskmzBMp8e7DxPi0G6wfEg8xJ
	 scxjd1xKwVYXBNvY4yLdTK+lLfLlpyoPsQJiOc+CXDkMTEy49lv0vFjR1/WzHvQO2j
	 VCeC8PnEKZSIXYbYyeSI06izYRMTWaiem3cMbRLcblE+wXTUpad7m9qO4CLt+ehW6z
	 vLT7quu3hyvIcI0LcpAcyksDkDbComGT4jx4h2Cd7GiBHo0YTpRLef2Rxqs+Fcc3ky
	 Zt+xfUjb49RUVgxm938KxdClbWG8K3t/H5K3CyEder0XR5/2MkR9+9eMeVzhDLGAYv
	 TxoHnwALAMRQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Li Jun <jun.li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: imx8mp: fix device leak at unbind
Date: Thu, 21 Aug 2025 13:55:11 -0400
Message-ID: <20250821175511.873013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082121-magician-conceal-4df0@gregkh>
References: <2025082121-magician-conceal-4df0@gregkh>
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
index d328d20abfbc..3443b3737eb0 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -183,7 +183,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -191,6 +191,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 err_node_put:
@@ -211,6 +213,8 @@ static int dwc3_imx8mp_remove(struct platform_device *pdev)
 	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 
-- 
2.50.1



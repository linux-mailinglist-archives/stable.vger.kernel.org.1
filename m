Return-Path: <stable+bounces-121585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C46A586A5
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B541671B8
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5911F4C86;
	Sun,  9 Mar 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EU2LlHVf"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77A1EF360;
	Sun,  9 Mar 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543111; cv=none; b=FzUbuo5gLokeTQBx/TCoyWT7L6lE6tX4bcRiMv861NDof5mD8uIs1lUu1PGxeUjSvwxIQBkmnxkTrAq61xLUSxL4ibQDT0A9elDq8vZh9BgfjVxSHrZh1hD/UdgyUcBVk6aRd3yI7By+9aLBXP1TQj4eDjFYKEco1RChg4WtZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543111; c=relaxed/simple;
	bh=06wf01TsmmpRes+UvWw6uQMyFGml7XZZArYvq8jmXho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkazEszLVhOlChO6epJMxeHo0SPpVUVVT+so/ZXTv3bqjMA/RYAIMZ0O1c8SYuVYZvfyA7MxzAdz34xTGL/qcHB0zIkfRuALNM8RvlzScUxLkgIPy7tdwRFA7znESlwUwK8MbqcAOo3ZLhtujqRNOvTE6yYWjj0lN1bfhiLIn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EU2LlHVf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2F51F40737B5;
	Sun,  9 Mar 2025 17:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F51F40737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741543102;
	bh=6xAcFWQMf/3kpz8hZodjQsek1OR4yEQXvAw17qmj90Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EU2LlHVfLgHvwfGvs7O7sFpiCmJalp1HkLqW04BxWO/Hlw6/fN0m60rk1SVm0NdU5
	 ckARJkC89MD2pv7OJarVGcoEsxJNbuobjDcfTXb8hyCxC+LuWwvysFPAN/SrOZnZVk
	 d4diBZDvzpf9bAmZErO3Kqflnt+opBalYsozDsic=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Peter Chen <peter.chen@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling
Date: Sun,  9 Mar 2025 20:57:59 +0300
Message-ID: <20250309175805.661684-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309175805.661684-1-pchelkin@ispras.ru>
References: <20250309175805.661684-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_phy_init() may return an error code if e.g. its implementation fails
to prepare/enable some clocks. Detect this early. Trying to disable it
later on driver removal would result in a WARNING splat.

And properly rollback on probe error path by calling the counterpart
usb_phy_shutdown().

Found by Linux Verification Center (linuxtesting.org).

Fixes: be9cae2479f4 ("usb: chipidea: imx: Fix ULPI on imx53")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 3f11ae071c7f..720b998376b9 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -470,7 +470,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -479,7 +483,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -488,7 +492,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
 		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	if (data->usbmisc_data) {
@@ -522,6 +526,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	clk_disable_unprepare(data->clk_wakeup);
 err_wakeup_clk:
-- 
2.48.1



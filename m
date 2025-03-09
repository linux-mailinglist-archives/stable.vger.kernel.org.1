Return-Path: <stable+bounces-121584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB472A586A3
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4451887B84
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CC1EB5FF;
	Sun,  9 Mar 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Qk5TaXam"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709061F0981;
	Sun,  9 Mar 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543110; cv=none; b=qa8/yo4vq/s+gjXV4Rx6VY83QfCBGTtiufCKZjwwYTcAMocqnTPSLggtsm+PNhHl0GpaxFsyvhV8XbnNGoK2C9AYUDdvB2FA+CS+IJWVWYwMxLSzmzk9YjFHoWt98wMUUtUdvykXxFqbDxpIyqZK4seZb55yB+ShNhF+kFpXuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543110; c=relaxed/simple;
	bh=IoZRDSWclLoY0c9HHHU0rFNnEogfw3ECDrvyX7T0Ctw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/oRBLPyPOX+qsJM5YL8j2zj6Isat/9sBw1uuParlfS4+IDbBpM+owo6CBv7d+/5TELy802w2C00Jgzm7h1MefD6uNe4qBrm8TnV200uNAib+vJtlJvEVcj0rulspejct5o3UP/5nEHQRry2jC1cCz8PfYc8l2Wj1Fymo0kY0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Qk5TaXam; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id A693540CE19F;
	Sun,  9 Mar 2025 17:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A693540CE19F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741543100;
	bh=XnT7h38wk2Tx5Bqn00SrYumy1xtf5pPAUEWMtYlgi4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qk5TaXam7vZF3GgpvkRfqvLbrNaaBXTYxwQ2PnwjMxP0NxZcixpuFHZYuV/384Q67
	 XphwSpNWgRDrkbxhvL3udAcIWhSCnDIbJTZjUIBRkixDEPNmBkYCij3qgn5Au7BD71
	 akkY0I+ZIlwqkUB2zWFjhMxJ+OizZ4ckjvcUP5ZE=
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
Subject: [PATCH 1/3] usb: chipidea: ci_hdrc_imx: fix usbmisc handling
Date: Sun,  9 Mar 2025 20:57:57 +0300
Message-ID: <20250309175805.661684-2-pchelkin@ispras.ru>
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

usbmisc is an optional device property so it is totally valid for the
corresponding data->usbmisc_data to have a NULL value.

Check that before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 74adad500346 ("usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 1a7fc638213e..619779eef333 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -534,7 +534,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -559,7 +560,8 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
 		if (data->hsic_pad_regulator)
 			regulator_disable(data->hsic_pad_regulator);
 	}
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
-- 
2.48.1



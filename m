Return-Path: <stable+bounces-121586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B31A586AC
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB80F167307
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019F1F874A;
	Sun,  9 Mar 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Y7rEUn8u"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F41F0985;
	Sun,  9 Mar 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543112; cv=none; b=qC+9rPDpqFzrW4EYxn4pHdFCHSbPKqp2gGiwMkHucy82Maq6FCifGS2/6PBxj7jSHJIrRpfXTrOPsSNB71dPQiSx73PSdsu8gnZ5uEHX+6VfrfaIp5h+qmu0xGTRK5jdHmvNw21O5jhUdr2ZI6BnPJGVCEsUilvEvYb29v3SqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543112; c=relaxed/simple;
	bh=buwG0JNAqxmhy71yWmRSifh1WyssX4NtI11ieeR6OCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcWQe1fGPc7j55ZJXvBRroZT57LzN1sskksJB7c3XLe7kE01g6St6J02Qh2FhCairdNypSkmSHYfQEpiLkNlchhbue7hOPLPFdWB05xHchgcHC4PeyYDwfHtX+CGvoNuGmJUNe1fpPvc/R63FZU3aPO5KdIFXMZeq5wFNgs14LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Y7rEUn8u; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id 83D3140CE1B9;
	Sun,  9 Mar 2025 17:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 83D3140CE1B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741543101;
	bh=Tjb3sdTt+sV+fmJ3kLauDsvPMMI/JK6LCRHEJH7ZeKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7rEUn8ua3iAhXsU2TcVOuAZo0VdZ6PwteD4r69ZofP1rIcnfjN0wtvBoVuAyOFDu
	 bRH9Hr9CQwRDe+HcFKSSVmXIHwGf+S7Z6MSIhu2rfrqVLiMvwQ9eVeuLOmTDRBl++x
	 h1F5f7KRg6MUexg6ehWIYe5J2nquIJNo4SjLJbQU=
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
Subject: [PATCH 2/3] usb: chipidea: ci_hdrc_imx: disable regulator on error path in probe
Date: Sun,  9 Mar 2025 20:57:58 +0300
Message-ID: <20250309175805.661684-3-pchelkin@ispras.ru>
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

Upon encountering errors during the HSIC pinctrl handling section the
regulator should be disabled.

After the above-stated changes it is possible to jump onto
"disable_hsic_regulator" label without having added the CPU latency QoS
request previously. This would result in cpu_latency_qos_remove_request()
yielding a WARNING.

So rearrange the error handling path to follow the reverse order of
different probing phases.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4d6141288c33 ("usb: chipidea: imx: pinctrl for HSIC is optional")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 619779eef333..3f11ae071c7f 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -407,13 +407,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				"pinctrl_hsic_idle lookup failed, err=%ld\n",
 					PTR_ERR(pinctrl_hsic_idle));
 			ret = PTR_ERR(pinctrl_hsic_idle);
-			goto err_put;
+			goto disable_hsic_regulator;
 		}
 
 		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
 		if (ret) {
 			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
-			goto err_put;
+			goto disable_hsic_regulator;
 		}
 
 		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
@@ -423,7 +423,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				"pinctrl_hsic_active lookup failed, err=%ld\n",
 					PTR_ERR(data->pinctrl_hsic_active));
 			ret = PTR_ERR(data->pinctrl_hsic_active);
-			goto err_put;
+			goto disable_hsic_regulator;
 		}
 	}
 
@@ -432,11 +432,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	ret = imx_get_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = imx_prepare_enable_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = clk_prepare_enable(data->clk_wakeup);
 	if (ret)
@@ -526,12 +526,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	clk_disable_unprepare(data->clk_wakeup);
 err_wakeup_clk:
 	imx_disable_unprepare_clks(dev);
+qos_remove_request:
+	if (pdata.flags & CI_HDRC_PMQOS)
+		cpu_latency_qos_remove_request(&data->pm_qos_req);
 disable_hsic_regulator:
 	if (data->hsic_pad_regulator)
 		/* don't overwrite original ret (cf. EPROBE_DEFER) */
 		regulator_disable(data->hsic_pad_regulator);
-	if (pdata.flags & CI_HDRC_PMQOS)
-		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
 	if (data->usbmisc_data)
-- 
2.48.1



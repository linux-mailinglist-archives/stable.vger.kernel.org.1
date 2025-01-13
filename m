Return-Path: <stable+bounces-108404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E919A0B47B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D823164C83
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2319235C12;
	Mon, 13 Jan 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqZef/MC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DE21ADBE
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763872; cv=none; b=nxgb137K+WzU6gkOOJjoSS3trgpHhmZvpTrwRyoy1kFPxFMUP8rngLi3DYzt/fUu//E0KPPgBVUR0UclZGWRxVP/K/cEl9w/TD8H0zzPzPC9jwgcCmltJ2QmKsclx5bwlgTa5ifWswVJYQMy2xNI1IfrTD0KpHUZJfDdASnFMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763872; c=relaxed/simple;
	bh=lllTFKvmdVQKUSYIiIgGih1eywt3gUhfS/tS2Uvs0eM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Go+t9USgxpItxaB+T82x+bGs7dx1B1aRWXcwvvo/jtPl25OIF2tMgGO/jThwI2rUTAhwMqNpcqKsfTtu56J6FoG3CHuPhYcQyMfJksDlWhaFFyMERUoOejGj8H6uoH/0uXWzQ1tXYE+oEMh2OTwofZ969V5Q0iLwDUjgCQvw194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqZef/MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C25DC4CED6;
	Mon, 13 Jan 2025 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763871;
	bh=lllTFKvmdVQKUSYIiIgGih1eywt3gUhfS/tS2Uvs0eM=;
	h=Subject:To:Cc:From:Date:From;
	b=TqZef/MCjt+SIeCMzSufxUqECl5R/+3vROZA323r99ODozvjhCdynROplMq/Y2VTz
	 c0nTCtRSsI+S+Zkt35QRi5izLwDVncBLR5bFs5Mc5NHZ8eonTrPYdD/vSZHzORhc3/
	 wbPb0ZjU1LvOYS24ic1krcxtqEyv6F57gh2L/KSo=
Subject: FAILED: patch "[PATCH] usb: chipidea: ci_hdrc_imx: decrement device's refcount in" failed to apply to 5.15-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:24:16 +0100
Message-ID: <2025011316-turbulent-jawed-ce2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 74adad500346fb07d69af2c79acbff4adb061134
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011316-turbulent-jawed-ce2c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74adad500346fb07d69af2c79acbff4adb061134 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 16 Dec 2024 10:55:39 +0900
Subject: [PATCH] usb: chipidea: ci_hdrc_imx: decrement device's refcount in
 .remove() and in the error path of .probe()

Current implementation of ci_hdrc_imx_driver does not decrement the
refcount of the device obtained in usbmisc_get_init_data(). Add a
put_device() call in .remove() and in .probe() before returning an
error.

This bug was found by an experimental static analysis tool that I am
developing.

Cc: stable <stable@kernel.org>
Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20241216015539.352579-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f2801700be8e..1a7fc638213e 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -370,25 +370,29 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		data->pinctrl = devm_pinctrl_get(dev);
 		if (PTR_ERR(data->pinctrl) == -ENODEV)
 			data->pinctrl = NULL;
-		else if (IS_ERR(data->pinctrl))
-			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
+		else if (IS_ERR(data->pinctrl)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->pinctrl),
 					     "pinctrl get failed\n");
+			goto err_put;
+		}
 
 		data->hsic_pad_regulator =
 				devm_regulator_get_optional(dev, "hsic");
 		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
 			/* no pad regulator is needed */
 			data->hsic_pad_regulator = NULL;
-		} else if (IS_ERR(data->hsic_pad_regulator))
-			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
+		} else if (IS_ERR(data->hsic_pad_regulator)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
 					     "Get HSIC pad regulator error\n");
+			goto err_put;
+		}
 
 		if (data->hsic_pad_regulator) {
 			ret = regulator_enable(data->hsic_pad_regulator);
 			if (ret) {
 				dev_err(dev,
 					"Failed to enable HSIC pad regulator\n");
-				return ret;
+				goto err_put;
 			}
 		}
 	}
@@ -402,13 +406,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"pinctrl_hsic_idle lookup failed, err=%ld\n",
 					PTR_ERR(pinctrl_hsic_idle));
-			return PTR_ERR(pinctrl_hsic_idle);
+			ret = PTR_ERR(pinctrl_hsic_idle);
+			goto err_put;
 		}
 
 		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
 		if (ret) {
 			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
-			return ret;
+			goto err_put;
 		}
 
 		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
@@ -417,7 +422,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"pinctrl_hsic_active lookup failed, err=%ld\n",
 					PTR_ERR(data->pinctrl_hsic_active));
-			return PTR_ERR(data->pinctrl_hsic_active);
+			ret = PTR_ERR(data->pinctrl_hsic_active);
+			goto err_put;
 		}
 	}
 
@@ -527,6 +533,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (pdata.flags & CI_HDRC_PMQOS)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
+err_put:
+	put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -551,6 +559,7 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
 		if (data->hsic_pad_regulator)
 			regulator_disable(data->hsic_pad_regulator);
 	}
+	put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)



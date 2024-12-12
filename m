Return-Path: <stable+bounces-100873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E09EE367
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE21634AA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B1153800;
	Thu, 12 Dec 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="cztbVQQA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AD1E9B27
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996995; cv=none; b=Xk01XmtcOEaMcDM6krekS1Nd64iaozeDFAZchRUGQpV4jrUlt+D06AEc1rTTFOtXVEhD/PRmZW6WSGNi97aBgvTQmGWhlMqf1AG4JTZ0zSKADLt5COhllpckzJLd97Ob091009VIg6cxYGxNjSAsrxfL3Pg+N3Ivt55/+s7BYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996995; c=relaxed/simple;
	bh=s81qkoUSIoACM58iDiCwAec13spS5htj6r4Sfr88sQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IA+RKT5UDR6gqTDDbjR/gQQktguUO3FtFMFiCVgH0u9kNNeCr19x3mVlehku5PBxe/G1vt1TC8By8/90JjPk4dWksISdzOypmKgRNDbN/urMUHDGrFzeekg4iktwnbRpeTWvrkRv1tYpw+WjA+OQTlQL99wsG8IBw3nDjJOF+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=cztbVQQA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so333783a12.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 01:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733996992; x=1734601792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx/0fdgxjKDGAMHYgncy5mU2Vm1CuDbaOYTtTgjXVXI=;
        b=cztbVQQASad10KpVSGJMC743oj/LrUvDhfLRiGZnMxwt5amIZvkEKT92PO5WSETGdj
         7lTJod6zCi1iGBZ6Z6MI0x4RP1So4GBxkdhcwvwPRPmoBp+PJLtzEUwcmmyLESeXO+3A
         KfgwoVwcXsF/V5YieO8EQhJY+/FsSEzWql5Lyac/m5tLHkeo+dRMzyMiO/KCOGCv67y3
         GZN9TGXDw9AgFfqeJbMtn5EOq/39zzyiv/uGKEVy7TXOJEhvEfWHhBYFyk33qNxAu91B
         U6eHepa990YKIvniuugKSGw0JU+xQYoyv1iqorqXVmMph/MjXM88vMfzf0vbgDCMjjb4
         bdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996992; x=1734601792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx/0fdgxjKDGAMHYgncy5mU2Vm1CuDbaOYTtTgjXVXI=;
        b=pid8d2/jKtTSOB9Adm5ew6A3atSVMcJKbc56XJd+XQsW3/ilIIJk4gbzBofblsJbLU
         GIhxSsLNQd9ZnMCwb8+mw0Nh93E57rWkzrqzfyiWmAJO4JUqScC1pQgPaPYfLbc35yYW
         D7cOEtFr+S5LwKLgkedcLwzFidGzQ9Ldl5xHtdVFNdghECfR6fosqLjVoKXgSMZ9Dw97
         OEI5+DSDIq+g8MSbgKGE8S1xFqp/RIMPUAFBGzzADaLm1KVGD4W2UTNIdr/2DomYs2c8
         k+FaIve7UjXUQE5EuSRQZfNNodw6FkIBgteI4h1m4PB9hWp63l6X639EYCFih3fGLvzi
         hPcw==
X-Forwarded-Encrypted: i=1; AJvYcCWlC0z1W1K0JjxLxdCJYimsF9Xt5YVCckqU2hqunDo37TTZdalfRPwZ/V3TBlOID1+oKkvWwek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcmnu2zfKMxjLNQgNmVHLTWHdXKUM9gE8/QS5OZfTDyUC5AJD
	DTvviZ3ptmpIWGGZ9YqTofgS+fAOCJdw3JBfZxmpEfglOMZZyhQdzMsbTvNd9W8=
X-Gm-Gg: ASbGnctyTE9a7KyeLCPbjyoy79m5nUb2F3sOk5zYeFUIW7qxTNOGa2VkI5h8gOc6054
	/UYozB8WPlzCssLueBZHWyiyKIbXid5WmeFE05/6nRKrggLfLdc4aX/JIIMfMi2c0QouYr3GzXR
	YxG6BaRfhExHoqrxzWNRge8qln4+dw01737XKBLjLu+LBxNltl/LvAOxuADxcA2QYwCYtXMbro2
	p6Koa3uSyoCp2VApcrZf66EfG7y4Q37qL4mdfMGDfEOTAqA3G7DJhAXG18CcllWr+VXXAhZP5dY
	FiwdRxOsgClEvEU3OSircpnPqbo6OYWqWb8GlOHBFiQ=
X-Google-Smtp-Source: AGHT+IG3Iz5dRJ5sBcw7SXyRAd9ifotl+/tTrmFy4GLzX26DqsnCMCjd/ftOnykjadUym1K0y6Yrlg==
X-Received: by 2002:a05:6a21:e92:b0:1db:eff0:6ae7 with SMTP id adf61e73a8af0-1e1cec0abb8mr4140267637.33.1733996992166;
        Thu, 12 Dec 2024 01:49:52 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725dc0bb650sm8713034b3a.101.2024.12.12.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:49:51 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.chen@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH] usb: chipidea: ci_hdrc_imx: decrement device's refcount on the error path of .probe()
Date: Thu, 12 Dec 2024 18:49:45 +0900
Message-Id: <20241212094945.3784866-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of ci_hdrc_imx_probe() does not decrement the
refcount of the device obtained in usbmisc_get_init_data(). Add a
put_device() call before returning an error after the call.

This bug was found by an experimental static analysis tool that I am
developing.

Cc: stable@vger.kernel.org
Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f2801700be8e..6418052264f2 100644
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
 
-- 
2.34.1



Return-Path: <stable+bounces-104303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420E9F2841
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 02:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A446E1881261
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544F171BB;
	Mon, 16 Dec 2024 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="i6PiGfpb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E2E56A
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314148; cv=none; b=AOQDFN2vGtqbxVKBgbwPqnCbVcfewyyMKPoNxNtax3g32K27XjJH+OMyvt2hXaeX1+TJkohL0YpiHCyjHcvExcCB/ZTaRJBtAsTflu6iV93o5YHFSm3FgcbyE6kRM/Hk5oIrcqEJn4SF1F0swof5sp8vLH0553I+50+Oe8R4j/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314148; c=relaxed/simple;
	bh=TCpfm9gNYyeEAUajZEJgeVz3y+h4GZWeBYqd24ez5ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDU39OWMDua7yX2KgfIBtK/1Ao+ITaA+hvxKdMHGw9/1Swl0EjtlRM++wj1TnRgP5zeqpzk5XLOPVE4xxmXxnxLVyFqepthfiOXe+6r8Q06eXMkO8uBNEKuAAuodRqpBsEEY09/jogIbYjk7ghlcXD9NAf0BaHGQuhJbRXpsw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=i6PiGfpb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso37643985ad.0
        for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734314146; x=1734918946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzM676k1DKJkU9oLGeHVpaSFbuH7S+Pq9zqIC4eZblU=;
        b=i6PiGfpbwEOSRz09i8/AabCnQljjRyKL2vAu0RapgBj6r4VksBHjIy+TY/7UDtHMfr
         CMBW+KdM5FhkUV4+XZ2pImqntdzFQY2HRUC6NCmbk+4JEbYPbu4RVbrmVjKLvwYWN7J8
         NssmJR2VmYhTrIukY4Y6GleiemL+ctORR2zirvPPx516qNZRRJQrFUqXo04ZenZsM+XI
         OZRT5U8nBhaL3MHwMd6r3t9QUjRbYO6D4bzx2hYhLs1ozfZpqxoXaJdC8vhuVyfY8Mxb
         tq/Klm9RPMyIZF6GFY3nRpfXIz173Iu5Ma2JUkW75Lx38LE3MG9NDBOdc8t2LOtxYzO2
         +zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734314146; x=1734918946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzM676k1DKJkU9oLGeHVpaSFbuH7S+Pq9zqIC4eZblU=;
        b=TpiiZU/o/JyBfOyP5TREFTFZ+TIbAesOdKWa28HZk3A/sIS23GaPg7u5WAZlrTgFsv
         eV9iiYUkxDhudKCH7MoC7eYRjzljfCZp4ttcVa4sQG5aKR65nkxtVIjD+ongmpUmr/Z1
         fp+oNZyQYyShWDu0DmIjFQAjIYHanNvcqOy1SCllFgvY00PUQSNMLUWIe3/4evWXtLr3
         OBZCNPib1dv1n6dFgVLodOmg1efRXk6qUSs/EpVyOfWWpc1TobqWpoOEngYgK1X+Sk7X
         ogrOmEbDAeYiA9fssHG5/qL3ZyG4pzzISjfsQOXBfJq3mbIVTri5AQ3iabIiUYRUeFkW
         he4w==
X-Forwarded-Encrypted: i=1; AJvYcCXMPoW87HuTHcdCFqy2Xqzkr00el4wBWUOmu2dKNNK1/N0eHguSZlXugZdZGDp/oFEJ3I2EUEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgR6wK+FBvmLUvUdLmOdAe+BrgH9jWvQCbm2WbBzm9KpGvNbl
	PpOG5T/DgdNFJKsVWKEK4jTkLLENhqEkJvIEz7oLClDvlTuZSPnStCl/WzLz80Y=
X-Gm-Gg: ASbGncvcNGbwbnTjOOkWMoZldGT5w7a+HScCZbuTcFQGCx2O8XaA4gNVABBX2opeMAL
	HUqzGyVtmuIJFb3EKLYXsa1IsS9V1uvMs73VCFiWvpLclFCvvtm2WlqCbQ8f6XkpNndPbAit8P0
	8Z9GjkZgiVU712J5SLaSLUp7GkJ7fE4rdRsBwp/AO6H7bm9idw420vJqUHaf/QQcdTCZw/J/HUk
	AioAJswmw3F45YbJ5gt54HzqbqS3zFtkisLrOEDC3fjA3/S3q397HaGM6jZuT7oIYKzAC0pqspT
	goSGasTEutPGPlJEUI5fhXScW7Waq0rbwtbhxAqHYfc=
X-Google-Smtp-Source: AGHT+IGgoCQ13pdlOw67VoMMX5O+6nchdoRA43p02Rv1YfssUVhyWfB3j/Sbk45VYRYFXB2PqhZjpw==
X-Received: by 2002:a17:902:da8b:b0:215:6f9b:e447 with SMTP id d9443c01a7336-21892a5d814mr132437185ad.30.1734314146034;
        Sun, 15 Dec 2024 17:55:46 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5c9c8sm32137365ad.193.2024.12.15.17.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 17:55:45 -0800 (PST)
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
Subject: [PATCH v2] usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()
Date: Mon, 16 Dec 2024 10:55:39 +0900
Message-Id: <20241216015539.352579-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of ci_hdrc_imx_driver does not decrement the
refcount of the device obtained in usbmisc_get_init_data(). Add a
put_device() call in .remove() and in .probe() before returning an
error.

This bug was found by an experimental static analysis tool that I am
developing.

Cc: stable@vger.kernel.org
Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Put the device in .remove() as well.
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

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
-- 
2.34.1



Return-Path: <stable+bounces-108330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A33A0A943
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1917D3A2643
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91E1B425A;
	Sun, 12 Jan 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poAFrwe2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75C1B4138
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685737; cv=none; b=LkezibpXbOavhymBFQG0Gke+iGmUlri+cm9GAlosYYFG0MTDQIhztYAh0IWPElOPCMOk2CpF0QB0H5sIDXRHgWVMUeJNUffHpciBc1JPhG5C5C3BunOhJsIXlvKeQ3/+ZuvSBgE2KqfAeWONw+53YMqTJ+FxF7JG9vtJiB8TJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685737; c=relaxed/simple;
	bh=Uqe+X9HQ/C7lDmVSxMMVz8XhQh1iM6bD28om30hNHJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehd37YeR7gUXwLoa6icdhHK7/oY+IbwGgCd8tUQjXxP9UGs48AclwGaxtKasq823EK7em18WI9KKk6KlydDP9u3qkIhD9Xva4uBJDPTzVq9QsUZwdeY2OFx5iEuU8CtwPzwSYix5TkcIYIPy/pTA3XqeOTbm39M0imwDWjFur8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=poAFrwe2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d8753e9e1fso625883a12.1
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 04:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685734; x=1737290534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyRu92GnYYRT1EExmHa7Cr87va2Y0x+pDGRBBU3ijHs=;
        b=poAFrwe2jjFPlmswXLkEUKrh2+7gjX0dpgkSvOFiVWxQxSqHvmfQ3OxhFL8CAmZqPT
         AMwi2FLt3fSZ7+W7OedqU6GNOHbZihKAyv8VgQJ7o8p+fIUh7SjZZEcpD5wqnYiAX7Bv
         NXpHn6ncToHQnmrqbpNKNOnfBeE/tNZzFakBStywhCDjjHVShItCl0sL5NK0ELrUtU62
         tM8U5HdLNDnsfADBtnJEYFubShXBhVOkc9BWnQSQ43WsQIu1gn0jZyD+rQtEdHr44l/B
         3UvEEIuGRO1UNTw1S2aespQdK+QCe0aPFQdgD2AesSMRqDPC3oHAKviLRjukpnEW0weZ
         TDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685734; x=1737290534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyRu92GnYYRT1EExmHa7Cr87va2Y0x+pDGRBBU3ijHs=;
        b=Ko5eA9Yserryoptobsbhkmxh1qyXFexVBH7VSgWnqQe8cZ70FjhYWAJR0IzBI/a2C7
         36fW5cO8rj0oTBWtHPWyb5tBf4CmA8RgItIc9egqLw0rc3D09qhNEyzFbUz8OAKZSGdU
         MF1JFry0xPAK+ynrxPWDdog0ZrHhGHuh2dWqHPkCMMtSSiAVM5MjYYFIQWS3XA92vROo
         TO4T8u2zEYnoe94Zuz53Mx3vNlX6IuAgvWmwsCq0s6tQfNR06DqCWQRhcMkwb1Udn7+S
         ltsTXcgDsOJ/P99LRlQkpftCf1UlUxPfwBcPMsxNXeUM2hcG1FmNjHbSY5JRI5NOww6c
         NvUA==
X-Forwarded-Encrypted: i=1; AJvYcCXxxhtIKBWAaEn+8Ss0ymEuPYwHmAFQAWUEtQctfBm++ltO2+XqAOo/+RYVTxQwSmd7PDQ19Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCZJwg5wcn9kyDzawEqDnpv0MPEIyTKGZVF7qUNHhbK+/bESb
	7LlWx+b4zIaevCHGYf5wiS5BybIsxrPmQ32JoflGhvBVO3fmxJloEAiK/MGlOLU=
X-Gm-Gg: ASbGncuLh87tbx0BjXk8zkyYqEpA8w+x3caPVfY3d0zhv2XmkaVa8wFPIZbJ/IerHHS
	9twjihvXrwRF77CDx5Bc2Z4kIrK2OmZt4oACaISK7co9PX8uTquj//g5amstYWs5N3pXybZnlw2
	9SQdiEKi21VoEmsmwu7URbWbpeDbZPV2RvAur0hs4JzdqYQjF4UzCrimyla5glXs6J4gklBY0SH
	b4lBTpg0m7n+Na5bZ/7F45/zrg32ptw/C2IVpIy5QqjxT3A8Us8zpyuZbrqzNYelOGYPu/o
X-Google-Smtp-Source: AGHT+IHEkmiLH1Xc3jcUnwJ/XjUhROqe3vBN3H5xX6BsixyORvLdzMfz3hEnYJmroLlz0vk3hcU1eQ==
X-Received: by 2002:a05:6402:388d:b0:5d0:8111:e958 with SMTP id 4fb4d7f45d1cf-5d972e6f286mr5138846a12.9.1736685733664;
        Sun, 12 Jan 2025 04:42:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 13:41:52 +0100
Subject: [PATCH RESEND 1/5] can: c_can: Fix unbalanced runtime PM disable
 in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-can-v1-1-314d9549906f@linaro.org>
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Uqe+X9HQ/C7lDmVSxMMVz8XhQh1iM6bD28om30hNHJw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7ibDeRdZpkb845LLrBXAJsGnon7ogW+6Htdc
 r3/DgaXmAmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4mwAKCRDBN2bmhouD
 1/GSD/9CfR3vJnpiV0XW+YYuRHAouF5cS+H9oEfyGPYmdZfQuBqfSDpYspKAOFhPDWxE1e7tYw0
 DwY4+8fvJhXUoegEjCxUDDZkyFjPpWSD4JKfz19mQxOnFK7fA86RBs8gade+c4/OJQzIDsM1W0N
 XcXRsMIF3np8QN5Gz/RHeEVoBUmZK+WRqLPBqS4QeA6AxlzsVhWALVhEfuB7nI0w0f9mYYUp/Le
 epJFIZ5mnOPPUTAqIhiLSQo7KWfQJWh74iQAqKPbSnEAx4niT3mDtXIqkShvBoos6IaaaVggbwH
 v5Jeph9wK2CeS/KEVqPDKoJP5JobH4Qtog21yLZf/s2pB3My1SCFs7UYLrX+JZkqRyKTQK/u8wh
 CTLLIQYCKnqtN2RsAqudpRrj/hDdkNVtGmKcWZP2X8ksHsIFeQETha5PRlEWBWcLPgGblmp+6rG
 9YLBf+B9etwHKefrA5iBEk073w2IFudDg33UM8cX+0bZcgeqRalnEXfWrhlTtP0AmJehWzARBlg
 4thJjrZmqiUb7y0ZjiylP5T1y6ntvXcxIaHbunOaOwh/esF+kYhK3wFi2KmwfDVGLwknC3xRae4
 JjmA6lUpKEcZJibH0hXlXTF/ui8V3Gv/USkH9YeWXsW5XmR7j1husGSj8MwR/HvsmjI289z/2ff
 x4YdJuquyoV6OPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Runtime PM is enabled as one of the last steps of probe(), so all
earlier gotos to "exit_free_device" label were not correct and were
leading to unbalanced runtime PM disable depth.

Fixes: 6e2fe01dd6f9 ("can: c_can: move runtime PM enable/disable to c_can_platform")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 6cba9717a6d87db3d779a31afd6966162094f452..399844809bbeaad42e19b4003b85fc487b01d336 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -385,15 +385,16 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			KBUILD_MODNAME, ret);
-		goto exit_free_device;
+		goto exit_pm_runtime;
 	}
 
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
 		 KBUILD_MODNAME, priv->base, dev->irq);
 	return 0;
 
-exit_free_device:
+exit_pm_runtime:
 	pm_runtime_disable(priv->device);
+exit_free_device:
 	free_c_can_dev(dev);
 exit:
 	dev_err(&pdev->dev, "probe failed\n");

-- 
2.43.0



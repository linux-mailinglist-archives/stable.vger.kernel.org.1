Return-Path: <stable+bounces-96240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1B9E171D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DEA280F99
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940951DFDBB;
	Tue,  3 Dec 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tuRcgEr9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5C1DEFF6
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217594; cv=none; b=oToZYHPLVzy9GLNvRhSB98jH6s/o3qMxERapPR3abh0Uit2yKyi1KZBkINdK1+jWt7HoUTG/FdPusRWrX9vtirxcXMYw7ivAtu9MIe8M35YKOm0r1ZZcTS5SuXxWwyZbv4Pq1pvJ5nsEPwbqzs9OaIsRxdxbBzBQAUJi1LeWihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217594; c=relaxed/simple;
	bh=eYuNbK80WRaAXbQTcnKblv8sx0lo50Hxsz+fIFYIPBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WO5WXO5JnCGwfoYCvDrtbwGx5NbmnfUKaNPwdTq6EY69P9I+EwKx0dOfW6FmIKZNqE9ZUv64Py/LmFFYRnFT2r91ZyZd8BvmBJiiqT+7VdeTMPkKpCMcRzAMhEElb12jZiE8jQzcGshSRConTZBWOzYzNqmWVS8MQEZ7ikjFP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tuRcgEr9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so79478131fa.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217591; x=1733822391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/FxCq/D+ZrwlBd1hxrnw2bJ03+PvBK8Cp4qmHys6u8=;
        b=tuRcgEr9b3IchxC9FKSVGgv26qwo7cZ+VCvbhv8sBx61MPlvwfgPL9zjaN9TB4UVo6
         eFCN1SNkAzUxTx5hH3dW7439AXzmda+i5C1ZCBWLvpj5CgInBZ2scNSyo/waexhDcqJm
         qQ81PEK0S+De3w72bPk9TU/0n0ueFp6UbWs0HiSuNw1sONnxXrPklPMAQ51mBKI89Qmv
         0oGHwcE7DIlBWvdV72UtKU5GuaUOLebmeZuWhEJOWFQFSVLUomACVgDrLwp8qTexProG
         ObxLDzlZKX6RUkTwSb4Sq//IQV/eSZLgEPrfnV/MFjMXPJfjUytmEwKTbhlxGjbaAOHw
         clJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217591; x=1733822391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/FxCq/D+ZrwlBd1hxrnw2bJ03+PvBK8Cp4qmHys6u8=;
        b=b24NW4zLWj+Gv5XgiGnKTlBsct/wMxGJu/+fuuCKxEhX5NZ4e7Zf1xPjkUZRHbJwv6
         zMsx2KDGyKgzM5P3teEoepm2yyqkwNRHIM0HPTj/HvtPq5MRWTjcJFhO1ukxNLRu9zOL
         g8wWez84KayYPh7nlRzSzCqKJYhqDnTHkS0WlkKIiEZ3xAKRwbrd/pjX2OIW6Ighhfh0
         lhuJFItbaFMlJr9I7UUhjfObcGJOgAygSt3hc9Ncz7l1B5amVbL6cGBObLHJq7Ypg+EB
         HXRg/lC3yR0e6KTIOsN0DggX2Bh4gY6UG0Yqs0EYSM9eVs4VfjuYCcYXx9RyPBizxj/9
         1ujQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvvzP0s/SFkps2IwBuxJyjY+p1+56i4IazXadLBdiEfdL5j99hVFou/7g5wO9uk4+Sp5bA8ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVipPUarc5jZ6Dze4HE0n8NbYvpy08KXmmJF5VgFryjFuC4M+
	1QZjpcORyKKEQZurjFRElejqv/cMheflX1VsD80hnJZgmcKazIpF+ixFJSgL0T4=
X-Gm-Gg: ASbGncsBBmEEf6WVTVQUhwYNSZ7uf0kRJsWE2ew17xA8ZsL6bLJ0aIdQkrXzYKYTFo0
	0J57nacHrRgFTg+V3ELmr1q2vLP6fVbKYdkEDNiDbLsvDgm19FSeGRZrFAguvDBD2pWXV4AoqaB
	96DQs6neFZaLxib5ieu8P2jPiGEypjK6LiqUBTAzcH0i3HRO3A6hsLcbDl67XQ/jOOuywEhirxv
	ryMUWYB6FISokL3ldVJbRXy1VBYzYao8AOuobPn9AjQHTHKWmzcQvz200DxkjnC9QQYMB+QwAAv
	uXyjISs=
X-Google-Smtp-Source: AGHT+IEfXdjC8Yy7o9RHZ+7NgaXen0b0wo8Kg4Qe17WVjeTIs6uDHz7DGadVEYSDMKcH/M4MKy5dSA==
X-Received: by 2002:a2e:a9a4:0:b0:2ff:5c17:d57d with SMTP id 38308e7fff4ca-30009c46730mr14340111fa.2.1733217590598;
        Tue, 03 Dec 2024 01:19:50 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:30 +0100
Subject: [PATCH 2/9] crypto: qce - unregister previously registered algos
 in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
In-Reply-To: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=AfbQb2BovfoohKrly7MBshyETjFSgtG70aWbcVS1ssU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0w6LMZ4oCMoqdYSOCLYwhUym1VRGdxxsqzH
 49+cG0An+aJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMAAKCRARpy6gFHHX
 crPMD/9LzRflfe82BvLf9MYfTWI3o+kFii09BTKW8IgEonlmbp5zrkjC2hAw1b93i2amJozgvK2
 /FHV7gZWxOnB12uKkpsZ4csxUxaDSmXGzP31RGwjaBZmK7nKfaO75mqWR7KKwKvMIabAgtWg2LQ
 UZqJ5dGd173VgDzctd5VrfOq+97489FaIu2wIuYSzMDOgLIagFZL4jcQBDsGl/9bujZPVeVFnVc
 GTz+8a+oYXDoC49AHHPjq2+t+HMX0CAhuGoqdmdD0Wn8TLP4zxZjXXmPR9H4jvH7x4xJAMl2MNH
 EGosLof58L7Zcvj4mbmyHsATV6B2pcv/znjfQoVWIIEFwBSlblaHcg9RQ76ndR88Oo09SEN3ECr
 Z8wssjPr2NPDeIC31PtjdA9GDGVl2YS4osgsGx6DM5TduXNkjXCHrPyssKD2EJuiMMcMgwrmmFZ
 TOVnOWnWRc8uXmhrmxJfPS2z5IDq+RZa3E3krJPRskqMUJgvbvG1tjc1UAu0QBMA1qydxotqleO
 4k/DlSRU3PYjFFdFjoTePtfTszKuME+yO1JZKv0JqaWwCaoObhpwazXDgVpdKRk2IbhEpAtb7eG
 8NpRB/zzb/gx1yd3gVXiOuzPYVMIjU72ZzGjKMzDVOJN47kZ5V7zWBgoAVoHo6JZGmsai7YvP+D
 wfWmRBvsBLW0ppQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we encounter an error when registering alorithms with the crypto
framework, we just bail out and don't unregister the ones we
successfully registered in prior iterations of the loop.

Add code that goes back over the algos and unregisters them before
returning an error from qce_register_algs().

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 58ea93220f015..848e5e802b92b 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -51,16 +51,19 @@ static void qce_unregister_algs(struct qce_device *qce)
 static int qce_register_algs(struct qce_device *qce)
 {
 	const struct qce_algo_ops *ops;
-	int i, ret = -ENODEV;
+	int i, j, ret = -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
 		ops = qce_ops[i];
 		ret = ops->register_algs(qce);
-		if (ret)
-			break;
+		if (ret) {
+			for (j = i - 1; j >= 0; j--)
+				ops->unregister_algs(qce);
+			return ret;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qce_handle_request(struct crypto_async_request *async_req)

-- 
2.45.2



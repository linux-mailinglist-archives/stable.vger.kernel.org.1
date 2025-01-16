Return-Path: <stable+bounces-109282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD1A13CC6
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D495E188DE23
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609022B8A2;
	Thu, 16 Jan 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj4BxhIO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535022B8B9
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038971; cv=none; b=Shs5KR/TgY9f3Rm43dcqP8dm0CoTvb3HnUwi2hlLb4ITgZh4cfb0BuTMM08aIqCk0hTFjWUPM18d5fOFXtJxBdQvNbzxDNYx4PU0IO5qJ4xFjU+koCcyuzDjBRxHe29YQdaEMwKevnvjRLEbZr11xe/nq0N/Yd1yXGuQ3tqSFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038971; c=relaxed/simple;
	bh=Wje1BciONDqQrKQyhp/R22j+9s7pjT1C1mQYS4XxTmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUY3O79xLCnFVqxGJrK7+di2kRNhLFPXg+s2GD0pjrJ6w2rAwBtzBLYpb/vgT92uQTRW9G9r8Euin5Hp2VZsfFkI9k9Xh9UVmshnv3Xom3lTrWmJVwFMH7QF2+t+/ylwpWjticMAdBcqj28FGJAsb6Ran9wouCzeD9VwD5xPcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cj4BxhIO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385eed29d17so603804f8f.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038968; x=1737643768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbb6Ezfzp9O8O/V6bl6D5LDxeK+r+UlRD6ckNgY/1gU=;
        b=cj4BxhIOazRcHCNPKjsyeoxRxz3FuQ4Ok7sBqmWmD1tVSWnG27HKkfrR/NoN8ftx2I
         VEsUNWMd6b8voWUmiayk67a6BwE6ZAuE7BLfM+cLRX5WUTiB2o5I6CKQIv1MhopaLRoC
         MbFd3V/x5dGnX6EqIcbFKwDV9pKahE+HZAyFHgsWmGDJO/esypA1uxFBJcqvJyKK0fyS
         o510CMK33n9WCSv6mOZBx7P5/vALGzjjUF1l1nHVARra/93O7A3uAQYoUxDNpiHmI+jP
         y4uE6Jb54xEwxChGoUvFhn4IbFLt1eWx5J5my2duEQmmgdzOuX6I1nV9VjwtwTeLFoOQ
         2p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038968; x=1737643768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbb6Ezfzp9O8O/V6bl6D5LDxeK+r+UlRD6ckNgY/1gU=;
        b=YeJDaP2Cmjp7D4WLH69givlu/c1OQvBS1TxRVWgdhaPaPyo0o1w0bq7VgnNYNBQq2/
         DDNDC9W3xAlJwyty+y/WVyBJMAPiUvLAUEMShfHglla5gYnO1Ooa8YdSSVRrL/aCSSSY
         OtkkRZT4GvzjHbK185n0PPWj5hcptOuP3V6JPNFEICkozz9yyUOQ8OAq+eF+uOE6azf4
         +XblrMyXYZBZXCubzQzARCG4sBwXboCj/ft2Rxi7GnXZKEVxSslqTR66+KPWEYsFAd6V
         rZoUeFgQE1E4qibshNQoeZ0yiXN2+cd9LArwRAnWsU7+N5C7X5XFlHowdo1psC9MxFSV
         UMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM98pO2BK0wbqNYuDJou5IRgQcS9Tf63W2Pap6rOyQx+m67ID4t3HosGNRtohAyN5qaGpg+sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNnesKhjPKZwSSePeidaIjOnbiRRLgt33KXuY5h0zvuitCnE+
	3du+GoygBhz/7/lb4rUnHQG5CFlvHqd95mfkCP2bfOUvv5jfBdWaMMFVwoQTTgI=
X-Gm-Gg: ASbGncsdoHm0tpPJr10LwKiPu9pnTvFsEiCZunEHPMQLJLUBLEe1ndhabKnnFP50j92
	eSbA5K83PYwYta/+eII+pw6G0kz7i/A6ZMe4Ks5LK0nl04cEjgfQzYrvN6vGhA1YW6VKQRV7Hu4
	awjMliPWIhPfxYeUcVC0WBzX7TniHGWQtFEcBKG767Uy2mJkz7OZpJBDaHxVby24yjsAT4+Trkd
	Tc047xJVu3reKvmIKxFbp+eUMNeiLB3Z1geg66lfR0hbmQX0qc8ZUH8nT/O/du7vKXCs1Tg9Nfm
	HcDVbulUwQmMGT9zb0+lprb1malyIDHtt1JI
X-Google-Smtp-Source: AGHT+IH9TQuJ8S6VwCv/DsUwUueSrMwmdIaON0G+tCnVqhp1ubDleE7CO0HW5JVWQ93mm1BDZ5rH1g==
X-Received: by 2002:a05:6000:18a4:b0:38a:a043:eacc with SMTP id ffacd0b85a97d-38aa043ee63mr16034591f8f.1.1737038967915;
        Thu, 16 Jan 2025 06:49:27 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:27 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 16 Jan 2025 14:49:06 +0000
Subject: [PATCH 2/4] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-2-84d937683790@linaro.org>
References: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
In-Reply-To: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=939;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Wje1BciONDqQrKQyhp/R22j+9s7pjT1C1mQYS4XxTmo=;
 b=aMMD3l+fSYmaasELHSb630GvEIX81VeJMVo3eY8nHViIArWh5G7STBR9Qc3WZpAaFDvitRjk8
 m9LNmbtOIdmDxHTkSnPmHvYOH/JFRZpvuMIE8UrP0vRAQpXFltqIOPi
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4610f067faca..559ea5af27f2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1824,7 +1824,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
 		return 0;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;

-- 
2.48.0.rc2.279.g1de40edade-goog



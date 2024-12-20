Return-Path: <stable+bounces-105417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57719F9218
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C31169E3F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB16204693;
	Fri, 20 Dec 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yNe1M87h"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE27204567
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697337; cv=none; b=LWWRN+nGPrqmJ6vbz+14WQF7mSt8pkh6tP8UvhvAHOAd0YPXn3mIvMawzscqO93Ark3c+jgxU1gtPvqhgd9cQy6rmSVVIp3Bfa7K9Zpq005REWP2IGU2QNQQp5M5DoZwU2toUppuLVqsvsm0R8d+ObTYYOBQzjmREnf249G6/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697337; c=relaxed/simple;
	bh=qx5p/hDbUkuDZtzddbNWpM0QTt2rSGt/pmcZqagYCts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F84pb/SLm/szhoNU4GCUkuvh7r0b8RxcTTKU9rQcxQEiotfZOUiFV54Yd0SRStJLkrCnk21ne16F7e7GD3iNzw5F6VH2IpMtFtYz/VqItkdPS5btcKKXL3XvXibCq4TlGSOnnxEVDXLPp0XYlHOiwhomrtr8ETPM3M4p8ylf2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yNe1M87h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a68480164so304672066b.3
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1734697333; x=1735302133; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVIs/A5zO1lF6Hvf56Jf96I1JylRoUAYB/UjCgUI+Ws=;
        b=yNe1M87hI4shQl5xbvB5lfiFPX8AzZmee9d8Y/Qjy2JqC1Ws+mK3zlWN5TEW7NuYkr
         MfHh5/GpW0ET11M3A/9CO9GevuavAJlWy+H46RjyU0kOpuO+LCiaT1HT32pXIowmrMEt
         5ibW/d6SA+j1srgNYxGclQzDQtDufNO8GuNLjh4u8wE+xG6HcTBa4+toGaFmrTt+g/x6
         uxFpTLtXIkJ0ipoAwgYC+OJjAfzmlBdfy0LF3fW+WTjTiCvDG3F8RfNj0wnMInu77edQ
         Q1Utfk1POeg0y1Yc5V5d00b1Oontqwwvi5wYjTcXxKfL/zi8e6DKbRzCiri0FnzikYHL
         oTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697333; x=1735302133;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVIs/A5zO1lF6Hvf56Jf96I1JylRoUAYB/UjCgUI+Ws=;
        b=K51vbUdMAnPe4jYxY3UNVQq6TcHT7vQihVv5a+6TgcqWnpzx34iFF+/3afieSiAlyI
         YUC6H4mfItMiEg5244TS7bZv+SW9zYHSJtylCYOCqq/FKrD9dTN/dHFOqN0E1eojjsdn
         mHBAa7Y/KISuddoLUi9Aqx39MfLTcBH/X+jwhvy5kz+RCcVdMucpLfT6csekbgMPWgOL
         hSQKKUvVCyBtTbkyZv/V8YPpQoXJODmKW4/zU0aUZVn9WUAK5lFHwD/scWVB/lui6sEX
         6Anvmt60BmoFF5QJA4XHONBladxd1s6018u/6EYRN6iV2++VHEVp9ad9nU80W3Rn0lch
         7F/g==
X-Forwarded-Encrypted: i=1; AJvYcCU41H3RNFT0a/9esasvbIvGImaSO4ndBqRmHLZLvkgU4TCITwiUcfGzCSQ8qgWIzPgJwcdTjfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5JGesGujU2X6zLNHLbC+T81uzc5+2XKgaoXDzwcD6qXOoEO7
	GjZWJNl1imS0wRfap9jCgIJSyItTzvJGTVUfcRpcM4rhCy5EQcXYiYBiE2Z3vf0=
X-Gm-Gg: ASbGncstjKJ5iwH9ZtkdCprwgo6aaCdBM1+eUk8BS5NFG3RegyDHAl3NQTmEeuyeB9q
	QyCCM4yg1IUokspXjx0xuhoRwmXHNOvczvIOOBmtUoV3kx+WtIBifggJ27fQqV7+o1vwZ5BrMf3
	vNS+VcaedlmF1S6jWy1pDrXdM+DzNN5Fqwaaj6ysTNFUFvUrUFsZaYneYbxznxoQJ9YZD9eDSBo
	fQvAa/eGW4fl06BiqVwa4xCpCZB/Ynvrlz3vstzimaYZdqd45Y9Dcw9Om4LPrCENx6GKWt1atK4
	jdK4RIEF3TL8hlkbo134hH3dJNx8YQ==
X-Google-Smtp-Source: AGHT+IFPG5xPXCwcvvE2JWaV4HcrHvc6W3DgQ5ZikyH58crfIMJ8TJhxYQjOiX6A2Ig+f3m0RqS6HQ==
X-Received: by 2002:a17:907:7e86:b0:aac:4ef:36de with SMTP id a640c23a62f3a-aac2b19a851mr241107266b.17.1734697333203;
        Fri, 20 Dec 2024 04:22:13 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f5f4sm171403166b.6.2024.12.20.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:22:12 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Dec 2024 13:22:07 +0100
Subject: [PATCH] nvmem: qcom-spmi-sdam: Set size in struct nvmem_config
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-sdam-size-v1-1-17868a8744d3@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAG5hZWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyMD3eKUxFzd4syqVN2URLPElNRks7SkxEQloPqCotS0zAqwWdGxtbU
 Aju9aLlsAAAA=
X-Change-ID: 20241220-sdam-size-da6adec6fbaa
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shyam Kumar Thella <sthella@codeaurora.org>, 
 Anirudh Ghayal <quic_aghayal@quicinc.com>, 
 Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Let the nvmem core know what size the SDAM is, most notably this fixes
the size of /sys/bus/nvmem/devices/spmi_sdam*/nvmem being '0' and makes
user space work with that file.

  ~ # hexdump -C -s 64 /sys/bus/nvmem/devices/spmi_sdam2/nvmem
  00000040  02 01 00 00 04 00 00 00  00 00 00 00 00 00 00 00  |................|
  00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00000080

Fixes: 40ce9798794f ("nvmem: add QTI SDAM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Related, it would be nice to set sdam->sdam_config.type to an
appropriate value, the ones currently upstream are:

  enum nvmem_type {
      NVMEM_TYPE_UNKNOWN = 0,
      NVMEM_TYPE_EEPROM,
      NVMEM_TYPE_OTP,
      NVMEM_TYPE_BATTERY_BACKED,
      NVMEM_TYPE_FRAM,
  };

I don't know what would fit for SDAM and I couldn't find any info on
createpoint either, not even what the abbreviation SDAM stands for.
---
 drivers/nvmem/qcom-spmi-sdam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 9aa8f42faa4c93532cf8c70ea992a4fbb005d006..4f1cca6eab71e1efc5328448f69f863e6db57c5a 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -144,6 +144,7 @@ static int sdam_probe(struct platform_device *pdev)
 	sdam->sdam_config.owner = THIS_MODULE;
 	sdam->sdam_config.add_legacy_fixed_of_cells = true;
 	sdam->sdam_config.stride = 1;
+	sdam->sdam_config.size = sdam->size;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
 	sdam->sdam_config.reg_write = sdam_write;

---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241220-sdam-size-da6adec6fbaa

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>



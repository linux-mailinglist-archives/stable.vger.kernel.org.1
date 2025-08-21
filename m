Return-Path: <stable+bounces-172085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E039CB2FA94
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02035AA4C23
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C1334398;
	Thu, 21 Aug 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNvgPcH2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903E32BF50
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782905; cv=none; b=aULO5ZDp7BnE4+cfJyHlMt72hQJINlMSqSjFydcLDWL479usU1pwwBKjGbzfBftnxVprPaYpJJdZZg4W9CJSSArA15hAQlDmNhF3qnVI48dgiZMGd61ql5r2w81A+g8Jw+MtbI26DXv7wcgHVuxwCFcjdObdArPu4b5bWlGFR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782905; c=relaxed/simple;
	bh=uBtIogbSOsIbkE4R4niciJeJE+S7iTtvZxRDaPAge9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r6LbSFeI+1Yeti9K4dTW5IphNs+edtZWGkvuOZbvQVehUBb2Zx8UxM0bxuNjks6xM7z29080Qg5kQbScR8Ew4ERmcF/0cQdOUpvfa7vI3gifUXbSrR7VNAkPJf+qbWVm3dxo33UMo7GOQfntIpNDMtYlBUWz2l3vSQo1Y9R9aR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNvgPcH2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so6182945e9.2
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755782902; x=1756387702; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8T31mCfWW90OKBE5TgdxVP07GBpIWXUZaFTrUQ7T0g=;
        b=eNvgPcH2mvccST7yomJhSaiOtQ4QywpazjVtPqKCneWttUxku10PW8OgPEuNNTnyxl
         fck8412vRX+gTnjWS64iM9remCSOTRKx73GgVxvEzGcKPRca4eMdaL7F6Qaz+dg9dmRh
         qifsrNB3KWkRrXLiGbK+E6Qm5tnWKKqFwWIfxGwiU71Pkolwg3pYcCAjOowboOtfC1Dg
         Lz2Y0us5mhyDYKjAoI689+Pdk+ei4nFmfoWAP0/rjBT2c4RJ2/8gD+bIehLak1ohQaRR
         /25jpeRikac4IG5HmmsLrn1dqpUbhe/x5JwiE/oAI04usERIBgS3thz0URuhd++c03cT
         j06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782902; x=1756387702;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8T31mCfWW90OKBE5TgdxVP07GBpIWXUZaFTrUQ7T0g=;
        b=FdP5Z+ObxWobDS3z15ISx+afUqEab1v7vkIobr6Jlyfe/sc9GU6OfAAn1nh4PytdGv
         NN709vhMPRpC9feLoDuz5Ni4nIn06LlTp7WXEQQ2yI5su/spvK6o99Pr3MN3rIc55jI8
         ql18qAGSD0pH6g6Pr/e4kUFg4uQj13wy5t6dbPFITml70kundxaXFNrjl1WNvW9y4u39
         tac+vdVssKWdKmNbve/sVCcSrJlay3rlEvH3sbI4MD12Da+Dp1INwJC4obi8ZdkzVzZT
         4rHmsiuByVjBiIOMXQOJvebeuw1X2nlVmwt6Gyb8hV+EyOAdlzYJLW4lNyjaQizwzI77
         oTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWWlhzhkdaaPjiozrWtY4z6FsRF5TLQ372qfbcG6PiFWVfx8ggsg455eSTp8pCg4hZlN+WBAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApuoaxvlt7cvXqs31tfQRIDpDLDFGHw+S8jW5wdVpCMg0N8Sq
	R1scH8/fFLC0nKV4U7h5x6qtX6F+U7rbt8rk1qfI3utrWQ9ulezHiWu7hgrvPuSvnZY=
X-Gm-Gg: ASbGncvbTC0DGEsAsIZKkJ3KwKF1exGOXIwPM7SKA9eFoMqVCU6jBut2f6dCE1hFUMW
	L3uQqnEp3Orz01y+UKTHN8XIIueDLjbIrwdr1vdU2OFYvK9+EnptUt7R+UUdiS8jfWt7bYAHVmv
	iKnXitFPfqQSA+9A7tsxAtxomDEoOtxD79Vslh/5twfuDy2A6UQq7o1rNtTlcReSqM8SDMBNLga
	ZFyJlWW9IEy/0QSbhx7CgDLljsVio5FSjjl1zJClexzOlAU+e4w7+Sg/cpfJtwllaflKzMDnPx/
	P8S7oT3S9+ifeMtryIppZx/q8O2DPwZ7mQytCNBlFfESLt3seXjYYryFeQiusG2DRdkPR3Q9Ly2
	J8fnMQJ7yO5fvqzfeNpJ2l8whWzDC0TqWw0pezZ1e5mwitn0cUQauAHn5vCnXwF4LIRI8SGZrTH
	F16xz/NJF2gVHg
X-Google-Smtp-Source: AGHT+IHOk+jQ+Wc1ajIsPeOQSauihlXX1jqWqmrDAgPp4glmc0IjdS3XEeisSeIe/xP/WO4p4q+GUw==
X-Received: by 2002:a05:6000:4382:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3c49452a39dmr2007478f8f.21.1755782901781;
        Thu, 21 Aug 2025 06:28:21 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be3csm31540135e9.1.2025.08.21.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:28:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 21 Aug 2025 13:28:19 +0000
Subject: [PATCH] firmware: exynos-acpm: fix PMIC returned errno
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-acpm-pmix-fix-errno-v1-1-771a5969324c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPMep2gC/x2MSwqAMAwFryJZG2grfq8iLrSNmoW1pCCCeHeDi
 1kMw3sPZBKmDEPxgNDFmc+oYssC/D7HjZCDOjjjatM5g7NPB6aDb1wVEokn9m6pqCHbBruALpO
 Qxv91nN73AxVDRlplAAAA
X-Change-ID: 20250820-acpm-pmix-fix-errno-92b3e6e17d1b
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755782901; l=3666;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=uBtIogbSOsIbkE4R4niciJeJE+S7iTtvZxRDaPAge9A=;
 b=1nMwO7SPbvVV2Ic1y0bLWWFDpBvHQZlBekOmTvTQEbZx+2RjXPdcqhD6YnT+0MGs1ddVLnyky
 J4OcImc4x67CzaIkz3H3GahGRXSxX7N+V5IUctoqE+OAraYZLLQo/Yc
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

ACPM PMIC command handlers returned a u8 value when they should
have returned either zero or negative error codes.
Translate the APM PMIC errno to linux errno.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-input/aElHlTApXj-W_o1r@stanley.mountain/
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm-pmic.c | 36 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 39b33a356ebd240506b6390163229a70a2d1fe68..a355ee194027c09431f275f0fd296f45652af536 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -5,6 +5,7 @@
  * Copyright 2024 Linaro Ltd.
  */
 #include <linux/bitfield.h>
+#include <linux/errno.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/ktime.h>
 #include <linux/types.h>
@@ -33,6 +34,26 @@ enum exynos_acpm_pmic_func {
 	ACPM_PMIC_BULK_WRITE,
 };
 
+enum acpm_pmic_error_codes {
+	ACPM_PMIC_SUCCESS = 0,
+	ACPM_PMIC_ERR_READ = 1,
+	ACPM_PMIC_ERR_WRITE = 2,
+	ACPM_PMIC_ERR_MAX
+};
+
+static int acpm_pmic_linux_errmap[ACPM_PMIC_ERR_MAX] = {
+	0, /* ACPM_PMIC_SUCCESS */
+	-EACCES, /* Read register can't be accessed or issues to access it. */
+	-EACCES, /* Write register can't be accessed or issues to access it. */
+};
+
+static inline int acpm_pmic_to_linux_errno(int errno)
+{
+	if (errno >= ACPM_PMIC_SUCCESS && errno < ACPM_PMIC_ERR_MAX)
+		return acpm_pmic_linux_errmap[errno];
+	return -EIO;
+}
+
 static inline u32 acpm_pmic_set_bulk(u32 data, unsigned int i)
 {
 	return (data & ACPM_PMIC_BULK_MASK) << (ACPM_PMIC_BULK_SHIFT * i);
@@ -79,7 +100,8 @@ int acpm_pmic_read_reg(const struct acpm_handle *handle,
 
 	*buf = FIELD_GET(ACPM_PMIC_VALUE, xfer.rxd[1]);
 
-	return FIELD_GET(ACPM_PMIC_RETURN, xfer.rxd[1]);
+	return acpm_pmic_to_linux_errno(FIELD_GET(ACPM_PMIC_RETURN,
+						  xfer.rxd[1]));
 }
 
 static void acpm_pmic_init_bulk_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
@@ -110,7 +132,8 @@ int acpm_pmic_bulk_read(const struct acpm_handle *handle,
 	if (ret)
 		return ret;
 
-	ret = FIELD_GET(ACPM_PMIC_RETURN, xfer.rxd[1]);
+	ret = acpm_pmic_to_linux_errno(FIELD_GET(ACPM_PMIC_RETURN,
+						 xfer.rxd[1]));
 	if (ret)
 		return ret;
 
@@ -150,7 +173,8 @@ int acpm_pmic_write_reg(const struct acpm_handle *handle,
 	if (ret)
 		return ret;
 
-	return FIELD_GET(ACPM_PMIC_RETURN, xfer.rxd[1]);
+	return acpm_pmic_to_linux_errno(FIELD_GET(ACPM_PMIC_RETURN,
+						  xfer.rxd[1]));
 }
 
 static void acpm_pmic_init_bulk_write_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
@@ -190,7 +214,8 @@ int acpm_pmic_bulk_write(const struct acpm_handle *handle,
 	if (ret)
 		return ret;
 
-	return FIELD_GET(ACPM_PMIC_RETURN, xfer.rxd[1]);
+	return acpm_pmic_to_linux_errno(FIELD_GET(ACPM_PMIC_RETURN,
+						  xfer.rxd[1]));
 }
 
 static void acpm_pmic_init_update_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
@@ -220,5 +245,6 @@ int acpm_pmic_update_reg(const struct acpm_handle *handle,
 	if (ret)
 		return ret;
 
-	return FIELD_GET(ACPM_PMIC_RETURN, xfer.rxd[1]);
+	return acpm_pmic_to_linux_errno(FIELD_GET(ACPM_PMIC_RETURN,
+						  xfer.rxd[1]));
 }

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250820-acpm-pmix-fix-errno-92b3e6e17d1b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>



Return-Path: <stable+bounces-81161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2349915F5
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693021C2196E
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B96149C7A;
	Sat,  5 Oct 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnpatQ9G"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FF145A09
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124273; cv=none; b=lHX0z7K6jpH11LAUeVEEQesHTnXKg/5/ud9+Yj0leHttneoCvDpuudFAzbS4IqOvTVNtzWPG8LQrndeKPo7Xaabw7kf2p6GBqlC7eU2P1kLBx2JOuE5UeFKuFunNNRgtPihPrqqwQKcM4y98ZZ/oTHZlLhm9xzmCDk9r68bu/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124273; c=relaxed/simple;
	bh=vTwVvG8iZlHzHza+YS67mEwp2zyunt+kNzBDYWtFYWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSXt8kSI4MMwDL4MwiwxQdYzehTsz/5ZzKQeW2P2qHjkO4eDzrjQQwpJBrvTr1fsR4qD0NK9MgHNeO4tpQ4VDHmpIcIAjcAEGwcSOGcWBYV8S+FquYl59/ChDx9qyAwBBdO+I8qaZHGVQrw1dPaJqCqfe9MXHzaXE4TiQ1IIM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mnpatQ9G; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99422c796eso16488166b.3
        for <stable@vger.kernel.org>; Sat, 05 Oct 2024 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728124269; x=1728729069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=mnpatQ9GEEEMayWewFkEs5Jrn6hI6nlA/jNRwo4KPX1V6Zi1cchTK2DhbBeYgwV6Jc
         tnKgq3V2QTK0j1jljiXdcsJNFPSR3JwppcwgVT4s42dk/IMLtn/wfsGYj3u6ndPBhzId
         Kkg6fPnfpqQ8hBPzJTX3plE5wXfj/sbcvKREM4AxxejfRh7+X3kVpJyx+9jhUxjmQv+N
         3Rxl5rvN6XWiy2Q85Ld0zUbLeXXa+3cb9AR/iNJPoTebVL4qiLdqwug6eImtLxFoHxHC
         0y1rh2yt7bmQ2FGWxUMt5wtPjTGWnLkEY7G3OVHWmDC//cpKcJ5ZBVlo+oH7OvQosOjU
         xMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728124269; x=1728729069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=P+7o4qcb0xC2ge6E5TCQONmwIsZelwe4V/JDGZc2BHRLW9dYSTmrJb0OMgstKj60hS
         8jDNm4lgE/A2oTK8z7yQOfjl9zmB57L5caPxMzaqQEIg+UfWpIYxnFhGwBocTUncuxG/
         EsEg4+3SRxbYjEmmM1JrDp3ZAMp6ULnMMA9dpWkeWDnn1h8jShG0s3S4naN2PNXe4c54
         Pcj4KEmbnnY19slzYSuzX4teVhl1zKectTOdp7EHtdwFDfdHRakXDYUUk6SvG6Mhu9Tp
         A8LW15CCVgjQUcy4Y1/r1PneyQSsTgVGjNytvqBJ/vZX7LL7z3xWarRkENSDVsiZ29fN
         rHyw==
X-Forwarded-Encrypted: i=1; AJvYcCVcsM95VIOoGGeIg+KEvWAl9L2GmKyebjlUkdfF8FeE2hfMugK3ri88FqN0Ct1S+vptpERC+JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwsm74v/eds3LJingPkdYVIPFuqxcYEGGTfRLMl9ha2dc4jzH5
	VVzq50bfbHHBRfembroJrZmw3fG0xV/4q23MF6OxNKz5Xe0SlmVO7khJ5uidceg=
X-Google-Smtp-Source: AGHT+IGMw6qNSWut4ShGQ2E89T3alI/rY9/tMRu5/jv2l5XfRLkJFb4c9fLiEXAjApPQ+ggWZtlBlA==
X-Received: by 2002:a17:907:25c3:b0:a80:f6a0:9c3c with SMTP id a640c23a62f3a-a991ba979famr577085366b.0.1728124269473;
        Sat, 05 Oct 2024 03:31:09 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856bfsm116315566b.138.2024.10.05.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 03:31:09 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 05 Oct 2024 11:31:03 +0100
Subject: [PATCH v5 1/4] media: ov08x40: Fix burst write sequence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-b4-master-24-11-25-ov08x40-v5-1-5f1eb2e11036@linaro.org>
References: <20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org>
In-Reply-To: <20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=vTwVvG8iZlHzHza+YS67mEwp2zyunt+kNzBDYWtFYWc=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBnARVpPvMthR5vaCpvzYZx2Ib+Iducs9nYCFnN1
 kMDZUqdG+KJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCZwEVaQAKCRAicTuzoY3I
 Ohj/D/49VOqkWw6B83cchu7024YSwZ9ifrGHWKGj5dPQ/pm5R19PW26WsWa9rD4GKbaz8Yc+ZZw
 qoIiRg+ezt6zLVHtRjS6xIM9k8tlZYGEyNoKtyqJGO54XJdkNiJc6P8cEcStc7YGOne9VV0/bFL
 FSx2wzfl1K4qmeiSn+sS2jV46Kbv/tjCXPQwgeEpv70mnkeQ0EA4AYOTrlVBmmNaSHMPrPW4DVE
 xIhnrV3xpK/kqwuAXSKdQGG0nFL+iAGMp3B0205d/l/PHqhuTFBGn14Zzm/pTmqfxOdCw763PWY
 o1YLwipqSyEcV/wtg7Abr6cIUeAu+2q09nasK2hla/bUdgNWoEnyXx/Vc+/7TwTZvd3e2K5ACys
 sJZlgUdlXQLDpZO5VeZC8xUEIew9i6d7nEm0SkwEMgsGKwS0VgyVHgOgDTo4PcGyyggx6ESl5ni
 IusIKJlYVKqpR3JYlRvmrDaLMSNUKQRGJhx0Jg5Jycrg3ZZSxe3YB+eor5oh3r9Ekf6xWoY5IcO
 xvA/5zvwRKDbWYUORrqVy2idpiPdK6T3huVpvn2lJshU+3qybWkyTg/vIFclJb673AL+AcD54+8
 Dovy2QRQMtreUzbPnbf8ehZ7B7crZjvGFlHONpM8G/Xzb/876xaePKi+dhDpflmHfkKrFoLpUSn
 TN06H04H50FCceA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

It is necessary to account for I2C quirks in the burst mode path of this
driver. Not all I2C controllers can accept arbitrarily long writes and this
is represented in the quirks field of the adapter structure.

Prior to this patch the following error message is seen on a Qualcomm
X1E80100 CRD.

[   38.773524] i2c i2c-2: adapter quirk: msg too long (addr 0x0036, size 290, write)
[   38.781454] ov08x40 2-0036: Failed regs transferred: -95
[   38.787076] ov08x40 2-0036: ov08x40_start_streaming failed to set regs

Fix the error by breaking up the write sequence into the advertised maximum
write size of the quirks field if the quirks field is populated.

Fixes: 8f667d202384 ("media: ov08x40: Reduce start streaming time")
Cc: stable@vger.kernel.org # v6.9+
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e80100-crd
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov08x40.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 48df077522ad0bb2b5f64a6def8844c02af6a193..be25e45175b1322145dca428e845242d8fea2698 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1339,15 +1339,13 @@ static int ov08x40_read_reg(struct ov08x40 *ov08x,
 	return 0;
 }
 
-static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
-				   u16 last_reg,  u8 val)
+static int __ov08x40_burst_fill_regs(struct i2c_client *client, u16 first_reg,
+				     u16 last_reg, size_t num_regs, u8 val)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
 	struct i2c_msg msgs;
-	size_t i, num_regs;
+	size_t i;
 	int ret;
 
-	num_regs = last_reg - first_reg + 1;
 	msgs.addr = client->addr;
 	msgs.flags = 0;
 	msgs.len = 2 + num_regs;
@@ -1373,6 +1371,31 @@ static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
 	return 0;
 }
 
+static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
+				   u16 last_reg,  u8 val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
+	size_t num_regs, num_write_regs;
+	int ret;
+
+	num_regs = last_reg - first_reg + 1;
+	num_write_regs = num_regs;
+
+	if (client->adapter->quirks && client->adapter->quirks->max_write_len)
+		num_write_regs = client->adapter->quirks->max_write_len - 2;
+
+	while (first_reg < last_reg) {
+		ret = __ov08x40_burst_fill_regs(client, first_reg, last_reg,
+						num_write_regs, val);
+		if (ret)
+			return ret;
+
+		first_reg += num_write_regs;
+	}
+
+	return 0;
+}
+
 /* Write registers up to 4 at a time */
 static int ov08x40_write_reg(struct ov08x40 *ov08x,
 			     u16 reg, u32 len, u32 __val)

-- 
2.46.2



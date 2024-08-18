Return-Path: <stable+bounces-69418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7C955EE4
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE057B20D07
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814C154429;
	Sun, 18 Aug 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="upWdjS4g"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCA14A4DB
	for <stable@vger.kernel.org>; Sun, 18 Aug 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724012503; cv=none; b=IlYA2JhOaUlk6v+k0rF+XLw0defyLmn6s4qJkWqaGr3kCqyfnnfV0TEndurEiHrAF876VDTZsVeDwF3VNxL0L2U+j8LAhdy3GYUiBjrv+GmhhEOeCSPxrAUpCQsNmVhnJ5qF1mfxt44RNU5BrJ16fqDSV6YK+O0o3nYRxXUxyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724012503; c=relaxed/simple;
	bh=70Z4hvDcxJ0JQ1h2UgF/clGEXvnPtqwlNLdYJo/LkOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SgUo6g+hyLWxLvEIUeeq461MmSVZs87lxKN3ogieRpTNFIoGEzGX8Jwp3NOF7/p4x5HDAZ/3WPmwonjpKW7sKs8vda0bti+JiQkc8rcTW0pCV5AMTQMFQCCqa6+/DK8dJ9X4K7Do9jPcz5i1KQlohgxwtI4OYPx6NdG4zVGr8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=upWdjS4g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371aa511609so851642f8f.1
        for <stable@vger.kernel.org>; Sun, 18 Aug 2024 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1724012499; x=1724617299; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YP6/tJr0AaQIXolLt7n3xjX+yRAvdjUkQdCsfI84uZ4=;
        b=upWdjS4gqjW0G8OLeXw7JRBfVMFnPdzPLGCzb6JJAyxSu68srOvLqFHjGL5igHZkzh
         F94dwWFsc40XmY0MdhX/MIRbzYE2Fi3F0iF4OQn06W8LaUtKNae3VKOx5+Vj9ysh1p9j
         1/3NebsVkfogFyRCci1qwiQr7g+4KrSwT4FMvQ+H54//TnMyDUUKuM4MTXwV0Cw0caFC
         9XS3SK7wR0IRAeAUI1aqn2EjJMdmgU6G9GIhmeydSxWH3ojLW0tHzYSVIV5ZJJlKQ0fx
         vbWzIkiBVtCsUHajMzzKGJiOYwSFWmy2ZVsC28Gw1rXomA/XYJQbiGnXE0mijFTco7DW
         7xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724012499; x=1724617299;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP6/tJr0AaQIXolLt7n3xjX+yRAvdjUkQdCsfI84uZ4=;
        b=TcBwKgAO58FkXbDUIMF0n0hbto9rUje4JNQRnxhthI31hO+A9sqTRlecinlxNeZJXL
         3DnpgbVMyO92gUXdf9FfZh5TqbyLSE7Wg+6iM9OdD7jHD9zzuQL2w2HDUTTE4nWDrxtN
         t9on8ASe5JU1gA4ZhKHF0KqORYTH7O8ckGEO25O8UxW/kPLF6zDCPJdGHpJTDc0XnhMl
         PBfTpOvknMA7cufhzZU5aW9vq9oGcLJ/D6naUNaCdvCKPVByRwl+NaAKdMTf/EcKx2PY
         pZu+vOTaYMZURAWxr+WCkxysD3od3iYKjrHRecQTxVp6ok3yjKwKg1/f2IBtbewVlEQD
         vLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWxVxwB7UNPOnHfyjXqinp6eoYA/3xpEEmXNOZYPE6WbCjZLmYofeE5k5uwLrBitWtU+VHyPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+O2+kucjjAgbXzqw9ZLWGkjtTE+AICfbiIzmUk9ng7iBJpOaM
	AX/EU2+nrZxg7Ayq4Qc6ml+U/lmhsjJEnFXY2n70z5rzBOmbH9vJn2ShyWNw1To=
X-Google-Smtp-Source: AGHT+IEzeMiU4Y8sfoqhoetfoMozEKIafj6FwkmAOx4atTNxTwtNuJAsjc81DT9gdhnWnvwnbKMMlw==
X-Received: by 2002:adf:fad1:0:b0:36b:a3f1:eb with SMTP id ffacd0b85a97d-371946bfa9amr4842568f8f.53.1724012498679;
        Sun, 18 Aug 2024 13:21:38 -0700 (PDT)
Received: from [100.64.0.4] (ip-185-104-138-79.ptr.icomera.net. [185.104.138.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a05sm8716179f8f.26.2024.08.18.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 13:21:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 18 Aug 2024 22:21:01 +0200
Subject: [PATCH] usb: typec: fsa4480: Relax CHIP_ID check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240818-fsa4480-chipid-fix-v1-1-17c239435cf7@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAKxXwmYC/x2MQQqAIBAAvyJ7bkFNSfpKdBBdcy8lChFIf086z
 sBMh0aVqcEqOlS6ufF1DlCTgJD9eRByHAxaaiOdcpiaN8ZJDJkLR0z8oA5LSNYpqWYLIyyVhv6
 n2/6+H/xHf5xkAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.1

Some FSA4480-compatible chips like the OCP96011 used on Fairphone 5
return 0x00 from the CHIP_ID register. Handle that gracefully and only
fail probe when the I2C read has failed.

With this the dev_dbg will print 0 but otherwise continue working.

  [    0.251581] fsa4480 1-0042: Found FSA4480 v0.0 (Vendor ID = 0)

Cc: stable@vger.kernel.org
Fixes: e885f5f1f2b4 ("usb: typec: fsa4480: Check if the chip is really there")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/usb/typec/mux/fsa4480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index cd235339834b..f71dba8bf07c 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -274,7 +274,7 @@ static int fsa4480_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
 
 	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
-	if (ret || !val)
+	if (ret)
 		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
 
 	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",

---
base-commit: ccdbf91fdf5a71881ef32b41797382c4edd6f670
change-id: 20240818-fsa4480-chipid-fix-2c7cf5810135

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>



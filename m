Return-Path: <stable+bounces-56065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171791BD96
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 13:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E4F1F23104
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEEE158215;
	Fri, 28 Jun 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNp7xFT2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC015697A
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574635; cv=none; b=XSYwgfrkG+3DQeSiB8holmb73VtBmZPfYgV1PKUQ7sSh4N90yE4fAcTYv0AVVOGF5WdR8s0U/BnMWU7RgoKL8Tlc3WGzXXSVHTWdBgZ5PFepYql1QjoCdzUzbc6REFrncfZyfI+hIIiXZoAYY80aTqstKD1GUx+M3Eq3hW5SEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574635; c=relaxed/simple;
	bh=f0YR615m2QgME41ZUyooksZyyT/9mKV+05jqOFNdcZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Td/nmrryWDeh16wTOx+PiMF/u8e8iHm1+EUnDChgGyDjg5AZWFailnP9wJpM4wZUBR26p27R1WHLUQHJkPXgKxpgeX4HR0XOIiFvvEc8XHw2KsbrxhwOcwL3TIOIsWPNx0C2Z4gP6AsTZlV4HgXlPSC358SCYE5A5ZI/1iceNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNp7xFT2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so4360735e9.2
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574630; x=1720179430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwWX1BxAmFeGs34ZcghluLxqutvZVP2KEVsj6J0J/0c=;
        b=UNp7xFT2sOBaI3r2APh96XYGM1fCNGTmFBtcBuvKCl68SV/kHAtxm9z/31g3jkCKhO
         hsmlyIsl8TojS06OIvL5wO01ulXpuZdMV6ZyhxzGQPoCCl39VO6wyIh691cci033dNuI
         LiLWtLA1A/Yre1yvgi+52YLIK/VuZLkr0t/FSSnMM+xZvQBHHaM69asVy329qM2kkTaj
         3InIbeC7oJLo2XbYlREU55uMKRYbGU+6pNP20xTS9KoVZQLz75uaeUd7pbDnNrGUOvzj
         96IVkewsp4JXf7bAFYuse6QssTibPs2DZdVlq6h8tjpf/hTmnjF7I4qnCMtzARmH7cVW
         pv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574630; x=1720179430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwWX1BxAmFeGs34ZcghluLxqutvZVP2KEVsj6J0J/0c=;
        b=tVuc1vYWNIWbOJgh5HRWu/gZqg+9UXfMeCBRxGOsfqixt04LsxWtJI+4kyQkYyPJUE
         ipdYH7L8pFoIjONrI9+s3oc70EHIbJ6vnw4mKBls7QUSFSIYBGmFm7iCToq/RR9OIhVK
         72yYzVUqfMo29ByBGk8iSN5TI75mR5JxsBkc1MWeowaJriAoLWNFjP+YHrXwgNdZdpck
         NI+hRi9DsFIybUtRkWSXgzFw1FXsTqm8BWmJlrbwsUD++3JoIQRyhPb+ohiSR559tiBn
         wi/dqcfEg0WDTWrY6QTpbAApqXXLsGqsbWbhyo+XyesEQ4us7DvweROcQfPDh439Ll8i
         LyXg==
X-Forwarded-Encrypted: i=1; AJvYcCXppi//TomJ2CH/2XwJxEuCvctV9Xb1IdESpDxWKWfBBoq9F2e0EWQnoKsMp5XNuXNbFFP+OjU/lmKYmPWPVmoeJOx03N8B
X-Gm-Message-State: AOJu0Ywvv/3D7YmCb6gR2UK1PjEhnVtmS+3mdx9jm95+wbQngpHyqZaG
	vcRVSzmV8ombtcIEyEfEJWktYaTI4hY5LfRwnEi7NPtvU4bw7GJ7p+pMtzCUnCX6iVZAdMaVHPU
	LfuE=
X-Google-Smtp-Source: AGHT+IHQAPEuqCA3qwXGu6N+3+vFkEz2Q5fA7oNQ3wSkj2pPOLGorNhEGkU8syADGi1vAFMLoKOSZw==
X-Received: by 2002:a05:600c:56cf:b0:423:6b7:55eb with SMTP id 5b1f17b1804b1-4248cc2b65cmr102647495e9.14.1719574630596;
        Fri, 28 Jun 2024 04:37:10 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:09 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Joy Chakraborty <joychakr@google.com>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] nvmem: meson-efuse: Fix return value of nvmem callbacks
Date: Fri, 28 Jun 2024 12:37:02 +0100
Message-Id: <20240628113704.13742-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
References: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=xzCb2vl3xj3rdJauJ6cZLY2wKERo2kWjhl7YDaxZ4iE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqBTJvyc/Rp+GQmZ6rtTbXTrVdNH4uT4tvR8B 2OiQURtv5eJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6gUwAKCRB6of1ZxzRV N6GrCAC7kQG2q/QVs7FPXTnHOzKxNVncou+IuyA9IQIWyX1doLaa/wjLW411S6g9c38TMdNdY0+ 9LYLUPxDU5akyy4oucX+n3JnyAaY8FG4tfWpb7gzlx9/+dOKo0mzYUFIIcbYSKIzTN5sFuDh4GU oWNlQppCaJi46GbjO5YCR56mDGNdgm83TuROWn5Yux4vKS8z9Cb6Vh8u8MSSCtACahbKA2/wOtW X7NH9QIyvbEHfvz5fGOwDKlXKj0K3FwpfHciAf25DRRCNN0xWZYsQRYoUX47oK/UAQU25CVjSLh JQwKz7cvMYnLoDFyIzmvcEtvwxOAxxX7HAc/xHoVXFdS91tC
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Joy Chakraborty <joychakr@google.com>

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

meson_efuse_read() and meson_efuse_write() call into
meson_sm_call_read() and meson_sm_call_write() respectively which return
the number of bytes read or written on success as per their api
description.

Fix to return error if meson_sm_call_read()/meson_sm_call_write()
returns an error else return 0.

Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..6c2f80e166e2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {
-- 
2.25.1



Return-Path: <stable+bounces-56064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311091BD95
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07481F2330D
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E21581FF;
	Fri, 28 Jun 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmzYwaw2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC77156F2D
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574635; cv=none; b=nrtvvWpi43o3ZqH4AFLlGqEHPQlRYcr4vmYck24tjI4jv9zPvaDdFM7hVck2N4ba0cXx0zeS7/zFSeHkiKboKlo1/qyC7K8l142vbFsf5K36v5OjHjZN0BCseHWipMVlY/mB9jKPk9dZw9zSZXaOZFugZtLW7aQBRZTt9mm2Djk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574635; c=relaxed/simple;
	bh=ye6FSQS/NKpcJzutp03vkmto5rrZ7PNX1AcZMkv0NpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLfcY7P2HBs2ykkBkyPNz+6o2OiuhHpeJUKY2rGiA81/YDYo8JGS3B8NZK7AtrGn/OzsDi7EKz90Wu1+lSge8Prvd0mr/Zl0Hy6IIsG1R3c8vP1uN6i8N40o3yOOehHKOsO9fqv/RwCxpsAF4EeUnme62vcdXmWm5QLm+7bMkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DmzYwaw2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42138eadf64so4442385e9.3
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574631; x=1720179431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dllfp3FX/5YC/zss7njE9Wc54i5SAUNqTlCZuQW2zLE=;
        b=DmzYwaw2xUgSvCDAvmLXW7CPP3rcRSemkJTBvJouieSyjZzVKZWBhBJRn3TXBvT/JY
         guuZANHYJVoITlnrOWKlFt5rG2hUpXweTIA+cwv56MOsKkEBwRfxVUdvp5F+UHmXWITn
         kutoY9FwRO4bJara2AaYeBA8twHvgM2eEIP65K8ZqplilyKXsNxcKlnTyoSHpMQPHhwy
         pVxFeRAjr4aLiJ0fdwp4Qh3kBtTYd2AO7NzYb6lLu/H5TdNKusqwWPXPi4328h0goG3z
         +kW4UXUnNCwphvZ+dZ7yAvZoC9srMRDGORXgaOTGp2jWbyodu8gOh5BO3/GsvasxMCTP
         7jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574631; x=1720179431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dllfp3FX/5YC/zss7njE9Wc54i5SAUNqTlCZuQW2zLE=;
        b=Qt1F9iVECVImvFARvi9me9NMusioVvSOnB1cO4VZOXCidDNIawMkVnNKhhjGkAK/1i
         f6mH6ZVh4/p3KVf0IGaQrdTmluNinh1PnF4VP5UvQ0dKmswnX1ERM6FXtqnTOMy8ljfK
         Op0lmcUcyXrbIh62wCOUuspCnRIYv7gQB4OnWt1a7gzjVDh2975GSrJjSlzmGFEDU0++
         lUXON9ParpY3jZr3ygyV7nFTdm526+XBWG9T9aQoZ6pEril1n8pdwSJHLQbgvrMda0gO
         qSzkeSfKk1uHcdczqENrf69aSYMC5w8T2RoFfPVcIXhE9T9awxKeE/n8uOFvrGShpdpX
         CjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSPHGgL17RcTfXPkVQRyO5gLbippoNovW+/Gzu4E6YZFL575rRKD1hHzC2EhBpEFZn7xevF2W+cfWFcJGjYP/3wHoRzTfU
X-Gm-Message-State: AOJu0Yzn8yW9/zJG1CKMnx33xD11IDeLhjgTxkSLs4hzY3rkz/vEHrCR
	5gx6YXuvu/NVQKtIEtb2mFj2NrJyYI0PkJPQPfdgqUfw3VIa5nZp8blkDhXzuHA=
X-Google-Smtp-Source: AGHT+IEP8mJtr2lv0WyW5t8xLXDlcpnPJ7I1nJsFkBFMY1oOTNaTcrHwH+OH4b6EySrpeAIuc5h5HA==
X-Received: by 2002:a05:600c:11:b0:425:6bea:8554 with SMTP id 5b1f17b1804b1-4256bea85ccmr13302165e9.27.1719574631518;
        Fri, 28 Jun 2024 04:37:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: core: only change name to fram for current attribute
Date: Fri, 28 Jun 2024 12:37:03 +0100
Message-Id: <20240628113704.13742-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
References: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=13iG1hG1MVP/pselTNqSmavmAZ1CPaJ78TUQIlJ1yGI=; b=owEBbAGT/pANAwAKAXqh/VnHNFU3AcsmYgBmfqBT+Em9xCEa/qzMWYgKZcaUN5HhiHE7IZ7SG u8x0i+hVciJATIEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6gUwAKCRB6of1ZxzRV N8ToB/dXE+xVIc6GnZPcsWPb/lhvpTL21aR57RHEvfNxHSbmruA24nYginOnvL+gts3KVBRoQcN oQ1tGr1HHc38SWuZRlKOnhPsAL0vUSbsSHI5sRleisOjXF+DJpYeermvcCY8yUqGnKgeWyqYdHD 2ago7IDeH+HXdMeRnz/OGDT0XQC/4/lSMdb3qor2pUWznpFb/Hhfrl8RtbnD1RmMmbJOxgY6OKn Ez3Zq3IBOkh2i+giS3u4+pW9/EdwfugCtmh7c1z8R2+K0YVTfBGzqZbf5KxtLgX/LRYkpU/bVBl Q0+OQ0DwItpB1DuM8wcSQgy1BxVb0mU9iCyAKekJvTa2mEk=
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

bin_attr_nvmem_eeprom_compat is the template from which all future
compat attributes are created.
Changing it means to change all subsquent compat attributes, too.

Instead only use the "fram" name for the currently registered attribute.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..1285300ed239 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -396,10 +396,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (config->type == NVMEM_TYPE_FRAM)
-		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
-
 	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
+	if (config->type == NVMEM_TYPE_FRAM)
+		nvmem->eeprom.attr.name = "fram";
 	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.25.1



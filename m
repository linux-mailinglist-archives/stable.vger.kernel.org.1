Return-Path: <stable+bounces-89325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D09B651F
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E840E1C215CA
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D0A1EF953;
	Wed, 30 Oct 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz+N5jTk"
X-Original-To: Stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC731EBA05
	for <Stable@vger.kernel.org>; Wed, 30 Oct 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296991; cv=none; b=UOlbUoHoN58zR2DHB1qJUzO3PYTGtHLWoVrd+rO3j58jMxajGbblHys+JmNoM6SrxYubXRnEOPEHDKVfHQnG8YHBrNC8XUq/yl272OgqT00rTRYga67FuDxjR+pKt85x3Q+Ze30xPBqd8GQxdlng85RIU7Rl3HUI+kaxqDFz9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296991; c=relaxed/simple;
	bh=KcdzhRO/If1OuI4c3v3ZnfFsHM+6d695CCxO1Jt01YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFyyEVEUCo8jh0TGd1xUq5Cy82FSO6joTWpq2ph5/LFMJPzSya5oD5hQGfW8h/brCNODUklRKJwTxLFV8DxLjGRGQKTb++QggGU/1erofoxZKHhfGmBGyrESIEymF7p7fBUBwyzUgcsO3AEvxZznRis3sawYwYzHtMwvcx0GDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bz+N5jTk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso85037345e9.0
        for <Stable@vger.kernel.org>; Wed, 30 Oct 2024 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730296986; x=1730901786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfw8Ood4YyQU21hBhhh/MYB/873eLuPNg8YIyr6qoJg=;
        b=bz+N5jTk/GErvkxyZlOCGtCKfL0vcePy9vrJMTSfXDU7RqveZDJdqYO6DIH3nddf/V
         KGkKF1MuiCaDUP+LrsqaDJL1ltvpoAanDjMlq1R+jQrIGoORzFKMIRr9M8wXhJ30oWrZ
         FaRi0n90RWqFvGefDJi2dfjPKyooLPWNqEGBZHqmGnvuD52xZetcPErnfXDFQWZYS2+2
         v92lHRl6QUbiSbqLIJsaTb6M5n4bsY4BlWvj27SA9bmh94RXthTWaccXeRFTor3O+V6u
         b5S2Tq/agFAmKADsqzLBWgK1LbS3I4+Xt/rz7P0l58Uelj3/g6S1nTjtmBcaYWvN2Ed3
         dBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296986; x=1730901786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfw8Ood4YyQU21hBhhh/MYB/873eLuPNg8YIyr6qoJg=;
        b=pbptFXD2comi+2TrA5NY4l+EVbOOjEJyF1Fp5CPWDiMNGkkB0V2szChKCEakygZT+z
         wt5KjLPThLs65uxxXI88MPw5AaYay+s9aDv9QbKoT4xtoR9Ger8NZQK+/UVODnf8tcGK
         LDe+h9eYDEDNBcsFR7o3HFk0FCAI/VxCXIjJtGcrnHjIRTM6TlGB8hqrE28rz5UBH7T1
         xkyf+Jx5rJxhLfkomXXPj4FTHggH0l5wVQ95G2ROOgHEgJjbUQjXmu6uXgPZCyjkJ7Rg
         /CfB1vzUrCIpsoc1Nb7aZUp2pplVTmMF9D2oesX6uruEh2n7oLa3zXYuFGCyikRpoYFY
         w+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWN9RjHpCao6YhK4TzLUkT4i0KXVvbjtaNhbkNyoQ8Lgrbj+wdqdAt2tveZZUesoR/MAF5XxlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWqfKV0U/nuvnvSwGKn1waaUME6qiSkjvteV83mYsrYIJjJgw
	RnYu0GNsXXMn9JhUelNsnSLOp1Ge4V+H+i6IXJdP6d6uI7eUY3iXNaFZLQF7Qy0=
X-Google-Smtp-Source: AGHT+IEIra2ZxyDFnzgwj/1LVvss6qmyetjd0M3URL96h9nwuQpeiVOuZyRjsuqvzOCA415x1Ty+kg==
X-Received: by 2002:a05:600c:4fcb:b0:431:5ba1:a520 with SMTP id 5b1f17b1804b1-4319ac6f87fmr177890425e9.3.1730296985199;
        Wed, 30 Oct 2024 07:03:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd918220sm22707505e9.2.2024.10.30.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:04 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] nvmem: core: Check read_only flag for force_ro in bin_attr_nvmem_write()
Date: Wed, 30 Oct 2024 14:02:53 +0000
Message-Id: <20241030140253.40445-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140253.40445-1-srinivas.kandagatla@linaro.org>
References: <20241030140253.40445-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=NfPJa1RhH2l4SVfGLaSbnnUZwziHJIZ8twODeIGtxjo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyN5dICX5eb+r/9I3SYIH1H2okyVdyfkfdYz 2O3Ri/vxfmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8jQAKCRB6of1ZxzRV N6b7B/96zr+2XsHz5POjTgwlYqTncQAQPZbAisQhw5BkfKNO4hR/+JJRrDzi0redGIBpV4u5xFc opDJWBPpmI0CPHnQrcSDyjrwzk9Vx4Pkxo0ywXqkFGtfsU3H9M1XTUEjRa7CjbbeLL36i0srtpR qgx7UV/HfGZN5WNOVJWQqYzEewwt+jZ/J5y9cBVNwSm3VObmHdhHcNib2ohRRnW7tVI40k+1nMY 0z19vk3nZb3jwusaDWkflLPnx0KNi9HyQa7cbv4umi7GhQ2qIY5LiJPm82Yf28FwoohfFOwYPnr TJmSDrD3tXzfWj3I8I8sRph/LfKkeE4t4SE/hjyC4DcobT3t
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

The bin_attr_nvmem_write() must check the read_only flag and block
writes on read-only devices, now that a nvmem device can be switched
between read-write and read-only mode at runtime using the force_ro
attribute. Add the missing check.

Fixes: 9d7eb234ac7a ("nvmem: core: Implement force_ro sysfs attribute")
Cc: Stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..e1a15fbc6ad0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -267,7 +267,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
-	if (!nvmem->reg_write)
+	if (!nvmem->reg_write || nvmem->read_only)
 		return -EPERM;
 
 	rc = nvmem_reg_write(nvmem, pos, buf, count);
-- 
2.25.1



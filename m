Return-Path: <stable+bounces-106286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483969FE6FA
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934CF3A1615
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCD1ACEB3;
	Mon, 30 Dec 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deYJuRq2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828E1AAA1B
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568453; cv=none; b=FocD3drwwwj9JpXzX0UUUiW2bbS/JB4awOiwpcAlJhjL7/sNS1MKQWRQ6GRywkK8Kt9X4Uew7IB0nk2nR5ZWuJD29T/Jxv55PEdkNpOBQ7rTtJkTUsdQc2oudG4QWz6Ec6KE2JLka8UkMNejKDsgmS9Ybmi+0zP4/K7o72VAe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568453; c=relaxed/simple;
	bh=9sPmgt30nBGMdwfN5L62gm0t+fmgz+pvqOhAQOfBJHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSY++aR5stlDV4aRX3ugkuRgbp+D2GF9Oer5Jwks3HzXMLkAMIw4rZokHVUCXzIrr/mkXCUP1QUKCAKJPqfL9poy2TqY4eJmHIrQpnpCG6lD7emTCd6r5XrpQfdM53b90CUDSct6c89xTd50MLSTWZSQI74jMIH0mufS1IlUoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=deYJuRq2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso92537135e9.0
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735568450; x=1736173250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccNwZtNnGr/4W9StK3y13dTEyPZkarz5VVc5IgE/Cww=;
        b=deYJuRq2rGZc7s2BVC9WutadUudfLQklL6pdLbzM+Ow+4v9yvcW+Qgz/s40m6550Fq
         ETRvNvAPi81gwocxvkXwImR4F30vhXSTXMjGT3DY3rKcjxBdHiJLkBTjllQNsX+H4lVj
         AZezNhLN8gprEY+0ZZD7ON9WoXVOhFAyFZVXIpcUQhhWb4DF7YWgmei0B45mLWJjkxuI
         QX+Au7nbpngGGIcaoTdfU2uNPvV5/O0T2f3grAkxyGRivKDAEJejXhM11XAjochlkp5x
         L8s8rkIZkXxH0kREl/Moecub4NYam8fF8KMqOey/61NMucWOdMUWzKq67UoFlRgXHsmZ
         CUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735568450; x=1736173250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccNwZtNnGr/4W9StK3y13dTEyPZkarz5VVc5IgE/Cww=;
        b=lHYkPj3TYcHZ1CCZ/k4qcaTMhwPSQnYSxGvXiqew2FyRJ5spSMd8VBAThnAvaoAsKa
         oUbkuB0/WIGs69PNLX3o/Qwm1/Xs6UeDZUV8Ph6dMg/g3BjipP12Z2vomJAvLc+Ub9DO
         z7MiCWwY3QFfArC3coEdBIyAu0JQyiyrZNmjwK5jp2xZVDtGPibLHI7uctyPW4GUhT5g
         Mow7Pm4ZV1LrGcEX6XBY1+OotgwDEdaQD4vIXcaOo1DV0Dz3IEVyXs5PSNKFDB1giuhz
         YjGwsIhKRLAssMCMz58DaBHZi+w9fxFRaM6qJIavojXYtvyHP3ksrKfz3OwuUvB9FoIi
         Xtjw==
X-Forwarded-Encrypted: i=1; AJvYcCULA1Hi9BRGRvHqlTIjsHszve11TJFVmpc4gtKj4tPlz3u/MtjkBLLbWPkgvxXLlXmQ/p5y9B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxc2J+0W7eWvxOWImn6X0G8Qz5opanWlFM7fzXIZ8NYVN5pIC/
	feDcK0g892EfVNT9WO/aSrIVnbOajMPPoTLkX+njcfFDM1q5VO6cTYEv9sk+eBYn7yflVEBCM8m
	A
X-Gm-Gg: ASbGncvGu09hr+Yv23+PxNNoJDsZ+xEkHOEE1Xk4MmwhVY6TVjcVyL5DZK6Xm4WDdil
	D4oIEQT5jHKhu85Y5EVo1CA/wEGnGH3Iunlikaeg16yXJOlzgJ+q4HivuEsURzzAwbsfAWs4fWn
	Qko9KMMf0P4huCwW6Kys6DEzKjNzpP/FglF5moOzc3GziGFJ/aITCuZDxs48p49+XB20dqORBl4
	LjzcrQaalWEAp+9r95ux1VTmt+cvEGRQGK90DqvpwtssEbjlH9GWlQ/uOLuMk1QD3ROwq0tllg7
	skBq/g==
X-Google-Smtp-Source: AGHT+IEZaffaWtn5e6DdWpG4G/dL+kBcYQMTaGM4Gv+hwB75plnav3yPRsIBsDBwaFFwiryGINPc/w==
X-Received: by 2002:a7b:c3c7:0:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-4366fb89a04mr355346625e9.10.1735568450170;
        Mon, 30 Dec 2024 06:20:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8471dcsm30377536f8f.48.2024.12.30.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 06:20:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	stable@vger.kernel.org,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] nvmem: qcom-spmi-sdam: Set size in struct nvmem_config
Date: Mon, 30 Dec 2024 14:19:00 +0000
Message-Id: <20241230141901.263976-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241230141901.263976-1-srinivas.kandagatla@linaro.org>
References: <20241230141901.263976-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=FL5THL4GxmLd5V3ZZ9djMFqthvMfgl1TEG7K7smrkEo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBncqvVzROS27/FPVGORk5eHxHWAmoryOsWk6wj5 +WhjS06vvWJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ3Kr1QAKCRB6of1ZxzRV N0BtB/4qEP5xPVdXyT6/OGlxM4X/DlvdFpdkicqFt2WRGBrEW6aW/vf7/PFV2YLENXgLCyJeAPn 5gCgehXiFEOm135kyBv9n8EZeoovMgpAImJqx++fcWAtF4rLIgGPA8wVzwu8qgRH10SeHAxW9NG +Y/asphpEeO9ujUnu5sqg8+bqTkZu3EIVMcbFCBqmDinKwUIyv37TSy7QyG24snnfKFe6URQ9UG CszLrvKCB/E57v61lZSBwn3jHbVjCBtylfkoovTCN1IjMJTYE7YCkXy0YOy7aC+tP2jXZexZaVX 8xThq757w8BmDNZe6dY1odb3rVWOibU4sYT9RvvI7Z9wv2h0
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca.weiss@fairphone.com>

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
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 9aa8f42faa4c..4f1cca6eab71 100644
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
-- 
2.25.1



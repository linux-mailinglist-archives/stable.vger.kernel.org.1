Return-Path: <stable+bounces-108700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B9A11E4C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0853188D3C2
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5DB1E7C01;
	Wed, 15 Jan 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOeHsK1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD00248196;
	Wed, 15 Jan 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934086; cv=none; b=hOqd9LZTMQxpPwWDa340ZiZf3R/mFnJUm60Tvuk3DYgw4g2HoadEPL9axrJyAChpDG+CGeVCEyI92mUE5fwIhyIyZG6+xXOT+YvEy2LIKJSIWjh4ZUDRVIH1lfSKO4uQNQAP0J9XPUjVZ1HoPb9NAsyK1OZdqw64Y2d1KuHDSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934086; c=relaxed/simple;
	bh=5oReLHIpN2lAiQRCzx/Ef7CF91qXy+TZzyyQ4YBsyNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z2h+bjgpP9ujNs2MSxgms8vbRyv22/CLY86L5UYRgyqtXwECGnOP/TqGfzIsAurIpTQQyY7vlM+bGp3l/brMnXqYBZeW0bjOVd1KQVR7Gur7YsfQ6Tp+MOsNo80NDfMZ0fkdsIOwHYkWbBmJ9aZ8eCXnPDZmhzDJ9J7j1UwprOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOeHsK1V; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2163bd70069so118050855ad.0;
        Wed, 15 Jan 2025 01:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736934084; x=1737538884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITCpAMeZuX5d2LlTH5TVNzmiC//AJQ3OwCZfN6NZFnw=;
        b=XOeHsK1VHuWokkHnXWwBgXjKfQxPKMrGSQx14Z0m3cSDt+RHzORa5xuYeQ6eXRcXNH
         zPnWiKm2eEEYO2tvOii3vFYXtPUzJdWeX+6SFWNezxipsUdq6COom4nRS1HJeRio/obn
         dgxRN1+WS6N0eWyyQevJaNittEOCgvpdkniYCJPTb+fyAEgxD5EF8Aoge5Ch82nNjdYw
         26gg7a+mU2C7cTBVhDnqpMs1hbArXHigC0jWohM6v8YAtRjwIhGPTmlSA3TaN96Q6v8P
         1ygSpL9qVSlmd9ZFZnW2wb0ibY/amfyfIIALvj6+5yaopYxmFAi8/wh/wb1YQWdtSOEL
         05SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934084; x=1737538884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITCpAMeZuX5d2LlTH5TVNzmiC//AJQ3OwCZfN6NZFnw=;
        b=stIhSnd16J7OSKRFaAMr8lgD8QsliONBI0lIdcJj8htl+ta+KxFwXCzkP3CyYIVcKT
         RX2wZtGX1Ph+tb91YsNjMNHm3kLwu9OARy606Qv3hKH6LCWxg9aAzX2NkoDP6TaJQC3I
         rreGlwbVeqDLzcgWNwZaRGbvPmziZb/EvOqCL1KR/wI9qzqfdcv26Tqjl4IIzF5ZcFI5
         VpMmg85bknWg6abVYfiJGS8o0n7cPPG48FuqN/bEtwkxbdzK1wrH++euu5vrCvZ6hcgg
         38T+nmA/peWBWamzEOsTfYunoQl7SUyGIdrzTOKrLUsFlOEfBk+BcgWVhARI0zFqvFwJ
         hjLg==
X-Forwarded-Encrypted: i=1; AJvYcCUknXQBZ1QV5NTZ8ZdP4sB2wz8F1mI1EejdEmc4n3Ukc9VppmOFFSvRFxKtZ2hfEIB/czWBUHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MGi4j/owBPuHD6mfk6L3HNVWYjVm+vnJjozUXzutKsTad9gj
	o9ULRslYHR+y+0iR5We8P5DqLpGhBeUgJE6i2a8Utdv0m5A0IZqcfwvZ48fNEBs=
X-Gm-Gg: ASbGncvp7+YGC8yx56ZsH2fnM4YpWn8vvgLPZdPBn5c3MJidtBB7NA/bigAlr9m0MuH
	sXre/0OBwcssAbGh2KGDp4nRWMtnXMckXeTFbMStxjSrg4l9Q3u+6EVImxv6PzA9QoVqRQeDqyf
	OahBcqvI4TxqonpwcEC6d+0smdWqu9HhAKjH0IK8X1xksgyRdajABtMcECpZZYIIhGNOovnx2xu
	KqxWKFPbBFdSvVyGFC4ShV+y3txScXZnGy4z/FszlMVJQ5opmcUTAAvCsve04mfrTwEu9Jqnt4=
X-Google-Smtp-Source: AGHT+IGHUvaFye+q7lzfN9DBn9tovAaMnHoP2oHY/3j6GE9CbQBL0uvkblyOPcLlhvxb98aohKoQng==
X-Received: by 2002:a17:902:ec89:b0:216:45b9:43ad with SMTP id d9443c01a7336-21a83fa3d89mr431182795ad.34.1736934084527;
        Wed, 15 Jan 2025 01:41:24 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f1381a6sm79706035ad.93.2025.01.15.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:41:23 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bus/fls-mc: Fix possible UAF error in driver_override_show()
Date: Wed, 15 Jan 2025 17:41:02 +0800
Message-Id: <20250115094102.103503-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a possible UAF problem in driver_override_show() in
drivers/bus/fsl-mc/fsl-mc-bus.c

This function driver_override_show() is part of DEVICE_ATTR_RW, which
includes both driver_override_show() and driver_override_store().
These functions can be executed concurrently in sysfs.

The driver_override_store() function uses driver_set_override() to
update the driver_override value, and driver_set_override() internally
locks the device (device_lock(dev)). If driver_override_show() reads
cdx_dev->driver_override without locking, it could potentially access
a freed pointer if driver_override_store() frees the string
concurrently. This could lead to printing a kernel address, which is a
security risk since DEVICE_ATTR can be read by all users.

Additionally, a similar pattern is used in drivers/amba/bus.c, as well
as many other bus drivers, where device_lock() is taken in the show
function, and it has been working without issues.

This potential bug was detected by our experimental static analysis tool,
which analyzes locking APIs and paired functions to identify data races
and atomicity violations.  

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Revised the description to reduce the confusion it caused.
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 930d8a3ba722..62a9da88b4c9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -201,8 +201,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.34.1



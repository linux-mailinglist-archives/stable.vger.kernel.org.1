Return-Path: <stable+bounces-92812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91B9C5D14
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885152836AC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15024205150;
	Tue, 12 Nov 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpHHm4W+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80546205152;
	Tue, 12 Nov 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428674; cv=none; b=OG8CO/Pf3AbUgmVfJkO7Ikn9+thraHahD3xpKgWnlsQ7EHF5QTr4eyJEhU4uN/jJLQuL5nAHv1tgJhw5g3wv1b2TYw37RuxPmHh1oVsb6sYycrz8oexK4SNg9RtVJesTFOOIxmIQTOozjcgs+W9YIQaLjgKel4Vzo/Eed6V7sYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428674; c=relaxed/simple;
	bh=ag/HdRoh38kbO1i9DHSCd4uqYVIokme209GlcgzIAto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/74tFYpJKfTUG9sHnfyeCw7r7wgqpqnkDv8iLp4SRC73BmDHoVG7shOhSyT6wAzkpOAC1X5dnVQMkYCSiZrIFlj+0+0EuRmzK6Q4lnC44lj5dpz+knu0ZAISdauwVpIXa3sKKNCUIj/UHqkJZZU2oYFBmzPYwiHr/H8b5zGdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpHHm4W+; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-720c286bcd6so5254256b3a.3;
        Tue, 12 Nov 2024 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731428673; x=1732033473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7LLPaLtW/IEmQFdv53g6R18K2MU22yx3TojOFacJNg=;
        b=PpHHm4W+orsyjmAsB9B7bK1qcKaj+O74pGNoaHPXEAxK96mNjyZ1nF+kkRywsDwkKY
         0ZcSW3fUW2QZtvG1qhc+sKS9YvIXP8QrRu8HEGX2a3uiSLCDrvHhlrlq+ArHjQjnWzHK
         c0PeowJFr50wg4au042V+xGZOD0r53mjBJw1wN5fq7m2LYc83C3hz4bZU70rBLGeVq4M
         f4faMjfuHc8VVm0Hcvo+lyL4R6c292uNBji5L6hRfRnlv+fqP8HuYo3JL5Op2sRAT9ki
         RnCe7MKmJvc9Kmr6r55oWs2bN1QduJI8Ehxtq00Rx/vHiaKLiOCBhEiDX1e1HhA40ib7
         Vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428673; x=1732033473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7LLPaLtW/IEmQFdv53g6R18K2MU22yx3TojOFacJNg=;
        b=mZExUm1eASz5WmkFamST2DgrOHLsNnS/Di6k9T4XMCzhSKRNEmo8yqwZdvv7syT6fI
         48WWk6EgaD4WoU5exY6bFowjoCnRrIybzd9NwNRke5L5EqCtHGKc/yySiE8TSCKcicch
         ZiFtX14EKDyKwFL6sLuWgWEzhKrquNjVISfKwNViJO3Je16traQbIl/rJf4gqg8ZfX2v
         JBB35UvMeZRixuVfbkmD3PV33Dt+2ccaV6e+6sSyvNU1H3QOBuSo8fSxm0bK/v4tya/T
         qRi+bIuyMpJcgWdMPnvoeR1jJl0oIyyzfYPsBVWBRfpQqww/0zydb98c75DtTvTV821v
         E6eA==
X-Forwarded-Encrypted: i=1; AJvYcCVhKKXFI3Wx8rWvT7mt5syPm/BoyBSOyvwu3vAO4U83bzkK3kfmNYFSvPGIDurnc6dfpIvm2DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uWWHz5An06CeZY2H9q69r2/+Yt7jljqsKt3qPrYyHd4ebimq
	LX+fQK6AtS8bJNd0Lep8tcRiiWiHUIlOrfWYW9vZP25SMqbQkfJnrW0vBXK5OEg=
X-Google-Smtp-Source: AGHT+IFwMNvSijpAcd2Vk7MVBJqqB6TV2LM75YTFipHJRvolV/ABn2k2vD5t+4BsS3kbXLY11lOoPg==
X-Received: by 2002:a05:6a21:33a2:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1dc229d5f22mr24226019637.21.1731428672744;
        Tue, 12 Nov 2024 08:24:32 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f67f079sm10730093a12.85.2024.11.12.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:24:32 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus/fls-mc: Fix possible UAF error in driver_override_show()
Date: Wed, 13 Nov 2024 00:24:26 +0800
Message-Id: <20241112162426.39741-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a data race between the functions driver_override_show() and
driver_override_store(). In the driver_override_store() function, the
assignment to ret calls driver_set_override(), which frees the old value
while writing the new value to dev. If a race occurs, it may cause a
use-after-free (UAF) error in driver_override_show().

To fix this issue, we adopted a logic similar to the driver_override_show()
function in vmbus_drv.c, where the dev is protected by a lock to prevent
its value from changing.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
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



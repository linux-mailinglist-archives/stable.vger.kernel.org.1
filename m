Return-Path: <stable+bounces-109430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F81A15BA6
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 08:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BAB7A40CC
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953421459F6;
	Sat, 18 Jan 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaxqycKJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF1126C1E;
	Sat, 18 Jan 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737184147; cv=none; b=jxBsdGZYQSa+dT1L7zKWC97I/RSbbY2arm/toGmjWhmnVx7J4aaWCQCiPOLjuvIXrSl6p45S3FGAgQ9JK96YuXA3B5g/RBXpTQPJgON3fvem9SNnf/RWtDVq/vfYYT/RaxUsEW5pLT5YN6U3pA/W5fkKsPd4E6J0seuWTOJ0Mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737184147; c=relaxed/simple;
	bh=ydYUFpTfoFKyM7TEYILooPRIN9Ue1rFIdpad2ndazg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpTxGiQ/HYYSM5XJM+ZwnoDYGn5A5xyVPjmdAVS6uE5+REpp3KwhO/Ty5fpKkKNuXAGK2CycW4SluggpkRyvZn1GNDUfYq5E/Q7Cuz+efF2dgXiDjLsdTcMZ41rQ9sWJlqsBfvEtlRlroXfKCNzZfaAFIk4Ie0S1vzbZpeUonU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaxqycKJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-21649a7bcdcso52098635ad.1;
        Fri, 17 Jan 2025 23:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737184145; x=1737788945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jIl1C9RNfXF7o6KaUUW4aB3oigDEkuPQe5BHvQikPQ=;
        b=NaxqycKJ77UedoY/Ocplge9k9ZRiiZWKBsFY5HfzYVLVewW8ZCmwvgV6rN9Lth2x+O
         RzZrHoTD9WMzvjfkJPtOkvRDsK6SIiC3K7lfAMupV8hjVREOkAY165N/srA3ZTZjUaft
         tmHDyIS1RSwAfPbwQxWsSZzNOJFY3fi+lbNAR7YkUVhqtMx1eIk9REp+ur6zdfU9aarv
         CoS7F+7xnzcvuPDLgZk9cwu940yLeo+MFWapaHusmd85llm0HXA488F0wqWyETK7BoHB
         b/4jJ2pVbDRmFeJ5l52u/yDTGOey/ycZvfLMe6Da+rcc64BiqGeo/zlnriig0XU+3C/j
         +PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737184145; x=1737788945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jIl1C9RNfXF7o6KaUUW4aB3oigDEkuPQe5BHvQikPQ=;
        b=e4JRxZHKS268WLDxS22O2bWKv5pvsr9lil3gsiL1kN1uUGgRZ/MxiUzzxF6mJvWO/y
         j/h0neGj/noT9+dRdcoVBzAlCYYQrzYXsGz4pVPH4tHp6UrC9dRvNSwlyoHmo4lwhaaA
         DqLbn/fth1qw9KwUuGF8yLCW+oIHLk9UzXywk+9qcxIGwvu0SNf/UkGpES2I6IVcb/Tn
         IwFSQx0zxmNktvZYqfKXKHzmOet+yalKko4h4JLv5ha87gNly1PgczMYMgl4xQ5Tzrl7
         wVxt6XvPldAGVEEMnR6zUm6Giz9veBhCzOywypAIx15dpwF/3O77Wisj9nKnnPVPArGU
         qw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfDUOMpcszbgPi0Hd1f4RHAO7Si2uzF6wNWZf9QXaueybftASQe36tyroCfqiF85/8rYatZYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EEO2kXMJz31EtnLQxH3Oh2PxVG9ZJUcwnTMx1C616Qv0lS0s
	WUPmLtYXMERoSQtUS2jCW+oda5Kqv+JWHYJEpDeaBaBvgVqeq1fxs/oupoKWFLccNg==
X-Gm-Gg: ASbGnctVXiE3LUSZi/grdYha3tD8scFmEnChI9flMyqWTc+ChwdR/jSjZVYAKTlE1TU
	0OXGCGYC51xV1Kg6Jol4T7NVK3EwzyS6IVc3kIMj/PEfTqcNPpliH0XXg8oyUPJLww7MMnhimvD
	Sh3RfVHuyMZHJ6PDMz5VznhmE/9jmHxtjjZ1MsutCzoAI6nOI+1MJsWrEBDgnABsQQJDuWNXdVH
	+GqZf+BAkudVfvJ5d1hZlQoZhoJLCDgzGv+k0lG1jPW8EpoeuU2+MA0Qh4I7CVW5A8PKtRaXCXe
	d0+JHlV3wDo=
X-Google-Smtp-Source: AGHT+IEfe3yetVbWE4OnE9wUlQB+bU+2YSQDKPzVZdbmNXsaIGY6VYUaW4ad1aTcJ3GUUvSVs0ADOA==
X-Received: by 2002:a05:6a20:7fa9:b0:1e8:c159:b6ef with SMTP id adf61e73a8af0-1eb215fb150mr9240395637.37.1737184145188;
        Fri, 17 Jan 2025 23:09:05 -0800 (PST)
Received: from localhost.localdomain ([117.140.170.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81762bsm3197643b3a.62.2025.01.17.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 23:09:04 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	greg@kroah.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] cdx: Fix possible UAF error in driver_override_show()
Date: Sat, 18 Jan 2025 15:08:33 +0800
Message-ID: <20250118070833.27201-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a possible UAF problem in driver_override_show() in drivers/cdx/cdx.c

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

This potential bug was detected by our experimental static analysis
tool, which analyzes locking APIs and paired functions to identify
data races and atomicity violations.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Modified the title and description.
Removed the changes to cdx_bus_match().

V3:
Revised the description to make it clearer.
Thanks Greg KH for helpful suggestions.

V4:
Fixed the incorrect code logic.
---
 drivers/cdx/cdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 76eac3653b1c..daa0fb62a1f7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.43.0



Return-Path: <stable+bounces-86783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FA9A3854
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF661F2957C
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CE18C903;
	Fri, 18 Oct 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpBfGMMR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5117BB25;
	Fri, 18 Oct 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239408; cv=none; b=cWJb2LmeWWkkQ74sH5gkk7Mj4u537m3oMDFzqzYxAdexKQFxxoUG9F4dzeR0GufyOoHIA40ixQn48pKpvNhAIWC1UVzrH4U2tBi5Wcmh80j2/ZP7yS/jScGr2/Dqfur7efw5sQsIKdz2HdOmookV98LEVzwszaa8TnXhAiVrByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239408; c=relaxed/simple;
	bh=MalrlWnAKRodxO9JH/NF0CvJPl/3eu5Z/kkI/o59bqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uX5l/RpeCV3DrInx/+aqnDyuREj89o/DGdotKgXkoEW5YVDNjtwa9ZnW5366L38J+mKhcq/KWZsyQ9i5Kg36aHNVULSvAp/l+od5iuHDwk/hdpkzr46xmCbRqQ4TqEreR4OhZltfVXXA4Ce5QMMzI93G/5FboulwVOQ95pKAX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpBfGMMR; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e7086c231so1357768b3a.0;
        Fri, 18 Oct 2024 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729239406; x=1729844206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGoRSOJcQ6469sYxhK1PaAZHs8nFmvAts7UKrLL8raw=;
        b=YpBfGMMRkPD/5Ez6mBCOBsp1fvoWwm2r1sYuQjbjsaIoVOxiwWlD8Zg3aWjbyty0QD
         i2flwkKmKsAGAMpaYU9cvpFkwPjvgWbYJskIkvJYV97zE8ZAAIWKNjeuzyyUnuhKgQEX
         5BJJH6TwnxfKNY2iKT6FaaBu+7kCixd+0mIu5CFkD3YCNLgsMuvpTLg4sbn0p9dKMI8l
         FpCIXWYHOvQSvynkrPHbNuJSFqbwUylJSCmHRe6tErGHzzsHjJR7ccCGNvR/CwoUFC+p
         DUPlrURQBHPKig9E2Zd3dG1/VNmCeX0ILJpCY+0az25ML8JxsQhOyjk4qHYaeEk/So1u
         iiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239406; x=1729844206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGoRSOJcQ6469sYxhK1PaAZHs8nFmvAts7UKrLL8raw=;
        b=Oz/GLxavYH23kDJ9W8D8B5bZAWSfpq2m1LcHB8ld6H24xRJGPagL+l1/SPaihhcoB0
         fbnRjIYAc2YIRk494m/OBirBEB0ACgcdPbCZXTYd1pwUxU+nr0rkfpMFUrTJP8bHN1hw
         MMLEZcFNVgbsAyU9glR+p7CCEi2NvTkhbCLT7vHGFojr7Rn+LzpTl+fIdcVvc3VqeYYM
         uPHRqzruStwi0WfnwkMiSLRCMR2F8zAfPrIFYZNGArDQBNwT9HMQSNpy8vA4BnQsYN3H
         TId1Ie6EuJKITOerJvMTQiAr7nbIEo3eXrQGhr8ADByNSmO6LO6nNXn3DTcaxX5HEjoQ
         dp6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/V+/E8yCrKTdhsWv4vOPoXmHlyi0bMcid27XroHhGMm3p4KRbXr0bF0S7QdRUtsS185HUlac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsrXKqVP8SEoIUJ33t8DLq7IZy8cR/sQ4bz2SEkqRiBEu0Iry
	yPf8s3qEU2MW+xB+VdjTWWCRXBD8yDsJNwf2+P7rCKd4xVcPz92IhnClC6wxjb8=
X-Google-Smtp-Source: AGHT+IF9en4qw2LNVlM3dSfg39+nc2hG4Bpg6PU2WGXmdrtS/Ssqzqf+zxyBWvnFpb5/DzUJEj848Q==
X-Received: by 2002:a05:6a21:3a94:b0:1cf:499c:f918 with SMTP id adf61e73a8af0-1d92c4e047emr2810709637.18.1729239406009;
        Fri, 18 Oct 2024 01:16:46 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34094b8sm900868b3a.134.2024.10.18.01.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:16:45 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cdx: Fix atomicity violation in cdx_bus_match() and cdx_probe()
Date: Fri, 18 Oct 2024 16:16:36 +0800
Message-Id: <20241018081636.1379390-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An atomicity violation occurs during consecutive reads of the variable 
cdx_dev->driver_override. Imagine a scenario: while evaluating the 
statement if (cdx_dev->driver_override && strcmp(cdx_dev->driver_override, 
drv->name)), the value of cdx_dev->driver_override changes, leading to an 
inconsistency where the value of cdx_dev->driver_override is the old value 
when passing the non-null check, but the new value when evaluated by 
strcmp(). This causes an inconsistency.

The second error occurs during the validation of cdx_dev->driver_override. 
The logic of this error is similar to the first one, as the entire process 
is not protected by a lock, leading to an inconsistency in the values of 
cdx_dev->driver_override before and after the reads.

The third error occurs in driver_override_show() when executing the 
statement return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);. 
Since the string changes byte by byte, it is possible for a partially 
modified cdx_dev->driver_override value to be used in this statement, 
leading to an incorrect return value from the program.

To fix these issues, for the first and second problems, since we need to 
protect the entire process of reading the variable cdx_dev->driver_override
with a lock, we introduced a variable ret and an out block. For each branch
in this section, we replaced the return statements with assignments to the
variable ret, and then used a goto statement to directly execute the out 
block, making the code overall more concise.

For the third problem, we adopted a similar approach to the one used in the
modalias_show() function, protecting the process of reading 
cdx_dev->driver_override with a lock, ensuring that the program runs 
correctly.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
Fixes: 48a6c7bced2a ("cdx: add device attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/cdx/cdx.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..fae03c89f818 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -268,6 +268,7 @@ static int cdx_bus_match(struct device *dev, const struct device_driver *drv)
 	const struct cdx_driver *cdx_drv = to_cdx_driver(drv);
 	const struct cdx_device_id *found_id = NULL;
 	const struct cdx_device_id *ids;
+	int ret = false;
 
 	if (cdx_dev->is_bus)
 		return false;
@@ -275,28 +276,40 @@ static int cdx_bus_match(struct device *dev, const struct device_driver *drv)
 	ids = cdx_drv->match_id_table;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (cdx_dev->driver_override && strcmp(cdx_dev->driver_override, drv->name))
-		return false;
+	device_lock(dev);
+	if (cdx_dev->driver_override && strcmp(cdx_dev->driver_override, drv->name)) {
+		ret = false;
+		goto out;
+	}
 
 	found_id = cdx_match_id(ids, cdx_dev);
-	if (!found_id)
-		return false;
+	if (!found_id) {
+		ret = false;
+		goto out;
+	}
 
 	do {
 		/*
 		 * In case override_only was set, enforce driver_override
 		 * matching.
 		 */
-		if (!found_id->override_only)
-			return true;
-		if (cdx_dev->driver_override)
-			return true;
+		if (!found_id->override_only) {
+			ret = true;
+			goto out;
+		}
+		if (cdx_dev->driver_override) {
+			ret = true;
+			goto out;
+		}
 
 		ids = found_id + 1;
 		found_id = cdx_match_id(ids, cdx_dev);
 	} while (found_id);
 
-	return false;
+	ret = false;
+out:
+	device_unlock(dev);
+	return ret;
 }
 
 static int cdx_probe(struct device *dev)
@@ -470,8 +483,12 @@ static ssize_t driver_override_show(struct device *dev,
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
2.34.1



Return-Path: <stable+bounces-89831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BF9BCD74
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FA1C2248F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B251D6DB5;
	Tue,  5 Nov 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZxGhWKU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0EE1D63D1;
	Tue,  5 Nov 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812171; cv=none; b=fmF3zm++W6AcW2fDkqohvMo5Xe5GF0ovKxQ1aTZGBeIoS71Fc5C8QsltyIlsJZXbtIUnzqWZgZTT6KJb5vVZCp7xszyEyrPEO5DNsOrEOX8xR46JWWz1FeW31oNTvexWfunPsZnuiwfA4Yswjua4boCEmWmVJl6iMP6V6GgL0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812171; c=relaxed/simple;
	bh=bm+rvjESdSE4SMq4P+KGOWrksrd7Sl4vepqz4mPMsWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iABDVpwPEdUXQXNwtTy2buXnx9tmUt3h2mMeqPAeKm2ucqGZzJeo+MoF7dUaixKo+gZ7JVf0y/25wfJNi4AVcYwKz1ZRMAeZrELWZwr7ypVqznl6wdjQKbhqyXqmXHdbtOQLC3lkwzuPG7yb7D+NbC+ytxitczGR9g9nOxLTl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZxGhWKU; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20ca388d242so53858185ad.2;
        Tue, 05 Nov 2024 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730812169; x=1731416969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDWyygav+8muC3u5fmkiDyo/AKuSKyI9CkFr65axGHk=;
        b=hZxGhWKU/XxBH3Cc4fnwOASIQ0GX9HtDP4uEvrW6ayxKmerf7RVa4T780X5y2/M+zC
         sOSJhO3dEedmuCoYWUb2GEPnYrqebMSl5rlUM2SNO3UnCSH8eD97Nqm310E4dYUxqDdW
         YoDDmwQXK+zESMGxgqBSVL/CWuGMhAA5mDJOWNjIsP+4vOO8tyeevEa5kgEIeg5VaL5C
         2Zc9NjrQ2P4RBcGpF5Z70UwZIm06TU63N8JzScK87lGc1JptclZbsrjV8TiMMl+5MiqD
         MAnBgz1HTpL5090eT6lRWwLN87q43FuFYvijiNckN+9SFGLRobcW83KFG1R+/vE2LazC
         FuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812169; x=1731416969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDWyygav+8muC3u5fmkiDyo/AKuSKyI9CkFr65axGHk=;
        b=OxPJpvomKaVEwC1xDo2uzoWquz6k8UbI/cPRiNkpy2t6ZRAv0t8mfm0rZSZ4kMaYbA
         bPERYxQT11kROe4Bq7eIVSyADmJM317bJmtvhpNmmewGxTfpUGE8P3NfX3hz5EPouBoH
         OG4eqjelU1KSMDR2ch/bfqRkYshZT8TslvugKt7Is+Fgcx/l+YsLvxaoj2T+mNzYQw+k
         suLhzvPlYUWfq94SONCjq92D5Zx7sKKoAOY17rbKtFmEtDezUIRuiOM94inFrNnBooVP
         fNn3ifBAs5KczQWqFxfMSYaqSbcwPFSXFDdZrTLUgo/oj9K5k1IacNdA0e5CkjxPRoRw
         GzkA==
X-Forwarded-Encrypted: i=1; AJvYcCWrykGX4nrBG8D2YbNN4/Sf9CUAg+gIHO7ZRLvlAgNOUhrNfeKj0NbZ0sw3biGApD/asDNIhLsiXFsxZQk=@vger.kernel.org, AJvYcCXlG8bG8JtOoT4bwiEBOizbFcK47A6xOXFOvdCFu7zx5h1lBVdT1nH+eKjnMeGLq5HQKb7L/U/g@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhxOxI8+7d236x24LgZKss5kw1icqJ87FwmVNTvwbhCcr8gv5
	YLl+i+xU1NFHd18pHq3dA+WGuI0UgUL3F3rmC/X6SGf/W93cJzOM4flSyB2A
X-Google-Smtp-Source: AGHT+IF1g8Nn9YJy/sRBPmJnKRunRLCLlieuQkXJ2jxt8P/MMM6nEAY++N1OmI759/YFFuLeFvjT3A==
X-Received: by 2002:a17:903:440d:b0:20e:55b0:3607 with SMTP id d9443c01a7336-2111af1cbbcmr199687325ad.2.1730812169318;
        Tue, 05 Nov 2024 05:09:29 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a306esm77998805ad.144.2024.11.05.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:09:28 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	gregkh@linuxfoundation.org,
	sumit.garg@linaro.org,
	xin.wang2@amd.com
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
Date: Tue,  5 Nov 2024 21:09:19 +0800
Message-Id: <20241105130919.4621-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue in the function xenbus_dev_probe(). In the 
xenbus_dev_probe() function, within the if (err) branch at line 313, the 
program incorrectly returns err directly without releasing the resources 
allocated by err = drv->probe(dev, id). As the return value is non-zero, 
the upper layers assume the processing logic has failed. However, the probe
operation was performed earlier without a corresponding remove operation. 
Since the probe actually allocates resources, failing to perform the remove
operation could lead to problems.

To fix this issue, we followed the resource release logic of the 
xenbus_dev_remove() function by adding a new block fail_remove before the 
fail_put block. After entering the branch if (err) at line 313, the 
function will use a goto statement to jump to the fail_remove block, 
ensuring that the previously acquired resources are correctly released, 
thus preventing the reference count leak.

This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and detecting potential issues where resources are not properly managed.
In this case, the tool flagged the missing release operation as a
potential problem, which led to the development of this patch.

Fixes: 4bac07c993d0 ("xen: add the Xenbus sysfs and virtual device hotplug driver")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 9f097f1f4a4c..6d32ffb01136 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -313,7 +313,7 @@ int xenbus_dev_probe(struct device *_dev)
 	if (err) {
 		dev_warn(&dev->dev, "watch_otherend on %s failed.\n",
 		       dev->nodename);
-		return err;
+		goto fail_remove;
 	}
 
 	dev->spurious_threshold = 1;
@@ -322,6 +322,12 @@ int xenbus_dev_probe(struct device *_dev)
 			 dev->nodename);
 
 	return 0;
+fail_remove:
+	if (drv->remove) {
+		down(&dev->reclaim_sem);
+		drv->remove(dev);
+		up(&dev->reclaim_sem);
+	}
 fail_put:
 	module_put(drv->driver.owner);
 fail:
-- 
2.34.1



Return-Path: <stable+bounces-92811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B79C5D10
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D15F1F24D84
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590720513E;
	Tue, 12 Nov 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCA5qOzP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0691B81B8;
	Tue, 12 Nov 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428627; cv=none; b=EFqAs080K28afHsQYKccLXMXy5ew3lSVjcuBT9Jh7AjOJ0LwoP3O+XiAIq5n0PElkoyLdUG/2E0VvQWIqwe3PH5yy4pE+CAH9ywbxm2fU7XjT/tWcDHEp2yoSClfMRVUh+yukucFfFaD+3cRKdcJ3iNaF4qXEd61aUHpvGdhZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428627; c=relaxed/simple;
	bh=zTHHEBahoFgg2D6b85gEFQC7H991Ba1VjVX28zyuJ9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSrHh/tVEHvmsn2cegxy6/7sBbHpVccJBeVRv0GWueL8/AqRLZrr7R0aVfBUcgm/hbT+Ht7DcXIwDU11owSgXMd6RQ+nEafYDRBRhoVYe7kSjLQwK8ZbT6lL4Y7oxK/MOJNUUb3yab04aUJDkb07DxTCkOnovHS3u7ed2Vl/KJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCA5qOzP; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-72041ff06a0so4764434b3a.2;
        Tue, 12 Nov 2024 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731428626; x=1732033426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5PEATHp+4fkek8PlOaUtNxfBpk60iNVk1kWOvrmMns=;
        b=jCA5qOzPNxvbHFesMV3Hfy5nVugaBHHovl7YOWwZmhx1VliKNBbxOYAdZkDcAaYiOx
         K31HZfbnjrZbZLLPkZKYNiuFn99aZw5XBB9Aan1S0rprXeT7c87oDhGWcI+IJZ3NjdEO
         SygA5PgIO5RQyCNw523L0vnd0vYaOZUkiwAL347CzxaNxw7yqTDc3i2gYzXLSZDlUHWM
         z72Vtydf6cG1LZKaLaDqJQPMqmJ16rsl1DKsJjd+K05EQho4DsypUUsC/HMDkqDc+txK
         /GRjjEfcwMkC6phHHL7K+uFuG1HpppN+Bp3zT9pT+jEcdZYRAd+YbXnTxFO1Z/KcZjus
         LVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428626; x=1732033426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5PEATHp+4fkek8PlOaUtNxfBpk60iNVk1kWOvrmMns=;
        b=QcV8hczldGvrOykJvr5JMCYYPDiVbSusTStFT2P3UdYIv4OvT7cstoZXjF/xanM8F2
         nCcEVtbqvJtcUnKd+DcF1pTwj++hDM58jFXaLkSFY/beUuk+PJ7G0gOO9g6JnD6St+zK
         AzvknEa14G0R5fkPxmq6Q+RaCA1lkz617C7fzvTRUHdXKEx6xchx+NcTxpBhU7QSKiBB
         xH9mOJrVvFF0g4ji0zVY/6H24GA0NxKGPrq98u7Xn3g8Ejrb23rrYki5043Oh2Nz/NsI
         muA1DjRysFbtuOgI/qvvzJzHrP0D0o7MDws7f+rnG436gxoJSMnJiurQzlIUCW/OTOjB
         blGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTOxjNIAbiiw66/RFtw8E0YwCyhnE4J9TVIYOiSmV0DobuGd6Nx+fMwVV1QtOtNXz7oAC9ZUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYdegIIh0qbt1NyVvXIVQZ3K4sdb88LVX6RW3MiSrV/zgNe0n
	mMBJVEPK3dSSg4libN6Dfdjm/fqV/Wcw1BDqQEzA71qE1EVZkpdne74cc047
X-Google-Smtp-Source: AGHT+IGnRDb+SEeLSHe456d86JAmZ0Jrkmk+sVJHlpYVcNalmC/Zfw9B0radJASlrcXDLAK7VeqK3Q==
X-Received: by 2002:a05:6a00:3925:b0:71d:f15e:d026 with SMTP id d2e1a72fcca58-7241326dd7emr22576590b3a.3.1731428625538;
        Tue, 12 Nov 2024 08:23:45 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a97sm11775646b3a.27.2024.11.12.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:23:45 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] cdx: Fix possible UAF error in driver_override_show()
Date: Wed, 13 Nov 2024 00:23:38 +0800
Message-Id: <20241112162338.39689-1-chenqiuji666@gmail.com>
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

To fix this issue, we adopt a logic similar to the driver_override_show()
function in vmbus_drv.c, protecting dev within a lock to ensure its value
remains unchanged.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 48a6c7bced2a ("cdx: add device attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Modified the title and description.
Removed the changes to cdx_bus_match().
---
 drivers/cdx/cdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..4af1901c9d52 100644
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
2.34.1



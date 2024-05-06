Return-Path: <stable+bounces-43110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F48BCB94
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEC91C218BA
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC6142651;
	Mon,  6 May 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OPePBoRY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F8142652
	for <stable@vger.kernel.org>; Mon,  6 May 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989914; cv=none; b=dFADIwOGDRkXYjV/epOmp41ayioHfBYWPzO9ClUYJiOPQ9MPutdKx7mJNxvYyshTsf52WJRTgIP5S3bai79GH6ZewI/rdn33Ye7XKwG41uBysugfAELJOaZWrRBmCkvCqwxgrDCijlnUaVKBfdMU6SwuAM7dYzXKHnYh5qDQzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989914; c=relaxed/simple;
	bh=aemkZcsy7nAq5cW+lATCKsHKq8tKuoa46y8xPvkvhQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRg1ib16ZKSAFIEjLmU7Umu9YbKGeb/eGokUGpje8tjqE/HWZrqsILDl1jMAzUMkZO+4BSLmHmqEQoGnwhsktDm5DBTusXFn804hxRCJ08xEWGn05T8MdBDEtBM6g1mmdgNQWbK1dI0rKRQ8qCwP3fRlPL8QTEsCmz+nlQvdkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OPePBoRY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ed075a629so1109553fac.3
        for <stable@vger.kernel.org>; Mon, 06 May 2024 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714989911; x=1715594711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nmY7KIRPTz0rvANaiCUoTCrjaAVQza7xB6Szy1HcQ0=;
        b=OPePBoRY4vPiKki/eMaziaa0DMdBFOLEGLfgZcq+jEwd8sm/qqNAXETI6NVc9xiCwu
         EFfeuunnouXjAChZEA+OWNXjqdyHMzhY5lXTBZAWar5aOCxwK48X5TrcHnRJlHa4KaFv
         ZM1vzuZBb15L8x4Y0qdtLZaze8UXgbtuvf47c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989911; x=1715594711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nmY7KIRPTz0rvANaiCUoTCrjaAVQza7xB6Szy1HcQ0=;
        b=jYSsuUTBj92pFI7qxMKcU5LBMSsblOKqoMHdln9oJJ6BQFSAx+N+IIUKmSyHXqQy/L
         SNqp300NmXIw/nBCvAk7bjkc37AViu88kDMEFhLjOkHqmiQrRPJuD0TNTu2bLJFzz/gP
         YRDfE7XXYkRK2iTyNBUp3fIJowPDCOMSl6a5UEB/j0CcjPFrJmemX0GX9rxNc6/eKin4
         VoRbevZzOQN+DPo3xSj51YQP4oMW+gMYGfLrQqaBnLdPac+yN4QdRoT6uszZQpcMvY2e
         IctD2vrq3T6ZqufXNjZiy0G2wgfRC7wD5ldrD2hyohvq90GRgmcqsn7xPyhU6cJS77zC
         9l2g==
X-Gm-Message-State: AOJu0YxZJhGgBE2XIukEubsoFtUu3ZoiIAe3GZcP/x3/w328+FQMrzAM
	hT0GSI1wctHL5MGhzxgu/6sUGjaWrHs983cIx6lQrdk4SegtNlfOPPHT2fahACkGuX6FATY3sRS
	QuwJcM79xgU6Ukr+YSrYwg7TI8XH4tN9QxD54IIgsxC5Fa+rYRQcnCLQXymSzvSKd9AJY5fyiqa
	jFy9HEZM5bivUzMNfXC9ryDq0ASqYmthDWx18gSslUuuX+Jt9s
X-Google-Smtp-Source: AGHT+IEfSMqMIcDo5miQPw83QX3BMxcIOrClD9+x7yN2uyUeGLScj5hgzrDyV1jJ55OiWGa9rdoQSQ==
X-Received: by 2002:a05:6871:4ce:b0:22a:508a:66e6 with SMTP id n14-20020a05687104ce00b0022a508a66e6mr12495312oai.17.1714989910891;
        Mon, 06 May 2024 03:05:10 -0700 (PDT)
Received: from srish-ubuntu-dev.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a626105000000b006f452591488sm4965472pfb.183.2024.05.06.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 03:05:10 -0700 (PDT)
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: agk@redhat.com,
	snitzer@redhat.com,
	dm-devel@redhat.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	He Gao <hegao@google.com>,
	Srish Srinivasan <srish.srinivasan@broadcom.com>
Subject: [PATCH v4.19] dm: limit the number of targets and parameter size area
Date: Mon,  6 May 2024 15:34:35 +0530
Message-Id: <20240506100435.2059451-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

commit bd504bcfec41a503b32054da5472904b404341a4 upstream.

The kvmalloc function fails with a warning if the size is larger than
INT_MAX. The warning was triggered by a syscall testing robot.

In order to avoid the warning, this commit limits the number of targets to
1048576 and the size of the parameter area to 1073741824.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: He Gao <hegao@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[srish: Apply to stable branch linux-4.19.y]
Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
---
 drivers/md/dm-core.h  | 2 ++
 drivers/md/dm-ioctl.c | 3 ++-
 drivers/md/dm-table.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 8cda3f7dd..2542f0881 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -18,6 +18,8 @@
 #include "dm.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 88e89796c..70929ff79 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1734,7 +1734,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 3faaf21be..4822f66b0 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -187,7 +187,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 int dm_table_create(struct dm_table **result, fmode_t mode,
 		    unsigned num_targets, struct mapped_device *md)
 {
-	struct dm_table *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	struct dm_table *t;
+
+	if (num_targets > DM_MAX_TARGETS)
+		return -EOVERFLOW;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 
 	if (!t)
 		return -ENOMEM;
@@ -202,7 +207,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
-- 
2.35.6


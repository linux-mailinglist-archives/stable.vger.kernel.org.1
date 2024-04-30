Return-Path: <stable+bounces-41821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397B8B6CD8
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BC51F23C6B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC511272C6;
	Tue, 30 Apr 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pwqn2Od0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDB126F2C
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466023; cv=none; b=CKGx9myvXJndufmUcvBHrToF1dhGevwFu0PaXgNtH4k/zzj66IqYAEpX9ro71UrieSyV6dFfSE+42UQMqASFPPFtimJLmLzJ4ZuQC3Abzm+Xy4947cM7+hVHkEXUnZ9iJKTWc2WTtI9GoznZuLb9m2aLFqWcU19uIPkYk83wya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466023; c=relaxed/simple;
	bh=oecYEBg/m+JIl1z6nng3Q9y9gkG6hNdRxPbZ3Q/c3F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t9roiduuUgYNr6Kqtoab1ZYJetSarf3Or+5cmQJlVLq61IiiEYnZRt01J0UyRqGZdpEfldPuirvkkjhKr5aNdg/yGrs6qnNrYfZ+Yh/z93bT5SMBCjJ09S82ulsqOyxpdHZNEWt2blgBCWCXDqcmMKgOY8HNIaY5MBaT/rtX+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pwqn2Od0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec44cf691aso2133675ad.0
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714466020; x=1715070820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+cEXH1y9v8gdKKfiUtDyIavn65HjLmSRQA8Q6Bh/1I=;
        b=Pwqn2Od0ubM9IuPaTGxT4hySmMsl6FEvkrG7sBiKvrJYDsQeKqzCBJUmUBF3zrj7Mr
         RGBkV7sW93wYTCLn2pUTVX+MjavVCs733P7lCRWsPQEoAntMGYys9itRaemLO5BlZDBh
         Tvg5EPRH3opf1HAbF/ChQv9jZB6rOQGxKNidg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466020; x=1715070820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+cEXH1y9v8gdKKfiUtDyIavn65HjLmSRQA8Q6Bh/1I=;
        b=k/JwdFahLZ1AbS9yb7NCb7SR4e48xUpfKKDmxhLat/Pq6/E0Ewe4+dI6lB1PaS9nVx
         VK/rEt7Up0Cbvb2Ju6yKZWqYCFUGszrKl/VlhEghWLELBpiSLZsoi65SDu7Jh8pH7dAl
         BRoMAZIqZr5Kw4pZNg/FhVq25vtHQnhBmclHz+hNFTcTHMdFrv8zBDFAoPbse4X5f3od
         0z6r+s011hvhPjiFg0JGzU/0L758pkDuoTwNcsZiFSwTuoiOeyx/ckuOtsZ2h37YmKFm
         XhrQlzFl/Gb2GKv7i/WHx1P0i/dNnx0s7cCWNgQW3mIVIA0IvdcEVZTdS7ztVqj2HxD5
         /vxA==
X-Gm-Message-State: AOJu0YzXn6lXkLMvvKaEGVxRVYeQDz+9CJy+/L8WTvNQJEzHJBGdnl0/
	/j0MjKAVxYjJNfMS7UyJe3amJx1vADGydLx9ONzBnZtBuipaV6SGt80RAHDr90IuYWyPtybBIyf
	bdnVQu4jyaM8MQYQ22ivOjndowFaJgSkeBBk3YLDEWjj3x+UQ89CRCKh1Dhx1R053jo5VjnZN6k
	jfT8iIEst9fu8LSs5+xBOrLKUdULcvK+b3wdDHiFlfyVBwzmor
X-Google-Smtp-Source: AGHT+IGCOzmCKio/JP5qG/I6KNBaEo1J13jlZS2fr9YI7oFRkUWGrDWWUxDmUGoZl0Q9cBtbT05Amw==
X-Received: by 2002:a17:903:244e:b0:1e5:c131:ca0e with SMTP id l14-20020a170903244e00b001e5c131ca0emr2961832pls.6.1714466020323;
        Tue, 30 Apr 2024 01:33:40 -0700 (PDT)
Received: from srish-ubuntu-dev.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001eb3f705ddasm6222720plg.255.2024.04.30.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:33:39 -0700 (PDT)
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
Subject: [PATCH v5.4] dm: limit the number of targets and parameter size area
Date: Tue, 30 Apr 2024 14:02:59 +0530
Message-Id: <20240430083259.13876-1-srish.srinivasan@broadcom.com>
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
[srish: Apply to stable branch linux-5.4.y]
Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
---
 drivers/md/dm-core.h  | 2 ++
 drivers/md/dm-ioctl.c | 3 ++-
 drivers/md/dm-table.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3fea121fc..e3c3bbe92 100644
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
index 8e787677a..e89e710dd 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1760,7 +1760,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8b05d938a..fcb9e2775 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -184,7 +184,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
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
@@ -199,7 +204,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
-- 
2.35.6


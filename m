Return-Path: <stable+bounces-21757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C980085CC2C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693411F24166
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9E154C05;
	Tue, 20 Feb 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocGQEnhp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3A154BE7
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472643; cv=none; b=WGrczsu06cBkWRWg/UIz0lJYMdvGMZJBj9PkNL2jLKUSH/GY0z/uvLfAzxX81U985N/pl7nz+CGtWP48b/6z9ylTh1k7v+m70e55Icol1FUpltNWWTR0P44KMRqFdpyugf8uIhJITE03bCV3iJ9+WnpTlvJAUFARUN96/Oy4zQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472643; c=relaxed/simple;
	bh=UhIS/6FgpzpOilvrxeNHRDzwn8K4UrkMDFFnxsVjTlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLoTld2b/qTa6g15FD+lN87N+AlhnRfANmSUyjlNWcVn7pCX5PupAPr9BtkSB5+KcbLJ9LTZ2XrBDxBvC3l986a5pBQAR/tcDDHJEz+7q69y+evzSqGCc5GDl9Zvs2LWfJ0wMMfvLKzOitk6Or96z8tfxdQ5dhMGcDgfRoBAiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocGQEnhp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dc91de351fso5827847a12.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708472641; x=1709077441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZi660jfXFzypRoMS043Gn/yPT3WFjY20uZYEuJ7uRo=;
        b=ocGQEnhp+JYUZwDYA7gl5zf6b4kI5AuoMFdkrXTqMktzAfujlTgayXongg573M0uTf
         he3t6Ox4hTda0dqUrTmg2MFO9QHg9C4DMhNYpqV0pjU4l6naCvpCdFbF2U/XvouTBRXU
         8isB0FEXsqAuMmbalfp4/i6y6IRJcUduVotLqAM4s4IG7K+snMEjqoJX8qcWngWq2W2a
         zOQdEmqQDJl4Thd7W91IpjaVB6EXxllbLRe3OwnKPdiU0D4UlwDgrYOMjY/T1KMNz9Tq
         Jj4TI9HtEVAmoGPAZZILtw1lIt7WjOk1KsQBvyUtdBvvIRCL3x4LAItMEahKCXg53zTG
         a+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472641; x=1709077441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZi660jfXFzypRoMS043Gn/yPT3WFjY20uZYEuJ7uRo=;
        b=RI2yjW4m+GSdGp7p6Q2NNL6C8ZFs3rWHXm20+lcsCm1cuBtPWRoURTQY368zuA61sP
         6XbJWECPct9Ldq0PkqwUuAYhXuazAyLk1hbjGAR38N5+5cMtdpdSi1emU0xmQY7U+txv
         Jy+6P5OO4c+QbQ3K1Lc8Y5woRhKnsnYPooeYoWd8VNV689abxB+raUuPohPcuAAMMx5W
         vFf+fsxpPAaPDcEN7+uu2oHREvAtZnebQkCdE7fssZkBIAuhaNU6nGVtMBwvQkYUHvge
         PZUkFR4NOvR8Db2D7z7fghxyBd0h5duWpNyIa6U4lubtzmnNhHStoj9KSwq8RPgMbZ1d
         X0iw==
X-Gm-Message-State: AOJu0Yz0iJpJboMaRMTY1NW817W9KdNQM2dnKu1jLabB9otYIML7aaOI
	/aBNqqVQ+KfOXz2rye+tpwnbS4ol1YoB/TyFxYyUz7+WJgYp7r4ThQSc5oDhEwhwAHz6h9+Ev+L
	JNuOqtFEWbyfVo93qCgE2eTy5LxQuYWmR+9cAZZhurkWx14tTWqJK7zryvYW2bvzhUhQayoDAqP
	T0XKEzCrfsl0SXRdPr+V0BsA6yZT0=
X-Google-Smtp-Source: AGHT+IFOAoy2xnsfrWLcxy91FwWqfF5zD1IrQlX5L3j59x1l5AIAT0MVbJ3ITjFD2HaQhH5OJDgMsibHGg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a63:6781:0:b0:5dc:9e39:dbc7 with SMTP id
 b123-20020a636781000000b005dc9e39dbc7mr55117pgc.6.1708472640992; Tue, 20 Feb
 2024 15:44:00 -0800 (PST)
Date: Tue, 20 Feb 2024 23:43:07 +0000
In-Reply-To: <20240220234306.3852200-2-hegao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220234306.3852200-2-hegao@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220234306.3852200-4-hegao@google.com>
Subject: [PATCH 5.15] dm: limit the number of targets and parameter size area
From: He Gao <hegao@google.com>
To: stable@vger.kernel.org
Cc: He Gao <hegao@google.com>, Mikulas Patocka <mpatocka@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit bd504bcfec41a503b32054da5472904b404341a4 ]

The kvmalloc function fails with a warning if the size is larger than
INT_MAX. The warning was triggered by a syscall testing robot.

In order to avoid the warning, this commit limits the number of targets to
1048576 and the size of the parameter area to 1073741824.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: He Gao <hegao@google.com>
---
 drivers/md/dm-core.h  | 2 ++
 drivers/md/dm-ioctl.c | 3 ++-
 drivers/md/dm-table.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5a7d270b32c0..eff11df6c32e 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -21,6 +21,8 @@
 #include "dm-ima.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 815c41e1ebdb..c1bcc857c1b6 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1859,7 +1859,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 46ec4590f62f..52083d397fc4 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -126,7 +126,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
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
@@ -140,7 +145,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
-- 
2.44.0.rc0.258.g7320e95886-goog



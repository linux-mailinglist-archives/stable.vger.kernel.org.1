Return-Path: <stable+bounces-21759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433B85CC43
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17C11F22701
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBC154BED;
	Tue, 20 Feb 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvFcx3eT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96F154C12
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473023; cv=none; b=uTMVHN0iQRUZhU5HcQmnbB7TKZpMtcYg1aFVwPPG07ezmABHzqrN2zz1OzQZ73Q8Pby6Jf9y+JEZ09rTn60TuKKGAzIkW6uox4i8x7ejj8EOtgT/e6kzkyXIma4K6CuhcqTQSZNy0nm1aqcR57vUyzJvabuOo1HFVlC7dmgyuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473023; c=relaxed/simple;
	bh=pwCGlGpVy2NGpH2j+jJynNhXa39yTVeSnVPmczrlIJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpnbIWJUXWy0//ALvcMC2TBUfRSsBpsmDfuaxENqbYpv4922YORnEKtJBA+0UfWdfKDoR1Iw7Sy75RaWAtjwtcR5uUM6+p4gs8kTYnAweU2ldrVcUZfLAsrCNHsTUCLy4A04dZv8WIHSGKAGnawsS2mKDKdH9/qo0p+oXO4DRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PvFcx3eT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dc1db2fb48so10965535ad.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708473021; x=1709077821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyytU+aFwTVIfG/FUZfMXUS0EaNfg2LI0e5olQGggs0=;
        b=PvFcx3eTGDv9FbTqXfxed7txa8NXDVsxtFdwtYwDLnb8OGUUvGr8EJ5spluX8mE9yM
         coWX7DkqvIWhgK/70ugytjgRDqg9KZFumfZpCvRWYfowQcQwAh+bELn7+qdK3XhEtdz4
         h9yKYeHZo7xGN9dRUnz/G9NkMdyxFACE6nRaw5RySYH1EBFrAbLsVc0IDscWmS+J1/is
         ohmuFgkEugqXnwnyqqwUUXRXLfW1x72AQDLjzq7KCxoS6lImzfA8IBk1r5FYa82EIkoQ
         40OOHANl3y6cBHxR6DyOzP8jja8d/5wc+lw9Nx4N3oANlN1Amra/NcCj0sAeLtn0dLGj
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708473021; x=1709077821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyytU+aFwTVIfG/FUZfMXUS0EaNfg2LI0e5olQGggs0=;
        b=vc7u2h9PMlIpDcDzuegi1tEw+iq6SCL0Y+Vb+AbW9n72OvCt/EuY5r0AeQlqDdk4e8
         JTpg6uFzjzhzFQfazszYNs1IKKcveg8FLgstKKGvr1rFzz+BbnZsiekYvNbQpa0Kj3Nx
         5jGe6uA4Tv9dhSCVBHvyW1+lQCGnVdZ8Dv7O8XPqZUy/R2/lazrITgNwwbYiDzhY2I7P
         Qc5wsvVYCXjfVG1XIE+NRht5pt6M8adiovwO3LznjHU0JIYCkRXf9i7aG+kdP3PLy0G2
         MDnBrcMfxyOeJpjkC3adpHC/y9T4RttDzuoYKFAfPkvWbdc5jy/zOz5egb/blBZts1zw
         sIUg==
X-Gm-Message-State: AOJu0Yzq+1Q0+Wg4PxO401DXC/VkOQiKAfDOT1VkJUOxa00vaaWUYdwE
	eXQoC1+5cDWh03s2wZFT5GHbgzAr7SDhH4Usl7p1zi36t3SUIfZ7BcwFlX90uy+Zny3wE43ATqL
	mPBq8hm9UfD2yEdHKqEiwbT4t3LoANCu72JANMYeIEs26HuQTcW+yCKCrvq8NLcjcaq7NbDbYUv
	fxuFy3KRnQC435RjcGlJNWGrGuAHc=
X-Google-Smtp-Source: AGHT+IF387iiYVEvWzxd+QkThPRq8IZl98biUNR/3+wKwh/xqEn7LGoXQ24Rbd8h8Ggl7V/W6+9fSJWpkg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a17:902:da87:b0:1db:2ac6:8a68 with SMTP id
 j7-20020a170902da8700b001db2ac68a68mr1034338plx.5.1708473021584; Tue, 20 Feb
 2024 15:50:21 -0800 (PST)
Date: Tue, 20 Feb 2024 23:50:13 +0000
In-Reply-To: <20240220235013.3854860-1-hegao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220235013.3854860-1-hegao@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220235013.3854860-2-hegao@google.com>
Subject: [PATCH 5.10] dm: limit the number of targets and parameter size area
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
index 3db92d9a030b..ff73b2c17be5 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -19,6 +19,8 @@
 #include "dm.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5f9b9178c647..4184c8a2d497 100644
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
index 5c590895c14c..31bcdcd93c7a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -144,7 +144,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
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
@@ -158,7 +163,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
-- 
2.44.0.rc0.258.g7320e95886-goog



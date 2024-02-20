Return-Path: <stable+bounces-21753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBE85CBFF
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A3A281B91
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5A151CEB;
	Tue, 20 Feb 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6AFOOVv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBB78688
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471456; cv=none; b=aH6wLbjhtlLxDv/IcywfsdChNLAcfAePtDA/60KIwfgNayXnJkY0CUkmK6xmBnFLYf2IVXEvZwdDDv/h+Y7NZF2YtBt7B2EueekFbAyZRRfLao+RSQw5C/dhww5x8dAyJC8EB8+pTOAbd/P9U3ysxAGwqmyPSNGQlLFiWGTcA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471456; c=relaxed/simple;
	bh=vMsZ3F0NcvLE5zxf/obYL/AZUAgHJzmyCjzSy/PRqLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=grWmW5ldQPJ4R4llXrtjH3rdxlT3RWHaablswxao7n59gz3YNZTbd5HgEC/+6+R72mBkJJbbtUGx1Cur6AX6pS6qrSvUdpMG0rM6oNTVveuVrF4/jI31DHAx4x0lX+UZbuLJ+c38Xr1wEd63aSH3h4M+TLzgRB5rudA3F6yAmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6AFOOVv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c670f70a37so6145631a12.2
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708471454; x=1709076254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=do987qzzhiUGxpa1LTdt57hkq5m7yEGkVJdBhUoUK4E=;
        b=j6AFOOVv+6n96ViQzk7BwfVbWEuTpDPC/MAZHac4Lic+iV2XFfFQcamo9zRtVk1DAU
         kw3t5H7Ha0BU8BckEMpH9twOKHeXOfCCG/JhEjqli6PiZKDLxU3XxOxfUyYc6aHfG0jQ
         CWYFjpcozTdDSAwCCzuZI4Yc0Al5PMwlDUmNKUl+Kn2qSC7z2xIUPkUTBi1T8vCiDdav
         KsjSxd/83nOJ7EBoTK7I4gi4URRq7Buw6MZbiMveXwZ7LnoJJVecyhKOaOPG2DgHSPHt
         0F4pZvF+mFs6SGYFNlLjdTeDD131eHCgAI3muzY6pbss42xtoH2hAwAVU4Kj49VnKngE
         WLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471454; x=1709076254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=do987qzzhiUGxpa1LTdt57hkq5m7yEGkVJdBhUoUK4E=;
        b=rdBaTrl/6S8N5/UrDxCRkKsyvZn1jNW2HdL2gFg2dDzoOPl5q7GKkNDTsqgbNfF0/L
         ndqX5HWrGoZDtKwZB2W+tALkshv96e1JxKf1oQzzq+oE3QWviheH+MNAQ3vMSrnQ61Nw
         xXauYVPCVkTvbl3usYhVFK7/P52VsAPrpz7LILPyVr1lk8T2rb5YuQfyvbXdhxtGvtnj
         bpJ8fsw8TrY0q4l+H4fTw/PEG7+SliS3hwVSr1Fpsx99ZxxahiunIKhAq5hoaS8zyBSX
         PnYN97QOk+aIHGC65wQtJPELNdeqVlAHOFKUBEWdOK7jipYu++oM90Cmq425FJ1P+Tj/
         SNDA==
X-Gm-Message-State: AOJu0YyxoKUGl4EhqJTxdjV02B3QOjIqc9Xb1cN/6WD4zJpmuv/5pInT
	5PoXs8L+UTu9qli/3k1GwGb0IIbc3cJzIFBpvN3p4O187Shweolvby0hNnr6oEtK4Mpb3gZXXjS
	CAavnAchCGnC/Bb8Fgdl/Sui4Pz8qHp4ls7fFcW0tQh/WSVIzm1jTC24Fdo7RhlQ1uoEWmB83cE
	nA+UWCMa9DUT74aLXeHLtvjsvlg14=
X-Google-Smtp-Source: AGHT+IEcUhf/ZUGLpzcpedaxluTl0h0jnBs5TLjWkYPooEa8YWMX6wQYGKhyPk/bhikkeUMdPf3ITVDrTg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a65:6d88:0:b0:5dc:3ac3:dcea with SMTP id
 bc8-20020a656d88000000b005dc3ac3dceamr44540pgb.6.1708471453839; Tue, 20 Feb
 2024 15:24:13 -0800 (PST)
Date: Tue, 20 Feb 2024 23:23:39 +0000
In-Reply-To: <20240220232339.3846310-1-hegao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220232339.3846310-1-hegao@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220232339.3846310-2-hegao@google.com>
Subject: [PATCH 6.1] dm: limit the number of targets and parameter size area
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
index 71dcd8fd4050..6314210d3697 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -21,6 +21,8 @@
 #include "dm-ima.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_io;
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 206e6ce554dc..4376754816ab 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1877,7 +1877,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 			   minimum_data_size - sizeof(param_kernel->version)))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size) {
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS)) {
 		DMERR("Invalid data size in the ioctl structure: %u",
 		      param_kernel->data_size);
 		return -EINVAL;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index dac6a5f25f2b..e0367a672eab 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -128,7 +128,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 int dm_table_create(struct dm_table **result, fmode_t mode,
 		    unsigned int num_targets, struct mapped_device *md)
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
@@ -143,7 +148,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
-- 
2.44.0.rc0.258.g7320e95886-goog



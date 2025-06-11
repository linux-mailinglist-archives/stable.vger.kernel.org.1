Return-Path: <stable+bounces-152466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99067AD6092
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895EB17ABE0
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E8235048;
	Wed, 11 Jun 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR43HXWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EDE2417C8
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675708; cv=none; b=XrSIWxsFGeL51jx40DhlEH8t/DVG5OzNKKe95G6gV2NDgxmQa2QEnTNDmjuZZQkm9OwybJkyDGqVGGR5QrqUEq0deyhu1fREy3ZlLEeR9QYAJUkgc3Uo5xdlR8Tf+PpreJmXLthFV/8OGLG5O8vCeKX6l7fOTftgGnylvnfw+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675708; c=relaxed/simple;
	bh=QK4ht+gyQnbDAazmMbEwlXOXssb/kL4R2dEsyFu0Lhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcqWxjCczhVYAjr/xnvr4p4pmes2/CSKdOiaYIGiXdqlfxhZTJM9Oj5tGPIfByN504yX826jEJO5YeDotJ+XTRadT/qMJzR1HHdkCpY9nZJKon280AJDxf0yaoXKPSJLNlVe6O+pr22oX/h8NhsXmi8w2ujRMquF0rTPVhBz1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR43HXWj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e1d710d8so3338495ad.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675706; x=1750280506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmpsqNErc6TU/dmUHqVj28wnwuX7x11lwpEunwZ7J+k=;
        b=PR43HXWjoCL4uTu8zWLF/kDfvWe2yzL4Lwhi6EGaaSovDzLLZSr47aYiOLkVr5q4Ii
         HgGdutW/z++Pi9aNIjq9ma119T6j3TWozzfTjbBgP9xv2Sb7BFKPufWvy6aryRf4QRw0
         17PkuowiMuC/o2WULn1D0xkHVNCFTd3P5v4dTT7eDRti4lVAEx4dPQVvX7fu1JLTJIn4
         lx8bgFwFvWelVHsSrHLZzTKCiZvrr/YYE3EmcwyJi/iR3sFuHlFYirj3sXlxD+sLgXbA
         +hiL1PsfIq1vjMlcpbaq2okAEtu0sZP+tQ1Iy/a1vWJp0UpjGV04Y92WWHihvwR/iSUu
         4l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675706; x=1750280506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmpsqNErc6TU/dmUHqVj28wnwuX7x11lwpEunwZ7J+k=;
        b=l4XfqqUg2YKDzPHLIU1RjSVYshJhq3gSGVDUX4w5ZV5/PLiMNntmNRKr41D+lOMdb1
         ARf0ay17kVuDiaU52n7D24yeBhTIeBsAdKx4jKfk/hmTyrxjsKteAQA9U/5b557OrRfn
         vZ+y3+fLQLgkaQDfw47SzjWdANknsD/MhKdC1kxID0hyF728jKr13i6PKvLxnCRXE4uJ
         b4vw/QgLSAp/1m6acqCf+RjJbNh0n7Fdg5/xmR2avF+3nMfMih71zT+JZDH0BGikN1us
         m3Wtn7yoQEB0CbNACawV3KCN9Qm4EIVt4i+BTVI/BFnBf93xzFXs5xOyGL9lEU6bOPI2
         EtVg==
X-Gm-Message-State: AOJu0YwiPzGgH5b/iTZfjWzbrnQRtTCq4xZgZ9Agxxw4kHauhoLzlaUg
	OEoTpBDW/FiDGiy8MXm/yVb+qsfw+CWtrJ+mSSvmZnRP+DQ1jySM0qTYQP2LXonv
X-Gm-Gg: ASbGncswoOsHwqTeNNdj2KFe8nlv++3a/o6Pv1iL+7VzmjLxbpV5+uR+X1PhAMKgUsB
	LtV8RAFUMwBYb4zilq6nU+UIcvusJbQWTZFtatLSUtD6WwUWYmEYblahHXcJkxNruWkzEGqkRLF
	AlGxrXLMIDppGPZR2xwfygZzxuqr/trHJ8P/J2gJyJqgTcJ7CC3vC7LaxP64okf55A3po8Rt1+4
	vFRM61y1DuI+PTWsDBWw65EuJgeajIeI7lUkMmzyk8bJxukTcbFN7Z8mMhN3d1YkiN5D3C92Z19
	HMGtTYcDDMw+cXaxXgWohhhSF77mx7Ayu0A70sLMue+aglyRrduV80gDF2uM2MBLAhim2yCnOn0
	VQpjwMFDaYdo=
X-Google-Smtp-Source: AGHT+IGszLN65uRxVYRrrLTxKG9E8z5QWjsYNwagvchTZyyicMl5FIIyg98VUXWKwmiplbVbyuNLRw==
X-Received: by 2002:a17:902:ea0d:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23641b19781mr72690155ad.32.1749675705673;
        Wed, 11 Jun 2025 14:01:45 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:45 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 12/23] xfs: declare xfs_file.c symbols in xfs_file.h
Date: Wed, 11 Jun 2025 14:01:16 -0700
Message-ID: <20250611210128.67687-13-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 00acb28d96746f78389f23a7b5309a917b45c12f ]

Move the two public symbols in xfs_file.c to xfs_file.h.  We're about to
add more public symbols in that source file, so let's finally create the
header file.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |  1 +
 fs/xfs/xfs_file.h  | 12 ++++++++++++
 fs/xfs/xfs_ioctl.c |  1 +
 fs/xfs/xfs_iops.c  |  1 +
 fs/xfs/xfs_iops.h  |  3 ---
 5 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 fs/xfs/xfs_file.h

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 821cb86a83bd..6f7522977f7f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -22,10 +22,11 @@
 #include "xfs_log.h"
 #include "xfs_icache.h"
 #include "xfs_pnfs.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_file.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
 #include <linux/backing-dev.h>
 #include <linux/mman.h>
diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
new file mode 100644
index 000000000000..7d39e3eca56d
--- /dev/null
+++ b/fs/xfs/xfs_file.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __XFS_FILE_H__
+#define __XFS_FILE_H__
+
+extern const struct file_operations xfs_file_operations;
+extern const struct file_operations xfs_dir_file_operations;
+
+#endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index c7cb496dc345..1afb1b1b831e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -36,10 +36,11 @@
 #include "xfs_ag.h"
 #include "xfs_health.h"
 #include "xfs_reflink.h"
 #include "xfs_ioctl.h"
 #include "xfs_xattr.h"
+#include "xfs_file.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6fbdc0a19e54..9ca1b8bf1f05 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -23,10 +23,11 @@
 #include "xfs_dir2.h"
 #include "xfs_iomap.h"
 #include "xfs_error.h"
 #include "xfs_ioctl.h"
 #include "xfs_xattr.h"
+#include "xfs_file.h"
 
 #include <linux/posix_acl.h>
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index e570dcb5df8d..73ff92355eaa 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -6,13 +6,10 @@
 #ifndef __XFS_IOPS_H__
 #define __XFS_IOPS_H__
 
 struct xfs_inode;
 
-extern const struct file_operations xfs_file_operations;
-extern const struct file_operations xfs_dir_file_operations;
-
 extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
 
 int xfs_vn_setattr_size(struct user_namespace *mnt_userns,
 		struct dentry *dentry, struct iattr *vap);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog



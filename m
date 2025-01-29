Return-Path: <stable+bounces-111222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB32A22436
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157C8163008
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BF1E25EC;
	Wed, 29 Jan 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElwwkZeN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969D1E104E
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176465; cv=none; b=RCbarsw9FJ+uR73D5LIX0yYJNU+slbarmtvZvlOyPCZo36XvWuyXViOAzQNmG/F6/x44uq0KngU4nktEQNrBLWDj5Y+qlfD4QgB9c7O5vgByskGziLZhc2mEn73M0ysbeMfZCC5sCFsm5oVL92mGGZS1ytayNnS+4wYGtaaj2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176465; c=relaxed/simple;
	bh=h6Dz/fWp32GrKkN0LCmgkD/EjiqZaERY0AMDwL+Lehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnUZcJyMqirn4B/gvqOeWPQSg1grsKmsJ22gByoA6PNy6woJIduYz/aUwwU9uA9LhhC9Wpf9Ht1P68ndjyZI+r8UMJhOu9o8nwdBeU2gsTGS87EUTrs1IqgOYuiePb7eepp1QET6VYLFzpR9ho3NxqSLYsv2EpJUnLtulj8SVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElwwkZeN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so21180115ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176463; x=1738781263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nk4cf0PomozpI3K8RQb7/fWQ9YX3BGzf9AlFcVdNt4=;
        b=ElwwkZeNpQs1q+TqLy10Ni4sih5+8iGvwS8lvPEV6nyL6pQ4s6Ww/Qe8lgq7Vd8veS
         PH9lRUBZpl6VVFryMSe0z6syZ+bTl5oCxRSaw+QJreRucu6uZUUzY35bNXMjHHmsBKNw
         Wr5iKLdaHXz4wbL1ycYRu6Bsz3eOSLzX0nO7I4w/VfLOJ4Lx1WmIe2/g+slnTmnUvxCZ
         5ueT3ftbKhLx1s1RARonJX3gk8wT0IhLDMIqxg92cElIVz+YZSubynnuL0WG6XC3Ivjz
         0VDwhmNdEaT3cjumaLtpkLr6NEEAqmobwueWsu773wfPWqF8mSk1nYxtsLi7DaL8VP+L
         7phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176463; x=1738781263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Nk4cf0PomozpI3K8RQb7/fWQ9YX3BGzf9AlFcVdNt4=;
        b=dDSJPwKo0FgLmZTW9p/784EFGOYu7y88i7FkzCDVinYhzFT2OlVUhCBNmkS6VJ0BHn
         Hs+cLsdqKzMpv2GBOmXmf23dxivyU6gJGqEQHZrGhVvBgiVrStyL3mqZqAdx2v9sn3jL
         CbYwhKnAgYcGOD2vyF0scC2+xaxEv65Ee33JZvgCkk/vcnUQUtD9O4kgLXW2gOwGSRcH
         RH3VUf8ZXLgVg606LdPk8B23Dc7vsT4zABtmOh/jZXdgPg1s2nfk1RQNTyocs1y2eI58
         QLcCklo/P85cZm2xANNzLlOJAczDGv+67SGlpsvbuEn5xzJSTAUt9jdM7etx0Jk9qIEG
         7iSw==
X-Gm-Message-State: AOJu0YwHLgjTrWg/wN5qMXEvRPrXwP6Uzq/rjODMZd0pe9qDCNTT98uP
	Q0kT09J8ZNyhF9VHaKeKiIp6KWAmB+AxmySwVm3z90v50XqXFATU3XVZ1pjd
X-Gm-Gg: ASbGncsJautnlnEiq2qRnoIJ127cxLUk0Ui8rTusiNRx2QUx1g9yF0FfxJig1kXORvi
	Cqjaixk8t4oNQm1D6vQixQ2MiA4Fhvued/giWAkgvM4Mx5LLISdZGU0MULq2YwoyGcM5bf6KJWp
	rJ/IOXCHIjtZ/y5ZGtYPLq50gEdZHLXNHECGnN5/RpX0lQqOKINSU7phtq422DxSsqDgEHwr1dN
	bC14gWHTD+qFGCpvyuo5oQ9odEyo6MYE/XVg+vYseAK38Rna3qYK4DnxFKYkeJwSIfq+uCSkp4D
	YvtaZkaSYAFPMzAVJGvlLiyp+MNR8SGK2dXRK4dHnOc=
X-Google-Smtp-Source: AGHT+IEDzLrsG8Gcxn8B9gul0zcaezeWTzQEYKQ9gyZiTI4tI5EwDmeQTGV8JUzGsdAWdumh4RckpQ==
X-Received: by 2002:a17:903:2443:b0:21a:7e04:7021 with SMTP id d9443c01a7336-21de19c6decmr5072495ad.24.1738176462136;
        Wed, 29 Jan 2025 10:47:42 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:41 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 11/19] xfs: abort intent items when recovery intents fail
Date: Wed, 29 Jan 2025 10:47:09 -0800
Message-ID: <20250129184717.80816-12-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit f8f9d952e42dd49ae534f61f2fa7ca0876cb9848 ]

When recovering intents, we capture newly created intent items as part of
committing recovered intent items.  If intent recovery fails at a later
point, we forget to remove those newly created intent items from the AIL
and hang:

    [root@localhost ~]# cat /proc/539/stack
    [<0>] xfs_ail_push_all_sync+0x174/0x230
    [<0>] xfs_unmount_flush_inodes+0x8d/0xd0
    [<0>] xfs_mountfs+0x15f7/0x1e70
    [<0>] xfs_fs_fill_super+0x10ec/0x1b20
    [<0>] get_tree_bdev+0x3c8/0x730
    [<0>] vfs_get_tree+0x89/0x2c0
    [<0>] path_mount+0xecf/0x1800
    [<0>] do_mount+0xf3/0x110
    [<0>] __x64_sys_mount+0x154/0x1f0
    [<0>] do_syscall_64+0x39/0x80
    [<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

When newly created intent items fail to commit via transaction, intent
recovery hasn't created done items for these newly created intent items,
so the capture structure is the sole owner of the captured intent items.
We must release them explicitly or else they leak:

unreferenced object 0xffff888016719108 (size 432):
  comm "mount", pid 529, jiffies 4294706839 (age 144.463s)
  hex dump (first 32 bytes):
    08 91 71 16 80 88 ff ff 08 91 71 16 80 88 ff ff  ..q.......q.....
    18 91 71 16 80 88 ff ff 18 91 71 16 80 88 ff ff  ..q.......q.....
  backtrace:
    [<ffffffff8230c68f>] xfs_efi_init+0x18f/0x1d0
    [<ffffffff8230c720>] xfs_extent_free_create_intent+0x50/0x150
    [<ffffffff821b671a>] xfs_defer_create_intents+0x16a/0x340
    [<ffffffff821bac3e>] xfs_defer_ops_capture_and_commit+0x8e/0xad0
    [<ffffffff82322bb9>] xfs_cui_item_recover+0x819/0x980
    [<ffffffff823289b6>] xlog_recover_process_intents+0x246/0xb70
    [<ffffffff8233249a>] xlog_recover_finish+0x8a/0x9a0
    [<ffffffff822eeafb>] xfs_log_mount_finish+0x2bb/0x4a0
    [<ffffffff822c0f4f>] xfs_mountfs+0x14bf/0x1e70
    [<ffffffff822d1f80>] xfs_fs_fill_super+0x10d0/0x1b20
    [<ffffffff81a21fa2>] get_tree_bdev+0x3d2/0x6d0
    [<ffffffff81a1ee09>] vfs_get_tree+0x89/0x2c0
    [<ffffffff81a9f35f>] path_mount+0xecf/0x1800
    [<ffffffff81a9fd83>] do_mount+0xf3/0x110
    [<ffffffff81aa00e4>] __x64_sys_mount+0x154/0x1f0
    [<ffffffff83968739>] do_syscall_64+0x39/0x80

Fix the problem above by abort intent items that don't have a done item
when recovery intents fail.

Fixes: e6fff81e4870 ("xfs: proper replay of deferred ops queued during log recovery")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_defer.c | 5 +++--
 fs/xfs/libxfs/xfs_defer.h | 2 +-
 fs/xfs/xfs_log_recover.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index c9adb649e9b3..92470ed3fcbd 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -759,16 +759,17 @@ xfs_defer_ops_capture(
 	return dfc;
 }
 
 /* Release all resources that we used to capture deferred ops. */
 void
-xfs_defer_ops_capture_free(
+xfs_defer_ops_capture_abort(
 	struct xfs_mount		*mp,
 	struct xfs_defer_capture	*dfc)
 {
 	unsigned short			i;
 
+	xfs_defer_pending_abort(mp, &dfc->dfc_dfops);
 	xfs_defer_cancel_list(mp, &dfc->dfc_dfops);
 
 	for (i = 0; i < dfc->dfc_held.dr_bufs; i++)
 		xfs_buf_relse(dfc->dfc_held.dr_bp[i]);
 
@@ -805,11 +806,11 @@ xfs_defer_ops_capture_and_commit(
 		return xfs_trans_commit(tp);
 
 	/* Commit the transaction and add the capture structure to the list. */
 	error = xfs_trans_commit(tp);
 	if (error) {
-		xfs_defer_ops_capture_free(mp, dfc);
+		xfs_defer_ops_capture_abort(mp, dfc);
 		return error;
 	}
 
 	list_add_tail(&dfc->dfc_list, capture_list);
 	return 0;
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 114a3a4930a3..8788ad5f6a73 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -119,11 +119,11 @@ struct xfs_defer_capture {
  */
 int xfs_defer_ops_capture_and_commit(struct xfs_trans *tp,
 		struct list_head *capture_list);
 void xfs_defer_ops_continue(struct xfs_defer_capture *d, struct xfs_trans *tp,
 		struct xfs_defer_resources *dres);
-void xfs_defer_ops_capture_free(struct xfs_mount *mp,
+void xfs_defer_ops_capture_abort(struct xfs_mount *mp,
 		struct xfs_defer_capture *d);
 void xfs_defer_resources_rele(struct xfs_defer_resources *dres);
 
 int __init xfs_defer_init_item_caches(void);
 void xfs_defer_destroy_item_caches(void);
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 006a376c34b2..e009bb23d8a2 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2512,11 +2512,11 @@ xlog_abort_defer_ops(
 	struct xfs_defer_capture	*dfc;
 	struct xfs_defer_capture	*next;
 
 	list_for_each_entry_safe(dfc, next, capture_list, dfc_list) {
 		list_del_init(&dfc->dfc_list);
-		xfs_defer_ops_capture_free(mp, dfc);
+		xfs_defer_ops_capture_abort(mp, dfc);
 	}
 }
 
 /*
  * When this is called, all of the log intent items which did not have
-- 
2.48.1.362.g079036d154-goog



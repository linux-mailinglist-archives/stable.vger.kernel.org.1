Return-Path: <stable+bounces-110973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F25A20C7F
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702D43A1DA4
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556491ACECC;
	Tue, 28 Jan 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jG+U6Va"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FE1ACEAF
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076619; cv=none; b=eo2CX6F1OWlBphQZQ3+B13rOGJuBYugCdiBpS7CrXmEY7lFo0swCAOpZ158ESRMnW9Ofa/Kh5tutxzkZEeEwX6Imi7VekcvM5Qzwtw1WG3fWDqhVnvMXNKrM7o0esQxq7A3yb/3VcPg2z88/KCLDOoirPTG8k84HIl4XSYfd7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076619; c=relaxed/simple;
	bh=HxZqAfmOwOmAdIkMt8il6G9o8EwW76EVjFZIgPEmI3E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KG0nO4k/AhBMsT/2dlnjZNIiwiz6TSRcCPEShjPBLjBTFd8GJASrS8JSvdw7zIxeTHlq0Ez1YTOhAIhhvQv17mcBMNoCUzGYOQEwc9tcdp0tONMow1tZuTv0Rg9CaJAOwLG0d9h3tolIHh9Oc7EJ13sD5RcHUu7cc0e0MLioWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jG+U6Va; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3ff3c1b34so6927358a12.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738076615; x=1738681415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxA+vwnqpxls10tnWmMGS7RGdrVXAX57CVII7Fqqv/w=;
        b=2jG+U6VaalbPn6Et61fIOzIUhkgaA3Jbw7iON6GaFQ7gahw8iZbzOPaCZThctkYN++
         gfXyeLdyZSbObuwAdT47037k2pk9FccYC05GSQKeYscfwWN2af3mkzKbt+EUaR1wBODE
         0BW+hUvMpZCFK9O3bPEff3cHvwQmeYG/kjltB6JpucV+txw34uBAxiZFxpHr85bk28Vi
         jQBdYvalW0noZvLI1i1TLghGqvmXkcrb9GbDI+irQXPFk+D7HsL2Ejf4oUIWjQWYTood
         EXuMphGoVt2pWw/rEKvCpWvzhpBrclRsDL/7EEabKGGUoqe28tV7giEkFXedTl4SDyz2
         lpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076615; x=1738681415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxA+vwnqpxls10tnWmMGS7RGdrVXAX57CVII7Fqqv/w=;
        b=aN/AEpMVaFq1U/CZK7fJOBESeggaQy/y558AnJnxzfrl7+i58ihn2wppisi2apqwk8
         ixdwTvYvB96FWQAU5SJlWGiLDjRKJVy3i4/U1Oa3GWulGhtyHbdVO5F10YQiGDnGdDFC
         SQL/g6miaSJW0V+xsp79ZcS2+1QAJRNBBws7DXCrFUA2AvKiIxDXpOcVACbb5gBizu5O
         CsmWCM0lE2dG7RVmRDF8Fuviw9v933nAyfg4K+cAgyhaH8gr1jG1kkRT7CdMub89hRhi
         kkSV5syQTC1g8kAwEj6K5G0JMRfDUZ50mr4YHQq/Z3D8wyfcTWr5vKgDYXzYhR4bmGYR
         Vljg==
X-Gm-Message-State: AOJu0YwTUpxinnQin2u9W9AiIiPbAmz/xKy277VRlkGEyfEvqi/bQAIz
	7OMfiro/MqXVZ+0YHUkXg9Z67d8Bj1u3lvPOXkEGqEMUmDkK8sgHiDquOFa9Bj0Kwiym7E3TXrz
	kmnh+c8j2KeLkiQWYH2P/bfq3pctwOaZ50AloW9AtfB12ZP/C+VSU/7WkkmUiwMxGDy8+9s4fTI
	1rFAHW2uZ2eBRIZUzXWd+0na8OvilBgxRc+5Cr+8vMqNSjvxoC
X-Google-Smtp-Source: AGHT+IHC26ZV8SsPt/ePyqHG+Yq1YIWVyTaSaIEqI9OQLCZGI3bOc7Y2ctktffAZnVEncdYZ69L52w+a28KN0ag=
X-Received: from edze7.prod.google.com ([2002:a05:6402:1907:b0:5d8:ab23:4682])
 (user=ciprietti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13ca:b0:5dc:5860:688b with SMTP id 4fb4d7f45d1cf-5dc58606ab9mr1311866a12.16.1738076615624;
 Tue, 28 Jan 2025 07:03:35 -0800 (PST)
Date: Tue, 28 Jan 2025 15:03:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250128150322.2242111-1-ciprietti@google.com>
Subject: [PATCH] libfs: fix infinite directory reads for offset dir
From: ciprietti@google.com
To: stable@vger.kernel.org
Cc: ciprietti@google.com, yangerkun <yangerkun@huawei.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]

After we switch tmpfs dir operations from simple_dir_operations to
simple_offset_dir_operations, every rename happened will fill new dentry
to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
key starting with octx->newx_offset, and then set newx_offset equals to
free key + 1. This will lead to infinite readdir combine with rename
happened at the same time, which fail generic/736 in xfstests(detail show
as below).

1. create 5000 files(1 2 3...) under one dir
2. call readdir(man 3 readdir) once, and get one entry
3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
4. loop 2~3, until readdir return nothing or we loop too many
   times(tmpfs break test with the second condition)

We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
directory reads") to fix it, record the last_index when we open dir, and
do not emit the entry which index >= last_index. The file->private_data
now used in offset dir can use directly to do this, and we also update
the last_index when we llseek the dir file.

Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
[brauner: only update last_index after seek when offset is zero like Jan suggested]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
---
 fs/libfs.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index dc0f7519045f..916c39e758b1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -371,6 +371,15 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	xa_destroy(&octx->xa);
 }
 
+static int offset_dir_open(struct inode *inode, struct file *file)
+{
+	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
+	unsigned long next_offset = (unsigned long)ctx->next_offset;
+
+	file->private_data = (void *)next_offset;
+	return 0;
+}
+
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -384,6 +393,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
+	struct inode *inode = file->f_inode;
+	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
+
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -397,7 +409,11 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
+	if (!offset) {
+		unsigned long next_offset = (unsigned long)ctx->next_offset;
+
+		file->private_data = (void *)next_offset;
+	}
 	return vfs_setpos(file, offset, U32_MAX);
 }
 
@@ -427,7 +443,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
 {
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
@@ -436,17 +452,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			return ERR_PTR(-ENOENT);
+			return;
+
+		if (dentry2offset(dentry) >= last_index) {
+			dput(dentry);
+			return;
+		}
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
-			break;
+			return;
 		}
 
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
-	return NULL;
 }
 
 /**
@@ -473,22 +493,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dir = file->f_path.dentry;
+	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == 2)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	offset_iterate_dir(d_inode(dir), ctx, last_index);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
+	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.48.1.262.g85cc9f2d1e-goog



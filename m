Return-Path: <stable+bounces-59359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8815931876
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E136B1C20FAF
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459911C2A3;
	Mon, 15 Jul 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihl6hK5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D8E556
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060839; cv=none; b=mLVuq8OrvryVTsTRoTdC7AoxiSxXLMmdz1w4EmZtaJ29o+vQrwbtsxIsDHYXC87VDh5qWohRw+sG2Nuh67VXa3DviSkg+0jYRdFLxVzA6Z2lXQUH+jpEvT4I8hGf73nVpX0rfKei+o1xEi9UYiD13QDhaLAsXJo6uGE25ut62AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060839; c=relaxed/simple;
	bh=kjZaKa7Yy3SsKy6z3Y6+0MyoiyO4FHBO9KeKYKWgF1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=unS2HM57YnePozi0QjYgH9JN3T5VSbD0NBGZV3od3azEzaKubMX5wRHJwBcUMaQdDDlKYUe0glKQAFrAJBS8CICYHy3UgSUI+ufmMmZFXyTgwA3Zz0wbDHc5gebDbM548OPggAZ4OLe8u4JOl0GQY6M1uoUi7WDobyGjLCBJqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihl6hK5R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so2926190b3a.3
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721060836; x=1721665636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CR9XMGHVRfXioS9lgeIqkeVvd3FXXcJnxuvbUivr094=;
        b=ihl6hK5RZUwWa1QtcgW3MBoivLMgB8nWLi4CphDWSHoprPBIDn13ZWEOEEAoEP0Q9a
         hrXKryyPtTtQq6A0zwlIuofcD1nvdL6egEtuW05ZB/MAw7CLhYmSoj/OVMxVxCPQldsO
         Ukr4SzcgY8GAkd/N/f6Ugd/qE2BHQrxQz2YclJShN4/AVumgZYqdmyIqh5VkStu0x4jI
         nbDjRWoBWF7nvcO7algMUgaDvbFm8d7np1E6zum8ApdIo+xM90XnmPnuvt58B9n4V7dv
         YCXiTOUmHhN+j58qXx5WjQDZ5B83NkJxNBA1soLC/5tIWdfG2pyrMa1lCN92BsPcLQbG
         dgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721060836; x=1721665636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR9XMGHVRfXioS9lgeIqkeVvd3FXXcJnxuvbUivr094=;
        b=qLGII5H0AGmON27Dw+Kczg0qEgygzUpfuG0n+OEzVFvVKrPxSiGrxzg+AMBCg2NK9+
         NPtLrefYljgZJOVMjnHc0XH3D6zyUF8+NKjFDlxLydAswEIbuC2UiamrixH2UGJILXHR
         MVGYL/w3zdcOlhlDmTAgydQFQfCMGhFbxUXuqCmwXrW0zfyo5RO1soWObcvjO1H8Y0jR
         9tebkWsuENdV3a4F+gI/9dSF+lnbvcXATzPxSzMcumG5fBjLxlWWWUKH9boPwjN9moSy
         m8GieWeBfUqyQ8tWjkMQOOCNxy4DYZaFwavq1lpCNBbd4tXv0azu1EMxmdo1Fx+mKmwR
         JRbQ==
X-Gm-Message-State: AOJu0Yxs/ruch1/D4zKilWsfbig/3kV7tXttYabyawQdgFZZ9Q7Ls2Zm
	UZIJyJwOMKXEC+ueHS7c2TSNdoTuHYCDF/v4UOUZnx2Qdv1dg1Wf+eRCQQ==
X-Google-Smtp-Source: AGHT+IHwWV3yqWo0womJbuPfyFmRYENDW2z7JqNnqkmJzi5ASOmGcLzom3APbDUDW0IfAzA/86p11A==
X-Received: by 2002:a05:6a21:2fc7:b0:1c3:b263:d992 with SMTP id adf61e73a8af0-1c3ee4c6fabmr484901637.5.1721060836121;
        Mon, 15 Jul 2024 09:27:16 -0700 (PDT)
Received: from carrot.. (i222-151-34-139.s42.a014.ap.plala.or.jp. [222.151.34.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedcac15csm4571160a91.56.2024.07.15.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:27:15 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix kernel bug on rename operation of broken directory
Date: Tue, 16 Jul 2024 01:27:11 +0900
Message-Id: <20240715162711.6850-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a9e1ddc09ca55746079cc479aa3eb6411f0d99d4 upstream.

Syzbot reported that in rename directory operation on broken directory on
nilfs2, __block_write_begin_int() called to prepare block write may fail
BUG_ON check for access exceeding the folio/page size.

This is because nilfs_dotdot(), which gets parent directory reference
entry ("..") of the directory to be moved or renamed, does not check
consistency enough, and may return location exceeding folio/page size for
broken directories.

Fix this issue by checking required directory entries ("." and "..") in
the first chunk of the directory in nilfs_dotdot().

Link: https://lkml.kernel.org/r/20240628165107.9006-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+d3abed1ad3d367fa2627@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d3abed1ad3d367fa2627
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the patch that failed.

This patch is tailored to take page/folio conversion into account and
can be applied to these stable trees.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dir.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 51c982ad9608..53e4e63c607e 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -396,11 +396,39 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 {
-	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
+	struct page *page;
+	struct nilfs_dir_entry *de, *next_de;
+	size_t limit;
+	char *msg;
 
+	de = nilfs_get_page(dir, 0, &page);
 	if (IS_ERR(de))
 		return NULL;
-	return nilfs_next_entry(de);
+
+	limit = nilfs_last_byte(dir, 0);  /* is a multiple of chunk size */
+	if (unlikely(!limit || le64_to_cpu(de->inode) != dir->i_ino ||
+		     !nilfs_match(1, ".", de))) {
+		msg = "missing '.'";
+		goto fail;
+	}
+
+	next_de = nilfs_next_entry(de);
+	/*
+	 * If "next_de" has not reached the end of the chunk, there is
+	 * at least one more record.  Check whether it matches "..".
+	 */
+	if (unlikely((char *)next_de == (char *)de + nilfs_chunk_size(dir) ||
+		     !nilfs_match(2, "..", next_de))) {
+		msg = "missing '..'";
+		goto fail;
+	}
+	*p = page;
+	return next_de;
+
+fail:
+	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
+	nilfs_put_page(page);
+	return NULL;
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
-- 
2.43.5



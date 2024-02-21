Return-Path: <stable+bounces-23202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08185E377
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CAAB227C9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8A7FBD2;
	Wed, 21 Feb 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyVxku0C"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A54436C
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533382; cv=none; b=YrO6lZ+A5Vs6ZivwBa3zU4UggtBW6vUvHoP87NyQYT/JrPnOQa8E69eAqZ3iAXhuXIQIm9/r6NQF7AgwA1XyQcAjRjOuH6XZTQ/SqFP6ahqkaQrk4hakVFXGZcMihjxKrVy7dfR4jTvoUjzFJIbD6o3UantOyyHxyd6/at5paCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533382; c=relaxed/simple;
	bh=xzh1MU7f9HaHOo9h7VnbOedXYRbj+OXXK89ckVDOtuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsRmtLg9Yg2Rq8Zj06zDD5VXCvonA9sNcUsEeXmm4DOD42fOIPhBwkh01tJFulAd8BDstHyXrutkEpZITa2zYBqGJ0S6/MABBAHVYHzguXVV01SmGwwA1b2XbLXTT4XIo7iX2MO6lv63KbGBcou7vsy1prPNCoKHClYOax0lnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyVxku0C; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21eea6aab5eso2338483fac.0
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708533380; x=1709138180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkQBw5FsGQdBcawGN493vMEju9xJFrfDZMYFWYJyFn8=;
        b=OyVxku0CAcZmHqUed1rp16qX7nTV4QL9ygkmgS3qALjnwvKTXq/CcljsNijwD12b30
         15WhZ5aLRaH/dPrEsMgroojGaihhbEaPp9OeaJOGHW2VYbT+VJpby7b8JWla5uZi05Tx
         mmvI6tTApLpwSF5QcuzEb6+qQE54kErJO4qE+TcBFArbZ2Ew/bJlpt58UIq3UC6i8fwv
         wVdM0a9FO9MiPys+6iMx3/kRepSeT/oOx6X78hfqf1Qgfj5ACO+S0eoUzLDVtO5/Zijq
         KuBggRgPEUFt7Aw7wzYQ0E4NVGRV1iyryAPljlsn0duVm7Pumb2SxPxPoEy7jjkIh5+0
         qPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533380; x=1709138180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkQBw5FsGQdBcawGN493vMEju9xJFrfDZMYFWYJyFn8=;
        b=mKKrK/g1JWIDCR3ktBYG/sbSlV9dD0B84MF/d2EconT60fbMjrTr59AkifOZD+MgLM
         VghUjKEujZmiqJ8mPwtG07wbO/ULumws5UPFjvQAnlArEFJL9IdtJj6XH3R3UbEMlRAH
         RGKQ4hXLc/JPKLfLePEhSIADfG4lR64FO3zX3LROSuoMpapyq3dcMNW+2S1Rg1VVH2rZ
         hPlxkqcnGnUfhK3tCxQCoEZEQ1s1fGUSjVIUWh5LFm5hIIUueeqD4e9YxycclX5Sg+pr
         8Ms5FAnhjd/XypQFFZKX2EoN3fYHR/SNAr+OySsUJ+LrcXae1BZKcODxU4zsF4zwCpUL
         w7zQ==
X-Gm-Message-State: AOJu0Yx2m6SDR6DCRaYjXBfbjhSeWyfOZYQbRPGeZQLRPCHtHDBJmGPJ
	LBVraWvTuvyeKMGUkWCGFfVTKbph2Cne1nCHOkpnyiJDDwsq7Wowt6zs2x4i
X-Google-Smtp-Source: AGHT+IGYBNxZ8yWDVs1jXS+7wTGhfIEQqa7KAkEatTGeQ/Z6qpawJjQt8hywuWy6fSSvYWhQ+LuQDw==
X-Received: by 2002:a05:6871:b22:b0:21e:b386:3c96 with SMTP id fq34-20020a0568710b2200b0021eb3863c96mr13129883oab.11.1708533379958;
        Wed, 21 Feb 2024 08:36:19 -0800 (PST)
Received: from carrot.. (i223-217-149-232.s42.a014.ap.plala.or.jp. [223.217.149.232])
        by smtp.gmail.com with ESMTPSA id t1-20020a632d01000000b005dc9ab425c2sm8850885pgt.35.2024.02.21.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:36:19 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4] nilfs2: replace WARN_ONs for invalid DAT metadata block requests
Date: Thu, 22 Feb 2024 01:36:24 +0900
Message-Id: <20240221163624.3831-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5124a0a549857c4b87173280e192eea24dea72ad upstream.

If DAT metadata file block access fails due to corruption of the DAT file
or abnormal virtual block numbers held by b-trees or inodes, a kernel
warning is generated.

This replaces the WARN_ONs by error output, so that a kernel, booted with
panic_on_warn, does not panic.  This patch also replaces the detected
return code -ENOENT with another internal code -EINVAL to notify the bmap
layer of metadata corruption.  When the bmap layer sees -EINVAL, it
handles the abnormal situation with nilfs_bmap_convert_error() and finally
returns code -EIO as it should.

Link: https://lkml.kernel.org/r/0000000000005cc3d205ea23ddcf@google.com
Link: https://lkml.kernel.org/r/20230126164114.6911-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please use this patch for these versions instead of the patch I asked
you to drop in the previous review comments.

This replacement patch uses an equivalent call using nilfs_msg()
instead of nilfs_err(), which does not exist in these versions.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dat.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index e2a5320f2718..b9c759addd50 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_msg(dat->i_sb, KERN_ERR,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-- 
2.39.3



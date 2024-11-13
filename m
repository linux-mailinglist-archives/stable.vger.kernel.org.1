Return-Path: <stable+bounces-92886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED29C6811
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 05:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5319C1F23532
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1E157E99;
	Wed, 13 Nov 2024 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UrocXZy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12004C98
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472262; cv=none; b=OuQLFONpdcPe35b4xqI7+nlGV4HZr+3RnxQlYAAWW8bhyU8Q+ctV2q8zyQncdIpZePMoBAEeYPe3oUbQoqm6n4QABNJwADiIqJkoF9Du3Q8T3o9eTlpM3cMM0h+IcHguCRqFxD1wXRjm3lavVgf9mvPl9fxqAnUFnFiYlYRObCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472262; c=relaxed/simple;
	bh=oZDQTJLtJcHCejpZA3+0nESJjE3xAAyfxfgTevbidls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sW5RfKrpXpUB8exwr8klxDv9sjLsOlnPG95lIWADgHl3JJFrZwNFloks6c/5xXenNsNPCY56t9iFQpXhQlwz015yRFlks7r503VKSatXjItlQhFvmcr0jZRgTCOSNG2l0SQIIflhLCHKaLaQSGbApYJZ2kXm9I76xPY2G7p0Css=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UrocXZy9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so5143489a91.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 20:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731472260; x=1732077060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ln6qGplbSMy3aFazEp2e6kKmp/jRFWyhr19Z464DDf4=;
        b=UrocXZy96BxDp32jQ5GuXR8mjxhagqCD7wuN7NmbNgaDPksb64/oJyML0Tucx339r9
         TGglarUzWll3mDkqj21/ypKiEM7ok9419DNy8BomCN9pHEX85DiO0J44xXk8q16SlfWV
         CUqO9uelgSe/hpQ4KqVemZSisY/KhyJiifS8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731472260; x=1732077060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln6qGplbSMy3aFazEp2e6kKmp/jRFWyhr19Z464DDf4=;
        b=NUH2i0PXuPdTArG21U2Z82FntvuftAKneAQ2dd6UptMtUrnZxqlLErpO42//DkQtO4
         Y6bNHJgUsudtjY57z64+FsWFYpMZbl+gD6JV27FMBNYpqpa8vognfR7LG/j/HKck4X0z
         6aGr0WMFqk9huu5WgjPvOmxGyWZIJBSmuu1vjtGGinGtoxG21aTAgRknTqTdY7WDf84u
         JevbR1HZpM2NIs6eFMz/P20n4nfFiPV+nmNiWqVu4w5dObwRPGbybfCpYeWAvXAbTlBc
         aPuhjEBgFwjA3LnaRMEgLZd1tQeqnp0b3XLfr37eNqX8AGwadR6VtTh2cWJhMckkwg+w
         Of/g==
X-Gm-Message-State: AOJu0YzTHZh+TSjoMSRy8wTJQTPZiYjIGnYpFrp5x2nuurMo62heyiMV
	sDKy0reQGLoTW+3BeLptxhDgf0lA8xAcN7S4HQNr+EqA0KagW+OvRjithBYDiVGqd+OE5XXun6c
	=
X-Google-Smtp-Source: AGHT+IFrcUJFMmWGjyE88CyyZaRPZkAHL55ZRqVbykkukt+u8VXds3Fk/ZCP+ccIo+F2IAmytEWvMw==
X-Received: by 2002:a17:90b:4b88:b0:2e5:5e55:7f1b with SMTP id 98e67ed59e1d1-2e9b16e1e82mr25737759a91.4.1731472259625;
        Tue, 12 Nov 2024 20:30:59 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:50c:65db:bb29:3cca])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e9f3ea5742sm455439a91.4.2024.11.12.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 20:30:59 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 5.15] udf: Allocate name buffer in directory iterator on heap
Date: Wed, 13 Nov 2024 13:30:35 +0900
Message-ID: <20241113043050.1975303-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]

Currently we allocate name buffer in directory iterators (struct
udf_fileident_iter) on stack. These structures are relatively large
(some 360 bytes on 64-bit architectures). For udf_rename() which needs
to keep three of these structures in parallel the stack usage becomes
rather heavy - 1536 bytes in total. Allocate the name buffer in the
iterator from heap to avoid excessive stack usage.

Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c | 23 +++++++++++++++--------
 fs/udf/udfdecl.h   |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index e7e8b30876d9..a4c91905b033 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -248,9 +248,14 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 	iter->elen = 0;
 	iter->epos.bh = NULL;
 	iter->name = NULL;
+	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
+	if (!iter->namebuf)
+		return -ENOMEM;
 
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_copy_fi(iter);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		err = udf_copy_fi(iter);
+		goto out;
+	}
 
 	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
 		       &iter->eloc, &iter->elen, &iter->loffset) !=
@@ -260,17 +265,17 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 		udf_err(dir->i_sb,
 			"position %llu not allocated in directory (ino %lu)\n",
 			(unsigned long long)pos, dir->i_ino);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto out;
 	}
 	err = udf_fiiter_load_bhs(iter);
 	if (err < 0)
-		return err;
+		goto out;
 	err = udf_copy_fi(iter);
-	if (err < 0) {
+out:
+	if (err < 0)
 		udf_fiiter_release(iter);
-		return err;
-	}
-	return 0;
+	return err;
 }
 
 int udf_fiiter_advance(struct udf_fileident_iter *iter)
@@ -307,6 +312,8 @@ void udf_fiiter_release(struct udf_fileident_iter *iter)
 	brelse(iter->bh[0]);
 	brelse(iter->bh[1]);
 	iter->bh[0] = iter->bh[1] = NULL;
+	kfree(iter->namebuf);
+	iter->namebuf = NULL;
 }
 
 static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index f764b4d15094..d35aa42bb577 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -99,7 +99,7 @@ struct udf_fileident_iter {
 	struct extent_position epos;	/* Position after the above extent */
 	struct fileIdentDesc fi;	/* Copied directory entry */
 	uint8_t *name;			/* Pointer to entry name */
-	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+	uint8_t *namebuf;		/* Storage for entry name in case
 					 * the name is split between two blocks
 					 */
 };
-- 
2.47.0.277.g8800431eea-goog



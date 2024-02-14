Return-Path: <stable+bounces-20164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978D8547B1
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D256A281ACC
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444F171CC;
	Wed, 14 Feb 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu+0gf1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE918EAD
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908570; cv=none; b=jCfrAZd5ABWpg7f8612WQlto8usTzBF+/lyboaSkUKtwxODfUR/pA5dQjBBOQ/taypfrd6u9dE8NSIwp2s5t6qyV7zWAnWT8meMy7YcYpTTaUNKYMPxAFvELgy4NQZNrc0Yp4FueWbIf+HUZUU6Ui507Smoxhn4/5OwbNOjpmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908570; c=relaxed/simple;
	bh=KhvqyU2SImqaAnzXlyOyp4cn+v+NvdExQv0lUBT7QE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y8PkR/a+eFcXYXEA6mSkSaBmCFxipG7QxEKFebLis9ZwtMFdRo8d3F0cFhLZKl9fM5P2HAs4LNx+reb7yPgbzfQL7ljuQ5YcSTmkCNna9qQT5Fnq18hEPWm9nYhAl6jmI/phvwYYW9zgIkSK2oiaDIDlzG3DMVudmaYQQWJt4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu+0gf1F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so13550085ad.3
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707908567; x=1708513367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4gdcqIsNQNU4ZdN2JO2vdY2WFbhslvGSd61nTxep2A=;
        b=Cu+0gf1FQckkElJ4lvzvUPd/QM/yZWN5PhwOgpFrJWC1FfJXpfpMY0UKR7SNbtjKi9
         5tC03TbdLgBqPoi/gNBD62ia4fMYzdOWOLBg2fwRco4QFgFj9XxEwuleCh5R/ivBjQ4B
         erVq75siCFCfQpDPncb8+6wvcocywYGWvjh/OrXoe5wvQR6IQ9lhtlRwh4lmrkfctLuN
         P3Nv1DJPa3jfz6Ztik4GxwGtSzEtm6fX/Lm7VrvMHz2ZvrVq0vo+ieUMCzjhRmnT0r9n
         /mXqTOF0x2GpijtQaZDx72SindU51LANlE+umaOpcDNMfaZ9H6rF/WFBLnUJ7HU4jsN2
         U6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908567; x=1708513367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4gdcqIsNQNU4ZdN2JO2vdY2WFbhslvGSd61nTxep2A=;
        b=XbxUaX0AOZhy5MIOFRIP/FajhURdYeYP7ZYBOPC2raujNyrbEXsampOZYSaHgUNSF6
         cXdWYZE7InVqt589ow7Y2fxh2F+Yi4Dlqe8w5QSQs1XA0QkM1B6A+0dcLSZwdb+J6dnp
         VLf+aPwIuXrVexEbKfH+zHrzMvTDo+Vuo/wk/CtPMmyq4YxEYIbkbit/IFTKdLjzj3tt
         /hS1M72ReIrujs9V9tjLv2qQoY/Yz9liA3kp69TmcB/XKxb/DtiWVMh0+r7FokJsNpLX
         CO73RZ8xeocWw827bc/i8YXPIh/OY4M9gtvtpLhvR5i4d80fwt1uaPokE8FXcDzfTnYh
         zkuw==
X-Gm-Message-State: AOJu0YzUwaGD+Egcc1EUDPT1ecUKQMZK+JvD5Yp3LYLT9k/elmnhJapr
	aIbdIYbmuuwgVay37LV3VMLODex9PQZNbVDDFVWSD/zHveUf7gEcVWLWWR+5
X-Google-Smtp-Source: AGHT+IGCKqIYQwdO3NMe1u//ihlrVudQjQWVsuIGclrbGf8pS6Z/FZmHmlbMeWOZ+whUUywKJDpHEA==
X-Received: by 2002:a17:902:b217:b0:1d9:624e:126d with SMTP id t23-20020a170902b21700b001d9624e126dmr2101494plr.62.1707908567335;
        Wed, 14 Feb 2024 03:02:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdr8WQalLUwjOV33b/2WDqE8lGjoyew05WXSvyjPFCYa088zTvmyymcazJPBnJGeKqjJ5+00Gg9muiPcvFccSuTj/19e1VOrK+5w==
Received: from carrot.. (i223-217-149-232.s42.a014.ap.plala.or.jp. [223.217.149.232])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001da342cf818sm3482360plb.141.2024.02.14.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:02:45 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 6.7] nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
Date: Wed, 14 Feb 2024 20:01:10 +0900
Message-Id: <20240214110110.6331-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 38296afe3c6ee07319e01bb249aa4bb47c07b534 upstream.

Syzbot reported a hang issue in migrate_pages_batch() called by mbind()
and nilfs_lookup_dirty_data_buffers() called in the log writer of nilfs2.

While migrate_pages_batch() locks a folio and waits for the writeback to
complete, the log writer thread that should bring the writeback to
completion picks up the folio being written back in
nilfs_lookup_dirty_data_buffers() that it calls for subsequent log
creation and was trying to lock the folio.  Thus causing a deadlock.

In the first place, it is unexpected that folios/pages in the middle of
writeback will be updated and become dirty.  Nilfs2 adds a checksum to
verify the validity of the log being written and uses it for recovery at
mount, so data changes during writeback are suppressed.  Since this is
broken, an unclean shutdown could potentially cause recovery to fail.

Investigation revealed that the root cause is that the wait for writeback
completion in nilfs_page_mkwrite() is conditional, and if the backing
device does not require stable writes, data may be modified without
waiting.

Fix these issues by making nilfs_page_mkwrite() wait for writeback to
finish regardless of the stable write requirement of the backing device.

Link: https://lkml.kernel.org/r/20240131145657.4209-1-konishi.ryusuke@gmail.com
Fixes: 1d1d1a767206 ("mm: only enforce stable page writes if the backing device requires it")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000047d819061004ad6c@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject line
prefix.

These versions do not yet have page-to-folio conversion applied to the
target function, so page-based "wait_on_page_writeback()" is used instead
of "folio_wait_writeback()" in this patch.  This did not apply as-is to
v6.5 and earlier versions due to an fs-wide change.  So I would like to
post a separate patch for earlier stable trees.

Thanks,
Ryusuke Konishi

 fs/nilfs2/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 740ce26d1e76..0505feef79f4 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -105,7 +105,13 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	wait_on_page_writeback(page);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return vmf_fs_error(ret);
-- 
2.39.3



Return-Path: <stable+bounces-20198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92573854F08
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 17:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF028FC4E
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC50604AF;
	Wed, 14 Feb 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOPZxgRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2F60273
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929294; cv=none; b=bSQrDDuR20U+bsYZyGIT97yOD/SUnDVX+ybL4tdNHDbeVWPTgHA4dh18cvZi6rAhbALGIzU1j7GPDX4ddRrp6QybJLZRZ6SB8ZeTFOUWeOHknFMC3M7ZnruBcsr7xfLAVFBRfAPIjA+PsVzxm6OH4ezjlnJ7VEzu8CajNvoHBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929294; c=relaxed/simple;
	bh=xT+RgJHSo2vdxV88Vs4x/fXB4DI5601vkyLotJ9HM50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ize+V5y3fZYYjIuD6KkvoetC001XCbdie5zSE2AJ4tITrJ1NTSJW9NrhiRK9KgPxcrKyesUe63uSney8iv7jTqVp9jyBYBtHKvbOSXwqOoI+m2Db9R8T8g4gXTDOH7GIIrAf//t0lCTWe1YBM85NhibvMPP7X/erIzISMd7oYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOPZxgRG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1db559a5e1fso7150915ad.1
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929291; x=1708534091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTWGu0/bskT9cMMUwm6IW0mSn4D9b4Ks6cVTC54GxjE=;
        b=NOPZxgRG+Y9Qhi0Uhnl7GgRdAy4RAuP1S40JD6AMjpa/j9PFaQPmxWJvW61i3+QarS
         XSWxGSW+1Qxcv5Ar3EFH5StajTM1yJ/3VLEWEEgqye9B5cNTUL7CJF2EEt4zdSWE6LDw
         L4G6mNTjJHssnj1Bznd857Pywe4B41oHNig0T7ervWFdRs8aLppxF22vbF4kAu2rX2hG
         24TOJ5+jbSbZ0v4EGZx/ZoMy5ifT86quHgP9QRgFhZ/GEQQ+2s+jGLtRZhN/DsbkQ5C4
         VPvZh9W3472OQR5dnc3CWGzFqv3wK/Fb+3hUowvZNNPHdQhGS+L2bEx69hUwFH2ng+BI
         lHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929291; x=1708534091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTWGu0/bskT9cMMUwm6IW0mSn4D9b4Ks6cVTC54GxjE=;
        b=rErXNWEK826kYRo6KDutiZkRoWQVtdDBFzMyphBrrBj78RgMoy8384KxB7PfAEAAgA
         KGbYKHYjY6v66uMJ3G9OQ0p7IDM/ObKTzpurkIr3CYvCME0YIZbX1PzQXT7W7atH9VoP
         BHPesAT0sQMoZpVOrMWSO5IGIF5xPk7i6yuj4DR+CYym25zC1CTGJE1RQ6s41xE2UgPI
         YWb6dpMoDEg/gtTEgI8GU4VSFbTils7LX2Ue+hlMvNbBZwjnOXitn8E6YvTmqz0sqIpS
         5H9ObIl7Pm0bn7hf/pcYxOe/X5cUmJhopmSdmX0xtwJNq2x6QZcMnNiEumk8BYFsF0Oy
         ryaw==
X-Gm-Message-State: AOJu0YynOs7iUFr6q2AA+xpGzxzMclAqk9eDPcV6Gg5DU4qk0ziFeb2U
	w70XmO5NnYOh52jSfpLV6+76R8BKQItNWhjCrlThITItmog/iZxpHWimzcA2
X-Google-Smtp-Source: AGHT+IFmvGdHT1t4k6QDpQpf/J6tWfObKKZ/9Bug1lj0KueheWUmFAShducWSwBNV1pWB59hMwLfBA==
X-Received: by 2002:a17:903:2652:b0:1db:2ad2:eff5 with SMTP id je18-20020a170903265200b001db2ad2eff5mr2992586plb.60.1707929290681;
        Wed, 14 Feb 2024 08:48:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOG8vVlH+l4csiNvftoUArKQx0U7MKRZMtwK/6D7AeSXkYNQGB9FTArm9DWJ2MAcFzSc/de+p7vAqLMV9bgfGVQ9xgcCjbeePPOw==
Received: from carrot.. (i223-217-149-232.s42.a014.ap.plala.or.jp. [223.217.149.232])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001d8d0487edbsm4065112plk.223.2024.02.14.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:48:08 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1] nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
Date: Thu, 15 Feb 2024 01:45:19 +0900
Message-Id: <20240214164519.8908-1-konishi.ryusuke@gmail.com>
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

This patch is tailored to account for page/folio conversion and an fs-wide
change around page_mkwrite, and is applicable as-is to all versions from
v3.9 (where the issue was introduced) to v6.5.

Also, all the builds and retests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index a265d391ffe9..822e8d95d31e 100644
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
 	return block_page_mkwrite_return(ret);
-- 
2.39.3



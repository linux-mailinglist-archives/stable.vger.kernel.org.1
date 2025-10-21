Return-Path: <stable+bounces-188489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B56BF8626
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F8EF4EA4F2
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83A274666;
	Tue, 21 Oct 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVZ1L3MG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77140273D9A;
	Tue, 21 Oct 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076569; cv=none; b=WV64DLv+6ulubNdvQ/Gj0aslc68HHM8yOBlZMrVpWY3uB0xE5aAiuk4yiu/+784g++Lmy8NQwO/MILyXv0CG6uNfTNaRFe8AIYBhRgWm7nCJPvdI2zYTYmh4T/msiRg2vYxUVRGKQK8R/mUdhX50nlD7cH7Zc6dSqQu5l659KRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076569; c=relaxed/simple;
	bh=Urn2mIWtIepZa1EMWXkhAISoumLFKyv2avl0g9LL0Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E067936m45zknnQEif11ddXPrOFlW3jWwfxCt0fDbh6xWJuPDCAYLS8utFMgG+Ck/v7dCK402fhzEaMDQpGaYYZhIHpJ9IyJPShcIXRJ0wxGjlHtRlLucErYQ/SMO0dxRudE6q1sr6iWM58VZ5dY77/TKXUo+5Sva0HgEoBL270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVZ1L3MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71020C4CEF7;
	Tue, 21 Oct 2025 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076568;
	bh=Urn2mIWtIepZa1EMWXkhAISoumLFKyv2avl0g9LL0Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVZ1L3MGYKpbVmEIr5eiNd5c5oz4YLuuXEdfLREtz9LPv0eV4tBA5X7Q5W0FAuKeU
	 BwoTF1v7cSiGConp+7hhX9rcv3ZYcuM2NuUZ0xwqP+2L8EMIvCmpJuw3pPWhGT4pLN
	 lu1cIZ1TirfG4Zj5hq8MvkevzCyN/aQ+M5w/FFLM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com,
	syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mahmoud Adam <mngyadam@amazon.de>
Subject: [PATCH 6.6 075/105] nilfs2: fix deadlock warnings caused by lock dependency in init_nilfs()
Date: Tue, 21 Oct 2025 21:51:24 +0200
Message-ID: <20251021195023.435485008@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit fb881cd7604536b17a1927fb0533f9a6982ffcc5 upstream.

After commit c0e473a0d226 ("block: fix race between set_blocksize and read
paths") was merged, set_blocksize() called by sb_set_blocksize() now locks
the inode of the backing device file.  As a result of this change, syzbot
started reporting deadlock warnings due to a circular dependency involving
the semaphore "ns_sem" of the nilfs object, the inode lock of the backing
device file, and the locks that this inode lock is transitively dependent
on.

This is caused by a new lock dependency added by the above change, since
init_nilfs() calls sb_set_blocksize() in the lock section of "ns_sem".
However, these warnings are false positives because init_nilfs() is called
in the early stage of the mount operation and the filesystem has not yet
started.

The reason why "ns_sem" is locked in init_nilfs() was to avoid a race
condition in nilfs_fill_super() caused by sharing a nilfs object among
multiple filesystem instances (super block structures) in the early
implementation.  However, nilfs objects and super block structures have
long ago become one-to-one, and there is no longer any need to use the
semaphore there.

So, fix this issue by removing the use of the semaphore "ns_sem" in
init_nilfs().

Link: https://lkml.kernel.org/r/20250503053327.12294-1-konishi.ryusuke@gmail.com
Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00f7f5b884b117ee6773
Tested-by: syzbot+00f7f5b884b117ee6773@syzkaller.appspotmail.com
Reported-by: syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f30591e72bfc24d4715b
Tested-by: syzbot+f30591e72bfc24d4715b@syzkaller.appspotmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/the_nilfs.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -680,8 +680,6 @@ int init_nilfs(struct the_nilfs *nilfs,
 	int blocksize;
 	int err;
 
-	down_write(&nilfs->ns_sem);
-
 	blocksize = sb_min_blocksize(sb, NILFS_MIN_BLOCK_SIZE);
 	if (!blocksize) {
 		nilfs_err(sb, "unable to set blocksize");
@@ -757,7 +755,6 @@ int init_nilfs(struct the_nilfs *nilfs,
 	set_nilfs_init(nilfs);
 	err = 0;
  out:
-	up_write(&nilfs->ns_sem);
 	return err;
 
  failed_sbh:




Return-Path: <stable+bounces-205261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E7CF9D58
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1A730E56A7
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B4346FBD;
	Tue,  6 Jan 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wt010Lze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80034678C;
	Tue,  6 Jan 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720108; cv=none; b=a70h19SgQUem3aV/M586nQ3C5uLxiUpGTpY5TDVdQMf1r65MSupZB76pJ+6fY0xkZWKwPwO0U6mv1pbjOT3iPpYXjuhpcB1fte5UbN7X1Dt/fZBqW8Xar1exAii038EZWRiYZlpfrVUqysiqXQ0mwYLyLoLXNHRjQzUCY6irovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720108; c=relaxed/simple;
	bh=fAUDj3JPjWOA1+xmTUXjPcAb6ixvpzKob9KxeqHkQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRU5wxfKqAXedT8nmPyRBADBVNf4wdLSylwjdrrnZowroh2XB3lSknALXdZukEYTRGbGbXE9KZixQtxpZu5wVIcfgI2iZWWQMxg4GYg+19xlKpZNJcrLOILKQ9tfhh5De7597DBowkny6fc9Z2Tu/khWBvruuPZRSrhJv7+j29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wt010Lze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C08C19424;
	Tue,  6 Jan 2026 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720108;
	bh=fAUDj3JPjWOA1+xmTUXjPcAb6ixvpzKob9KxeqHkQys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wt010LzeogJIeZbgrQd1lMMNFQGhBLwcyZQ2MEIrJZMpf6QxZcWq4fuSsolrxt9fb
	 bL6PdlZ+Ct+JO72zXkiRNF5qisEuM5hb5PRNUxjfQBH0/1telqrNwZe72uiI9gpUtN
	 xvbAalQk6KunkCqb/AnI97HoaS5jmXNb2ybHz5xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 135/567] exfat: zero out post-EOF page cache on file extension
Date: Tue,  6 Jan 2026 17:58:37 +0100
Message-ID: <20260106170456.319454613@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 4e163c39dd4e70fcdce948b8774d96e0482b4a11 ]

xfstests generic/363 was failing due to unzeroed post-EOF page
cache that allowed mmap writes beyond EOF to become visible
after file extension.

For example, in following xfs_io sequence, 0x22 should not be
written to the file but would become visible after the extension:

  xfs_io -f -t -c "pwrite -S 0x11 0 8" \
    -c "mmap 0 4096" \
    -c "mwrite -S 0x22 32 32" \
    -c "munmap" \
    -c "pwrite -S 0x33 512 32" \
    $testfile

This violates the expected behavior where writes beyond EOF via
mmap should not persist after the file is extended. Instead, the
extended region should contain zeros.

Fix this by using truncate_pagecache() to truncate the page cache
after the current EOF when extending the file.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 7ac5126aa4f1..033852efe5dc 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -25,6 +25,8 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_chain clu;
 
+	truncate_pagecache(inode, i_size_read(inode));
+
 	ret = inode_newsize_ok(inode, size);
 	if (ret)
 		return ret;
@@ -587,6 +589,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_lock(inode);
 
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-- 
2.51.0





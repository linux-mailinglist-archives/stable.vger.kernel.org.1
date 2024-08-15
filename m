Return-Path: <stable+bounces-67804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1D952F2B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F704B260D2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4619DF9E;
	Thu, 15 Aug 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nDTZ+yGg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FF1DDF5;
	Thu, 15 Aug 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728570; cv=none; b=kVcCzmEzhbAsGqkkaN12PQ7UevW4kOYbs18+zQCiqmy2tfEwXgdJ6tzx2cwIcpQ/4ufWUC6PBCp+MiXFtsr+PJapB3mCQcn880YFLz38P9Nzp7rqqb3RXqMsp6OlvI61AtAPX3CERin/rgn6dghD1Enj71WD8mJJI0NbYGOaSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728570; c=relaxed/simple;
	bh=R6q2mV44HDeLwUFgsSLweWfuVtA0119Tebh7ZlkWor8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qisKNqRHCXX7uRssUHzzYOj3zGepiQijS+SbmbJlkjdqm9hVY31TrGTGDlvB00O2typPJqXijlXvOO1mIbXbz8A38IxhMn4Kk/qIcWYDYf/46vZOnmGqUS/9DqQQFD370veHgamIJVNUE5AGWccmOcsaXYF+8cCCJ9Ac5lyGGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nDTZ+yGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF77DC32786;
	Thu, 15 Aug 2024 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728570;
	bh=R6q2mV44HDeLwUFgsSLweWfuVtA0119Tebh7ZlkWor8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDTZ+yGgMprHG2ny2S9HH8AzQL4AQBf6ffiuwBiLZBUFVGMIhjBpC0riLiVwNsnss
	 7ZOuwnvC8Rb2lgFKe+APM9qqDdj0EI2A2TvVNGsVEfqI1f9gP8BjXTI10O95ZPUCxo
	 bkGzrAZ79BYlQGr6ltjuDAeOA6YqiAW36ZFoNDa0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com,
	Hugh Dickins <hughd@google.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/196] ext4: avoid writing unitialized memory to disk in EA inodes
Date: Thu, 15 Aug 2024 15:22:37 +0200
Message-ID: <20240815131853.619190700@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 65121eff3e4c8c90f8126debf3c369228691c591 ]

If the extended attribute size is not a multiple of block size, the last
block in the EA inode will have uninitialized tail which will get
written to disk. We will never expose the data to userspace but still
this is not a good practice so just zero out the tail of the block as it
isn't going to cause a noticeable performance overhead.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Reported-by: syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240613150234.25176-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dc42a8fba0d22..e9299f769dbfe 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1420,6 +1420,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 			goto out;
 
 		memcpy(bh->b_data, buf, csize);
+		/*
+		 * Zero out block tail to avoid writing uninitialized memory
+		 * to disk.
+		 */
+		if (csize < blocksize)
+			memset(bh->b_data + csize, 0, blocksize - csize);
 		set_buffer_uptodate(bh);
 		ext4_handle_dirty_metadata(handle, ea_inode, bh);
 
-- 
2.43.0





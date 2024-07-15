Return-Path: <stable+bounces-59300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C66F93114C
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077F9B2408F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270E187323;
	Mon, 15 Jul 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qk5VviDh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FE186E5A
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036149; cv=none; b=gbPJKD7FoZxo7ovGNBiZodLtrNSVU10pOszVAiPkjs6Mss3MX7ViazYbSzIOKckE9TDsEi/UpZhVmnCNMeEgmomu66vx8LXgm562cbxOTwFMZZmmSM0YkYwXpfcKdys5hYx8yllN+JwcofhcmZy8xwYFUv/lVyJaS8st4/kZaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036149; c=relaxed/simple;
	bh=3TMVX1FeHDlFowJEoer9KMC08tz4Fcjtbm3An92U+V4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A4AQh0JBZBDBvOXncWqa5Gt5t6XigrqnhwUsxuJMR5DdjfABd7s1/FoK2s3bf72Lavq1TV0S8nkMSK2v1DpbiQtXY4FjVzE0WqEM9wSkakm9cIDuzo0sEpzK3lsrDZjUHUPB6wTLEDQ3Y0XDw/POgj7Dg+PjPzLO069P4QL1Z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qk5VviDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14AEC4AF0E;
	Mon, 15 Jul 2024 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721036149;
	bh=3TMVX1FeHDlFowJEoer9KMC08tz4Fcjtbm3An92U+V4=;
	h=Subject:To:Cc:From:Date:From;
	b=Qk5VviDhMJpDASsoLEwfapvMrJ4Qy1fmPgYxCZUvqK5D5qEhc/ak/kyBtlchx7j5p
	 XrBXLo9IcOnRt4zA0CvcEIE/8AzGRwsA6soKdoq3HrtG9KkYrynL5wFDDPsxxsvj0b
	 aJmeq/U7yB/AaFtbZ66TL+XZIGYco2qmvdycnfsA=
Subject: FAILED: patch "[PATCH] nilfs2: fix kernel bug on rename operation of broken" failed to apply to 5.15-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 11:35:38 +0200
Message-ID: <2024071537-wilt-goliath-e654@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a9e1ddc09ca55746079cc479aa3eb6411f0d99d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071537-wilt-goliath-e654@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a9e1ddc09ca5 ("nilfs2: fix kernel bug on rename operation of broken directory")
6f133c97e5ce ("nilfs2: convert nilfs_rename() to use folios")
a4bf041e44d5 ("nilfs2: convert nilfs_find_entry to use a folio")
9b77f66f9927 ("nilfs2: switch to kmap_local for directory handling")
09a46acb3697 ("nilfs2: return the mapped address from nilfs_get_page()")
6af2191f8358 ("nilfs2: remove page_address() from nilfs_delete_entry")
6bb09fa1b44f ("nilfs2: remove page_address() from nilfs_set_link")
8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")
584db20c181f ("nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link")
b3e1cc3935ff ("nilfs2: convert to new timestamp accessors")
e21d4f419402 ("nilfs2: convert to ctime accessor functions")
21a87d88c225 ("nilfs2: fix NULL pointer dereference at nilfs_bmap_lookup_at_level()")
79ea65563ad8 ("nilfs2: Remove check for PageError")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9e1ddc09ca55746079cc479aa3eb6411f0d99d4 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 29 Jun 2024 01:51:07 +0900
Subject: [PATCH] nilfs2: fix kernel bug on rename operation of broken
 directory

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

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index dddfa604491a..4a29b0138d75 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -383,11 +383,39 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct nilfs_dir_entry *de = nilfs_get_folio(dir, 0, foliop);
+	struct folio *folio;
+	struct nilfs_dir_entry *de, *next_de;
+	size_t limit;
+	char *msg;
 
+	de = nilfs_get_folio(dir, 0, &folio);
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
+	*foliop = folio;
+	return next_de;
+
+fail:
+	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
+	folio_release_kmap(folio, de);
+	return NULL;
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)



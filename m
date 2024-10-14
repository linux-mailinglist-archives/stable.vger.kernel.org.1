Return-Path: <stable+bounces-84576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909599D0DC
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA2284148
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76B55896;
	Mon, 14 Oct 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1ER26l4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5226296;
	Mon, 14 Oct 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918478; cv=none; b=OHakwcQdwRbbzhWlHaRU4J2VN+lBn/PBBQGOv3ZRcvFvlBS6S05lJf5B8I8svkttAmzGHkmlOuFvppEyQEiLWME9W98i18ClixmOy5CznXPwPQ9el6uQEJ/Nri3s3IsUPn06GZ/a81rU4dDEJ97tPl7UOXg4QOqGGJAyoHgKLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918478; c=relaxed/simple;
	bh=5C3RfetryDn29rHsdJSqHvgeqfB74R9s3Q+C97PmwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYiPex/4PsMtYeupGeXPnBumobQyZF7v8mWjCfpPoHIs3joqzCmgpxnC0SmfqiZx/wvhfHZVAsMdwsej3TdjEMvhYnV1xyGx1OhBCKqxSDasEynyA1fU9cIUKgemjnK0rm7fv03UJei1NnrMttOFL5p9C3TjZS8ggMvvGi189Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1ER26l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ED7C4CEC3;
	Mon, 14 Oct 2024 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918478;
	bh=5C3RfetryDn29rHsdJSqHvgeqfB74R9s3Q+C97PmwVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1ER26l4OSwktgKyIddy/67r0TPLcO/p82Dcnomq5YPPM0ySH8LUvdAMyAiAa9u/7
	 dlXbth7+Sy1iRcI6h3hefHJiJbAmM8Ven97gZTM4QyJuwOO+20MTO+wYzEw6L54//8
	 B1xp/UXj91pg8FG5u/YgGvPwXMeAH5oiaM4mxjvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 336/798] vfs: fix race between evice_inodes() and find_inode()&iput()
Date: Mon, 14 Oct 2024 16:14:50 +0200
Message-ID: <20241014141231.148784988@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Sun <sunjunchao2870@gmail.com>

commit 88b1afbf0f6b221f6c5bb66cc80cd3b38d696687 upstream.

Hi, all

Recently I noticed a bug[1] in btrfs, after digged it into
and I believe it'a race in vfs.

Let's assume there's a inode (ie ino 261) with i_count 1 is
called by iput(), and there's a concurrent thread calling
generic_shutdown_super().

cpu0:                              cpu1:
iput() // i_count is 1
  ->spin_lock(inode)
  ->dec i_count to 0
  ->iput_final()                    generic_shutdown_super()
    ->__inode_add_lru()               ->evict_inodes()
      // cause some reason[2]           ->if (atomic_read(inode->i_count)) continue;
      // return before                  // inode 261 passed the above check
      // list_lru_add_obj()             // and then schedule out
   ->spin_unlock()
// note here: the inode 261
// was still at sb list and hash list,
// and I_FREEING|I_WILL_FREE was not been set

btrfs_iget()
  // after some function calls
  ->find_inode()
    // found the above inode 261
    ->spin_lock(inode)
   // check I_FREEING|I_WILL_FREE
   // and passed
      ->__iget()
    ->spin_unlock(inode)                // schedule back
                                        ->spin_lock(inode)
                                        // check (I_NEW|I_FREEING|I_WILL_FREE) flags,
                                        // passed and set I_FREEING
iput()                                  ->spin_unlock(inode)
  ->spin_lock(inode)			  ->evict()
  // dec i_count to 0
  ->iput_final()
    ->spin_unlock()
    ->evict()

Now, we have two threads simultaneously evicting
the same inode, which may trigger the BUG(inode->i_state & I_CLEAR)
statement both within clear_inode() and iput().

To fix the bug, recheck the inode->i_count after holding i_lock.
Because in the most scenarios, the first check is valid, and
the overhead of spin_lock() can be reduced.

If there is any misunderstanding, please let me know, thanks.

[1]: https://lore.kernel.org/linux-btrfs/000000000000eabe1d0619c48986@google.com/
[2]: The reason might be 1. SB_ACTIVE was removed or 2. mapping_shrinkable()
return false when I reproduced the bug.

Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
CC: stable@vger.kernel.org
Fixes: 63997e98a3be ("split invalidate_inodes()")
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Link: https://lore.kernel.org/r/20240823130730.658881-1-sunjunchao2870@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/inode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -757,6 +757,10 @@ again:
 			continue;
 
 		spin_lock(&inode->i_lock);
+		if (atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;




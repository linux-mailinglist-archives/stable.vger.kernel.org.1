Return-Path: <stable+bounces-143798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C174AB4195
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3954A0BF2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42A5298C23;
	Mon, 12 May 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e93sx00j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4B298C1A;
	Mon, 12 May 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073066; cv=none; b=C3i76RMHkcbi2m+fQDkglVP4mjikKDwGJagooIiXZ1QdXKl7WQFgl+mXZHrE2a1MVc3zQi65vI82NOZIVPFcfXMPHegeekYRrftLKSz3810UPJxCwlNqIwwNAlzYRZZxAEPKDR/o5Cw0zhkErdsuSBZFZKb/r1KGlwcqan0x1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073066; c=relaxed/simple;
	bh=xe/yd5hY9F/c7KpezlLnUK454tNnJ0eM9dMDV1J9e/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NohzNA55gspVOvBdfcG50/OrBNkpNVY0w8MKZcswc4TmdQjVzDEEdGqEzsNaD6W2SaTAJv3TJOYK0/jjBgJeeQ/+NN13GCnSEdo0jL/c04+LUD6ZOV0OnF0dbPjo47+deWJTLBTNXbiWsTGr62wbBnbfScJGf+HQwkBaR0NtLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e93sx00j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D7AC4CEE7;
	Mon, 12 May 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073066;
	bh=xe/yd5hY9F/c7KpezlLnUK454tNnJ0eM9dMDV1J9e/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e93sx00jHOCFHGUIcDlVo9iUZMCFK5H8FXQmb0/+lL1A+D7UJEnq/dzIzFkJagBKJ
	 C43diqkd3ustih7jvEH6sqOh3/Zl2l42cFh7JPtWymhcww/2rq7ie2Pl4KMnqPcuLG
	 0rfOlwA9VUOOw7mftfD9NuQV5+X0pXqUb2MaJh0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 144/184] loop: Add sanity check for read/write_iter
Date: Mon, 12 May 2025 19:45:45 +0200
Message-ID: <20250512172047.669780379@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit f5c84eff634ba003326aa034c414e2a9dcb7c6a7 ]

Some file systems do not support read_iter/write_iter, such as selinuxfs
in this issue.
So before calling them, first confirm that the interface is supported and
then call it.

It is releavant in that vfs_iter_read/write have the check, and removal
of their used caused szybot to be able to hit this issue.

Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250428143626.3318717-1-lizhi.xu@windriver.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e083099a01e29..6bd44ec2c9b1a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -501,6 +501,17 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
 }
 
+static int loop_check_backing_file(struct file *file)
+{
+	if (!file->f_op->read_iter)
+		return -EINVAL;
+
+	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -521,6 +532,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		return -EBADF;
 
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
@@ -953,6 +968,14 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	if (!file)
 		return -EBADF;
+
+	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
-- 
2.39.5





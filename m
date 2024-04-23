Return-Path: <stable+bounces-40698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4A8AE79E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74161C23667
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC7135A72;
	Tue, 23 Apr 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJovO74d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD960130AF7
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877818; cv=none; b=NlPp1O8S1uCM8RQdx8rklYMefhrGP2wmgOs/uKk6kEW26rOeWvY0RDilIGp9kH1pa3cnNsSSflyAmMcppuhfyRHcqtI9Y17ELBVT4FAdrlkkVZPlDXhGIjLPz60/WhtemjjEcNcvLiekvqvkO4Ofird77ZG1a5aD33yQlAoFqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877818; c=relaxed/simple;
	bh=tRXJFrQO6qim44kWVeszsm0eFebqmBVVwCdSxhPmfAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LwP7wjWSaP3XZpr9AgJgpcxGz30FyVyv+UNVM+m0+x6yu6iHJ5Nsmipbd31bcHhW24MesnJMlfQawnyt7iBUn4qKPirL8GUH74QOCS6PNWIJ5rDWqyqZ5KSx2yvSZCLLlgqDXhRB5VxVzX7vsZ4vcEczpOh/+5M9N7M1VnV+4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJovO74d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C15C116B1;
	Tue, 23 Apr 2024 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877818;
	bh=tRXJFrQO6qim44kWVeszsm0eFebqmBVVwCdSxhPmfAc=;
	h=Subject:To:Cc:From:Date:From;
	b=BJovO74du6Au2zkAVe3w3nQf/WxmcDAyBleB5zw6cFYzmpc7A8kKBgKOKzdKU/twk
	 QFjH00m5HQgfHAL6MkdoY0VZJSp+7ju67uNrI3bpX4dVrJGCG8eRErEZJK0XYH+qbS
	 5Y9amCflA9JpB3Y4LIZHae8so2xucjmsbSZ93k1A=
Subject: FAILED: patch "[PATCH] Squashfs: check the inode number is not the invalid value of" failed to apply to 5.4-stable tree
To: phillip@squashfs.org.uk,akpm@linux-foundation.org,brauner@kernel.org,bugreport@ubisectech.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:10:08 -0700
Message-ID: <2024042308-reassign-skylight-6cfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9253c54e01b6505d348afbc02abaa4d9f8a01395
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042308-reassign-skylight-6cfd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

9253c54e01b6 ("Squashfs: check the inode number is not the invalid value of zero")
a1f13ed8c748 ("squashfs: convert to new timestamp accessors")
280345d0d03b ("squashfs: convert to ctime accessor functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9253c54e01b6505d348afbc02abaa4d9f8a01395 Mon Sep 17 00:00:00 2001
From: Phillip Lougher <phillip@squashfs.org.uk>
Date: Mon, 8 Apr 2024 23:02:06 +0100
Subject: [PATCH] Squashfs: check the inode number is not the invalid value of
 zero

Syskiller has produced an out of bounds access in fill_meta_index().

That out of bounds access is ultimately caused because the inode
has an inode number with the invalid value of zero, which was not checked.

The reason this causes the out of bounds access is due to following
sequence of events:

1. Fill_meta_index() is called to allocate (via empty_meta_index())
   and fill a metadata index.  It however suffers a data read error
   and aborts, invalidating the newly returned empty metadata index.
   It does this by setting the inode number of the index to zero,
   which means unused (zero is not a valid inode number).

2. When fill_meta_index() is subsequently called again on another
   read operation, locate_meta_index() returns the previous index
   because it matches the inode number of 0.  Because this index
   has been returned it is expected to have been filled, and because
   it hasn't been, an out of bounds access is performed.

This patch adds a sanity check which checks that the inode number
is not zero when the inode is created and returns -EINVAL if it is.

[phillip@squashfs.org.uk: whitespace fix]
  Link: https://lkml.kernel.org/r/20240409204723.446925-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20240408220206.435788-1-phillip@squashfs.org.uk
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Closes: https://lore.kernel.org/lkml/87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com/
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index aa3411354e66..16bd693d0b3a 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if (inode->i_ino == 0)
+		return -EINVAL;
+
 	err = squashfs_get_id(sb, le16_to_cpu(sqsh_ino->uid), &i_uid);
 	if (err)
 		return err;
@@ -58,7 +62,6 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
-	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode_set_mtime(inode, le32_to_cpu(sqsh_ino->mtime), 0);
 	inode_set_atime(inode, inode_get_mtime_sec(inode), 0);
 	inode_set_ctime(inode, inode_get_mtime_sec(inode), 0);



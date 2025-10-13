Return-Path: <stable+bounces-184132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823ABD1DEF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EBC189895A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22102EA496;
	Mon, 13 Oct 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khFeZWKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11B2EA480
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341762; cv=none; b=jsE+kyiv6H49M5/zCgFKYwWoVesR8QWtrDrokKVHCW4ZlY/3jA+/S7ytUZk3i1a024BW3aCLuJIKcsvm9vYYzqucOCXXxPUe+vBUCCGAUe+zYbA710Q5uasqrMUL8oWfjXQ8RJisDD3fJWROuCiqVtULo9iZS9JYt9YftOfDYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341762; c=relaxed/simple;
	bh=Xt7xAQ9ahcitULyGnGs6GmrChlnhvkyaqdhxWWiko14=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LUP0D/DRgMQj/YIUPFH9/audK6ywquxU72lgzmTRM15qfO27q9DBluiOID2acZFaC+7jnIDqb7tkNm9K/8g2mZTP+kou2KPzXdlP3ra/spOdO8irCIWnzu8QiOz/owxP9/kFMFiyeg3VL+ONJCrVi62CElQwkKzuYYyCh9ubIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khFeZWKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FCFC4CEE7;
	Mon, 13 Oct 2025 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760341762;
	bh=Xt7xAQ9ahcitULyGnGs6GmrChlnhvkyaqdhxWWiko14=;
	h=Subject:To:Cc:From:Date:From;
	b=khFeZWKB+CV7JxyP6A0K0mU2BUQPV/hDOWjo2FNp7hrvImzGLu/A+8OppnygME1yI
	 SU3j/SppG9PVwUMU7V4pQ22XFTpJPVl//oA5RY+pb7zu5YuHnOT670qUKFwUGBxSju
	 km6onqW34f3c5IHQB1q92VijYiuZTNVJU/Zg31cY=
Subject: FAILED: patch "[PATCH] Squashfs: reject negative file sizes in squashfs_read_inode()" failed to apply to 6.17-stable tree
To: phillip@squashfs.org.uk,akpm@linux-foundation.org,amir73il@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 09:49:19 +0200
Message-ID: <2025101319-anything-blob-1499@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101319-anything-blob-1499@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b Mon Sep 17 00:00:00 2001
From: Phillip Lougher <phillip@squashfs.org.uk>
Date: Fri, 26 Sep 2025 22:59:35 +0100
Subject: [PATCH] Squashfs: reject negative file sizes in squashfs_read_inode()

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying Squashfs file
system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

[phillip@squashfs.org.uk: only need to check 64 bit quantity]
  Link: https://lkml.kernel.org/r/20250926222305.110103-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250926215935.107233-1-phillip@squashfs.org.uk
Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index ddc65d006063..cceae3b78698 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -197,6 +197,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*



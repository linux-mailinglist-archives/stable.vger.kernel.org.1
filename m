Return-Path: <stable+bounces-3734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF28023DA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5711E1F2102E
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B2E54D;
	Sun,  3 Dec 2023 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kiKXJeCi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199733D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26956C433C8;
	Sun,  3 Dec 2023 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701607857;
	bh=FIKKSGKySrrL/F1uRdI+9hMVrVVGcdX2UeBJNe0RwTo=;
	h=Subject:To:Cc:From:Date:From;
	b=kiKXJeCiQDm81duZvpO52nBK//Ctjwle4gMZsdMvnK+8TOiKvv2lfeyT/Cp1UGMhj
	 fdxPyAxD/j+MZ2Ms9pimrxWl5B/gWA4kz/apSjwDFfwX7wHY1RNPE41fd2uhszkWm2
	 SXtL1Yptgxixq6Pk1pFRfRdRyhUTiFqIS2sxkvc0=
Subject: FAILED: patch "[PATCH] cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved" failed to apply to 5.4-stable tree
To: dhowells@redhat.com,jlayton@kernel.org,nspmangalore@gmail.com,pc@manguebit.com,rohiths.msft@gmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:50:43 +0100
Message-ID: <2023120343-catcher-slush-36ba@gregkh>
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
git cherry-pick -x 83d5518b124dfd605f10a68128482c839a239f9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120343-catcher-slush-36ba@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

83d5518b124d ("cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
c919c164fc87 ("smb3: missing inode locks in zero range")
400d0ad63b19 ("cifs: remove useless parameter 'is_fsctl' from SMB2_ioctl()")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83d5518b124dfd605f10a68128482c839a239f9d Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 29 Nov 2023 16:56:17 +0000
Subject: [PATCH] cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved

Fix the cifs filesystem implementations of FALLOC_FL_ZERO_RANGE, in
smb3_zero_range(), to set i_size after extending the file on the server.

Fixes: 72c419d9b073 ("cifs: fix smb3_zero_range so it can expand the file-size when required")
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 82ab62fd0040..f1b0b2b11ab2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3311,6 +3311,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
+	unsigned long long new_size;
 	long rc;
 	unsigned int xid;
 	__le64 eof;
@@ -3341,10 +3342,15 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * do we also need to change the size of the file?
 	 */
-	if (keep_size == false && i_size_read(inode) < offset + len) {
-		eof = cpu_to_le64(offset + len);
+	new_size = offset + len;
+	if (keep_size == false && (unsigned long long)i_size_read(inode) < new_size) {
+		eof = cpu_to_le64(new_size);
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
+		if (rc >= 0) {
+			truncate_setsize(inode, new_size);
+			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
+		}
 	}
 
  zero_range_exit:



Return-Path: <stable+bounces-78397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2098B924
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C5E1C21E1F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E919C561;
	Tue,  1 Oct 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qEQQ0v3t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D303209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777870; cv=none; b=KhD8GBq+rYaTMGurmqrnFUnzD+twkyIJ0QKUzQBS87yaUPrViD1Zv7+dLQamCQGN3sJvI0c08Tq77hB7wm2rCv5c4JUosSbyZ0rRXmEMRgl8XPlEadqIY5HtdX4MsKeAuERPqGtn3MhJvu6zSkOIU7GULFNneunVd7apZykKIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777870; c=relaxed/simple;
	bh=qfd9HuoT0aEhS6JIHxqrh+DHi1RmF39ZCNbujIVlk/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kt7w/EGzm1no5lRempgXfhuYJcmSgvNbOazT/3z5Ch+Z7RZeYNF+PIAaIS955FfMbjwSV42NrjGNtwZW3fr+CRS6HfSz7sK1QWTl8zVOuE3KuFwWuabPA+CiKq051TL7oxM1KHKXSXT53AqA5hIvjn3WYDpCkFBIxGE46NHtHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qEQQ0v3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE4C4CEC6;
	Tue,  1 Oct 2024 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777870;
	bh=qfd9HuoT0aEhS6JIHxqrh+DHi1RmF39ZCNbujIVlk/k=;
	h=Subject:To:Cc:From:Date:From;
	b=qEQQ0v3tiQNmOoCkL4b0XJnM5Tdx/zUCwlCuvjEn1GTxfQuMb5XDAHP44Fa8Yny7P
	 jnA6kHW1ZxguTy8y9aFJw27JF4K1jhn6hrtBZ77a94noG2eQOD8Zw5loyADET9EoFW
	 gJwaiJMZ+KSBArpkHdkbjQiSidgb1685+mZVe1Sc=
Subject: FAILED: patch "[PATCH] ksmbd: handle caseless file creation" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com,zhanglei002@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:17:47 +0200
Message-ID: <2024100147-stipend-vitality-f6cb@gregkh>
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
git cherry-pick -x c5a709f08d40b1a082e44ffcde1aea4d2822ddd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100147-stipend-vitality-f6cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c5a709f08d40 ("ksmbd: handle caseless file creation")
2b57a4322b1b ("ksmbd: check if a mount point is crossed during path lookup")
6fe55c2799bc ("ksmbd: call putname after using the last component")
df14afeed2e6 ("ksmbd: fix uninitialized pointer read in smb2_create_link()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
211db0ac9e3d ("ksmbd: remove internal.h include")
4d7ca4090184 ("fs: port vfs{g,u}id helpers to mnt_idmap")
c14329d39f2d ("fs: port fs{g,u}id helpers to mnt_idmap")
e67fe63341b8 ("fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap")
0dbe12f2e49c ("fs: port i_{g,u}id_{needs_}update() to mnt_idmap")
9452e93e6dae ("fs: port privilege checking helpers to mnt_idmap")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")
c54bd91e9eab ("fs: port ->mkdir() to pass mnt_idmap")
7a77db95511c ("fs: port ->symlink() to pass mnt_idmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5a709f08d40b1a082e44ffcde1aea4d2822ddd5 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 8 Sep 2024 15:23:48 +0900
Subject: [PATCH] ksmbd: handle caseless file creation

Ray Zhang reported ksmbd can not create file if parent filename is
caseless.

Y:\>mkdir A
Y:\>echo 123 >a\b.txt
The system cannot find the path specified.
Y:\>echo 123 >A\b.txt

This patch convert name obtained by caseless lookup to parent name.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Ray Zhang <zhanglei002@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 13dad48d950c..7cbd580120d1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1167,7 +1167,7 @@ static bool __caseless_lookup(struct dir_context *ctx, const char *name,
 	if (cmp < 0)
 		cmp = strncasecmp((char *)buf->private, name, namlen);
 	if (!cmp) {
-		memcpy((char *)buf->private, name, namlen);
+		memcpy((char *)buf->private, name, buf->used);
 		buf->dirent_count = 1;
 		return false;
 	}
@@ -1235,10 +1235,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		char *filepath;
 		size_t path_len, remain_len;
 
-		filepath = kstrdup(name, GFP_KERNEL);
-		if (!filepath)
-			return -ENOMEM;
-
+		filepath = name;
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
@@ -1281,10 +1278,9 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		err = -EINVAL;
 out2:
 		path_put(parent_path);
-out1:
-		kfree(filepath);
 	}
 
+out1:
 	if (!err) {
 		err = mnt_want_write(parent_path->mnt);
 		if (err) {



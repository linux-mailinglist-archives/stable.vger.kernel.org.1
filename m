Return-Path: <stable+bounces-20691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77C85AB49
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B375CB237DE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E24F1F3;
	Mon, 19 Feb 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pQv/OzZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32754F1EA
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368160; cv=none; b=g9hEGP/yRoqm6JOtq2yAiGCNflpRQB4f8OPT7KdsZVIkm1obvEgZNQsGJ1fO5J+v0hmfg62o48l4OLOrQ/BnWStsJwJu2gWPmHv6KWCyuBlSNWe0d5moDmZ224YIPPVrpDKWgo5SwJ5E+sZG1NFEuKxKHOf8qby1QJ5AtrV9owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368160; c=relaxed/simple;
	bh=ujOtIYiZVf7qyw0FSFUmW8vc5I+OZiMhOlshviOJSKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D+eTt9P1fK2aKxXAqH4MbEviZBX6LZ/4fGBkyn4UNRUFjA+GzmJPijaeEjNHG+kb1RFCxXrKtzRn3ezJ3BTkhoGhW9MojC7mDdn85GQtWQANDVcF8QSdAx1E+hOaMhEgDEKPhUUXeUTKcP/Qvm2GXBGXu+J3XTVOM3fSyygcaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pQv/OzZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5335CC433C7;
	Mon, 19 Feb 2024 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368159;
	bh=ujOtIYiZVf7qyw0FSFUmW8vc5I+OZiMhOlshviOJSKU=;
	h=Subject:To:Cc:From:Date:From;
	b=pQv/OzZaILMX/h659fJ+oJJG/mzI2UNco8hOg9F/7rKAH0rkVnel9TsuPXX612eAC
	 857alBlnP5MKPBSs13J5Jblia5pG5ZqMlpBH93tMd3vG3xbtwS/xFmyr60GkGhs631
	 RBXzMU2x4/xLZablJEQ5rlIgvIetPd7cJ5I1j6cw=
Subject: FAILED: patch "[PATCH] smb: client: set correct id, uid and cruid for multiuser" failed to apply to 5.15-stable tree
To: pc@manguebit.com,snehring@iastate.edu,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:42:29 +0100
Message-ID: <2024021928-granite-partake-3387@gregkh>
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
git cherry-pick -x 4508ec17357094e2075f334948393ddedbb75157
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021928-granite-partake-3387@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4508ec173570 ("smb: client: set correct id, uid and cruid for multiuser automounts")
561f82a3a24c ("smb: client: rename cifs_dfs_ref.c to namespace.c")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
b56bce502f55 ("cifs: set DFS root session in cifs_get_smb_ses()")
7ad54b98fc1f ("cifs: use origin fullpath for automounts")
a1c0d00572fc ("cifs: share dfs connections and supers")
a73a26d97eca ("cifs: split out ses and tcon retrieval from mount_get_conns()")
2301bc103ac4 ("cifs: remove unused smb3_fs_context::mount_options")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
68e14569d7e5 ("smb3: add dynamic trace points for tree disconnect")
13609a8b3ac6 ("cifs: move from strlcpy with unused retval to strscpy")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4508ec17357094e2075f334948393ddedbb75157 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Sun, 11 Feb 2024 20:19:30 -0300
Subject: [PATCH] smb: client: set correct id, uid and cruid for multiuser
 automounts

When uid, gid and cruid are not specified, we need to dynamically
set them into the filesystem context used for automounting otherwise
they'll end up reusing the values from the parent mount.

Fixes: 9fd29a5bae6e ("cifs: use fs_context for automounts")
Reported-by: Shane Nehring <snehring@iastate.edu>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2259257
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index a6968573b775..4a517b280f2b 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -168,6 +168,21 @@ static char *automount_fullpath(struct dentry *dentry, void *page)
 	return s;
 }
 
+static void fs_context_set_ids(struct smb3_fs_context *ctx)
+{
+	kuid_t uid = current_fsuid();
+	kgid_t gid = current_fsgid();
+
+	if (ctx->multiuser) {
+		if (!ctx->uid_specified)
+			ctx->linux_uid = uid;
+		if (!ctx->gid_specified)
+			ctx->linux_gid = gid;
+	}
+	if (!ctx->cruid_specified)
+		ctx->cred_uid = uid;
+}
+
 /*
  * Create a vfsmount that we can automount
  */
@@ -205,6 +220,7 @@ static struct vfsmount *cifs_do_automount(struct path *path)
 	tmp.leaf_fullpath = NULL;
 	tmp.UNC = tmp.prepath = NULL;
 	tmp.dfs_root_ses = NULL;
+	fs_context_set_ids(&tmp);
 
 	rc = smb3_fs_context_dup(ctx, &tmp);
 	if (rc) {



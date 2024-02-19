Return-Path: <stable+bounces-20690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1585AB47
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC6BB23656
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D924D58C;
	Mon, 19 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5caCtPB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5F482F6
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368151; cv=none; b=qxzDM6yBat+JTBO0ie2lWl05mJNIDqiC8wanmDELLGuJKCNwTBhaIr8jMaPrMBB/7hwZsjxa11Mg2gRy1y0zY1aMR65R9+kpRGoqOc3CQbDyg6dvnqDSykH0rLtf7tQJtiYPtMU36cBK+/p4Wlr7342hyh6Y0usA9UOyUAKXNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368151; c=relaxed/simple;
	bh=TMzGgDqWaULr/Hw7kRsZ7l4fSBGhS64VxkiOVRRtmFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J9NIhkA4uTDaBN8xPh1MS4qLBvgglNNoKs1Uq1HGpNb5n2iQfsQYTcNixb3JTiqqSEHEvkzxxMDXoySb7nO5XYv3hWt+gWTWlWwtSvaGDEptr0/T6VRHrL5wxwsWW67dU2WyomTsKqcmN2ge2o8F7Rq2izwx0lo2KAKN6kiCrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5caCtPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F4C433C7;
	Mon, 19 Feb 2024 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368151;
	bh=TMzGgDqWaULr/Hw7kRsZ7l4fSBGhS64VxkiOVRRtmFQ=;
	h=Subject:To:Cc:From:Date:From;
	b=w5caCtPBA8TIjq8y/G4EQUVdVWdPfYlxItB1ru3iSSF11yrGtPVWpli3osz7i3Mp+
	 1GEOQPh7qSdF2/JYd7/sQR8Q95+jCksKeiU3/Y2vP7qiDB3nnvJ02ZChLDdfaoUAXf
	 /eVZAZaX+1/AMHzSU+058DusPidxCfFprCdrD4cs=
Subject: FAILED: patch "[PATCH] smb: client: set correct id, uid and cruid for multiuser" failed to apply to 6.1-stable tree
To: pc@manguebit.com,snehring@iastate.edu,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:42:28 +0100
Message-ID: <2024021928-dragster-release-24a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4508ec17357094e2075f334948393ddedbb75157
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021928-dragster-release-24a1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



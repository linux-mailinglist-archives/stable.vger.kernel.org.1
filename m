Return-Path: <stable+bounces-178560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6CB47F29
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879817F6A8
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39750212B3D;
	Sun,  7 Sep 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LdritSk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA11A0BFD;
	Sun,  7 Sep 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277227; cv=none; b=Lba0WIwhbaJdZzGlfmoawUict0o4Xcfsi1nDGSEMndYlyp6fGB7ho8ODV9cmvIidp8rYyHSVNkumhL4f+o3RtzUJZNeiRralN2B7XXezo5xXkFidoyEC2pnSZKlIHSkDr4gQR8hM8HRGfsPHt4iDhD10PSQMQeP9+1CK9CLCkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277227; c=relaxed/simple;
	bh=HiRbnMMMq8EUnjpQrx1DVasTvF7kn3ynCL1xkL9IBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeHUNLjeDMFSULQ7xDmA0CgIzJwcaw1klxKZjUTm0BwF2P++j5JT1GwnXrnY677sVn4M7ym1cLbCNRtHZqyo6WImM0z0Ucpfb1QJO6lfSkfqp38avnKpM6+wl3Ko21r1unAS/jEguRjIg6+4xSUBF7zZkR3tQof4cumIPDd9V3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LdritSk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F39BC4CEF0;
	Sun,  7 Sep 2025 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277226;
	bh=HiRbnMMMq8EUnjpQrx1DVasTvF7kn3ynCL1xkL9IBLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdritSk+FZ2xMKPki8UaDq3aJaJ4qoTDZ7HFRYAyfqNJfKkBFmq/e3fPRnoKn7EwL
	 Fk5LKMP44jsu8l4tg6sdh+sbu33fXH9w3HM1B6DpYjfg/RmpAN97s8Xos2Q/pagjdF
	 QoGqjB2SR+Un7cGxqlTXrhyEty7m73aajHnnnUe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12 123/175] fs/fhandle.c: fix a race in call of has_locked_children()
Date: Sun,  7 Sep 2025 21:58:38 +0200
Message-ID: <20250907195617.767460359@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 1f282cdc1d219c4a557f7009e81bc792820d9d9a upstream.

may_decode_fh() is calling has_locked_children() while holding no locks.
That's an oopsable race...

The rest of the callers are safe since they are holding namespace_sem and
are guaranteed a positive refcount on the mount in question.

Rename the current has_locked_children() to __has_locked_children(), make
it static and switch the fs/namespace.c users to it.

Make has_locked_children() a wrapper for __has_locked_children(), calling
the latter under read_seqlock_excl(&mount_lock).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[ Harshit: Resolved conflicts due to missing commit:
  db04662e2f4f ("fs: allow detached mounts in clone_private_mount()") in
  linux-6.12.y ]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2227,7 +2227,7 @@ void drop_collected_mounts(struct vfsmou
 	namespace_unlock();
 }
 
-bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
@@ -2241,6 +2241,16 @@ bool has_locked_children(struct mount *m
 	return false;
 }
 
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+{
+	bool res;
+
+	read_seqlock_excl(&mount_lock);
+	res = __has_locked_children(mnt, dentry);
+	read_sequnlock_excl(&mount_lock);
+	return res;
+}
+
 /**
  * clone_private_mount - create a private clone of a path
  * @path: path to clone
@@ -2268,7 +2278,7 @@ struct vfsmount *clone_private_mount(con
 		return ERR_PTR(-EPERM);
 	}
 
-	if (has_locked_children(old_mnt, path->dentry))
+	if (__has_locked_children(old_mnt, path->dentry))
 		goto invalid;
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
@@ -2762,7 +2772,7 @@ static struct mount *__do_loopback(struc
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
-	if (!recurse && has_locked_children(old, old_path->dentry))
+	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return mnt;
 
 	if (recurse)
@@ -3152,7 +3162,7 @@ static int do_set_group(struct path *fro
 		goto out;
 
 	/* From mount should not have locked children in place of To's root */
-	if (has_locked_children(from, to->mnt.mnt_root))
+	if (__has_locked_children(from, to->mnt.mnt_root))
 		goto out;
 
 	/* Setting sharing groups is only allowed on private mounts */




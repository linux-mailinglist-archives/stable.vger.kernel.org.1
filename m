Return-Path: <stable+bounces-71971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D852396789F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1503D1C20A58
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B991183CAA;
	Sun,  1 Sep 2024 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMlMXtkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA55381A;
	Sun,  1 Sep 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208418; cv=none; b=uEWo9J6McTaJGazYc/PyM+yArPqenk8Pi3V8sh11oMs7VUTX7KSl437Lw1a3adH7ZRdEmUcmJ8C3AjnnNBJyTW4MQsgDRkeck72CQAoClIXvWjuxl1oL/zBaW81RJsbRpOc8D1oLpAPPG7ztYaqpwqbMReeE8m+a6hFlc8h+Fh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208418; c=relaxed/simple;
	bh=rIOmxPLFj9UCHT2aNovsEgaJy7WmwEJP2hugYtEo7L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Miy3UtPTgeDcrup9ZDSiCjUuzzcbyeWqhLgf/ZS5PGhHQzeqfIS08kJ3SmU+MzzzoKif5lXnyAOnWUTur5xZgHvF1QwtUWo3XD7OaqImVvhmce+Pit+L3zIJJk4pQUYZjK3M2ufnGnFiqgFUsGUNzjq3EvmA+5Y/HeaLoY72nyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMlMXtkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC5C4CEC3;
	Sun,  1 Sep 2024 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208418;
	bh=rIOmxPLFj9UCHT2aNovsEgaJy7WmwEJP2hugYtEo7L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMlMXtkVWgP9ctu+mW/YCBCdxawC7lLzw5AbSX7pXgd2oG40IdyXNSTABISVzN3OK
	 YfWCDxjcKGYlecF1LcFoVr7fTDIq7XdUnqPSF2AOEVuIplTSVtPbEpswsoYzSCzCxg
	 AZ8U4PjkkPsJID7vvzwg+FkPRmZy3OEvq88JGcMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Marek Gresko <marek.gresko@protonmail.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.10 076/149] selinux,smack: dont bypass permissions check in inode_setsecctx hook
Date: Sun,  1 Sep 2024 18:16:27 +0200
Message-ID: <20240901160820.324127490@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit 76a0e79bc84f466999fa501fce5bf7a07641b8a7 upstream.

Marek Gresko reports that the root user on an NFS client is able to
change the security labels on files on an NFS filesystem that is
exported with root squashing enabled.

The end of the kerneldoc comment for __vfs_setxattr_noperm() states:

 *  This function requires the caller to lock the inode's i_mutex before it
 *  is executed. It also assumes that the caller will make the appropriate
 *  permission checks.

nfsd_setattr() does do permissions checking via fh_verify() and
nfsd_permission(), but those don't do all the same permissions checks
that are done by security_inode_setxattr() and its related LSM hooks do.

Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
simplest solution appears to be to replace the call to
__vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
fixes the above issue and has the added benefit of causing nfsd to
recall conflicting delegations on a file when a client tries to change
its security label.

Cc: stable@kernel.org
Reported-by: Marek Gresko <marek.gresko@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c   |    4 ++--
 security/smack/smack_lsm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6660,8 +6660,8 @@ static int selinux_inode_notifysecctx(st
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
+				     ctx, ctxlen, 0, NULL);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4874,8 +4874,8 @@ static int smack_inode_notifysecctx(stru
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
+				     ctx, ctxlen, 0, NULL);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)




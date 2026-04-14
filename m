Return-Path: <stable+bounces-237888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BweOvpI3mkzqAkAu9opvQ
	(envelope-from <stable+bounces-237888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:02:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 779243FAD62
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C2F303FF2B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD53E5EF8;
	Tue, 14 Apr 2026 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgc0cPgm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4D3E63AE
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175173; cv=none; b=EfBP5vJBEZbmUz9/yL/oTu32QF6MfRKxW9RZEgyFzD7IvkJO9mCOJVz6xcIHvEx8rxDWnqmfntVRuBGYP3ArD/rjawaXJGynLEWPBXwi8CCZM6jLngrZ//4SBjr/HAQjR7J9th0dnv9Xcbyr5KmZ/X3OR//88bA47mjTo6lqMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175173; c=relaxed/simple;
	bh=wQe+RhB85yi02jo020KLvcVHTJCqLGplUXNCsaMyMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfv6iOnHUMghL+SMG+MbMlLkjuNRMOZBFbVd97pRb+yxZTcbZ32LpBRWy/IZYSqkReTXB2OGlyBxpogx4zBcgbRQST4L3RpwK6tcwCLWLTQs/3cczR0wful+6HRknr3GLJPF3HfqJlXjjWpBB6BUdKl7A+KMztVQ2xdAqIxmkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pgc0cPgm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so2087639a12.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175172; x=1776779972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ/ecoS+iyPaqh9vg50r98KJRrVZjWdsD/kOJ7GPw5M=;
        b=Pgc0cPgmkuu2ENf8dxRlkRrmgXNei4Gq6m55Kc/fYkyUHWezHfQNblbOHwmxEl20w7
         VpZFhIdnlEtRyNy2pUyGTiBFk7oFp3WKv4Jkm7V4oLY2OfGMcDLb2kzRJZXOEtvIqOl5
         f5qE3PNZncXSewspbCGqqtJWIVCW77nVGivnnqJKUQssCXpzkMCgGy0tr8/5twZNu46E
         +lTrZOzTSjXXQekUL9VdIY/kRo2aXHAT/uhii8UHr4sx/nbLDoOHVC3V3fOglRN7C9fS
         wR6teb259lnujgRIFlDU5yYr48KcoB9UD0CuCVytySIa1SSoEQL4PiRZPyhvF2zjBzkp
         puQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175172; x=1776779972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJ/ecoS+iyPaqh9vg50r98KJRrVZjWdsD/kOJ7GPw5M=;
        b=mJoCjl6Ms55dwf6mQifRy4+2LGC+vQWLc+3u7vu0g9IVI1CR5Z+iduOey1rkXSs+sJ
         nbQpO3BMVH6kUNlGf2+5cZqZ3/MwJPpZvEk3odXotnith2MEmDIYl2m/Pc0hb68tjvU0
         Ex3+/zDJ06IkjpueaxWMkJw1jMrWpDMoNEdI9ra846DGE2F6I5LmkAAqXzfHmRbrAt5B
         7p4zGh3TgHNNyKpVfB0uICGEcXu5EGHvN6YnHirLZeuyUV6lUY1db70YzYHB0LoESn5x
         YTxLnaZ53Ag/E1PhJep0d/X0e1uYTyQAnXF8Ff8sPf6z8T/d9O/DZYwcUD87QxBvpoZD
         6dAg==
X-Forwarded-Encrypted: i=1; AFNElJ8dxNMimjDi/lFG5nUypYVI9GUIPjnjY2tcVWAk6SbERCspI8/NPSZD53lMW1UYM5R9SnbseXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWVpTwdPj3H6IRUPMFZyWPyFD4PGg1aOoGBmgyTolvgBokFuA
	3x2zLdMA9+m3E4EERK7pnEuGq/o+v/bcNx4L71sK1vM9hIwwwOwNDGY4
X-Gm-Gg: AeBDievAk39rFBz9hcglmOnd5wPPdIfRkhEljbYw9i3QhZevL6enwKGnsm18NTd+D/n
	XBG1D3P0TKGBe74dx6F3BtXFgTbUyUZPvaR2CWPktyOckOxLSxjWNZz5MIp9XKxhAFlwOaYxbEt
	WBGhR58/dv0LjmsJsUMw4zWjF5zJ7DT50NgZKFu0HpmF+MQns+vcWdew/sw/z3HC5wgVGvnWkIS
	swhC+tbO4PvhKFtuf2ulJwTcYNmUnz+T2w7GuLW5FljpI2gjfOy3TbsJxNXeosYn/4WU/1+I4Qy
	vZG6P4717jD+xLcUnIk1wJ16KKx7P0iTVCl4/BgSBP7RAnJGoHVVhcOdZ5CPs8my8A5SLdocz+y
	y10xmuGjqDX6xdL/+mwnZUM9s9Rg3eWi2a9V5D62OiTTTnz1M/Tpq2N05JoS0h0esaEOsrEr0DZ
	pCgUqsJa+Bey2K40LJtzRnwAYJnxqIJxk1pB0Q/N5PixnsF203/Xwh
X-Received: by 2002:a05:6a21:3296:b0:39c:4af6:4309 with SMTP id adf61e73a8af0-39fe3c01179mr19500517637.12.1776175171649;
        Tue, 14 Apr 2026 06:59:31 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4612e60dasm59779895ad.38.2026.04.14.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:59:30 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/7] cifs: invalidate cfid on unlink/rename/rmdir
Date: Tue, 14 Apr 2026 19:29:14 +0530
Message-ID: <20260414135918.279802-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414135918.279802-1-sprasad@microsoft.com>
References: <20260414135918.279802-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237888-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 779243FAD62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

Today we do not invalidate the cached_dirent or the entire
parent cfid when a dentry in a dir has been removed/moved.

This change invalidates the parent cfid so that we don't serve
directory contents from the cache.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/inode.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 888f9e35f14b8..e077df844c819 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -28,6 +28,23 @@
 #include "cached_dir.h"
 #include "reparse.h"
 
+static void cifs_invalidate_cached_dir(struct cifs_tcon *tcon,
+				       struct dentry *parent)
+{
+	struct cached_fid *parent_cfid = NULL;
+
+	if (!tcon || !parent)
+		return;
+
+	if (!open_cached_dir_by_dentry(tcon, parent, &parent_cfid)) {
+		mutex_lock(&parent_cfid->dirents.de_mutex);
+		parent_cfid->dirents.is_valid = false;
+		parent_cfid->dirents.is_failed = true;
+		mutex_unlock(&parent_cfid->dirents.de_mutex);
+		close_cached_dir(parent_cfid);
+	}
+}
+
 /*
  * Set parameters for the netfs library
  */
@@ -322,7 +339,7 @@ cifs_unix_basic_to_fattr(struct cifs_fattr *fattr, FILE_UNIX_BASIC_INFO *info,
 				fattr->cf_uid = uid;
 		}
 	}
-	
+
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 	if (!(sbflags & CIFS_MOUNT_OVERR_GID)) {
 		u64 id = le64_to_cpu(info->Gid);
@@ -2067,6 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 		cifs_set_file_info(inode, attrs, xid, full_path, origattr);
 
 out_reval:
+	if (!rc && dentry->d_parent)
+		cifs_invalidate_cached_dir(tcon, dentry->d_parent);
+
 	if (inode) {
 		cifs_inode = CIFS_I(inode);
 		cifs_inode->time = 0;	/* will force revalidate to get info
@@ -2378,7 +2398,6 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	}
 
 	rc = server->ops->rmdir(xid, tcon, full_path, cifs_sb);
-	cifs_put_tlink(tlink);
 
 	cifsInode = CIFS_I(d_inode(direntry));
 
@@ -2388,6 +2407,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		i_size_write(d_inode(direntry), 0);
 		clear_nlink(d_inode(direntry));
 		spin_unlock(&d_inode(direntry)->i_lock);
+		if (direntry->d_parent)
+			cifs_invalidate_cached_dir(tcon, direntry->d_parent);
 	}
 
 	/* force revalidate to go get info when needed */
@@ -2402,6 +2423,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 
 	inode_set_ctime_current(d_inode(direntry));
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	cifs_put_tlink(tlink);
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2501,6 +2523,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
+	struct dentry *source_parent;
+	struct dentry *target_parent;
 	bool rehash = false;
 	unsigned int xid;
 	int rc, tmprc;
@@ -2532,6 +2556,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
+	source_parent = source_dentry->d_parent ? dget(source_dentry->d_parent) : NULL;
+	target_parent = target_dentry->d_parent ? dget(target_dentry->d_parent) : NULL;
 	server = tcon->ses->server;
 
 	page1 = alloc_dentry_path();
@@ -2668,11 +2694,21 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	}
 
 	/* force revalidate to go get info when needed */
+	if (!rc) {
+		cifs_invalidate_cached_dir(tcon, source_parent);
+		if (target_parent != source_parent)
+			cifs_invalidate_cached_dir(tcon, target_parent);
+	}
+
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
 	if (rehash)
 		d_rehash(target_dentry);
+	if (target_parent)
+		dput(target_parent);
+	if (source_parent)
+		dput(source_parent);
 	kfree(info_buf_source);
 	free_dentry_path(page2);
 	free_dentry_path(page1);
-- 
2.43.0



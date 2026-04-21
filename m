Return-Path: <stable+bounces-240046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IySNuAb52k14AEAu9opvQ
	(envelope-from <stable+bounces-240046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F54370B7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09F5B3008D31
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536AE386C3C;
	Tue, 21 Apr 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3tNBUjv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371F35F61A
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753616; cv=none; b=ZGh0b4zh+fPgDLVQFwLDXpQH/eaG9fRtm4HaSL2/XVjEWGXsnKlCSuIlAAlz4oZ5q8hlrErvzPI+ZDjnf5yeC76uLyQ9cMIi6+eYXgYtYdFpSPlpGcZsGDDQ8rxkFt70RSToAzZUrU3qcF/0Kq/+Kjzgy+2n9EYyJPOLMX1Rj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753616; c=relaxed/simple;
	bh=wQe+RhB85yi02jo020KLvcVHTJCqLGplUXNCsaMyMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRt28nlH27X8zQ05czUR8SLgqZRVSW1VjaJRoXVZyK2eEiYojAVhiIZ261056Xb/9HhBjY09GCtTm7g0aobVmy+mTj+0gyiXTqVU9Z7gZ0yJsk8PLM2Ig4/5ex/KOXThfDSR0BRC9MRKroBR4tXG/UmGvefl5WNUlNa0ZXhxTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3tNBUjv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2588491a12.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776753614; x=1777358414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ/ecoS+iyPaqh9vg50r98KJRrVZjWdsD/kOJ7GPw5M=;
        b=P3tNBUjvHk7/yyiD6NN4wksXextE7m1w5/1e4LRaS+DxsbcB0/IOyJIown9dIUrGXg
         KUnGkX+OWg71JBivNPefsDqM2kwsO/t2qr3ke5ql1HltxWXKqXv6auOtL8BXb/MFyTWo
         EXcaVCJQ93u6QXjCgclmrDMyY2O3iignPMzjaZhslz+FWa/e8tKMqa8yLJOF3Su2bF94
         rkNfQlgGrH84ctGEKaSpVmevdoBYtN6fmbDT1nrVt+24j3LtgE7W62VKyzC6MkML8pGA
         PVcIcZvjUriElTeIK75Q3JH+EnO+mEhZ4qCvShy1iEuqAX1XgY23JOg55pQN77XLbnls
         N5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776753614; x=1777358414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJ/ecoS+iyPaqh9vg50r98KJRrVZjWdsD/kOJ7GPw5M=;
        b=dcCf7KGjO1Gjp1/uF8wPrt+lHBwOM9EnZ6CadU7jxvZOXrOZUoJaI0DVqOktENE5Kc
         EXKyUXgajjX9M2GZTjWK7Va/oN01JHyDJ7ALd0OM98Pmtm0tLlp/2tA4b414fzawT3to
         iyOaCH+tMBOjrTnrlwUiyrus+aUIOCWzrQIFk5mn656aOpcBlsjCNywW0rwcrBS0M5FC
         EeVTeQI73j4vDJ950iLoZQZT+lI9JKNOOFiqDfX1Q+dmpnJD8fcEv8dmzlXSQBPcB7KC
         5ID5hlxTE3EFM/fh6yiXCNPCE4tZtG9VhPW/G1j92oqetOhd5aKZKxuPpDEVvnESPtbf
         89Yg==
X-Forwarded-Encrypted: i=1; AFNElJ9tB/2O6s+/Qiq6DinqZhpOosCXjhhANFVi6/rXxoXnIrSq8EqotMG8wMZaZgIr9CQ08BaQgNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/y2Zh7CVcnogEGv7F/QG5awtX5t8lwHFGtAULiR/j6jVma9qE
	4P9N2Ev5tbA/VgQIISV1SxHckj0NuUCIJhytzL+d9j6Un8AnH/N3eyqs
X-Gm-Gg: AeBDieve9jjcvrSS3O9pUyX7OkGNRXCzOSJJEya3j08GQdPkvdeC0RkSrtI8OL53DEv
	crg7UHG+7xUof0LpTVKPIe/xb6nTfgRjHoc+cXXjYAGNtRDzmPHQ4Sj5wSSKHpMhE71cIGYH4yZ
	zHzbHxBf2zkVZ2dgmAwmC7I8bT7xbpMaDUkF9Chq4r5DOSsXE6elRqdk527cE+VRsLWTdhGMwLg
	rxnrivGML/C0hhFIr4oMlYWl51tp2LMQPf0YUqCROL0huPM9cpiKaEzDxCFXmgPhjjEGvrCPvhw
	1c2lu2PHWPRuft/tDMus3gipS8wGQGaglKZVrCg/CDXfe9hw2UEX8atxOuE6P2WgWVuN04rVg7O
	fAa8f/mLSU04tT1mPlE66/zTqSrJr5u7vpcV6BTjFvc1DxhGeKL0AD5NUT2Khj4Yl/aAiGRhmYa
	TLwfxip1zftlvH8Va7iiEpaBSWpmJVcoXVipbkKGwJmf4z+LqYwoaK4TNtVTIPAYp1
X-Received: by 2002:a05:6a20:12c7:b0:3a1:1120:7971 with SMTP id adf61e73a8af0-3a11120834amr9191071637.18.1776753613406;
        Mon, 20 Apr 2026 23:40:13 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm10032811a12.25.2026.04.20.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:40:12 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/7] cifs: invalidate cfid on unlink/rename/rmdir
Date: Tue, 21 Apr 2026 12:09:51 +0530
Message-ID: <20260421063955.99164-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421063955.99164-1-sprasad@microsoft.com>
References: <20260421063955.99164-1-sprasad@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240046-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F01F54370B7
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



Return-Path: <stable+bounces-263899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+nVImJpMWrXigUAu9opvQ
	(envelope-from <stable+bounces-263899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED1690E77
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vJEaoX6n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263899-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263899-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13939302C811
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3D43E490;
	Tue, 16 Jun 2026 15:17:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736A35201E;
	Tue, 16 Jun 2026 15:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623061; cv=none; b=rh6g03nuRcOAfjT+1k/sykO07JLMTu0n4qgcLuQqPr99Jzv6NXqBzTuayU94isO44TJ2zIDuqK37anJ53VGtCbYtZk6Khi+KPhPaplMzEPph2mmuQxPCFEwxaV/DhVKTfS1NFajM463bn6UsidyWJH2dlmSEQzwTFukpuT0g/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623061; c=relaxed/simple;
	bh=BgG1REilJP2lL+/41Rokd777JubccItw4yr4irKsWkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVhh7Acygjgloj74eO0BdNe73XF3+vpwwygfrg0lXCj1Tnm1w/nqf1/Sqt0Qf+xDDSRG87Eb7yd9rX9WFXooG3zXf+rkBjesbcZR1J8L8uNkIQmxupViWRzOHmlnauO9EXGp2yqWZtOb8EPoR83cGnoXY6J0ZszK8teyccOMQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJEaoX6n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775D41F000E9;
	Tue, 16 Jun 2026 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623060;
	bh=F1H7jxVqGtbYQMRG6Nh6FhB9ZKrrHCy7FOouLwNkNmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vJEaoX6nJHavHD1KZc9SNV5Czdl9MxGKKZ4fBb/qsC7nh3jDN1AvKyhuZ6tniZnt7
	 b+E/T1MEAREWuSHFBnKGGDqkNkL6RAMlPzKYxZqUJbfE+NuzQmKpS2thwZvCS1zG3L
	 0A8WHwfafqhFk9tOeiNthOxtXd5IwOFVIFnjs3cg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 081/378] VFS: fix possible failure to unlock in nfsd4_create_file()
Date: Tue, 16 Jun 2026 20:25:12 +0530
Message-ID: <20260616145114.474240217@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,brown.name,kernel.org,hammerspace.com,xs4all.nl];
	TAGGED_FROM(0.00)[bounces-263899-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:neil@brown.name,m:jlayton@kernel.org,m:bcodding@hammerspace.com,m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,ownmail.net:email,xs4all.nl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24ED1690E77

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@ownmail.net>

[ Upstream commit e824bbd4d224cce4b5fb59cc9dcd3447fe0b7e44 ]

atomic_create() in fs/namei.c drops the reference to the dentry
when it returns an error.
This behaviour was imported into dentry_create() so that it
will drop the reference if an error is returned from atomic_create(),
though not if vfs_create() returns an error (in the case where
->atomic_create is not supported).

The caller - nfsd4_create_file() - is made aware of this by checking
path->dentry, which will either be a counted reference to a dentry, or
an error pointer.

However the change to use start_creating()/end_creating() (which landed
shortly before the dentry_create() change landed, though was likely
developed around the same time) means that nfsd4_create_file() *needs* a
valid dentry so that it can unlock the parent.

The net result is that if NFSD exports a filesystem which uses
->atomic_create, and if a call to ->atomic_create returns an error, then
nfsd4_create_file() will pass an error pointer to end_creating()
and the parent will not be unlocked.

Fix this by changing dentry_create() to make sure path->dentry is always
a valid dentry, never an error-pointer.  The actual error is already
returned a different way.

Note that if ->atomic_create() returns a different dentry (which may not
be possible in practice) we are guaranteed (because it is only ever
provided by d_spliace_alias()) that it will have the same d_parent and
so it will have the same effect when passed to end_creating().

Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open()")
Signed-off-by: NeilBrown <neil@brown.name>
Link: https://patch.msgid.link/177969022571.3379282.16448744624428323496@noble.neil.brown.name
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 9e5500dad14f59..d615cd62885198 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5002,6 +5002,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 {
 	struct file *file __free(fput) = NULL;
 	struct dentry *dentry = path->dentry;
+	struct dentry *orig_dentry = dentry;
 	struct dentry *dir = dentry->d_parent;
 	struct inode *dir_inode = d_inode(dir);
 	struct mnt_idmap *idmap;
@@ -5021,9 +5022,18 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		if (create_error)
 			flags &= ~O_CREAT;
 
+		/* atomic_open will dput(dentry) on error */
+		dget(orig_dentry);
 		dentry = atomic_open(path, dentry, file, flags, mode);
 		error = PTR_ERR_OR_ZERO(dentry);
 
+		if (IS_ERR(dentry))
+			/* keep the original */
+			dentry = orig_dentry;
+		else
+			/* Drop the extra reference */
+			dput(orig_dentry);
+
 		if (unlikely(create_error) && error == -ENOENT)
 			error = create_error;
 
-- 
2.53.0





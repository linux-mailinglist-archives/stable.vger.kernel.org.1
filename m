Return-Path: <stable+bounces-269640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bh69F1QSQmrazgkAu9opvQ
	(envelope-from <stable+bounces-269640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:36:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F36D65FB
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=CZvVKtJ+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269640-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269640-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C140300A481
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020339B498;
	Mon, 29 Jun 2026 06:36:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DF399899;
	Mon, 29 Jun 2026 06:35:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714960; cv=none; b=cuKM4BvkOzYTaVNhwfdwjjfqScp0XLgeNmNX2TPycLVfZphdarw06q55i45PDEW8P0hzMBjGgct+/iaoyIO3adVYk1vP3jVoPMD+aBoYPerJUl7Rvn//dgN0hvF7CwxJn7FRH3DKFf9B62685xD+Bijl0/fTHhydkdeORdfUg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714960; c=relaxed/simple;
	bh=84SgCX4/J8Nm/1TgJIEJEiLJQxKvJ4FTjUDPPwB4Sko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfLkXjxuISrP39DD+fsA1gHUY++/kDEfJxL2/dMkr2hKm7MOsrg5ECwzwZDe/61LG0gqjVpXFYY6d2DX8A1onAKGFdwCluz0YZ9HyrTssCUM1m5LFpqtOrPguhxjNs6ekcJ87sJCSQx7CcdKCb/oDrtCOpM3bGqbG+n0TRzNl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CZvVKtJ+; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xt8oDi+bI3bYNwgnYXtWn3UN8f+umrwsGOwaJMxCFgk=;
	b=CZvVKtJ+qfInXDOY1/oQfyXE7Ej1O6niptRYqR2KuJ9VOxK38Qd4y7WV3BnC7gROpF4JhYpa1
	d0hwW5tXeO+fxv2hUrgN9f4Lz8fkOi6sTDzhuUsXM+K2NTG8k1YC3aKO8vbV4X1SXB6pZ3Jk56a
	j5dmVmPgyWXAjwQy2kZJp30=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gpbsd0rmmz1T564;
	Mon, 29 Jun 2026 14:27:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D93252025F;
	Mon, 29 Jun 2026 14:35:48 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:35:48 +0800
Received: from octopus.huawei.com (10.67.174.191) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:35:47 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<miklos@szeredi.hu>, <amir73il@gmail.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<bboscaccy@linux.microsoft.com>, <caixinchen1@huawei.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-unionfs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<selinux@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 stable/linux-6.12.y 1/3] fs: constify file ptr in backing_file accessor helpers
Date: Mon, 29 Jun 2026 15:03:36 +0800
Message-ID: <20260629070338.578858-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20260629070338.578858-1-caixinchen1@huawei.com>
References: <20260629070338.578858-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:miklos@szeredi.hu,m:amir73il@gmail.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bboscaccy@linux.microsoft.com,m:caixinchen1@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:lujialin4@huawei.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,paul-moore.com,namei.org,hallyn.com,redhat.com,linuxfoundation.org,linux.microsoft.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269640-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A8F36D65FB

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 4e301d858af17ae2ce56886296e5458c5a08219a ]

Add internal helper backing_file_set_user_path() for the only
two cases that need to modify backing_file fields.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/20250607115304.2521155-2-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 fs/backing-file.c  |  4 ++--
 fs/file_table.c    | 13 ++++++++-----
 fs/internal.h      |  1 +
 include/linux/fs.h |  6 +++---
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 09a9be945d45..892361c31c3d 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -41,7 +41,7 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 		return f;
 
 	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
+	backing_file_set_user_path(f, user_path);
 	error = vfs_open(real_path, f);
 	if (error) {
 		fput(f);
@@ -65,7 +65,7 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
 		return f;
 
 	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
+	backing_file_set_user_path(f, user_path);
 	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
 	if (error) {
 		fput(f);
diff --git a/fs/file_table.c b/fs/file_table.c
index 2a08bc93b0b9..75a1908d51a9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -48,17 +48,20 @@ struct backing_file {
 	struct path user_path;
 };
 
-static inline struct backing_file *backing_file(struct file *f)
-{
-	return container_of(f, struct backing_file, file);
-}
+#define backing_file(f) container_of(f, struct backing_file, file)
 
-struct path *backing_file_user_path(struct file *f)
+struct path *backing_file_user_path(const struct file *f)
 {
 	return &backing_file(f)->user_path;
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+void backing_file_set_user_path(struct file *f, const struct path *path)
+{
+	backing_file(f)->user_path = *path;
+}
+EXPORT_SYMBOL_GPL(backing_file_set_user_path);
+
 static inline void backing_file_free(struct backing_file *ff)
 {
 	path_put(&ff->user_path);
diff --git a/fs/internal.h b/fs/internal.h
index 8c1b7acbbe8f..a4352d333c61 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -100,6 +100,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+void backing_file_set_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 87720e1b5419..70bbc00a2bd2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2738,7 +2738,7 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct path *backing_file_user_path(struct file *f);
+struct path *backing_file_user_path(const struct file *f);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
@@ -2750,14 +2750,14 @@ struct path *backing_file_user_path(struct file *f);
  * by fstat() on that same fd.
  */
 /* Get the path to display in /proc/<pid>/maps */
-static inline const struct path *file_user_path(struct file *f)
+static inline const struct path *file_user_path(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
 		return backing_file_user_path(f);
 	return &f->f_path;
 }
 /* Get the inode whose inode number to display in /proc/<pid>/maps */
-static inline const struct inode *file_user_inode(struct file *f)
+static inline const struct inode *file_user_inode(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
 		return d_inode(backing_file_user_path(f)->dentry);
-- 
2.18.0.huawei.25



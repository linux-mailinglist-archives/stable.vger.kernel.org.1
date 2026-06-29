Return-Path: <stable+bounces-269644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mSqxLlwUQmpIzwkAu9opvQ
	(envelope-from <stable+bounces-269644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:44:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5606D677D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=JRIVFRRO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269644-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269644-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287DB30610A8
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36839BFFE;
	Mon, 29 Jun 2026 06:38:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FA39A056;
	Mon, 29 Jun 2026 06:38:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715137; cv=none; b=BMxlYUJqdA1nra7cXLtxJiZNn5MAkd2iCdhSEHtIcFw0zj4STMQMxFdwGRrDd8DTW8HITl+0tjPQwBOkEB/pidFwCU7rnU/tRI+7BuI1epqURQgUBtUxXGGemV2ma92cSquBHmFOK+sMIFn7fZh2DiNZo6cX/FaCSgzZV6hPfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715137; c=relaxed/simple;
	bh=H2dMPBjcK8JunOKRpWCq8eRwiEF4de7/SDtihJlezVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epWxCYklnnry3jTUpzcP5FbDbh+QtOZ0DCQrWsHCLBXfSFC3DSX1Gww0w4LfZSyVRtKvGzOu+0jTNP+bpFJJBd9g1XiWuVBKJTifUnPFZ8LzFKWX3xum6k/6WNXHNebOh6lmElWOZZiW/n6moBytaCahBJB9AXnqRX8GmDX8DAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JRIVFRRO; arc=none smtp.client-ip=113.46.200.222
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W6I349o8tzNr0cqvWI15PUdRglPMO2szvDnfTtwE7GM=;
	b=JRIVFRROt5zTKcUUzZZL4OwnH5Ng6R1I5mnxehtgdqfBhNSuNLP3IB4EfLSi9e0yBwSt/fqJv
	L9MJs+lnNvvNVspqh+bE3xZ6VTlCl5JUsFwJ6yvFW07Vuns/Lb77aDvU/iNIhtJAJgKyjY1SJO0
	v7C1+fc+9loa5mVmza4O9/Y=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gpbwm3vvvzLm4W;
	Mon, 29 Jun 2026 14:29:44 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E36B340593;
	Mon, 29 Jun 2026 14:38:52 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:38:52 +0800
Received: from octopus.huawei.com (10.67.174.191) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:38:51 +0800
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
Subject: [PATCH stable/linux-5.10.y 1/7] ovl: pass layer mnt to ovl_open_realfile()
Date: Mon, 29 Jun 2026 15:06:47 +0800
Message-ID: <20260629070653.580879-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-269644-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D5606D677D

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 1248ea4b91bcdafefdb025087e67d58382cfc9eb ]

Ensure that ovl_open_realfile() takes the mount's idmapping into
account. We add a new helper ovl_path_realdata() that can be used to
easily retrieve the relevant path which we can pass down. This is needed
to support idmapped base layers with overlay.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 fs/overlayfs/file.c      | 22 +++++++++++++---------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4440ff43cb66..343db8b3ecd6 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -37,8 +37,9 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 #define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
 
 static struct file *ovl_open_realfile(const struct file *file,
-				      struct inode *realinode)
+				      struct path *realpath)
 {
+	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
 	const struct cred *old_cred;
@@ -103,21 +104,21 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 			       bool allow_meta)
 {
-	struct inode *inode = file_inode(file);
-	struct inode *realinode;
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
 
 	real->flags = 0;
 	real->file = file->private_data;
 
 	if (allow_meta)
-		realinode = ovl_inode_real(inode);
+		ovl_path_real(dentry, &realpath);
 	else
-		realinode = ovl_inode_realdata(inode);
+		ovl_path_realdata(dentry, &realpath);
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(real->file) != realinode)) {
+	if (unlikely(file_inode(real->file) != d_inode(realpath.dentry))) {
 		real->flags = FDPUT_FPUT;
-		real->file = ovl_open_realfile(file, realinode);
+		real->file = ovl_open_realfile(file, &realpath);
 
 		return PTR_ERR_OR_ZERO(real->file);
 	}
@@ -143,17 +144,20 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 
 static int ovl_open(struct inode *inode, struct file *file)
 {
+	struct dentry *dentry = file_dentry(file);
 	struct file *realfile;
+	struct path realpath;
 	int err;
 
-	err = ovl_maybe_copy_up(file_dentry(file), file->f_flags);
+	err = ovl_maybe_copy_up(dentry, file->f_flags);
 	if (err)
 		return err;
 
 	/* No longer need these flags, so don't pass them on to underlying fs */
 	file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	realfile = ovl_open_realfile(file, ovl_inode_realdata(inode));
+	ovl_path_realdata(dentry, &realpath);
+	realfile = ovl_open_realfile(file, &realpath);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5ac968f709a4..5b8a1c9bc355 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -274,6 +274,7 @@ void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
+enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
 struct dentry *ovl_dentry_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_lowerdata(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 26f29a3e5ada..431dfe3db0cc 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -209,6 +209,20 @@ enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path)
 	return type;
 }
 
+enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path)
+{
+	enum ovl_path_type type = ovl_path_type(dentry);
+
+	WARN_ON_ONCE(d_is_dir(dentry));
+
+	if (!OVL_TYPE_UPPER(type) || OVL_TYPE_MERGE(type))
+		ovl_path_lowerdata(dentry, path);
+	else
+		ovl_path_upper(dentry, path);
+
+	return type;
+}
+
 struct dentry *ovl_dentry_upper(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-- 
2.18.0.huawei.25



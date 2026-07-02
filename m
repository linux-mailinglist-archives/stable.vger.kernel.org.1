Return-Path: <stable+bounces-271027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0PVOEZCWRmpSZQsAu9opvQ
	(envelope-from <stable+bounces-271027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:49:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FD6FA9AA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:49:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fWv9qQ97;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271027-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271027-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43931306F7A6
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01AB3546E7;
	Thu,  2 Jul 2026 16:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A03438A8;
	Thu,  2 Jul 2026 16:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010480; cv=none; b=OvK5SxRVljAoKZ939TFuYd/KOoRAzIfHHcbf9VFO8jZc+LZTboX3bQ3GvzEZ8SDXNz+lm6rMcpObdNbmB1upBE8BLfPDJfG7ZOrbOOzCZ4XVKVBVXHg0dEOsYwWKLIx5udgxOiVGoNrVOoy2kHffJtw86UClRjcsbGxGfB1jHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010480; c=relaxed/simple;
	bh=sSl2Atn+zjo+JLixWh7AhRW7+sWg1zsuO1GOUtbSOOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IATq54TUX8JgbF88tnPOZMAY5MTToAbfzMert3L4zTrdbypJ4FIYJOLS0ncL00yZxG0ysB2SALvdwg+VYH8Df3r5UclZEYevuUNdMkOicK+y35EGCFlFNswY+YWWsA/ST9qyRwFa5YfLwn3Himj5ka8TEwYs4p/8tEeKnTH3l3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWv9qQ97; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98141F00A3A;
	Thu,  2 Jul 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010477;
	bh=Owp/7zCjhXGxzyQllLKXJvVqv39f0mL3BpoMVHnlLFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWv9qQ97WtbWS7KKSTokEbglUzcGvw3vncCe1yL5GuNC4snii5pdBZi9mMiWz6kc+
	 DcT48AaIT6fORr4kkAtGGnCgSDq7J1+lmSGMGTVuqYQkRztdeDejvhQOWZD3qaSJ+q
	 YsVH8w5LNqp+fBOzW/cV+nGYnWhKqdIaPIz6jncM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Cai Xinchen <caixinchen1@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 125/204] fs: constify file ptr in backing_file accessor helpers
Date: Thu,  2 Jul 2026 18:19:42 +0200
Message-ID: <20260702155121.277027601@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-271027-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:amir73il@gmail.com,m:brauner@kernel.org,m:caixinchen1@huawei.com,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE6FD6FA9AA

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 4e301d858af17ae2ce56886296e5458c5a08219a ]

Add internal helper backing_file_set_user_path() for the only
two cases that need to modify backing_file fields.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/20250607115304.2521155-2-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/backing-file.c  |  4 ++--
 fs/file_table.c    | 13 ++++++++-----
 fs/internal.h      |  1 +
 include/linux/fs.h |  6 +++---
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 09a9be945d45e6..892361c31c3de9 100644
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
index 2a08bc93b0b9c1..75a1908d51a9f5 100644
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
index 8c1b7acbbe8faa..a4352d333c617a 100644
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
index 87720e1b54192c..70bbc00a2bd250 100644
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
2.53.0





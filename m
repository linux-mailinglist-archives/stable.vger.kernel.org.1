Return-Path: <stable+bounces-226369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAvTEheHuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF192AE9A3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FB8F3035F6B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAB3EAC6F;
	Tue, 17 Mar 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xsn8fsRk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24643EDADB;
	Tue, 17 Mar 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766392; cv=none; b=if4EfG7EqCsNY2QlKVp0NyE0DgxZiwTgs5XKMJP++NqdFVdSYF7rQOgbSZfsldaH64yMgp/wopHfj8o3A9VCr+iRgMGjOIpBqreINAMnR/Qy4+XXF7b/T/Hkf8/DemHRmXFWdenoZDuj1eFEbXlvKLnpB3vpaYwccg1TAhClFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766392; c=relaxed/simple;
	bh=4JVky5YpgWp52Yi04mPiaTcc+q4p6q2vdP4UIiVIzaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0+SkVFFY50/GFL97aAefGGMd5HUahoqurlkeH2rGVJ+eSWEocYND2XfD6D5eJ9aVED4ezAkejjOvTP1pPvQ31m4fxk78fnWsZ12WskNDdjkFUp1G7/+L6CM+ngTDHBKFKsrHpUrkaXf8YBQd8DGOtHh6CVBRRuJ9hVJNYVEW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xsn8fsRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C3C4CEF7;
	Tue, 17 Mar 2026 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766392;
	bh=4JVky5YpgWp52Yi04mPiaTcc+q4p6q2vdP4UIiVIzaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xsn8fsRkbjAlmVw+CxFThb3EZb5yK9obaBbbjG13EQJA6TgXc0tC/PXcWPa0+UAYQ
	 68OSJa0/miVfwiEMvDsg9M9bS2F3NahizZCZfphMEru8hfeh+XoR0vAGb00Oj3vPVo
	 CdkgIh3HwpAZ64r8jN+AuiJrKBTkUTDj0H3vIhGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.19 204/378] ceph: add a bunch of missing ceph_path_info initializers
Date: Tue, 17 Mar 2026 17:32:41 +0100
Message-ID: <20260317163014.516120220@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226369-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ionos.com,ibm.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,ionos.com:email]
X-Rspamd-Queue-Id: 1AF192AE9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

commit 43323a5934b660afae687e8e4e95ac328615a5c4 upstream.

ceph_mdsc_build_path() must be called with a zero-initialized
ceph_path_info parameter, or else the following
ceph_mdsc_free_path_info() may crash.

Example crash (on Linux 6.18.12):

  virt_to_cache: Object is not a Slab page!
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6732 kmem_cache_free+0x316/0x400
  [...]
  Call Trace:
   [...]
   ceph_open+0x13d/0x3e0
   do_dentry_open+0x134/0x480
   vfs_open+0x2a/0xe0
   path_openat+0x9a3/0x1160
  [...]
  cache_from_obj: Wrong slab cache. names_cache but object is from ceph_inode_info
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6746 kmem_cache_free+0x2dd/0x400
  [...]
  kernel BUG at mm/slub.c:634!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__slab_free+0x1a4/0x350

Some of the ceph_mdsc_build_path() callers had initializers, but
others had not, even though they were all added by commit 15f519e9f883
("ceph: fix race condition validating r_parent before applying state").
The ones without initializer are suspectible to random crashes.  (I can
imagine it could even be possible to exploit this bug to elevate
privileges.)

Unfortunately, these Ceph functions are undocumented and its semantics
can only be derived from the code.  I see that ceph_mdsc_build_path()
initializes the structure only on success, but not on error.

Calling ceph_mdsc_free_path_info() after a failed
ceph_mdsc_build_path() call does not even make sense, but that's what
all callers do, and for it to be safe, the structure must be
zero-initialized.  The least intrusive approach to fix this is
therefore to add initializers everywhere.

Cc: stable@vger.kernel.org
Fixes: 15f519e9f883 ("ceph: fix race condition validating r_parent before applying state")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/debugfs.c |    4 ++--
 fs/ceph/dir.c     |    2 +-
 fs/ceph/file.c    |    4 ++--
 fs/ceph/inode.c   |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -79,7 +79,7 @@ static int mdsc_show(struct seq_file *s,
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
@@ -98,7 +98,7 @@ static int mdsc_show(struct seq_file *s,
 		}
 
 		if (req->r_old_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1364,7 +1364,7 @@ static int ceph_unlink(struct inode *dir
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -397,7 +397,7 @@ int ceph_open(struct inode *inode, struc
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
@@ -807,7 +807,7 @@ int ceph_atomic_open(struct inode *dir,
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2551,7 +2551,7 @@ int __ceph_setattr(struct mnt_idmap *idm
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;




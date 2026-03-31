Return-Path: <stable+bounces-231610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHO6Kar4y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ACF36CE70
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFB031CA283
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D1423A8C;
	Tue, 31 Mar 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQSTysb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF740710B;
	Tue, 31 Mar 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974615; cv=none; b=krywMiEqiXPnDRgVy76uZSbFy8EIdItFjGhUZ2DklBOhPXngrFy2sfZrGwXl3Z2qIZVwe32AbpbXzlsu5g/r2GT9Ogu3ymtdyvtIDNVpn9XNjIrRevpqdR6sbQClUYn2DKnvWOkZoEleTgY8c6YJfgBCJiu+pgNupeZHulS7fAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974615; c=relaxed/simple;
	bh=4SfU4IyLLJYdGNeBeZaaOeeV8HaVZymP72fCavohIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL53eIvKgQheqjjPsRtWu4HqcQTa0/+c5icE58EvNxHEE+9uqzUqrDFxaiIiy0nnKgpd9RAXtBX7Y6oNAzLaejQ0qipGy23Q2jpmeSS8PL2vDKvrg/daMTyrw2SJ3Qd64s0gYwJ2Yituxyk9O9u6cqvysy0PdfpjRosgbylXx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQSTysb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A11BC19423;
	Tue, 31 Mar 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974615;
	bh=4SfU4IyLLJYdGNeBeZaaOeeV8HaVZymP72fCavohIUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQSTysb190xj/fI5ABaOY5BWnGcyE2a3V176I3T+8trC/wgM76RlgFeb2Phq1UWg1
	 8oG2IpCyZJ+3hbsJ0awpvxUidfdSX+QyL39y3OAef9uTsXkxQ5kq0z5FFaV6KGzOJi
	 8CsFSEJtni+Uf+TtzTgX87m/tNKNijb84947n/C8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6 154/175] xattr: switch to CLASS(fd)
Date: Tue, 31 Mar 2026 18:22:18 +0200
Message-ID: <20260331161735.450792982@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231610-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,zeniv.linux.org.uk,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,foxmail.com:email]
X-Rspamd-Queue-Id: F3ACF36CE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit a71874379ec8c6e788a61d71b3ad014a8d9a5c08 ]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[ Only switch to CLASS(fd) in v6.6.y for fd_empty() was introduced in commit
88a2f6468d01 ("struct fd: representation change") in 6.12. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xattr.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,8 +698,6 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, cons
 	int error;
 
 	CLASS(fd, f)(fd);
-	if (!f.file)
-		return -EBADF;
 
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
@@ -810,16 +808,11 @@ SYSCALL_DEFINE4(lgetxattr, const char __
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (!f.file)
-		return error;
 	audit_file(f.file);
-	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
+	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
-	fdput(f);
-	return error;
 }
 
 /*
@@ -886,15 +879,10 @@ SYSCALL_DEFINE3(llistxattr, const char _
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (!f.file)
-		return error;
 	audit_file(f.file);
-	error = listxattr(f.file->f_path.dentry, list, size);
-	fdput(f);
-	return error;
+	return listxattr(f.file->f_path.dentry, list, size);
 }
 
 /*
@@ -951,12 +939,10 @@ SYSCALL_DEFINE2(lremovexattr, const char
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	char kname[XATTR_NAME_MAX + 1];
-	int error = -EBADF;
+	int error;
 
-	if (!f.file)
-		return error;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
@@ -971,7 +957,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, c
 				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
-	fdput(f);
 	return error;
 }
 




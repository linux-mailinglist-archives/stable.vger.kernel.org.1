Return-Path: <stable+bounces-233332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHZXAIlL0mnbVgcAu9opvQ
	(envelope-from <stable+bounces-233332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D38839E31B
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3929300A122
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777424C6C;
	Sun,  5 Apr 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="k+LA1N07"
X-Original-To: stable@vger.kernel.org
Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DD25A2C6;
	Sun,  5 Apr 2026 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775389563; cv=none; b=WNbnOOlWfOx3vN9cJAPXFnzIUDrr3PS6s8vUwlKFxGqZ+xXHmjc096Xb/qTBeKnR4vfioP42mBV0mEkhXP3Ds07uBERZGjcrBxRMrCcZEwo1qLNva04zjieYgcI5ckX11/cre2rFFzBfHLpPLSvfAKckbZtMU5h5IYGY+cAu4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775389563; c=relaxed/simple;
	bh=FM9YMsn6Yz6m1J9QEPf+8V7JwFT6Rqu5ikPJSt0xaMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDC2U08gxIw9mmv53Gn1KQ2tHVw85WF+Fg6SN4yZQyUOOPNdQ7usvzYL6RO9fI1TxmKoWrQmhwo9GT43usi5/hbVQF9Z8mc9iJgLBokzjPbWCelI/ywVjNKhDYIm4HOHl690BeMf52iOi9kyswR4oC090rP5ETqXHFE2VKsUAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=k+LA1N07; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=FM9YMsn6Yz6
	m1J9QEPf+8V7JwFT6Rqu5ikPJSt0xaMo=; h=references:in-reply-to:date:
	subject:cc:to:from; d=kramkow.ski; b=k+LA1N07cGClqCuRE/8GFNZHgiuxzBr8E
	uETV2HeS3YIc+WVghOydMoMpnl6CL4+I6xwr6p5KukA/Uz4AvOnIBXeKzntzzZ7DXsZgR5
	XbfDtuBNfQX9k6ebiVlocHTOq4nzZwmtqcjbIXb9AWCJncdLh3OSGRa8GVJ19SkADgEBNx
	VgG0wEng87hNRDT3NPujH2Lvoxu9nwCm/ZEHpjc0QR3aZvE4xieFpd2REJyh0Rr+lv8yKz
	Dq89Bdg2H54PjhQ71+wFcmeI5Vv8D63SYQRnkrKdcJmnVL4QIX/JhkryQ9AE6BF9esfH1D
	mg37lt9prXukCU6Huy/Yy8gl6SI1A==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 1891b1af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 5 Apr 2026 11:45:54 +0000 (UTC)
From: Tomasz Kramkowski <tomasz@kramkow.ski>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tomasz Kramkowski <tomasz@kramkow.ski>,
	Brad Spengler <spender@grsecurity.net>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v2 1/2] Revert "xattr: switch to CLASS(fd)"
Date: Sun,  5 Apr 2026 12:45:04 +0100
Message-ID: <20260405114505.568530-2-tomasz@kramkow.ski>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260405114505.568530-1-tomasz@kramkow.ski>
References: <20260405114505.568530-1-tomasz@kramkow.ski>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kramkow.ski,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kramkow.ski:s=20220506];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,vger.kernel.org,kramkow.ski,grsecurity.net,foxmail.com];
	TAGGED_FROM(0.00)[bounces-233332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz@kramkow.ski,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kramkow.ski:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,x.com:url,kramkow.ski:dkim,kramkow.ski:email,kramkow.ski:mid,foxmail.com:email]
X-Rspamd-Queue-Id: 2D38839E31B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 5a1e865e51063d6c56f673ec8ad4b6604321b455 which is
commit a71874379ec8c6e788a61d71b3ad014a8d9a5c08 upstream.

A backporting mistake erroneously removed file descriptor checks for
`fgetxattr`, `flistxattr`, `fremovexattr`, and `fsetxattr` which lead to
kernel panics when those functions were called from userspace with a
file descriptor which did not reference an open file.

Reported-by: Brad Spengler <spender@grsecurity.net>
Closes: https://x.com/spendergrsec/status/2040049852793450561
Cc: Alva Lan <alvalan9@foxmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>
---
 fs/xattr.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5f2d74332ea6..7574d24b982e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,6 +698,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
+	if (!f.file)
+		return -EBADF;
 
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
@@ -808,11 +810,16 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
+	ssize_t error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
-	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
+	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
+	fdput(f);
+	return error;
 }
 
 /*
@@ -879,10 +886,15 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
+	ssize_t error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
-	return listxattr(f.file->f_path.dentry, list, size);
+	error = listxattr(f.file->f_path.dentry, list, size);
+	fdput(f);
+	return error;
 }
 
 /*
@@ -939,10 +951,12 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
 	char kname[XATTR_NAME_MAX + 1];
-	int error;
+	int error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
@@ -957,6 +971,7 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
+	fdput(f);
 	return error;
 }
 
-- 
2.51.0



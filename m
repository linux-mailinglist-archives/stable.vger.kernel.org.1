Return-Path: <stable+bounces-231185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHR/HN9uymnG8gUAu9opvQ
	(envelope-from <stable+bounces-231185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:38:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68335B233
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32E6B301E98F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BAF3CFF7E;
	Mon, 30 Mar 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xg/p0yJH"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39640DFB6;
	Mon, 30 Mar 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874071; cv=none; b=MXb/kTwKbDMqctJjzZM/iVHEjGWgFHYy+Z0V6ACI52ol2Gu7/+oHt1Htt4iEs11ipffUD6X3vWK9Uu3Drrgl+CE8ZQszWu6gnM8aVO55kivDw+TcrCoAqJf3a5t9/FkO+aABIPVoiQ7M17n0i0f3SlMKZBsu4yp6CCKBpV07UfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874071; c=relaxed/simple;
	bh=+b8pRyUaGTFPcVh3p5cs1wBlGl3FyXNdI7pD/wTOT7U=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=m19inbKmxaqz05pyxTheaM6HAh1H7dcq8ozPaW5t3hgVaxk69pFeE2o+T+G6GGd4OHdvJ2IecMu9Y8sP0R3SA8Ev6D8KtZZkxGlYF2BuuReGxgxrgtXP+rz04j1xA6VBzOH9MJ7V0easCCFqI9oOfPkny9Oe83CbbEn05t2HI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xg/p0yJH; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1774874058;
	bh=UCXVo65JSX2KSbMvet5fJVP8ZzQOja4RAwPNKZX5iPU=;
	h=From:To:Cc:Subject:Date;
	b=xg/p0yJHwKX7h7gmO1i2gxlHAwVcvsgRjynz2u+Oqwnn4jvt/nJnENE+RI/g8k0au
	 ISRHLh53hhPXZa6fHrNNPz8mVew4og/I6xX+Zv7/Z1UXvnTDjCY/EhcgHhvM4XQ08v
	 TqTOtd4qQl1QLHFlfab+ORb6Vt9vqAnRAjYJt5vE=
Received: from Ubuntu24 ([2409:8a00:dd3:9760:a100:1088:9e19:6016])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 882A6ABD; Mon, 30 Mar 2026 20:34:02 +0800
X-QQ-mid: xmsmtpt1774874042tlr95jqh7
Message-ID: <tencent_72B5370E2D4C4AC319ED4F0DCB479CA4B406@qq.com>
X-QQ-XMAILINFO: MVuDTlnnQDnqsNmfGtEk2vNc4Ock0t2DTLOlW3uy3xOzuAm7K7KHHBLJGiqfk1
	 J5H5Kjc38TbR0Fgb1R/6CXPcRRgy3ZswY07evUGPqPymvE9XCK1KrZbGQPqz5YAjAThCKNS+BlXq
	 nGQwgfbRgwAqAtu5LFpRpN4QBcEEWE5BVnvXxe3cYIxY0Sx7AvVdbpa3+JHNVdjutRXADu6rKK/L
	 gOg/Iz8GbS2l0QLu01y5ZvQJSa5+KYOUNuDsSsbKE51/3D5Kl0FMkQA+6dCJBpc8neY8JlWHdDB6
	 kXKMIW2H2L2I7SPbN0cyibRtN3PptyUmbk0Tlp/olN9Jj/MKDWXC5wix5rf5YEQkoDe1uSoSoS7d
	 Cqy4Ev8zZbyYy8Blpl3aaTdnYfyj84uO2YcudshAK9+9Iq577vSMKKMVRJ7FZ9/n1NkxzqAvKgC4
	 gCl9E3Ffl69o0vQlURu9VJ6geFYL5YEV1px2IEJpIVYjwdJm1zSVYC4Um7f6DHP2AfE0w5h6Lb6P
	 DXQ6PONqKdBdCx7bn1kFhaUVFcoN10LbDbiFuqr1IoGGASuFf7bYq3mv28ry0YxgTgGM8DYo9l6U
	 0svHPowJRv4I99akVD/3/awh6ZQyfFhlKuLPLVAzMf8dSRRZJ3DtDRDN4g/QROej1C+uNc9VwAvI
	 F3fdHGgCMcZ1G9utHVDg+byy6LOKMxgwrOoawHQQKyHygy0cpT43oFiypfGGDftFsyFF49PO8dNq
	 8x71xmSiNn+/cwbvfnKqDUHZcR8Otl9dvdNWSNThbaJU2fxGenAJ+3ZBcdG08xRmDX1onjK/5AHr
	 P5CC5HSXd3XSDYZJFaAJQxuunWJHu2QT2pykR1ifVt6mpzGZM7cKjW0tLZMaJmHXBCio8xDm57YK
	 DYnMINHt6j9ZZkhLIhXEMsGg745wB+Y8s2okJts/XAqdHH40jTpjyO/nWG6DtVAtvKz+XAXNom+t
	 MKEbC2Qn4MQtMh2Fjw2dpWfzS7by9+bkj0ddj/5EfyCLpaoZZvAY2Vkr5W3tgSF2ucGLnH7XXzrA
	 yUVsCJgCjZ9GQ0hdYDonfYRzqG+x2Nx35iA8Zc6trb3rYCehccIzTRELbwyNljg+CHIaj0RvRfXL
	 igyIWw
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] xattr: switch to CLASS(fd)
Date: Mon, 30 Mar 2026 20:33:52 +0800
X-OQ-MSGID: <20260330123352.4745-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231185-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Queue-Id: BA68335B233
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit a71874379ec8c6e788a61d71b3ad014a8d9a5c08 ]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[ Only switch to CLASS(fd) in v6.6.y for fd_empty() was introduced in commit
88a2f6468d01 ("struct fd: representation change") in 6.12. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/xattr.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 7574d24b982e..5f2d74332ea6 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,8 +698,6 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
-	if (!f.file)
-		return -EBADF;
 
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
@@ -810,16 +808,11 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
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
@@ -886,15 +879,10 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
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
@@ -951,12 +939,10 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
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
@@ -971,7 +957,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
-	fdput(f);
 	return error;
 }
 
-- 
2.43.0



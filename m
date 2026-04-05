Return-Path: <stable+bounces-233333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKanDZZL0mmLVgcAu9opvQ
	(envelope-from <stable+bounces-233333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32BF39E329
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 061B4300F13F
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E1243951;
	Sun,  5 Apr 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="fNOqmVgg"
X-Original-To: stable@vger.kernel.org
Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF53326D65;
	Sun,  5 Apr 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775389567; cv=none; b=QBuH/MJVtrg34TFhW9yyREAvsS10cLa0M5YpcvY+HQW1O1RJFj7n7/AE2OYjhvp+Kv94aa5A48AG3Qo1QZXXGg3hgRH3cqq1tJG0fSE5xZacA7DBNhiqGqzgd7Xb6BpeppVZoN6xde3ozP3TUcLMvHG1Fjg3QnAbOyqFdRSV/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775389567; c=relaxed/simple;
	bh=EbiHYeDwemDRMIXMMn52TDVPdSdhxmHxQ7JV7c6bDPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP8xtymzwrs3Xse7OCQaeOdD66G0Fk8rzj0ldZyf2IkJn6JNELpUvxGZBxyJXfNPA7Iallc/Tn0zcvhAuKC2hddj0+jmhI980HgblBv4/b3o44peqGi5JbBZG2ywV5tsfGlcQmZVG1RPL9LliKbk0AYKFqX8uWUzzFifgwC/fgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=fNOqmVgg; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=EbiHYeDwemD
	RMIXMMn52TDVPdSdhxmHxQ7JV7c6bDPo=; h=references:in-reply-to:date:
	subject:cc:to:from; d=kramkow.ski; b=fNOqmVgg0ml1sQywzL28Bim6jnUxMz/Go
	LmTnp+oJTbAaxbwqYLbyIBgm6tFc2dPluFteKN5bbR57Je47tagoptZ1wFe4LkxlU3t/Sv
	IaF+kC0tLG09ILw933KQIKZfrPX1ymbVnjdIZW8/llc+9ZRtq8Rw2giwRiPGrmkjLPkRYY
	eoaHMS1oUYCgUKhbEStnOUzlydyL14S+5NPjm/JYK0Tvg5t2yvrYEKd5U20RIyo6KW0dPG
	glMtKvt1psaaIQkT391e8X0JIc3rTKW7Cwx7FokN8AmmEeebfC9sJrtsvdvllv5kBbAqvC
	Pw5TmHqsnT4zIfS9JLUHpFkI7K9yw==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 6f07a027 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 5 Apr 2026 11:46:00 +0000 (UTC)
From: Tomasz Kramkowski <tomasz@kramkow.ski>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tomasz Kramkowski <tomasz@kramkow.ski>
Subject: [PATCH 6.6.y v2 2/2] xattr: switch to CLASS(fd)
Date: Sun,  5 Apr 2026 12:45:05 +0100
Message-ID: <20260405114505.568530-3-tomasz@kramkow.ski>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233333-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz@kramkow.ski,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kramkow.ski:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kramkow.ski:dkim,kramkow.ski:email,kramkow.ski:mid,linux.org.uk:email]
X-Rspamd-Queue-Id: A32BF39E329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit a71874379ec8c6e788a61d71b3ad014a8d9a5c08 ]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20241002012230.4174585-1-viro@zeniv.linux.org.uk/
[ Neither `fd_file` nor `fd_empty` are available in 6.6.y, so the
  changes to the check are dropped. Kept the minor formatting change. ]
Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>
---
 fs/xattr.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 7574d24b982e..20a038b06d12 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,9 +698,9 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
+
 	if (!f.file)
 		return -EBADF;
-
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
 	if (error)
@@ -810,16 +810,13 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
 	if (!f.file)
-		return error;
+		return -EBADF;
 	audit_file(f.file);
-	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
+	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
-	fdput(f);
-	return error;
 }
 
 /*
@@ -886,15 +883,12 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
 	if (!f.file)
-		return error;
+		return -EBADF;
 	audit_file(f.file);
-	error = listxattr(f.file->f_path.dentry, list, size);
-	fdput(f);
-	return error;
+	return  listxattr(f.file->f_path.dentry, list, size);
 }
 
 /*
@@ -951,12 +945,12 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	char kname[XATTR_NAME_MAX + 1];
-	int error = -EBADF;
+	int error;
 
 	if (!f.file)
-		return error;
+		return -EBADF;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
@@ -971,7 +965,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
-	fdput(f);
 	return error;
 }
 
-- 
2.51.0



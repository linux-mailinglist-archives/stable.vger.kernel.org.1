Return-Path: <stable+bounces-233248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEb/FKpJ0Glu5gYAu9opvQ
	(envelope-from <stable+bounces-233248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:13:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF4399004
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 889D5301BA6B
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAD38B12C;
	Fri,  3 Apr 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="mUBS76kN"
X-Original-To: stable@vger.kernel.org
Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073C38A703;
	Fri,  3 Apr 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258011; cv=none; b=BrZK2udd2GSXYnmxWDHe/F33x++w88OuuKu1W32GLRwDjUHLWRoW/4cbHk3U/B3ZWkCfFludjGPFrO5OBWttrzXn+SyHrrzXr1YXnBkrGfp+drUopxa4CV1dSgKVU3S3jlJO4ZDkfe2zdePX0VEZsgumURoeH3L/BIrogVLtAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258011; c=relaxed/simple;
	bh=OHd9cvcdXP0j50wnuukpvo8aIeZ4hlzdJNoa40PKFC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JC46tIJP8wt/C1NyG27kyq4tMiX60nNBgdyYB1S9jst73aarLd8X5Zyu9st96BdmV8oWWB0OkEU8dUXfVmcnysB8zYh5QsFRKacj7ZeDiLmyyrGuqq51a3uCefSuMnsbhHqpVNqc0FY9iSVvF6o84xa6ctPvA6SE48cfPcNrOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=mUBS76kN; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=OHd9cvcdXP0
	j50wnuukpvo8aIeZ4hlzdJNoa40PKFC4=; h=date:subject:cc:to:from;
	d=kramkow.ski; b=mUBS76kNnIqlt3+BZ7Xa6ioCUA/GZ2EgKYuc5I527zNbs57PpMx6l
	nMdEtEkBR1EF8eZJVTIaRdJhKPtOljwknLP4jHZw9UI83cFkdLG5Ue8iWR6j4HOpGgXjbe
	SuAcwJW1sukou4XCAqmHwvxRz6uLWSMZeUM7CvE4sZyUgUKE63mkrV8vzf8+ueLCX+tYqa
	htLQPBGhus5vKUuhw0ZKarH9jCPHydmDOok6Z9CaF2ErjaL5mgiM9p134dmLXv9sgTYdu8
	gS0GApaUzGxvEY82dC9+li+f992ncilVGv979wOpLlz2AgzSU656kbons3XEw22T7zkPBC
	1h84tE2SA==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 3061fd7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Apr 2026 23:06:44 +0000 (UTC)
From: Tomasz Kramkowski <tomasz@kramkow.ski>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Alva Lan <alvalan9@foxmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tomasz Kramkowski <tomasz@kramkow.ski>
Subject: [PATCH] xattr: restore file descriptor checks
Date: Sat,  4 Apr 2026 00:06:36 +0100
Message-ID: <20260403230636.344097-1-tomasz@kramkow.ski>
X-Mailer: git-send-email 2.51.0
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
	R_DKIM_ALLOW(-0.20)[kramkow.ski:s=20220506];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foxmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org,kramkow.ski];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233248-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz@kramkow.ski,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kramkow.ski:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEDF4399004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch restores the checks incorrectly removed by commit
5a1e865e5106 ("xattr: switch to CLASS(fd)").

That commit was an attempt backport an upstream commit which had
modified but did not remove the checks to see if the passed file
descriptor referred to an open file. This seems to have resulted in the
backport removing the checks.

This leads to a kernel panic when calling `fgetxattr`, `flistxattr`,
`fremovexattr`, and `fsetxattr` with a file descriptor which does not
refer to an open file.

Tested in qemu.

Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>

---
 fs/xattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5f2d74332ea6..3dd28b30be69 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -699,6 +699,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
 	if (error)
@@ -810,6 +812,8 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 {
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
@@ -881,6 +885,8 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 	return listxattr(f.file->f_path.dentry, list, size);
 }
@@ -943,6 +949,8 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	char kname[XATTR_NAME_MAX + 1];
 	int error;
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
-- 
2.51.0



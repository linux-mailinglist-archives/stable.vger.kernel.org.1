Return-Path: <stable+bounces-87771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE58B9AB616
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CE4B230D9
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251019F487;
	Tue, 22 Oct 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nGQeEjgH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19A1C1AD0
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622737; cv=none; b=XbwUK04ywDu8ocVG6L7JwB97WhGp4HcfMcg5MEnpbnpT6gMRGnrH+ij7TCtA8h0ZikmS0zckNCEJ/mMKHeJ1sjE0bucP8b3Q551imjvms/rFEBUdF2otn5SH99DOq9JCNPI7dU1OJqYYPTTTZOV2WGHfcSSxX1Oy/iXzbvxXyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622737; c=relaxed/simple;
	bh=cwlLYfpAB1nLWaRmVhIpknGK2FbwCbvgNHzoTBAIBdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oCihwD43OCQtc0MXb4NK1/HZsmvv9F2skDT1yY7/KptEf0SPORjyQecUQbz+y2crXC/ZVrqAGBHDpmp65dKTApyFFLrml7ZNnL2JQspdMBVXQR7AToj0SG3v57VrhbXAqtC2QFXTS52b4XugrXK2EJeQRKxSWMFrlTRmkRbRngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nGQeEjgH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5XM1idQ0G/REixeXiFL8YUuvdV9ecT1/2x5WjDy3hVY=; b=nGQeEjgHbx3qmaWZmy+Ls4WAGU
	EoCGL7J/vCJQuxkwjxcBoU6eqjVA5iayZICgoBxC+IMQyYTTTM18X7/HEzCOJDoi2+btCY3TJ68zY
	+2It6gjEHInv0zt1o1E4PkKLokoV6cZdiwudOhx3feQeStlu5WrAL02AH5Dj5cOul9iORr3v5+vwk
	o/YIuZJybpoL/IYzRQ31diQ0thWc7NuroJeEdcRxPwGp1rCuwYDQe53PGblVKF3kiUTKkkmueWpNJ
	4jFRmsc7rcNHWsNZakfQzqF08FclnaSrNQropI1HqRzCJTRji/w9t99Jn2vHBXdTUAM6zGRArWVQm
	4BhscrCg==;
Received: from 179-125-79-219-dinamico.pombonet.net.br ([179.125.79.219] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t3Jsq-00DiYM-33; Tue, 22 Oct 2024 20:45:32 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1] exec: don't WARN for racy path_noexec check
Date: Tue, 22 Oct 2024 15:45:25 -0300
Message-Id: <20241022184525.3601318-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit 0d196e7589cefe207d5d41f37a0a28a1fdeeb7c6 ]

Both i_mode and noexec checks wrapped in WARN_ON stem from an artifact
of the previous implementation. They used to legitimately check for the
condition, but that got moved up in two commits:
633fb6ac3980 ("exec: move S_ISREG() check earlier")
0fd338b2d2cd ("exec: move path_noexec() check earlier")

Instead of being removed said checks are WARN_ON'ed instead, which
has some debug value.

However, the spurious path_noexec check is racy, resulting in
unwarranted warnings should someone race with setting the noexec flag.

One can note there is more to perm-checking whether execve is allowed
and none of the conditions are guaranteed to still hold after they were
tested for.

Additionally this does not validate whether the code path did any perm
checking to begin with -- it will pass if the inode happens to be
regular.

Keep the redundant path_noexec() check even though it's mindless
nonsense checking for guarantee that isn't given so drop the WARN.

Reword the commentary and do small tidy ups while here.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240805131721.765484-1-mjguzik@gmail.com
[brauner: keep redundant path_noexec() check]
Signed-off-by: Christian Brauner <brauner@kernel.org>
[cascardo: keep exit label and use it]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/exec.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 65d3ebc24fd3..a42c9b8b070d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -141,13 +141,11 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Check do_open_execat() for an explanation.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	fsnotify_open(file);
@@ -927,16 +925,16 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
-		goto out;
+		return file;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * In the past the regular type check was here. It moved to may_open() in
+	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
+	 * an invariant that all non-regular files error out before we get here.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	err = deny_write_access(file);
@@ -946,7 +944,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (name->name[0] != '\0')
 		fsnotify_open(file);
 
-out:
 	return file;
 
 exit:
-- 
2.34.1



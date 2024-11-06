Return-Path: <stable+bounces-90732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E879BEA23
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F051C23CF5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023D1F706D;
	Wed,  6 Nov 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOCmCByh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884421F7068;
	Wed,  6 Nov 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896649; cv=none; b=HVzYHptOTrzeYOyTjnIGlHuIpzfYRv1FsZY6iBr4oLgmusM6LWokaMvZ/uRWqO9KsdeHCZd69oIWoIDjqsjJpnrtFz16P4ZeWFLfeGs8g0vk52A+oXc3IwrCSKoK2Pet2f1Re9caWNoc73BDr4NF4l+aKCyuCfTHZGL7q5z0toI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896649; c=relaxed/simple;
	bh=v44Fwm6U9pv4I50ahEjuFiRCCes7cKNGJsTnRAqdZME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXQH26XmxGhsUXZRO/MJl6Xy3GLTVkS449YVj/Jd4XNx3uRy1l8JjyNdGHvaNktsLegmYY/gwBw5Hrf+pA7PIWaPi1n1TjhO8UuR/l6uO7p58p0bYqQ1AQYrMF8dpxFwlvKe0QCNkWHTHuNUZ1BWQdiorGaB+hVBszPto4tfAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IOCmCByh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B8FC4CECD;
	Wed,  6 Nov 2024 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896648;
	bh=v44Fwm6U9pv4I50ahEjuFiRCCes7cKNGJsTnRAqdZME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOCmCByhwbq/rh3xjrMUcFD+yZ0s3wQH0iMZpkWmYE78kFd17ZSY5C5+UvGD1W6UD
	 Il8g5ehcRrWbaxPOE8xq/gVudyNioSwFNkzWSNeFSQXEG/7pYYoSBotOhRosnW1+dt
	 JmqqnDYpaZx7mEtxRLnK9FYHHc2UMtIuNmi3F3WU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 026/110] exec: dont WARN for racy path_noexec check
Date: Wed,  6 Nov 2024 13:03:52 +0100
Message-ID: <20241106120303.893068466@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
References: <20241106120303.135636370@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6e5324c7e9b69..7144c541818f6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -144,13 +144,11 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
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
@@ -919,16 +917,16 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
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
@@ -938,7 +936,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (name->name[0] != '\0')
 		fsnotify_open(file);
 
-out:
 	return file;
 
 exit:
-- 
2.43.0





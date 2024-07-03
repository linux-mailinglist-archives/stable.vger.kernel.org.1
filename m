Return-Path: <stable+bounces-57131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D0925F33
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064D7B33775
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83117C9F3;
	Wed,  3 Jul 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FA4bGthe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DB61FE7;
	Wed,  3 Jul 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003941; cv=none; b=lWcmCS+nykn+dw/PkDkCA8yfp6nQQVS1LR9BhH/JTXqsfMyv+7yh6x8sMuRqZDOBvaQm0aFA604rN2/Eph+PeoRjadRdjh0FWzrE8wBhNUGMGgBNcZ7lKQEQg9WtEei9pWM/ZsCuAMSH0p5DVICChZBaoor+WXEk6uYnNmu+0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003941; c=relaxed/simple;
	bh=LklP16jw2Mkla9bjvvOUVvb7GD4vX5Mn0cQAsS2wTR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsdimGi0Uwuy5DzQ2AcOa0rBn+oViu8b2GDPrYGrUoYUFJxO0HYT127DN+AbgZsPbRR+hgA6pG16DEssy1705ywW8ntKltnhl5qCcZMXpQyHmAflwNImiq4SDwuFhKl718ZoK0y0fjU0Fmr7uI0LnqCX+vt2DisuDN0yDgwBSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FA4bGthe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779EC2BD10;
	Wed,  3 Jul 2024 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003941;
	bh=LklP16jw2Mkla9bjvvOUVvb7GD4vX5Mn0cQAsS2wTR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FA4bGtheuHFWn/pJjWDjsmqbeI3C/lWneiQHQ6sQbgEToiQTR+Z/SPsMqvbgCnTwZ
	 2nkMj1KKB3iO2F16BU7pLMY5HyI9qfX50xigmoVA0mD9XJYZr0SDRZAeGlDt9dkKAB
	 jkCiOELCG1OlYkohZDkvSULGgIi3IEzx35YNsXig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Yue <glass.su@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 072/189] ocfs2: use coarse time for new created files
Date: Wed,  3 Jul 2024 12:38:53 +0200
Message-ID: <20240703102844.225166658@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Yue <glass.su@suse.com>

commit b8cb324277ee16f3eca3055b96fce4735a5a41c6 upstream.

The default atime related mount option is '-o realtime' which means file
atime should be updated if atime <= ctime or atime <= mtime.  atime should
be updated in the following scenario, but it is not:
==========================================================
$ rm /mnt/testfile;
$ echo test > /mnt/testfile
$ stat -c "%X %Y %Z" /mnt/testfile
1711881646 1711881646 1711881646
$ sleep 5
$ cat /mnt/testfile > /dev/null
$ stat -c "%X %Y %Z" /mnt/testfile
1711881646 1711881646 1711881646
==========================================================

And the reason the atime in the test is not updated is that ocfs2 calls
ktime_get_real_ts64() in __ocfs2_mknod_locked during file creation.  Then
inode_set_ctime_current() is called in inode_set_ctime_current() calls
ktime_get_coarse_real_ts64() to get current time.

ktime_get_real_ts64() is more accurate than ktime_get_coarse_real_ts64().
In my test box, I saw ctime set by ktime_get_coarse_real_ts64() is less
than ktime_get_real_ts64() even ctime is set later.  The ctime of the new
inode is smaller than atime.

The call trace is like:

ocfs2_create
  ocfs2_mknod
    __ocfs2_mknod_locked
    ....

      ktime_get_real_ts64 <------- set atime,ctime,mtime, more accurate
      ocfs2_populate_inode
    ...
    ocfs2_init_acl
      ocfs2_acl_set_mode
        inode_set_ctime_current
          current_time
            ktime_get_coarse_real_ts64 <-------less accurate

ocfs2_file_read_iter
  ocfs2_inode_lock_atime
    ocfs2_should_update_atime
      atime <= ctime ? <-------- false, ctime < atime due to accuracy

So here call ktime_get_coarse_real_ts64 to set inode time coarser while
creating new files.  It may lower the accuracy of file times.  But it's
not a big deal since we already use coarse time in other places like
ocfs2_update_inode_atime and inode_set_ctime_current.

Link: https://lkml.kernel.org/r/20240408082041.20925-5-glass.su@suse.com
Fixes: c62c38f6b91b ("ocfs2: replace CURRENT_TIME macro")
Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -558,7 +558,7 @@ static int __ocfs2_mknod_locked(struct i
 	fe->i_last_eb_blk = 0;
 	strcpy(fe->i_signature, OCFS2_INODE_SIGNATURE);
 	fe->i_flags |= cpu_to_le32(OCFS2_VALID_FL);
-	ktime_get_real_ts64(&ts);
+	ktime_get_coarse_real_ts64(&ts);
 	fe->i_atime = fe->i_ctime = fe->i_mtime =
 		cpu_to_le64(ts.tv_sec);
 	fe->i_mtime_nsec = fe->i_ctime_nsec = fe->i_atime_nsec =




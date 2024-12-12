Return-Path: <stable+bounces-101035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9E9EEA39
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613CA16AAE4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E321578E;
	Thu, 12 Dec 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pj1DrslM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F62080FC;
	Thu, 12 Dec 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016031; cv=none; b=lZtBZU1ETZEQEys2ybRj6FS7Up6PPteYqyXyZP3m/xgAJ07yjo8SwXoZMF3b4hvUDc2SuFKapc3jwr2an8g8mwtecJ/LyTSdez4vkZhRzOzxwnnYn64yNdxkaD7fceVdz4vQlMoBhlYYbwifShc1JI8ArLQb2yLjqKy8zsFF/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016031; c=relaxed/simple;
	bh=ZNc2fwIO5rzVsdMc1wj8eHUCYGRcFqapnuMzHBXmPp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpuoL+v+/+sXEkotBM9e2jDvWpuPZD3CkK8u9Ir3IwX0zQwpGHHIqx/DQFt/CKJnkBfcqVhTtpDsGX/vv/qJ6EK0gEUz/4TjowUHlnefylL9dVqGpAmnJRqOMKMbp+Z3Mmn+/8KzUViiq0ADh5XuU8qF5aRzNHoW8bSYCtzfbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pj1DrslM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F12BC4CECE;
	Thu, 12 Dec 2024 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016031;
	bh=ZNc2fwIO5rzVsdMc1wj8eHUCYGRcFqapnuMzHBXmPp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pj1DrslMA87JJEJOaueEAsGjajoRo93Bnd+UQZy04h9RXxaDgcGFvC0MCzqFqW5NQ
	 ljSq+ERXJfkha35Ge41F4ZgApMtn0OqUgaaFm9VK5HRA9t+DkMfI5CgfNhy73ZGdDU
	 yKhvtItc3sokzIRCwKMAKTfvB49ie9DLqfsCV05Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 112/466] ocfs2: free inode when ocfs2_get_init_inode() fails
Date: Thu, 12 Dec 2024 15:54:41 +0100
Message-ID: <20241212144311.243393303@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 965b5dd1894f4525f38c1b5f99b0106a07dbb5db ]

syzbot is reporting busy inodes after unmount, for commit 9c89fe0af826
("ocfs2: Handle error from dquot_initialize()") forgot to call iput() when
new_inode() succeeded and dquot_initialize() failed.

Link: https://lkml.kernel.org/r/e68c0224-b7c6-4784-b4fa-a9fc8c675525@I-love.SAKURA.ne.jp
Fixes: 9c89fe0af826 ("ocfs2: Handle error from dquot_initialize()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
Tested-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 59c92353151a8..5550f8afa4380 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -200,8 +200,10 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	mode = mode_strip_sgid(&nop_mnt_idmap, dir, mode);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	status = dquot_initialize(inode);
-	if (status)
+	if (status) {
+		iput(inode);
 		return ERR_PTR(status);
+	}
 
 	return inode;
 }
-- 
2.43.0





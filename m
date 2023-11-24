Return-Path: <stable+bounces-637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C1F7F7BEC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E212821BF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73939FE3;
	Fri, 24 Nov 2023 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vUWMF2AY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4F39FEA;
	Fri, 24 Nov 2023 18:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83592C433C7;
	Fri, 24 Nov 2023 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849398;
	bh=iHuSRElPPdXTjPDd3eUMKRDHCJyFupMEphjLxS5wWHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vUWMF2AYwlBTSOHZmiDZykq9Lw3mKoCb3m/L2oBljANH6dxeCNFO/ODyBuePGkFxk
	 WpghQgm2eaEIYh15zsD17TwMllz4UBz9RHjQy8MXVvJo9RrRYQl3fGgXRMgtFNnvtE
	 2kuufNeGdQLPp/1/SnVkdPEfCJAD0ijW1QWfCDa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com,
	Marco Elver <elver@google.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 131/530] 9p/trans_fd: Annotate data-racy writes to file::f_flags
Date: Fri, 24 Nov 2023 17:44:57 +0000
Message-ID: <20231124172032.074280357@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Elver <elver@google.com>

[ Upstream commit 355f074609dbf3042900ea9d30fcd2b0c323a365 ]

syzbot reported:

 | BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | value changed: 0x00008002 -> 0x00008802

Within p9_fd_open(), O_NONBLOCK is added to f_flags of the read and
write files. This may happen concurrently if e.g. mounting process
modifies the fd in another thread.

Mark the plain read-modify-writes as intentional data-races, with the
assumption that the result of executing the accesses concurrently will
always result in the same result despite the accesses themselves not
being atomic.

Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/ZO38mqkS0TYUlpFp@elver.google.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <20231025103445.1248103-1-asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index c4015f30f9fa7..d0eb03ada704d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -832,14 +832,21 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		goto out_free_ts;
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
-	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	/* Prevent workers from hanging on IO when fd is a pipe.
+	 * It's technically possible for userspace or concurrent mounts to
+	 * modify this flag concurrently, which will likely result in a
+	 * broken filesystem. However, just having bad flags here should
+	 * not crash the kernel or cause any other sort of bug, so mark this
+	 * particular data race as intentional so that tooling (like KCSAN)
+	 * can allow it and detect further problems.
+	 */
+	data_race(ts->rd->f_flags |= O_NONBLOCK);
 	ts->wr = fget(wfd);
 	if (!ts->wr)
 		goto out_put_rd;
 	if (!(ts->wr->f_mode & FMODE_WRITE))
 		goto out_put_wr;
-	ts->wr->f_flags |= O_NONBLOCK;
+	data_race(ts->wr->f_flags |= O_NONBLOCK);
 
 	client->trans = ts;
 	client->status = Connected;
-- 
2.42.0





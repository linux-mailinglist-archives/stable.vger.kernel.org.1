Return-Path: <stable+bounces-108488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE09A0C01C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9111884450
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CA1FA252;
	Mon, 13 Jan 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdWxnJW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FD1FA243;
	Mon, 13 Jan 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793309; cv=none; b=jObL31tBLrG9iNIw1LNPZxKVgeZyoWfuDPjCdvoNzBVc3KDsCmhu4Fdug1EQUQuebpi9HrCXlzkxDBh5RQ8y0ra+gu9bFyPj8q4+D1SSTj7Uyo794T8ODF41E+mqQcXaDlHeQP2kwlGhET1rMjEFELOU4/wGUvag5R6ho20BuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793309; c=relaxed/simple;
	bh=7vSgLRPXc4F0intZyXUNvaHvnTlo04HUBqKOi5D/r80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS6NTrZ2mlis74wW9rJA65R4bOscZFOXCb/pi3VzOsndtcxVUXS+JpTeLS8T1vgzoYkxzLH1P4SLd7sH5oIjPWZUK8kLEIUfzOVQpBKAwd4ayUgHwJI28ecf6k2skj2BaQl8tITm3AFWNYpLR2ponaS0EeuHHs+kovrAj6CJC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdWxnJW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B57C4CEE7;
	Mon, 13 Jan 2025 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793308;
	bh=7vSgLRPXc4F0intZyXUNvaHvnTlo04HUBqKOi5D/r80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdWxnJW1EnusZzh5rYaYdWq5+cVGUD3WhA081mFXDCmbS1BXFxb8pEY772hV103jh
	 ZXHkIL+Y9/5TResp1rXFzYNhLimhR0TjrrEEiGnSnOVq1+mMqAl3xuQyXMc5zQZtnl
	 Jmd99u/h7ht5ECfiYK/3U7AzncMvgegD3uGnWbNeY3lglTGxBUL4hwZOstIOWT/XIM
	 2D/+MGVpQRFxeOOXnUDeh/Mge4oIMSvVHBi6qICBinOlv7iiOIL5Q31hMwFR4SgNGt
	 yzeKPmcIkN2IMj8sMKOq1kqdkdfmQHN3wYwaI6bZW5Po97tYyewzYIv+5ppjzngj7D
	 xqbOzH5ozrEag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+76f33569875eb708e575@syzkaller.appspotmail.com,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 19/20] afs: Fix merge preference rule failure condition
Date: Mon, 13 Jan 2025 13:34:24 -0500
Message-Id: <20250113183425.1783715-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 17a4fde81d3a7478d97d15304a6d61094a10c2e3 ]

syzbot reported a lock held when returning to userspace[1].  This is
because if argc is less than 0 and the function returns directly, the held
inode lock is not released.

Fix this by store the error in ret and jump to done to clean up instead of
returning directly.

[dh: Modified Lizhi Xu's original patch to make it honour the error code
from afs_split_string()]

[1]
WARNING: lock held when returning to user space!
6.13.0-rc3-syzkaller-00209-g499551201b5f #0 Not tainted
------------------------------------------------
syz-executor133/5823 is leaving the kernel with locks still held!
1 lock held by syz-executor133/5823:
 #0: ffff888071cffc00 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff888071cffc00 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: afs_proc_addr_prefs_write+0x2bb/0x14e0 fs/afs/addr_prefs.c:388

Reported-by: syzbot+76f33569875eb708e575@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=76f33569875eb708e575
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241226012616.2348907-1-lizhi.xu@windriver.com/
Link: https://lore.kernel.org/r/529850.1736261552@warthog.procyon.org.uk
Tested-by: syzbot+76f33569875eb708e575@syzkaller.appspotmail.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/addr_prefs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index a189ff8a5034..c0384201b8fe 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -413,8 +413,10 @@ int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
 
 	do {
 		argc = afs_split_string(&buf, argv, ARRAY_SIZE(argv));
-		if (argc < 0)
-			return argc;
+		if (argc < 0) {
+			ret = argc;
+			goto done;
+		}
 		if (argc < 2)
 			goto inval;
 
-- 
2.39.5



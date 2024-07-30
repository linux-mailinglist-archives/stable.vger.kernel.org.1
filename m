Return-Path: <stable+bounces-62802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1294127E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BC31C23030
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAA1AB511;
	Tue, 30 Jul 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHCRxbT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989F1AB50B;
	Tue, 30 Jul 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343617; cv=none; b=MdRE7dG0TQkqJvoq2P8cBpP2ZP1+36tJX9xB4VLoqxOC8ouGMQqVKSGmfnuDYEYH6mief200FkaBwTsPlHBUK85RmQszVVEzxYyyvqHKfh65yvF0wk/nDXESWWa09nW0YShqPlCrTGE8iZGkpIePbejqhiiTs0af8jP6bRqs0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343617; c=relaxed/simple;
	bh=GsOxEgMiKFM8yffjBP82pniK0TTBUEQVPH2N1h8+Nik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpEpm6HPHM7pHfu1p6Wbfll+T1Q3TPsVdK6O7GAZ+bmYw/aFP2tGoNjpHr1pkaDQU7bZMABj/gKbvE2Ywg2k96DY5ZZBNwSvleIzPJ9q5CXrvfE388X7WuZ4AKFtr/jjOkTrIfaS2V3XuWWEPI3IagotNubtgW4LhnBBvAIhO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHCRxbT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA3C32782;
	Tue, 30 Jul 2024 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343617;
	bh=GsOxEgMiKFM8yffjBP82pniK0TTBUEQVPH2N1h8+Nik=;
	h=From:To:Cc:Subject:Date:From;
	b=MHCRxbT0Le1M/2FrDBuPYvL+0CPyt59iaL1ty00HTmmSF5ggJQjPZ22VpVKgXBajX
	 lSoH15WVDcC+YJRiVbANNQFMe7LFiNMKmF3W9PYUSbGSF5MPO+CenY8746jgOE39/8
	 f7LAktU8W4D+QVF1bO7nhlfMTPdQUSLxGxcpHo0N6Hqt2aS45jVk+PHaYZyHA2WBmq
	 0NPRJC0xhyODvd4049CYKS0B9KpAk51/XCRhoP4wdctdf0YbhskeH67ORwYNvUlEkz
	 uas+a++IGo6ep5OHjz7eIHMFoziWGj7Ma8yfMUtcgDJAwLWMFBbm16teWXakHIB760
	 SRb9AHzG++nlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	osmtendev@gmail.com,
	ghandatmanas@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 1/2] jfs: fix null ptr deref in dtInsertEntry
Date: Tue, 30 Jul 2024 08:46:48 -0400
Message-ID: <20240730124654.3100568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ce6dede912f064a855acf6f04a04cbb2c25b8c8c ]

[syzbot reported]
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5061 Comm: syz-executor404 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:dtInsertEntry+0xd0c/0x1780 fs/jfs/jfs_dtree.c:3713
...
[Analyze]
In dtInsertEntry(), when the pointer h has the same value as p, after writing
name in UniStrncpy_to_le(), p->header.flag will be cleared. This will cause the
previously true judgment "p->header.flag & BT-LEAF" to change to no after writing
the name operation, this leads to entering an incorrect branch and accessing the
uninitialized object ih when judging this condition for the second time.

[Fix]
After got the page, check freelist first, if freelist == 0 then exit dtInsert()
and return -EINVAL.

Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ea2c8f0fe832c..0c16f7f8eaa2b 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -847,6 +847,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
-- 
2.43.0



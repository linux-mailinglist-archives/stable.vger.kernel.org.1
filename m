Return-Path: <stable+bounces-62800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE1941278
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E1C283944
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BB1A0720;
	Tue, 30 Jul 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZq0zdSw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AA1A071A;
	Tue, 30 Jul 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343606; cv=none; b=SN6zWRnowTQZpRHksH1mGLGL7Y3gV44u8cyWNHGu7DzQhduL3idVDk1Flflvg3vfPzuOwImXo42XqtD7ClOn5KLySKxbqzp0TTrJcQCzTrONfV2n7/MypqTCEJqvjGksymvCOmP27/Dx+/ASNBsE3Q/yyvxz1SnKDGPBNWQT8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343606; c=relaxed/simple;
	bh=QgpRP8PQLQZI+6MroDtH80z9AM5Jgo/I072EToxnGtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWuZLgj9vURRHdWuIuKG/oTo10cDJi/QaYP0J5ihI6Iv8o2x27g0PDZ50T5gY1btwxrdLeAJ/eKhLcP/bOEiR5Vrow8FtR1K6iXnXmx07FcwxWk1vzuNhlCdNuGpha5CwJR8ipz1r0qyef9lQIPjd7TXAhCW36mXLR8mGtMUM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZq0zdSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D1C32782;
	Tue, 30 Jul 2024 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343605;
	bh=QgpRP8PQLQZI+6MroDtH80z9AM5Jgo/I072EToxnGtU=;
	h=From:To:Cc:Subject:Date:From;
	b=QZq0zdSwTSYD3iS+d97cjr0sYWDS5wleuzrXM2U40iIXp1AL/XDvScRYaQx0NGrLa
	 Y2o3gR/SUAnKyck/eN8JLAQyjI9flZvfOCxUcX1pgx/zj5u4pn3YKjD0P9gWz9TOR/
	 1KwA3xbyH7+AIO6eAsq77lN1Z6s8WjywaXgWWsrh9BLd7MQGBPMbZltAp5gNRKkrz4
	 VTenh7SqxBQ9jEjhTQKV+crd64XiRpWdCwhLlZqYCVrb8gYYbxAZUILx1rwxnaKXK5
	 DXas39UEwTCASmuQLKJoX4EpeGaWVG1fUk1z0yQ8ZUP5SByJy26KaXVsNMbKLQGoE5
	 yGGJo9GRrxWmw==
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
Subject: [PATCH AUTOSEL 5.4 1/2] jfs: fix null ptr deref in dtInsertEntry
Date: Tue, 30 Jul 2024 08:46:37 -0400
Message-ID: <20240730124643.3099670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 077a87e530205..3bcfb37a9c1f6 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -834,6 +834,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
-- 
2.43.0



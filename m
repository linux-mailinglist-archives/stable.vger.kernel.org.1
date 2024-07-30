Return-Path: <stable+bounces-62795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0B941263
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE821C22CAF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F91A3BC8;
	Tue, 30 Jul 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uztncz+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B51A3BBF;
	Tue, 30 Jul 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343582; cv=none; b=Mk3Z6OkGlXUH+LMZWYa35poA6oF/YAYcOCiQW7uMQYbxU4qEqHrRMoEciTtwmbSuSZPKxdC60q+HnJGpNW5Zfzm3duT8Lw2ro/9D35YlAPHRS7Y1Eijxkca57zGtFPc+zxdG+U+3otkRSO3Ef9B+T1+rc6G4QrIrBnEmEv+TnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343582; c=relaxed/simple;
	bh=KDk4BTh7VK6rZwrO8HCpw526Tu7LvLPgUh20AE/sGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYOvXkf774rwC466MFztd1hm5aZ0yU1zA5umM/qW6jELXUE5r4W/T+euG0pVFrl+080kp8WszFEm9YhXQycGsXhqhKAdVCYK+mVUvZBKqSN6lFtCzOM5oISWHbDy3rmDmy0jNy7RvbL8lpjtYzyDd37mm+VmknKc1I0OnwLoa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uztncz+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F03AC32782;
	Tue, 30 Jul 2024 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343581;
	bh=KDk4BTh7VK6rZwrO8HCpw526Tu7LvLPgUh20AE/sGB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uztncz+/moiidG51YSOAr5JbqeOsSsVieLsAxKcrjDaMQpn2xImuTObPk5sE2GQpk
	 716xyXjjtrLBdfI/f2lTrPWWWQFIGlOKsY9+ORpodWAFxhAydf7qxDO9pSPeXAQFuO
	 sLYpZoETe8o/7wQUqdcswGCXwZfff++UgIh1fF7um3l3f6C7B2Zr/tmDTCtYVqUFN1
	 vLEv5bd9Iuoc9Nlg+LORKNAwmgFnzZ+lx3zek3BwBbjQlUOqOBOCI/OvZ6VB0MdFdb
	 QqaZA0p0njxue0lS7JK/ixa+B4erhvrnbf1241aKqUMM0m49/Dwtzh7a7tCqOdQlAS
	 Ru9Wzv4BA2g5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	osmtendev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 2/3] jfs: fix null ptr deref in dtInsertEntry
Date: Tue, 30 Jul 2024 08:46:11 -0400
Message-ID: <20240730124616.3097556-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124616.3097556-1-sashal@kernel.org>
References: <20240730124616.3097556-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index a222a9d71887f..defa82acb432c 100644
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



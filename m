Return-Path: <stable+bounces-62788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04ED941255
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8881F244E8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCA1A00CE;
	Tue, 30 Jul 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEjy4JjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A41A00D4;
	Tue, 30 Jul 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343553; cv=none; b=DEoLUNmf3fGc0Zbzvd+vWv5b3X9S0TzrxNanPP/qyp2OlXuAZ8720mdiTFGTNhzno81tBvFj3dprVR3aq/1ZxvPWE+z0OtjqkCoWIW/A6PieBDbKyJOr+AvL0YrnGbW126hgjMTEzt7X+l7nRA3wRpgjqe9ho1ntYTuYDczzG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343553; c=relaxed/simple;
	bh=MVz/znc9I233RgIM9zDHWcICToeODo3lTIKp9s5T8N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMLMFUtrCWsEFOrWbKCN5UuS7vd+d8KMQtY2iK9909yQhNIq0NNogxjL9rwgdg62cN10J6JgMJiVBqayJM5k+N+IOSQwZHx0tMYvgtlmaGP75M8q7eZeQiPCbALV4WmTpRUrga8p5eXN9VaTQg3+Jr1tBdAYZO5aok4AhfTubI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEjy4JjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F704C4AF0A;
	Tue, 30 Jul 2024 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343553;
	bh=MVz/znc9I233RgIM9zDHWcICToeODo3lTIKp9s5T8N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEjy4JjQTw5cJTiui8/BHM9eV+6tdadhjXlLg5ZaYkbFbFI4/CdF2vuouLG6acr/Z
	 lYa05AchDidLpEuOvEXzEtLbN6lVjQSlZ3Gp9oTNXVWw5G5Adgs0MlENFhrF4ZBOwX
	 qYsAMeHihnQxGiIzw8jQ8XTwTv72FiaYGAnKknsoiZ+NHSnWM8c2zzQvFUrhc7mTs1
	 Y4h75LQPbpLSH/fBXc2CIhFHe2gk48/otAdqucCioLr7qZJVg+WMOK/JAXM13wvleb
	 /9049C+P/F8UUHAp/uOBB9AJ9eTT/aik1nM3LMRF5eRNGXVEi0ALmGwshfsRRiqD2M
	 HJdcolMD1BvLg==
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
Subject: [PATCH AUTOSEL 6.6 5/7] jfs: fix null ptr deref in dtInsertEntry
Date: Tue, 30 Jul 2024 08:45:35 -0400
Message-ID: <20240730124542.3095044-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124542.3095044-1-sashal@kernel.org>
References: <20240730124542.3095044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 031d8f570f581..5d3127ca68a42 100644
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



Return-Path: <stable+bounces-159848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB0AF7AF6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787E74E4901
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBECF2F0045;
	Thu,  3 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIstWSOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D21E9B3D;
	Thu,  3 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555548; cv=none; b=vBZiZSZj9XY4PtkAAT6thD1st8Th3ShO5BdeXzHx2w+gvIUB1fNXLloBWBmGwxEfINznrfrhwxYCNK6dTpcVqjHOIju/SAobICLa8gf7Klpg951vuL0QwAIWMjgYh3z8JLqGIhvHrNWlmDyP5L/2h2i96dAW0QNmMCroyRy4VZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555548; c=relaxed/simple;
	bh=iTSZ2JdzhI4fqeH/56aDENO83Kh7wsbeADphdGmwNu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfxrt6Tzr415wLoWm+EDxbPEJlQPUQRCXVHYqyqJMH5Ce7Yh6k6/tffbf2ZSgUJo+Q3OKN8xHVreTjoDvs5xiRF+3ukYp0wSdOxV0mC7/oLhNuKSQxOuUf3gyje54gXVaxpMdHpNkrHjLOrCTR8KFTYBOHUxFBMdJFiph+iY0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIstWSOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94EEC4CEE3;
	Thu,  3 Jul 2025 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555548;
	bh=iTSZ2JdzhI4fqeH/56aDENO83Kh7wsbeADphdGmwNu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIstWSOVsmp0jmbQ5KaicgP0kGCrgFImxIiv1eNj5R2x0X72skiDZk9a3/lIZ44Lj
	 t/5ef+fuz+PLksnJbciXimUZ9z2jIVaOVOFFDtId7WFlOi1JGII/oUTYyO88cyXpWY
	 KI8xBUM4yeWjLI5mYIYFJH+7sfT0BWn+qmlb0vOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+fe8264911355151c487f@syzkaller.appspotmail.com,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 048/139] jfs: validate AG parameters in dbMount() to prevent crashes
Date: Thu,  3 Jul 2025 16:41:51 +0200
Message-ID: <20250703143943.050182256@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 37bfb464ddca87f203071b5bd562cd91ddc0b40a ]

Validate db_agheight, db_agwidth, and db_agstart in dbMount to catch
corrupted metadata early and avoid undefined behavior in dbAllocAG.
Limits are derived from L2LPERCTL, LPERCTL/MAXAG, and CTLTREESIZE:

- agheight: 0 to L2LPERCTL/2 (0 to 5) ensures shift
  (L2LPERCTL - 2*agheight) >= 0.
- agwidth: 1 to min(LPERCTL/MAXAG, 2^(L2LPERCTL - 2*agheight))
  ensures agperlev >= 1.
  - Ranges: 1-8 (agheight 0-3), 1-4 (agheight 4), 1 (agheight 5).
  - LPERCTL/MAXAG = 1024/128 = 8 limits leaves per AG;
    2^(10 - 2*agheight) prevents division to 0.
- agstart: 0 to CTLTREESIZE-1 - agwidth*(MAXAG-1) keeps ti within
  stree (size 1365).
  - Ranges: 0-1237 (agwidth 1), 0-348 (agwidth 8).

UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1400:9
shift exponent -335544310 is negative
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor130 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbAllocAG+0x1087/0x10b0 fs/jfs/jfs_dmap.c:1400
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x45a/0x6b0 fs/jfs/jfs_discard.c:105
 jfs_ioctl+0x2cd/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+fe8264911355151c487f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fe8264911355151c487f
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 26e89d0c69b61..35e063c9f3a42 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -194,7 +194,11 @@ int dbMount(struct inode *ipbmap)
 	    !bmp->db_numag || (bmp->db_numag > MAXAG) ||
 	    (bmp->db_maxag >= MAXAG) || (bmp->db_maxag < 0) ||
 	    (bmp->db_agpref >= MAXAG) || (bmp->db_agpref < 0) ||
-	    !bmp->db_agwidth ||
+	    (bmp->db_agheight < 0) || (bmp->db_agheight > (L2LPERCTL >> 1)) ||
+	    (bmp->db_agwidth < 1) || (bmp->db_agwidth > (LPERCTL / MAXAG)) ||
+	    (bmp->db_agwidth > (1 << (L2LPERCTL - (bmp->db_agheight << 1)))) ||
+	    (bmp->db_agstart < 0) ||
+	    (bmp->db_agstart > (CTLTREESIZE - 1 - bmp->db_agwidth * (MAXAG - 1))) ||
 	    (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) ||
 	    (bmp->db_agl2size < 0) ||
 	    ((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
-- 
2.39.5





Return-Path: <stable+bounces-154947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CE0AE150E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B514A48D1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB5227E90;
	Fri, 20 Jun 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vHX6ngnD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A123227B87
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404936; cv=none; b=eOg9/HVpUBUCk+6QMtI7R+nPFXZnWfo9FPLLNUMefrLMuvWDQjgvy1XCHlF4INh6JksUd0pqutx6c+FtYa1HcGtz19IXwpuXGk//W0i/vcbz2Fdxgc8nSyJ4q+LX4nLJdN8hxalRFXAz4LYTe983Rb3raNJ0BGJ8R/dRdWbOIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404936; c=relaxed/simple;
	bh=V9bbzWkfE9OcfVvToCIrSTepAE/FheNhhw1OZQXYCLE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pXtO0XpIxTQx2bLTrjDHI1/QCm7RCMNrKDPQTPc+H/PgQ7gVu718nGQpOKzYLohqDOhyByqifHp+Jwl/7loMaPZnsxvGkasHcUTZNHep41hqaHNDHIZgFIc9gdRQLlCQb3uibV7X0FRYH4poOSZXN8dmfX5DOsT52ZeWpFXU29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vHX6ngnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8EBC4CEE3;
	Fri, 20 Jun 2025 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750404936;
	bh=V9bbzWkfE9OcfVvToCIrSTepAE/FheNhhw1OZQXYCLE=;
	h=Subject:To:Cc:From:Date:From;
	b=vHX6ngnDnZZ7FSp8sSk293rZpt1xmafQqJV2oZv7M5Q5AMMdpeIZSNMuflUGTmnbX
	 jn+05osPfz7Hpz3En0w+FDJkzdkd6KNgFV5dviRBqudERPlVrawkRnoT8lh53Oj1PU
	 P0TkDn4ZODCcbISs4JgJ+OuQfRZicK6A9kq+6WsM=
Subject: FAILED: patch "[PATCH] jfs: validate AG parameters in dbMount() to prevent crashes" failed to apply to 5.4-stable tree
To: kovalev@altlinux.org,dave.kleikamp@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:35:20 +0200
Message-ID: <2025062020-trace-goggles-c401@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 37bfb464ddca87f203071b5bd562cd91ddc0b40a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-trace-goggles-c401@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37bfb464ddca87f203071b5bd562cd91ddc0b40a Mon Sep 17 00:00:00 2001
From: Vasiliy Kovalev <kovalev@altlinux.org>
Date: Mon, 10 Mar 2025 11:56:02 +0300
Subject: [PATCH] jfs: validate AG parameters in dbMount() to prevent crashes

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

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 26e89d0c69b6..35e063c9f3a4 100644
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



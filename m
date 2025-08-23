Return-Path: <stable+bounces-172540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD0B3267E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69970566125
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB620B1E8;
	Sat, 23 Aug 2025 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crc3nrVn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689419E97B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917414; cv=none; b=lBo0H9zuPBoSmlVdWcqTDExznFXC/DFURrdvUFSxcOmxHXASr25Ho/4UU8uylNRKpe5Edp3MdgPjLhWTVn3jf4nXAashIayWKTjx8Uxo9EYRkbEke8rjkYlULs7LSoXnIgluD7E6l2ONBrNcnnOStZQzknDtvHPx0nGxTmdJQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917414; c=relaxed/simple;
	bh=LrMMrQTj/RgUP3cabRQKKNt68duzBKXZ9bBFBUnEm9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NslNyVa/DeWbownDxddIDHGtsf2pgbEJWdZDWTofDIVfGtQqo+pGrja81B36cTv23l0OKjPjMJohsTJ0dNyE71UIou5T9PISEijHCe0sWtCwmoKZ562QPwJezxAo+G16BPZHVo+d02yyECBe4+5M2x0LL7nl5bDam6y7MAHr6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crc3nrVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9688AC113D0;
	Sat, 23 Aug 2025 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755917414;
	bh=LrMMrQTj/RgUP3cabRQKKNt68duzBKXZ9bBFBUnEm9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crc3nrVnz0Z4eSs9KYJfkNd2aOhIzEv33nPRUFjr3XuWWECJN8acerY/ed6jqvntB
	 tQa0nbJXsofjmMRUOI2vpkL5q0rWEERoLp9XqYmU6V/TBwMvVDX1O2EJhNRdB3t1uF
	 Zjx+LO6P+o+IRb4zR82fHQC6bHS2JhNtVpciFPJNXzjLq2zjTn78vVsJdHXbNdPJbX
	 w5rNbLmUCH2aG3HfYwxfaiFiNjgKm14by98CMK3lgAPV2SAKAs/SXYaI8ZyDy3/dky
	 8vNJzAGH98A+bAcG3sP15iKH59CBsRuAdz0wli810Tm3xr/EmuDQ+hk29ILN1IC9yR
	 u7lRgooe/0Y9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jiaming Zhang <r772577952@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] f2fs: fix to avoid out-of-boundary access in dnode page
Date: Fri, 22 Aug 2025 22:50:09 -0400
Message-ID: <20250823025009.1694095-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823025009.1694095-1-sashal@kernel.org>
References: <2025082107-suitcase-motivator-6687@gregkh>
 <20250823025009.1694095-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 77de19b6867f2740cdcb6c9c7e50d522b47847a4 ]

As Jiaming Zhang reported:

 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x17e/0x800 mm/kasan/report.c:480
 kasan_report+0x147/0x180 mm/kasan/report.c:593
 data_blkaddr fs/f2fs/f2fs.h:3053 [inline]
 f2fs_data_blkaddr fs/f2fs/f2fs.h:3058 [inline]
 f2fs_get_dnode_of_data+0x1a09/0x1c40 fs/f2fs/node.c:855
 f2fs_reserve_block+0x53/0x310 fs/f2fs/data.c:1195
 prepare_write_begin fs/f2fs/data.c:3395 [inline]
 f2fs_write_begin+0xf39/0x2190 fs/f2fs/data.c:3594
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 f2fs_buffered_write_iter fs/f2fs/file.c:4988 [inline]
 f2fs_file_write_iter+0x1ec8/0x2410 fs/f2fs/file.c:5216
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x546/0xa90 fs/read_write.c:686
 ksys_write+0x149/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x3d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is in the corrupted image, there is a dnode has the same
node id w/ its inode, so during f2fs_get_dnode_of_data(), it tries to
access block address in dnode at offset 934, however it parses the dnode
as inode node, so that get_dnode_addr() returns 360, then it tries to
access page address from 360 + 934 * 4 = 4096 w/ 4 bytes.

To fix this issue, let's add sanity check for node id of all direct nodes
during f2fs_get_dnode_of_data().

Cc: stable@kernel.org
Reported-by: Jiaming Zhang <r772577952@gmail.com>
Closes: https://groups.google.com/g/syzkaller/c/-ZnaaOOfO3M
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ccc72781e0c6..ec84bb7c31bf 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -797,6 +797,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
-- 
2.50.1



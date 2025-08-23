Return-Path: <stable+bounces-172553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16899B326C8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 06:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54925668F7
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B1217F2E;
	Sat, 23 Aug 2025 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMSzg+9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7901F463F
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755922241; cv=none; b=Yhi85IPNj2WMQ2aE/mZhz/i6nMLRtcwP2p/K1gzzD0BTH0uVmqwbS49dcBkcohRySiLJ9DUZwZ2Tlv5Uas9cQkZBOOZU/mex0sMPtjtUocMLVembGg2S/ZnkTFVCdwTQjEkXkD52Al7MEQng/Nuy9n6oC81HXU24tsA3MCPSkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755922241; c=relaxed/simple;
	bh=rvBp5FFp7Hm6ANOph6R1oQCizFlYD19B6PDOYa7y0hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGPMDyXWKdCb3n44VvGJWF5nwcx6sh9PgN+naV1eev4J2ypgBcFXg2mvDccaaFC7JA6GsdvW1GmrhPrfoJD2yd31Z+MsqfS7UcdlmqjUT5BjPwEpn2Svz1iJl7uj9gA+ine2NaesNMyzxa6q6QY3PPUvFUahycEp31XOwHXr920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMSzg+9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE3C113CF;
	Sat, 23 Aug 2025 04:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755922241;
	bh=rvBp5FFp7Hm6ANOph6R1oQCizFlYD19B6PDOYa7y0hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMSzg+9HkySx4nscSnMZSMRuY8nFnR6DcsC01hPljq8TSHpH+J4xPnGrEUaXBXQNX
	 5Ep1S1DkaQTewe6RqMkoBIO5TaR0+oLSZ+11mFREONM2TJfNQBAfCwVvJCN4xhPaMu
	 2z98EHwhUvhZCkHcgQOQReeUHDg08D/ZSz3PiB6Hsn4Lx3t+jVa/ZKamk0F4/0/TWd
	 QosQv68rQsO8kY36+sw+QRRWyn0AN0PBKN455VTVg+oNtKJSGzGwlkLD8zJ6RuXMWB
	 ypcgKhIK5kP7najPcRygpPHkwK/jUC88WF1Bh7MmXka3CA2GjXUn0eot4adNG+Lp7Q
	 jGcGcMd2hqACg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jiaming Zhang <r772577952@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to avoid out-of-boundary access in dnode page
Date: Sat, 23 Aug 2025 00:10:38 -0400
Message-ID: <20250823041038.1834302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082123-hemlock-starring-6459@gregkh>
References: <2025082123-hemlock-starring-6459@gregkh>
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
[ replaced f2fs_err_ratelimited() with f2fs_err() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 57baaba17174..1dddb65e249a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -760,6 +760,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
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



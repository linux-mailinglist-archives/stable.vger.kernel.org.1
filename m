Return-Path: <stable+bounces-132426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C65A87E28
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BCF3AC8AD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869F27CCCE;
	Mon, 14 Apr 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCtwJial"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1D27CCC6;
	Mon, 14 Apr 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628125; cv=none; b=WiYfe131dNPQy/MiDauVOMTtgn4HO9Ze7ltPzuvwcSTBXiBg38k7PQopKPQ8eOkRVdfpTr4fINv9nc7+wtHilcUkmAba0/v6y05tl1d5OaoNYyNRX6jG2opMvJkHx266PTsfFPdRTx+mSPFMIMnTvFdRjcznz4sBNgshSuxHkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628125; c=relaxed/simple;
	bh=sFL0SY01M0ooEAeGm2+7EY2DjKRjMJosXfbO3upoTZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3eOBjSOamQFZgfee/6XrKyObv8JWCIvKiQ1sV3S8R0uUEQKdHzXk42YgWHhIPoHg2CmUmG18ftjswf4HoEX2i7ic6aBAEenfNez+m5+X0hWXb140QQ9JfaQsaoHExwlWUKmbav1N3WVA1Zs661lMlRJqly8Di1A1sXMHUQ5+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCtwJial; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8850C4CEE5;
	Mon, 14 Apr 2025 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628125;
	bh=sFL0SY01M0ooEAeGm2+7EY2DjKRjMJosXfbO3upoTZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=PCtwJialYxjcGhDjswA24RqBthBGn8Hu88xXZqhpSWtXgeyqCI3IrLJHkhbEGBq/g
	 N6JplGA0xTImKlX6ldfmqjWbqsHObkpp/9A8E+LYX08WrE7nJzUNZeRA8E5G0JdEKi
	 DpFOjH6KOAArRIMqWJ1NPIo0jyjsG6ObR0t1RCy796OHBebGCKi5vc7ZB95spmUnOI
	 cqNEKNXX6vOdG/pmp8ueb9vqMctHGVMC5zjDHsDs/R6Sz51bcHVM0Nx4akZFEwSECV
	 uiQPpWa7+jClJ+bDTiXJN7KzGALPTHxhkBmFggtO6E3lS5a6NH8ibhihGwrxYIyERQ
	 ddH8IRUuN20eA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to do sanity check on sit_bitmap_size
Date: Mon, 14 Apr 2025 18:55:20 +0800
Message-ID: <20250414105520.729616-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w/ below testcase, resize will generate a corrupted image which
contains inconsistent metadata, so when mounting such image, it
will trigger kernel panic:

touch img
truncate -s $((512*1024*1024*1024)) img
mkfs.f2fs -f img $((256*1024*1024))
resize.f2fs -s -i img -t $((1024*1024*1024))
mount img /mnt/f2fs

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.h:863!
Oops: invalid opcode: 0000 [#1] SMP PTI
CPU: 11 UID: 0 PID: 3922 Comm: mount Not tainted 6.15.0-rc1+ #191 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f2fs_ra_meta_pages+0x47c/0x490

Call Trace:
 f2fs_build_segment_manager+0x11c3/0x2600
 f2fs_fill_super+0xe97/0x2840
 mount_bdev+0xf4/0x140
 legacy_get_tree+0x2b/0x50
 vfs_get_tree+0x29/0xd0
 path_mount+0x487/0xaf0
 __x64_sys_mount+0x116/0x150
 do_syscall_64+0x82/0x190
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fdbfde1bcfe

The reaseon is:

sit_i->bitmap_size is 192, so size of sit bitmap is 192*8=1536, at maximum
there are 1536 sit blocks, however MAIN_SEGS is 261893, so that sit_blk_cnt
is 4762, build_sit_entries() -> current_sit_addr() tries to access
out-of-boundary in sit_bitmap at offset from [1536, 4762), once sit_bitmap
and sit_bitmap_mirror is not the same, it will trigger f2fs_bug_on().

Let's add sanity check in f2fs_sanity_check_ckpt() to avoid panic.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index eb1275616d8c..8abfbee13204 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3716,6 +3716,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
+	unsigned int sit_blk_cnt;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3827,6 +3828,13 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	if (sit_bitmap_size * 8 < sit_blk_cnt) {
+		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
+			 sit_bitmap_size, sit_blk_cnt);
+		return 1;
+	}
+
 	cp_pack_start_sum = __start_sum_addr(sbi);
 	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
-- 
2.49.0



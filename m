Return-Path: <stable+bounces-52629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FC90C1C6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5662D1F21DA7
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C841865C;
	Tue, 18 Jun 2024 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ8kn9q2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3F1BC58;
	Tue, 18 Jun 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677417; cv=none; b=KZlgvlhvBIR7U5gKVeDy7AQFDpBCw0ZNAVuWQGmklWLMrja0D1mfSWYLDLbg7pwS1G5WiF4tAOjRXpYnPCyWsRQlz0ykaacFW/NiCPmwvdZhzw2KguxXM1qs6+K3wIidWP56l8zKRm0TtO+Pnj+d1L8AY/avyy89wCpgZW0DVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677417; c=relaxed/simple;
	bh=DPX6Yo3uKpQvU+s+OUpbimrmWAxi/0KqSd23VcY7cgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBvqV1vRhUuKTOEhKcKIL7pUgsNFvBAC6xdAATpoc/o/iaELn+d2kQd4aBAHFlJacKtcrxNSbBKHfUz/vp0K5TniTtc+DtkbLGYYf6md7dAYFwUKWnTKLy10i6aZ1fFAWUVNYt3WEq1imO6aHDAXdabajR8fj4Cv3P9ChK+3GsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ8kn9q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2558C2BD10;
	Tue, 18 Jun 2024 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718677416;
	bh=DPX6Yo3uKpQvU+s+OUpbimrmWAxi/0KqSd23VcY7cgU=;
	h=From:To:Cc:Subject:Date:From;
	b=pJ8kn9q2QdsmWTXpISZiAgAOalEzOy30BKEapBH7qcUQnn2ZF2wAk9Uqf06DhT6sc
	 JWCq7l0QRX3n/yKTgwDR266gR1tXhbZJrxg3E4179PrnvvKzfuHFhKNdmyHTN1wlF2
	 7GPwLezMeoxQXlJ/gsdDFU+3t4P9+vW8Q5dee8tCUFWRkNu2KwY34e2gAh4+bmPJdN
	 Qw6py0CeXbOX1LRqJXHm+/0BJ6Bg6a7XpyYSnuzexjG3aUHpr6kA3IrI8MzIZTarPS
	 jDSCYKkwQ/HEcJciWL7gVNuFjQlGJX2WFNDa6742T8qdArAccWJUrVZQ8TaDwbdghh
	 XmIPBTHgnAPBg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid
Date: Tue, 18 Jun 2024 02:23:34 +0000
Message-ID: <20240618022334.1576056-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkdir /mnt/test/comp
f2fs_io setflags compression /mnt/test/comp
dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
truncate --size 13 /mnt/test/comp/testfile

In the above scenario, we can get a BUG_ON.
 kernel BUG at fs/f2fs/segment.c:3589!
 Call Trace:
  do_write_page+0x78/0x390 [f2fs]
  f2fs_outplace_write_data+0x62/0xb0 [f2fs]
  f2fs_do_write_data_page+0x275/0x740 [f2fs]
  f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
  f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
  f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
  f2fs_write_data_pages+0x2d8/0x330 [f2fs]
  do_writepages+0xcf/0x270
  __writeback_single_inode+0x44/0x350
  writeback_sb_inodes+0x242/0x530
  __writeback_inodes_wb+0x54/0xf0
  wb_writeback+0x192/0x310
  wb_workfn+0x30d/0x400

The reason is we gave CURSEG_ALL_DATA_ATGC to COMPR_ADDR where the
page was set the gcing flag by set_cluster_dirty().

Cc: stable@vger.kernel.org
Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e8a4b332ad5..ce2300391031 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3484,6 +3484,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
+				__is_valid_data_blkaddr(fio->old_blkaddr) &&
 				!is_inode_flag_set(inode, FI_OPU_WRITE))
 				return CURSEG_ALL_DATA_ATGC;
 			else
-- 
2.45.2.627.g7a2c4fd464-goog



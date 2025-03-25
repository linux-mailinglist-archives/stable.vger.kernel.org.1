Return-Path: <stable+bounces-126585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A9A7070C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714723AC029
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC525D530;
	Tue, 25 Mar 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IFWRq18x"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046212E1CD;
	Tue, 25 Mar 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920361; cv=none; b=F5fJnrBoOukWxgA+Gsoaa0gdV64CMtbc7CRVE4UKlBcB2qF4eyv6CQrvOeStdJsGUjPEQKXGnePFBb4/8jzNAVPS+clb6jqReCK3P5i/eRBChKPfps2EFLyOhwIS0gbWpmqdopW035KlI4/S2J9gTxaOqw6jhyK4sCvYC8Pev2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920361; c=relaxed/simple;
	bh=vl9PHw3P9CnPqxmaj5vO84SgXuxPVC3cqOewI6IQ9AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZ6R3nInsLL1YOk8GNyhQgpywey2Mt5RmBMhyB3HllAr1V0q5rK6NViPWpMKnTNujOOdGj+hJl2IB26F7esC/0O9ImWta7Bt4imveruekcxSaAfJXcBqUkl4Vm/z13La/LaDA1m2Cu8vW8TlMRX/LRHNmsCyrqiwZAs0p0+lp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IFWRq18x; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4161C448787A;
	Tue, 25 Mar 2025 16:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4161C448787A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742920349;
	bh=xtjQNCIG90SkONBmw2cPQ+VxbDhw9iY6/7ps8Q1kb8g=;
	h=From:To:Cc:Subject:Date:From;
	b=IFWRq18xmsCHUVqvKa7vP77Ae03kPGXNyvbr33sDvejaQOUZiEnIwgVm7sloBCkNh
	 ACyuNMbQ/EdaLzr9MpGbAB6oFmHrhIetXs4QH+sTk2cIyCUl49rRkkURmEdd6GJgSc
	 zrN+6Vc4R6fsIE2EfmP4Ll3oxPFOwrWqNd97DEdk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] jffs2: check jffs2_prealloc_raw_node_refs() result in few other places
Date: Tue, 25 Mar 2025 19:32:13 +0300
Message-ID: <20250325163215.287311-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing hit another invalid pointer dereference due to the lack of
checking whether jffs2_prealloc_raw_node_refs() completed successfully.
Subsequent logic implies that the node refs have been allocated.

Handle that. The code is ready for propagating the error upwards.

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 5835 Comm: syz-executor145 Not tainted 5.10.234-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:jffs2_link_node_ref+0xac/0x690 fs/jffs2/nodelist.c:600
Call Trace:
 jffs2_mark_erased_block fs/jffs2/erase.c:460 [inline]
 jffs2_erase_pending_blocks+0x688/0x1860 fs/jffs2/erase.c:118
 jffs2_garbage_collect_pass+0x638/0x1a00 fs/jffs2/gc.c:253
 jffs2_reserve_space+0x3f4/0xad0 fs/jffs2/nodemgmt.c:167
 jffs2_write_inode_range+0x246/0xb50 fs/jffs2/write.c:362
 jffs2_write_end+0x712/0x1110 fs/jffs2/file.c:302
 generic_perform_write+0x2c2/0x500 mm/filemap.c:3347
 __generic_file_write_iter+0x252/0x610 mm/filemap.c:3465
 generic_file_write_iter+0xdb/0x230 mm/filemap.c:3497
 call_write_iter include/linux/fs.h:2039 [inline]
 do_iter_readv_writev+0x46d/0x750 fs/read_write.c:740
 do_iter_write+0x18c/0x710 fs/read_write.c:866
 vfs_writev+0x1db/0x6a0 fs/read_write.c:939
 do_pwritev fs/read_write.c:1036 [inline]
 __do_sys_pwritev fs/read_write.c:1083 [inline]
 __se_sys_pwritev fs/read_write.c:1078 [inline]
 __x64_sys_pwritev+0x235/0x310 fs/read_write.c:1078
 do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 2f785402f39b ("[JFFS2] Reduce visibility of raw_node_ref to upper layers of JFFS2 code.")
Fixes: f560928baa60 ("[JFFS2] Allocate node_ref for wasted space when skipping to page boundary")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Similar to https://lore.kernel.org/linux-mtd/20250307163409.13491-2-a.sadovnikov@ispras.ru/
but touches two remaining places.

 fs/jffs2/erase.c | 4 +++-
 fs/jffs2/scan.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index ef3a1e1b6cb0..fda9f4d6093f 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -425,7 +425,9 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 			.totlen =	cpu_to_je32(c->cleanmarker_size)
 		};
 
-		jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		if (ret)
+			goto filebad;
 
 		marker.hdr_crc = cpu_to_je32(crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
 
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..62879c218d4b 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -256,7 +256,9 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 
 		jffs2_dbg(1, "%s(): Skipping %d bytes in nextblock to ensure page alignment\n",
 			  __func__, skip);
-		jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		if (ret)
+			goto out;
 		jffs2_scan_dirty_space(c, c->nextblock, skip);
 	}
 #endif
-- 
2.49.0



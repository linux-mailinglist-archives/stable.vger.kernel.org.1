Return-Path: <stable+bounces-225733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dj+Bj6/uGn0igEAu9opvQ
	(envelope-from <stable+bounces-225733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC02A2DFB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7CB5302F7D2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E5346E66;
	Tue, 17 Mar 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pNkv3aAc"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1713C918;
	Tue, 17 Mar 2026 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715218; cv=none; b=qE2F7COYuQF9NN49eZ+tMmjgKm7LMaZ5mPv8ry6Tpye3xtnfcp7m5wbsNzmUN8WWR3Ji6qPhb99RIGtYBoKPvEU4wBRikWJMQKD+xcfmIdBGIU03azwMyOWjtdVeZeGJnTp1v2pDllAGBk/UDGJnPd/PinNY6zsViSoTGGKmlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715218; c=relaxed/simple;
	bh=wpLkP6426R8eIS9XNxuum2JVL6TVBDjCG1R4l1ZUr18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IwZ70AEYcYuw3VKPKcdk5eNPRGOi5XZHJWtNfvmXUMmxqiBiVxlwBzIKBgKGx4A/mhr8+IGONaJo70UpcjnZs+Mew/nV2K9SH06qr4zWCrUcNfCSO4fp7k7FpfqZrMCklhoSejnnbYaS46y7iJi8apkuQ0LO/OIp2DijsT5FV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pNkv3aAc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I6
	n0DiJEy0CtQ+Dd24ZDMSUwX9r1dxgSv8gIU/QibNg=; b=pNkv3aAcm7xCaKn/fx
	Z4I+0POR3p2rOuw6btVthr371v6k488luFrhrCrhHbiJknHWwZUMXUeLX5BL0t5Y
	7urDHjsmGx2jlaVH0NWHIaRvPQA7MrgZ6P+r0ibfFSCGAAIR6dUfv96BAhWfICNJ
	HX4HDOYGURFQj6z9caDfZfM/M=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCX7q_lvrhpI0YERw--.14635S2;
	Tue, 17 Mar 2026 10:39:34 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Robert Garcia <rob_garcia@163.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] f2fs: fix to wait on block writeback for post_read case
Date: Tue, 17 Mar 2026 10:39:33 +0800
Message-Id: <20260317023933.1654240-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCX7q_lvrhpI0YERw--.14635S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4kAr4rtF43GF18KrW7Jwb_yoW8Cr1kpF
	yUGr18Kr45tr1Uuwn2yF4DZF1fK3yUGw17KanFga1Sq3WYqrnYgas2vas5XF4Utr93Ja90
	vF4kCrykJFs8GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMiiS-UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5QZx3Gm4vuYqqQAA3E
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225733-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,163.com,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4CC02A2DFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chao Yu <chao@kernel.org>

[ Upstream commit 55fdc1c24a1d6229fe0ecf31335fb9a2eceaaa00 ]

If inode is compressed, but not encrypted, it missed to call
f2fs_wait_on_block_writeback() to wait for GCed page writeback
in IPU write path.

Thread A				GC-Thread
					- f2fs_gc
					 - do_garbage_collect
					  - gc_data_segment
					   - move_data_block
					    - f2fs_submit_page_write
					     migrate normal cluster's block via
					     meta_inode's page cache
- f2fs_write_single_data_page
 - f2fs_do_write_data_page
  - f2fs_inplace_write_data
   - f2fs_submit_page_bio

IRQ
- f2fs_read_end_io
					IRQ
					old data overrides new data due to
					out-of-order GC and common IO.
					- f2fs_read_end_io

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Minor context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/f2fs/data.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 887e286d2c32..39c633fa162c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2537,9 +2537,6 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 
 	page = fio->compressed_page ? fio->compressed_page : fio->page;
 
-	/* wait for GCed page writeback via META_MAPPING */
-	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
-
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return 0;
 
@@ -2718,6 +2715,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		err = -EFSCORRUPTED;
 		goto out_writepage;
 	}
+
+	/* wait for GCed page writeback via META_MAPPING */
+	if (fio->post_read)
+		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
+
 	/*
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
-- 
2.34.1



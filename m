Return-Path: <stable+bounces-220516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDIMEUU+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A121C6B20
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E965230DDE18
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1553CC1C0;
	Sat, 28 Feb 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYVlv6mg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EE3CC1B8;
	Sat, 28 Feb 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300400; cv=none; b=lmE1di2ove7wnvDx/QCqYgMt7Bj6AlAXQkY6qCV5tY3gtdoZYPcWSGRIxaXjZVPCG/Q1pBM0o0B1//Qr3/4R3C49J5qKMn6RA0JEQJ8qhVhQgY9dNQsOP56RvDFctNbrW5/nrMe6sSTFdttsCEwtzyrwCGT30/L1/qKkXACcmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300400; c=relaxed/simple;
	bh=CAIGXWOCpq5JZbzY6B5ypnvatHjxM4ndTCrYQmeRl4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOgamChd+sR2h2KoFIoy57gKL5pAovneoE0FjNMZI97y5bFCXeqlnCyJ4RFA7fG+8glQEdpLmQvxPcY4z7x3SqOvm7PsiD+pNuDHsKWK2Gov+sFDMBpcgQyjP5gQ5d5jxq+4yC5mgwEKzIAzlg03ZBO2Nzq8AlGS2Ij/DHGJNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYVlv6mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDB2C19425;
	Sat, 28 Feb 2026 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300399;
	bh=CAIGXWOCpq5JZbzY6B5ypnvatHjxM4ndTCrYQmeRl4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYVlv6mgQgQzmQIMpxpyy5R2+CnDMACA7TXK/quVhCN5fddxn2w1v5KCuy3i4jMSy
	 yJlZp6gicVumFtoD0ccYSdtKcHd62FhrD5yA9nVbllzC98P/LaFPhG1eoRAxYsCU7C
	 9zVUFv03qie8ilpSy1kDeXB2DDh+/1ZjnNocXrWlnDRwn9rnk/rdbaTDmCt4/sDD/M
	 WUTxFevVlDfPyPVHPM9I9O/fJcnvCapdQ/yNv9orj/X0kXmJqSuJRcRKIOI0SgVTjA
	 0JFMgf+AS5iRsdR20C4QuKiy1/h4bg3mxtOfXvCKzEbzZXty7Si9Om3+WzABBPFaAr
	 nwnXt9uZk4YxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 437/844] btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
Date: Sat, 28 Feb 2026 12:25:50 -0500
Message-ID: <20260228173244.1509663-438-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220516-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url,suse.com:email,lst.de:email]
X-Rspamd-Queue-Id: 75A121C6B20
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 8ceaad6cd6e7fa5f73b0b2796a2e85d75d37e9f3 ]

[BUG]
There is a bug report that when btrfs hits ENOSPC error in a critical
path, btrfs flips RO (this part is expected, although the ENOSPC bug
still needs to be addressed).

The problem is after the RO flip, if there is a read repair pending, we
can hit the ASSERT() inside btrfs_repair_io_failure() like the following:

  BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -28)
  WARNING: fs/btrfs/extent-tree.c:3235 at __btrfs_free_extent.isra.0+0x453/0xfd0, CPU#1: btrfs/383844
  Modules linked in: kvm_intel kvm irqbypass
  [...]
  ---[ end trace 0000000000000000 ]---
  BTRFS info (device vdc state EA): 2 enospc errors during balance
  BTRFS info (device vdc state EA): balance: ended with status: -30
  BTRFS error (device vdc state EA): parent transid verify failed on logical 30556160 mirror 2 wanted 8 found 6
  BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
  [...]
  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
  ------------[ cut here ]------------
  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
  kernel BUG at fs/btrfs/bio.c:938!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 868 Comm: kworker/u8:13 Tainted: G        W        N  6.19.0-rc6+ #4788 PREEMPT(full)
  Tainted: [W]=WARN, [N]=TEST
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  Workqueue: btrfs-endio simple_end_io_work
  RIP: 0010:btrfs_repair_io_failure.cold+0xb2/0x120
  RSP: 0000:ffffc90001d2bcf0 EFLAGS: 00010246
  RAX: 0000000000000051 RBX: 0000000000001000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffff8305cf42 RDI: 00000000ffffffff
  RBP: 0000000000000002 R08: 00000000fffeffff R09: ffffffff837fa988
  R10: ffffffff8327a9e0 R11: 6f69747265737361 R12: ffff88813018d310
  R13: ffff888168b8a000 R14: ffffc90001d2bd90 R15: ffff88810a169000
  FS:  0000000000000000(0000) GS:ffff8885e752c000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  ------------[ cut here ]------------

[CAUSE]
The cause of -ENOSPC error during the test case btrfs/124 is still
unknown, although it's known that we still have cases where metadata can
be over-committed but can not be fulfilled correctly, thus if we hit
such ENOSPC error inside a critical path, we have no choice but abort
the current transaction.

This will mark the fs read-only.

The problem is inside the btrfs_repair_io_failure() path that we require
the fs not to be mount read-only. This is normally fine, but if we are
doing a read-repair meanwhile the fs flips RO due to a critical error,
we can enter btrfs_repair_io_failure() with super block set to
read-only, thus triggering the above crash.

[FIX]
Just replace the ASSERT() with a proper return if the fs is already
read-only.

Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-btrfs/20260126045555.GB31641@lst.de/
Tested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e4d382d3a7aea..1de1b408c6a6d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -934,7 +934,6 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	struct bio *bio = NULL;
 	int ret = 0;
 
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
 	/* Basic alignment checks. */
@@ -946,6 +945,13 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	ASSERT(step <= length);
 	ASSERT(is_power_of_2(step));
 
+	/*
+	 * The fs either mounted RO or hit critical errors, no need
+	 * to continue repairing.
+	 */
+	if (unlikely(sb_rdonly(fs_info->sb)))
+		return 0;
+
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-- 
2.51.0



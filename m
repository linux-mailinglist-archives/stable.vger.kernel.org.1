Return-Path: <stable+bounces-262704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEh4Kre4KmofvwMAu9opvQ
	(envelope-from <stable+bounces-262704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:31:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C3672595
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=IU9WaWHI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262704-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262704-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90D69300C3B2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A040D57A;
	Thu, 11 Jun 2026 13:30:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB212C3757;
	Thu, 11 Jun 2026 13:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184622; cv=none; b=A/1lSTw44mjL05WOTUEmXWYRNHXkVUYHvV2SCLvLBjarqQ3fi1ajK7nzk5aNT8/VLxt2rJV4uRLcBJwnXOyMniQMm0+0zHLW2R2hc4o0H5hICK6TgY+hqkUgspeN7nxoAIVFln/wtKlybCLEw0ooftuJ74XLZYIwSZwsb2dijl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184622; c=relaxed/simple;
	bh=piJtE2ahdVYa+ggULfzDB8d/kV1sx/QZAzOpPP90Gkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVmx4LcFtFKXu1A8xPBsdyp2Zt/GDT61S0RXyklZzv/UeF182nhTVCa/1M2bsr6vdrFhwLsAhBAhUB2SBoXjf5kF7yId+8lheeMbYE76H0liDNE4EezeN8eBulIG/OSlj4DwGQmWm8NEflEH1LZrT1DPuk21II/H2A4snYVQFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=IU9WaWHI; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420485744;
	Thu, 11 Jun 2026 21:25:03 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: naohiro.aota@wdc.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: zoned: protect sb_write_pointer() reads with invalidate lock
Date: Thu, 11 Jun 2026 21:24:50 +0800
Message-Id: <20260611132450.971236-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb6db8f8703a1kunm4232c44d1660e1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUhJVk9PSkJDS0IaQ0MfSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IU9WaWHI4YTlvVhpHFkqGyFJ9U1KIWnreKJLh0Myrkamq8J7gR720fAuAmVY7feesrnjwVn07hksuIythqXyDLamVpRgIFKzQRkJuwCFoGZpHvYSoBbwnDRf+MtDvdp5X3PdczAwuX2jRPb3bJIlnCYVhwxIKStvMxd+svwvOfk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=MYYVWZGuWUy72thSlvgrKpQW5sePp3HufvzonBWY/1U=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262704-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:naohiro.aota@wdc.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 439C3672595

When both zoned superblock log zones are full, sb_write_pointer() reads
the last superblock page from each zone with read_cache_page_gfp() to
compare generations. Those reads go through bdev->bd_mapping without
filemap_invalidate_lock(), even though the same zoned discovery flow
later reaches btrfs_read_disk_super(), whose final read already takes
filemap_invalidate_lock(mapping).

A running system can reach this while mounting or scanning a zoned
filesystem whose superblock log has both zones full. In that state,
sb_write_pointer() performs two unprotected page-cache reads before
btrfs_read_disk_super() does its later protected final read.

This leaves the early discovery reads outside the same synchronization
domain used by set_blocksize() when it changes the block-device mapping
geometry. As a result, read_cache_page_gfp() can race a concurrent
block-size/layout update on the same mapping and see inconsistent
geometry across folio allocation and mapping state.

This issue was found by our static analysis tool while scanning
read_cache_page_gfp(bdev->bd_mapping, ...) sites for missing
filemap_invalidate_lock() coverage, and then manually audited on Linux
v6.18.21. The same synchronization requirement is already enforced for
the final read in btrfs_read_disk_super().

A focused QEMU KCSAN test then raced the zoned superblock discovery
path against a set_blocksize-style mapping update on the same
bdev->bd_mapping. It reported a race between
blkbszset_update_mapping() and read_cache_page_gfp(), with the read
side reaching:

  sb_write_pointer()
  sb_log_location()
  btrfs_sb_log_location_bdev()
  btrfs_read_disk_super()

Add filemap_invalidate_lock()/unlock() around the two
read_cache_page_gfp() calls in sb_write_pointer() so the zoned
superblock discovery path uses the same invalidate-lock contract as the
final read in btrfs_read_disk_super().

Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/btrfs/zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e14a4234954b..edc797a43fb5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -130,8 +130,10 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
 						BTRFS_SUPER_INFO_SIZE;
 
+			filemap_invalidate_lock(mapping);
 			page[i] = read_cache_page_gfp(mapping,
 					bytenr >> PAGE_SHIFT, GFP_NOFS);
+			filemap_invalidate_unlock(mapping);
 			if (IS_ERR(page[i])) {
 				if (i == 1)
 					btrfs_release_disk_super(super[0]);
-- 
2.34.1


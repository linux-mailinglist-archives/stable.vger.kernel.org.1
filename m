Return-Path: <stable+bounces-230600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKErFTU/xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:26:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F3340EE8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 105E93014125
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2C3D6663;
	Fri, 27 Mar 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="NvSilcsf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CA3CCFD6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599875; cv=none; b=F+dLDU3SbG7BIppse3cdMbcJL6b+JV2tI4y4O6FCfmOe/iAzfJKXv9Jm2eYtQCu+DItRIQ9V8HCi2KG6GSKtvLnqjeAcpJw3LjfjLkotdr8AbHbOVnLVeYf75zKyjjfnL44+VuEX9g158D9X9Fyi/9AJLuvBWvVWJrkpEH8C6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599875; c=relaxed/simple;
	bh=3vNoqKe/aR8g29HWgPtyQ7y1TEApUPs4a92OYmUp+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d617ZAV+4ZkTnfqw3DXY6lxE7QMyB+8ns6/IvsU18o1VugD1ALyzBkSycNeN7BXLZw3T+GNAHv2a+BSuKIEwfozZ2Bywxq+5az1DSYYCeCiR+B3OycKo6PndWgrE98RfWErhK1QkQgc6I7zKKu3iunqofPVTc4lfS9jr7bRogMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=NvSilcsf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso753267a91.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1774599872; x=1775204672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9L57hTltiEsNstXFa51jdQMNN6vMySfO13WmKQYIEJU=;
        b=NvSilcsftwXriZ3Ow1j1G/IZkebeQKX8aW7Rgmb41u3LsFh7OxWerTzon7TVowcNxO
         YxlfcBQsCC9hUynBxM1bpC/R0gpTY1rNhMXRNDxbWkldHHcAD/Smed1s4lFizq1sItpv
         CjRq+Rt690R3EM/yvWXG/Y1d1fiP7350PRUGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774599872; x=1775204672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L57hTltiEsNstXFa51jdQMNN6vMySfO13WmKQYIEJU=;
        b=gUtjP2y9NfOod1PZbuWoMjZwxcU5L2VWnfbNxawtKpq1haOH94iJSg3moxmcxkFNuc
         FEXZM2omnBy+VhyMAu2Xh/th4MFP9wXX8kQyt5jAXJ1UQrHjLDdmt6YP0ztxZSQ3CGZG
         OIKVEpFv+0hFI6SbY5J6Dm5oWjXaiG9S7Pc8MjAtRLVCVH+BFUd4z9Tth9OIFCb8JfXI
         28jVLC2BCxpJ7tZaLI8FhYylJVYMXck5FZwArbDi/SH+JCb6SOhKVI/7qX+YxkFJ2ksv
         zrX5wQ7aSAENF6TbeWh/0wWlZiEatBGVL3AxctCzhqM0oWqCdDbD6sT8r5/cUOyB6w3z
         ZZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Uz9VNHoA/1nYUbtlVcxhqOLSkt5ULFuKSX4Oon7YQPATXwl3AEAgPeZy4lJbkiB9pjT5T2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsqskIiiIKVUgHfol18eFudSCViG6hKUH3WvMEu0iPiu2H7UI
	vytKOlD4iwaWg82q1zmPb1MqY3JALStsXH99g91OjycKnMf7GsDzKM7IFbARgTPI6F0=
X-Gm-Gg: ATEYQzw34kgvYDevK4sez5ReKqke3tIbgPLZVNR7PtlEMnF1jNH9ys0ZF+TWtLbq9Q1
	PPEbUVahrSAGbm0H+aCNlMnsZjaexvFKa+dssHKZBNtsUdoqOooezg2/jQRSsEV8jbrdePDD/t6
	eY4jx5wQ5JegtJTmfXwYn+ZaJCbVWghjD5QeG4Kv6Sr7Q40V2yxXnD9DGeae0yfspCuRdla0Agm
	wXqnqW2e2fS2ibENizfD3noVjPnEEqtXTU5gQiqdPhwaah8PCKFB7wq8mENfurqsAAD4JHiqkCX
	llL/v4Jv/x++qq+xQAe29A0Stcr55U65lDCCWZA6MBZqE2a1g9pHb0HTxpHBqmRYwf+E8SL3LzC
	pW6lqw295WlV+3VaTevwl08N9VKMRmzJPzIeAX/LP6TwARftidSKCGVP9upLU0SGL8IfbieSwEb
	ZNSj0cOcIUC3o943esT4B3L0NlHTZngN/C1kdsVmh7UXzWw+CPahWnH1tqanOg/Kl6IDz3x5eIh
	Qq+Skn9Xkw5OMv+k0+fS+ZkHJABdCfYuBXh6oEEV2bemiipg528n05pwx4L6BjAf0DRPBeiEJZ5
	kMsXbKDURT/1gN/HEWzZgR5S5+Xs/WGD9X67wvY+CuXphLG2AX1UpDuStlnxYQje
X-Received: by 2002:a17:90b:558d:b0:35b:9d97:63ac with SMTP id 98e67ed59e1d1-35c2ffa82e2mr1854768a91.7.1774599872214;
        Fri, 27 Mar 2026 01:24:32 -0700 (PDT)
Received: from aegis ([2001:fd8:4d01:cc02:cf55:4e55:9fc2:64c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ba5700sm4114806a91.8.2026.03.27.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:24:31 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] btrfs: Fix BTRFS arm64 tagged KASAN false-positive
Date: Fri, 27 Mar 2026 16:24:18 +0800
Message-ID: <20260327082419.12654-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230600-lists,stable=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quora.org:dkim,quora.org:email,quora.org:mid]
X-Rspamd-Queue-Id: C96F3340EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When booting Linux 7.0-rc5 on a Qualcomm Snapdragon X1 with KASAN
software tagging with a BTRFS filesystem, we see:

BUG: KASAN: invalid-access in xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
Read of size 8 at addr 7bff000804fe1000 by task kworker/u49:2/138
Pointer tag: [7b], memory tag: [b2]

CPU: 0 UID: 0 PID: 138 Comm: kworker/u49:2 Not tainted 7.0.0-rc4+ #34 PREEMPTLAZY
Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
Workqueue: btrfs-endio-meta simple_end_io_work
Call trace:
show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:597)
kasan_check_range (mm/kasan/sw_tags.c:86 (discriminator 1))
__hwasan_loadN_noabort (mm/kasan/sw_tags.c:158)
xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
btrfs_csum_update (fs/btrfs/fs.c:106)
csum_tree_block (fs/btrfs/disk-io.c:103 (discriminator 3))
btrfs_validate_extent_buffer (fs/btrfs/disk-io.c:389)
end_bbio_meta_read (fs/btrfs/extent_io.c:3853 (discriminator 1))
btrfs_bio_end_io (fs/btrfs/bio.c:152)
simple_end_io_work (fs/btrfs/bio.c:388)
process_one_work (./arch/arm64/include/asm/jump_label.h:36 ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3281)
worker_thread (kernel/workqueue.c:3353 (discriminator 2) kernel/workqueue.c:3440 (discriminator 2))
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:861)

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:f1ff00080055dee8 index:0x2467bd pfn:0x884fe1
memcg:51ff000800e68ec0 aops:btree_aops ino:1
flags: 0x9340000000004000(private|zone=2|kasantag=0x4d)
raw: 9340000000004000 0000000000000000 dead000000000122 f1ff00080055dee8
raw: 00000000002467bd 43ff00081d0cc6f0 00000003ffffffff 51ff000800e68ec0
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff000804fe0e00: 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b
ffff000804fe0f00: 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b
>ffff000804fe1000: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2
^
ffff000804fe1100: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2
ffff000804fe1200: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2

This occurs as allocation in btrfs_alloc_page_array is from multiple
discrete pages thus different KASAN tags by design, leading to a tag
mismatch when linear access is used where the pages are physically
contiguous.

Fix this by retagging all the EB pages with the same KASAN tag.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Fixes: 397239ed6a6c ("btrfs: allow extent buffer helpers to skip cross-page handling")
Changelog:
 v3: Retag only when contiguous; fix build failure when generic KASAN configured
 v2: https://lore.kernel.org/lkml/20260323061827.22903-1-daniel@quora.org/
  - Retag pages rather than bypass linear access optimisation
 v1: https://lore.kernel.org/lkml/20260319053413.14771-1-daniel@quora.org/
---
 fs/btrfs/extent_io.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f97a3d2a8d7..141092da871b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3533,8 +3533,23 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (uptodate)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	/* All pages are physically contiguous, can skip cross page handling. */
-	if (page_contig)
+	if (page_contig) {
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+		struct page *page = folio_page(eb->folios[0], 0);
+		u8 tag = page_kasan_tag(page);
+
+		/*
+		 * Since pages are from multiple allocations and physically
+		 * contiguous allowing linear access, prevent KASAN warnings
+		 * by retagging with the first tag
+		 */
+		for (int i = 1; i < num_extent_pages(eb); i++) {
+			page_kasan_tag_set(page + i, tag);
+			kasan_unpoison_range(page_address(page + i), PAGE_SIZE);
+      }
+#endif
 		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
+	}
 again:
 	xa_lock_irq(&fs_info->buffer_tree);
 	existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
-- 
2.53.0


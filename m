Return-Path: <stable+bounces-227887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMHAGsTbwGn6NQQAu9opvQ
	(envelope-from <stable+bounces-227887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:20:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536E2ECFB1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48325300989A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26502D781E;
	Mon, 23 Mar 2026 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="QNXzDK8M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808182D7398
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246832; cv=none; b=Y4g4ym/O7WxZzlxvjlydXbPt6HcsmHY3pWBCNnHnzUxd2u3geudKyJrlRbJsOrtVtW5+wcO9L3D4GJeRzMgQTqCmg8ZRgotb91v72h3NdegY5v6A3wh5D6l8D0fVt31zIc8AbWZf+SV/sBpDyvOV8DmbCZHCHMxH4u1wfIY1Bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246832; c=relaxed/simple;
	bh=EaqVAWQj1+JhnM0aduwM8TyiqVz99tNZ9GgCmbJeEd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6s3dWNx8D2BR+Jb/8dnt4fn9zuOVVjoaE+wABlfxmOM4BnLr40u9lvWVvC63IFQO/4Jj7EZ8kEmnqBWryqs/rSbIpRxWZpKbgOXgkCeNjNN/guWWLTxwvnRzBUV9oCqpFgU4jczsVmZSOwiwFQRFIeAqUscylHVDbI2Foyay7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=QNXzDK8M; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a646c96bdso3056825b3a.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1774246824; x=1774851624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szc7+D5ToNJHA+7kPaHA4IjzMkDBvZLOp0vWoYKX35U=;
        b=QNXzDK8MQDh/t770ggkSVC69++yRKbf+ukgUpM/g7ewPNPIcvpGfl/qboqyBhOMHte
         vcJ/tApE3yMaFGm5llWW2uDLlWC8dRhZuDur9wyMa7x0P9M4p15NOufp1lewYd+yD2Bc
         hk3WkrtgMGI8qV42cCGteNjSuolr+T89TuhSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246824; x=1774851624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szc7+D5ToNJHA+7kPaHA4IjzMkDBvZLOp0vWoYKX35U=;
        b=P92hblKUshT+1sWPQug9FI+0mDaf2VAAZyoowTZrH0o6x0qNRD6gpi9HasVqlNmaWw
         eC0lX8o3rhbVKilJp3S5XcdLFKjE3EZpvDKBpQyniN3HJx8LJL4TAPF3WD3GGQikwiDi
         C219WSOXKOUIj2TlBNuQHg4R2tn/UGkpZNC1Ba7Tb0xQA/nWMWckUtXxR+Y5W0O1Pex7
         kbu2F0LVhrJNXZm8xVfg2BdsB/9EeMb5OiSie20SYuMiokrn4K6qN9S8CEoFtGiIrg4W
         uSpHuKjX7GsmVsmU0jLRWR1+ZQUoDfPRMdgTs6SEUOwxiHgicT62MNN5hEPzAJ0bTpHT
         coyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9YcUauRwyTZC7E3gehiun+trBptSqnM+hQKWTphqGGiN7cQuXM+9cYkBtcdFaxcQGN9UT/rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiKPRvJaVzpOi1AXm2vfk2FWShJJthkVIf9YjGyvHtvt+SzHa
	+stDu1Ep1ms4IIno+J9jM3wWBOeGk8YuxIH0l9xQZfuc9GG3ZOdvDAffknPYIUKK0xU=
X-Gm-Gg: ATEYQzxzcraF2LPXTlC+wJ9HarEI00nk9hhP8K4MD6xz+MEPuQTN9/7ix1AWqfLke7E
	qsX2QzlGX5DNT6G+qr8h2euVdmAeGUvdQ5Eha3MnTPGyFwwUV3zIGl7MtrcBBQkdWXWnTMKCjTf
	CTSNlU2voic5jJqpf15avdXZfAP0iizolEHogaM+JnjLGVvso4aRQec3FojvqK8nWfTWQCIfnC5
	m8riYKdMg35ws9LwBhlA9GTRYvik05e39Qq8kNz6BdlvKBMMVWv+cHwYMKy1CHUffxfMDet+ovZ
	5f4aW04eK1zvW1NWW3QxnxKhMAAIeBZiLwo/SE1Erj698VlJWZEBuSmmeg4DXZo0lDf9Vb1xkWf
	hZu2X20K5JmwRvHvjZtM3fpUYIrNpH/e4OxKiR50KF9Wmst7Hub5a5OxqWbwj+VbfDWmCpqnIL6
	BuF6d5wtMU9lpShsdIZsZXKt/gy/+ZYpC435/t1TcdD8p2Kf5FVBXNPJ9i2+mmMZQGA0vWbwRla
	cenKfq9uC4GTdo7dm0to0pgnqJEpbZyywURbLEaNl4xrgNnkziCDHSEnVmCq0Be2ceFZJ2Q+mZ7
	aMIybChukeShjTMbYHPtFw40Vl92Owj9e9qzkPCOdlsJZTDwz16KBxr8GMs1z10mgC6sVcY=
X-Received: by 2002:a05:6a00:300a:b0:82c:254b:79fb with SMTP id d2e1a72fcca58-82c254b86eamr6645766b3a.9.1774246823837;
        Sun, 22 Mar 2026 23:20:23 -0700 (PDT)
Received: from aegis ([131.226.111.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da9c3sm8305814b3a.44.2026.03.22.23.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 23:20:23 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] btrfs: Fix BTRFS arm64 tagged KASAN false-positive
Date: Mon, 23 Mar 2026 14:18:26 +0800
Message-ID: <20260323061827.22903-1-daniel@quora.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227887-lists,stable=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quora.org:dkim,quora.org:email,quora.org:mid]
X-Rspamd-Queue-Id: 5536E2ECFB1
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
 v2: Retag pages rather than bypass linear access optimisation
 v1: https://lore.kernel.org/lkml/20260319053413.14771-1-daniel@quora.org/
---
 fs/btrfs/extent_io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f97a3d2a8d7..37836d685f21 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/swap.h>
+#include <linux/kasan.h>
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
@@ -706,6 +707,18 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Since separate page allocations are used for the same extent with
+	 * linear addressing where physically contiguous, apply the same KASAN
+	 * tag to prevent false-positive warnings when crossing page boundaries
+	 */
+	u8 tag = page_kasan_tag(page_array[0]);
+
+	for (int i = 1; i < num_pages; i++) {
+		page_kasan_tag_set(page_array[i], tag);
+		kasan_unpoison_range(page_address(page_array[i]), PAGE_SIZE);
+	}
+
 	for (int i = 0; i < num_pages; i++)
 		eb->folios[i] = page_folio(page_array[i]);
 	eb->folio_size = PAGE_SIZE;
-- 
2.53.0



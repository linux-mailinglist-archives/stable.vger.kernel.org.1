Return-Path: <stable+bounces-224836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OixB2qUsmnONgAAu9opvQ
	(envelope-from <stable+bounces-224836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:24:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFD270512
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80D93136CAE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC963BA240;
	Thu, 12 Mar 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT0n3ZmA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0037DEB5
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310964; cv=none; b=Mb+/l2MuDAQVLzAds+RW/v0jOuSEUyt4IjDngLI203TVVb4qUMUoNQzdpm+63d5Xqgtrr0+Zg9pTOvuMFaX1MgFp2REd+Fjyh7hdjDkbPcP71NBzyfA/t7iaGDxBYh6oDFP0WWPff5+mOC0ty2gqLOI5dyPqroyaN7Srg+TGh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310964; c=relaxed/simple;
	bh=UQ8eTy3O54/yQDmZQ53filNsXiiPrqRjxEEESeSEOsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTKfQlE06TijZxaawVHZhCh0vEuXGyakAXIXs2kk2razTSVid9qCUuL3MqGA/drinji2uQsLg/DjxLsQiAKP4JdyD9pQxf0NR3Axvt9hkAsV0hQZoIyi+wrEcztJIbPUXFkUaWYseRKINIQT9nYtDy2vAZ33Y7wAfxrrK0HGzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT0n3ZmA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso7549825ad.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773310961; x=1773915761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJUHIhc2weYpVFeAG0o1aQbqOU671Mp2foYGXrmt/ak=;
        b=QT0n3ZmAZcT+ovwZyvEmGBL5ftbwIkm9oYx2AAXImc/F01O4hqqhlm+OaG5ywWmrOr
         vx1JoO/6AniXKXL9N35QW2S8N3CDPaDLpou+ce62dRCCOeC56dWF1FVcSqIw9BIll9mB
         OgliTpTcedjvm1WgT1IFlzlQCXMubqsrLHfOYKQtyDuRWExnBJ0wT3iDvfGTGbbvDtjm
         bA8FuwUmV8yVCZdVjoOiCPnuWw81zgE+qGShFDNfC84JG3F0HDFOr2Jm2xmBbGJeq5AF
         1PD/gJOIn9pe2783sgoAaFcmlqUTU00KwooVBKCWhUHxURAo4VajYVUPPM9nBMsmwo6k
         KRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773310961; x=1773915761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJUHIhc2weYpVFeAG0o1aQbqOU671Mp2foYGXrmt/ak=;
        b=iTpdeIvetuCR34r/xEA/9cMA8IF+BUV3SuBdThuAZCtX2WFXBGG553dcLaUqbaxsdC
         hDuVQAnD76axOLwyOtYzNTwouGkEQO75aPSyE09w+pgZiUMg7jdoT2XHPgI62itH4t+F
         Qd4BGgifzpUl+LoCM1eGqY1NGCnjAbFZsfTOg6L7ZiUL9tCSKlF2DloDzbwmZD9k8ASG
         wc8+oU5oGLLjVhdgc1cEn6LppTwa4gsDmdzs4MUNRKpDnJBPlnb8R4JHme1j+clr9ICX
         /6T8BY+IzB60cU5t1opdNBc4lPWqGiWeGrJvPSrey5dzN5TONWfXrMuOLmo7DNS+i6b8
         Xo+A==
X-Forwarded-Encrypted: i=1; AJvYcCV3XC8FXqMfjsuQ4SIL9xDlgkxuxERrYIpCQmXYrNqkl8uwnuL8wxlMkCEqexabJ8z5KacYxT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlJNoHTZIGFUrvVa0aiXwaw5ZixBDbFFGPPcl8CybXbkfO9mC
	6GB12UjZx7Yv3gb3TZrudVSDuaFvPshC3mkDFsjB91Uttho8crc2hHpF
X-Gm-Gg: ATEYQzzOXCgFe/jNwrKLwfRSKwDh9/ADZjbphANbXtZVuwO1UsoxcWMkRtTndaWunVl
	YA9Nvq/VeXoZyhM+RSI8wEYJHwS2YggSc7ow4dtdID2+7ddyYb9E8XHPbdGwzbzK1/9NUL82HFI
	H/Lwl3kJ27DaKRE5FLIpd0LPTRK8RCfiU3m0pGxhvbHr2o3Fofu3u3fbgc4mbp3CcaMMdGaLRai
	0yw1ZWNTg7odoo8Msm3gc5Wu0yY2QxBSLTkAJqf0bQwGfCDd8YuOZWmBvgzq5wxUHEzWJ26m5e2
	4p7tXltLiDIHOM7Q+2IOpQZtvcBwiB43j5pXJDyCVrzF9/ywzqLBu+nnGsUGzydpzWvhfua/fHI
	Rbdlwt4zcD5QFpbGewvgOZ0YlHe16Vs38wpE/Vg5OTini+Q5CmvxlB0+pdNdkJQOa4vqKqGk2Et
	coV+mGz9MeW/WVoRV860FcYE74UaXGeMgiMwU2Qtdkk5qFsAI0zjRqTZsxgENL7hK4NqpT3bU=
X-Received: by 2002:a17:903:37c4:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2aeba2e60d8mr28067915ad.0.1773310961125;
        Thu, 12 Mar 2026 03:22:41 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.183.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae260ea3sm52828275ad.39.2026.03.12.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:22:40 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: reject root with mismatched level between root_item and node header
Date: Thu, 12 Mar 2026 18:22:29 +0800
Message-ID: <20260312102229.220570-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-224836-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8DFD270512
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
A KASAN null-ptr-deref is triggered when running balance on a filesystem
with a corrupted root item:

  KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
  CPU: 1 UID: 0 PID: 347 ... Tainted: G OE  6.18.0+ #17 PREEMPT(voluntary)
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: QEMU Ubuntu 24.04 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:get_eb_folio_index fs/btrfs/extent_io.h:180 [inline]
  RIP: 0010:btrfs_get_64+0x91/0x590 fs/btrfs/accessors.c:117
  Code: 400400f3 f3f36548 8b056324 31054889
  Call Trace:
   btrfs_key_blockptr fs/btrfs/accessors.h:368 [inline]
   btrfs_node_blockptr fs/btrfs/accessors.h:380 [inline]
   handle_indirect_tree_backref fs/btrfs/backref.c:3324 [inline]
   btrfs_backref_add_tree_node+0x7a5/0x26a0 fs/btrfs/backref.c:3538
   build_backref_tree+0x11c/0xb00 fs/btrfs/relocation.c:437
   relocate_tree_blocks+0x583/0x1a30 fs/btrfs/relocation.c:2649
   relocate_block_group+0x521/0xf60 fs/btrfs/relocation.c:3584
   btrfs_relocate_block_group+0x4d8/0xde0 fs/btrfs/relocation.c:3984
   btrfs_relocate_chunk+0x133/0x620 fs/btrfs/volumes.c:3451
   __btrfs_balance fs/btrfs/volumes.c:4227 [inline]
   btrfs_balance+0x1e8b/0x42b0 fs/btrfs/volumes.c:4604
   btrfs_ioctl_balance fs/btrfs/ioctl.c:3577 [inline]
   btrfs_ioctl+0x25cf/0x5b90 fs/btrfs/ioctl.c:5313
   ...
  RIP: 0033:0x7bbaa73a75ad
  Code: ffc3662e 0f1f8400 00000000 90f30f1e fa4889f8

The bug is reproducible on 7.0.0-rc2-next-20260311 with our dynamic
metadata fuzzing tool that corrupts btrfs metadata at runtime.

[CAUSE]
The corruption consists of a single corrupted field in a root tree leaf:
the btrfs_root_item for the affected tree has its .level field set to 1,
while the actual root block on disk has header.level = 0. The root block
itself is completely intact; only the field value stored inside the root
tree leaf is wrong. The existing tree-checker validation in
check_root_item() accepts this because it only verifies that
root_item.level < BTRFS_MAX_LEVEL, and does not cross-check the value
against the root block's own header.

The inconsistency becomes dangerous when balance calls
relocate_tree_blocks() to move a level-0 block belonging to that tree.
relocate_tree_blocks() has two sequential phases that together set the
trap:

Phase 1 -- get_tree_block_key(): reads the root block to retrieve its first
key before building the backref tree. The check level passed to
read_tree_block() here comes from the EXTENT_ITEM in the extent tree, which
correctly records level 0. The disk I/O completes,
btrfs_validate_extent_buffer() sees found_level(0) == check->level(0), and
marks the extent_buffer EXTENT_BUFFER_UPTODATE.

Phase 2 -- build_backref_tree() calls handle_indirect_tree_backref(), which
calls btrfs_get_fs_root() to open the affected tree. Inside
read_tree_root_path(), level is set from btrfs_root_level(&root->root_item),
yielding the corrupted value 1. read_tree_block() is then called with
check.level = 1 for the same bytenr. Because EXTENT_BUFFER_UPTODATE is
already set from Phase 1, read_extent_buffer_pages_nowait() returns
immediately via the cache fast path, skipping
btrfs_validate_extent_buffer() entirely. read_tree_root_path() has no
cross-check between btrfs_header_level(root->node) and the level read from
root_item, so it silently builds a btrfs_root with root_item.level = 1 and
commit_root whose btrfs_header_level() is 0 and installs it in the
fs_roots radix tree.

Back in handle_indirect_tree_backref(), btrfs_root_level(&root->root_item)
returns 1, which does not equal cur->level(0), so the tree-root early-exit
is skipped and path->lowest_level is set to 1.
btrfs_search_slot_get_root() starts at commit_root (level 0), records it in
p->nodes[0], and returns immediately because it is already a leaf --
p->nodes[1] is never assigned and retains its kzalloc-zeroed NULL value.
eb = path->nodes[1] = NULL is then passed directly to
btrfs_node_blockptr(), which calls btrfs_get_64() and then
get_eb_folio_index(), where eb->folio_shift is dereferenced through the
NULL pointer, causing the crash.

Note that the subsequent for() loop in handle_indirect_tree_backref()
already checks for a NULL path->nodes[level] correctly; the initial
blockptr comparison just above it was never given the same guard.

[FIX]
Catch the inconsistency in read_tree_root_path(), right after read_tree_block()
returns root->node and the generation and owner checks have passed. At that
point level = btrfs_root_level(&root->root_item) is already known, so
comparing it against btrfs_header_level(root->node) costs nothing. If they
differ, emit a btrfs_crit() message and return -EUCLEAN to prevent the
inconsistent btrfs_root object from being installed in the radix-tree cache
and reaching any caller. read_tree_root_path() is the only place that sees
both root_item.level and the actual root node simultaneously, making it the
correct and minimal location for this cross-block consistency check.
Returning -EUCLEAN is consistent with the existing owner-mismatch check
directly above and with the general btrfs policy of converting detectable
corruption into -EUCLEAN rather than crashing later.

After the fix, btrfs detects the level mismatch at root load time and
fails with -EUCLEAN instead of crashing later in
handle_indirect_tree_backref().

Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/btrfs/disk-io.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 900e462d8ea1..06a8689cbf62 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1067,6 +1067,26 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 		ret = -EUCLEAN;
 		goto fail;
 	}
+	/*
+	 * Verify that the root node's on-disk level matches root_item.level.
+	 * These can diverge when the root item in the root tree was corrupted
+	 * (e.g. a bit flip changing level) while the actual tree block is
+	 * already cached in memory at its real level. In that case
+	 * read_tree_block() returns the cached buffer without re-running
+	 * btrfs_validate_extent_buffer(), silently bypassing the level check.
+	 * The mismatch would later cause a null-ptr-deref in backref walking
+	 * (handle_indirect_tree_backref) when the commit root's real height is
+	 * lower than what root_item.level claims.
+	 */
+	if (unlikely(btrfs_header_level(root->node) != level)) {
+		btrfs_crit(fs_info,
+           "root=%llu block=%llu, root item level mismatch: "
+           "root_item.level=%d block.level=%u",
+           btrfs_root_id(root), root->node->start,
+           level, btrfs_header_level(root->node));
+		ret = -EUCLEAN;
+		goto fail;
+	}
 	root->commit_root = btrfs_root_node(root);
 	return root;
 fail:
-- 
2.43.0



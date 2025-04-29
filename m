Return-Path: <stable+bounces-138341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A44AA17EF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C249A57C8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F352221DA7;
	Tue, 29 Apr 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AFJjo3QH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88724BD02;
	Tue, 29 Apr 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948919; cv=none; b=gqZ62OK9uFgCw7DhPiGumyP58huzOu4JpLQu0z6Ov0qiA2yksUSzLAMCOFlhngzhI/j9MPDrPHUmcefgjzHaHHhitN+LwINw5qR/sVAh1PirN6ZRdGZANDQ4e8J2MQxSwDa0Y1+wu9IE+GVZIo/vO4FQmAuU33P981TRm4w0x/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948919; c=relaxed/simple;
	bh=/g8XxKqH/bEbSAFfguprWCCW5AgTGLLmIeGkDA975Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgcPCJVylN7iLQ5I/+zWIzLj4KRWL3OI6heS084HZVJ6XAdrOYzT1ImLmmjQYRzYQsyB4UHZMBbiHE0bdqvtdnPN6gP4YHwq7Q83fRiITc9DmqN/0ekVI4jWxNyvwpUaNb6Ow96090xoH3VN4P60a7NhYJ8G30FbBY9wbm9mGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AFJjo3QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2663C4CEE9;
	Tue, 29 Apr 2025 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948919;
	bh=/g8XxKqH/bEbSAFfguprWCCW5AgTGLLmIeGkDA975Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFJjo3QH2S27s21nwURUEAvRiXIwDir7t9KEKGvhQ3DIHvjvLzgIgQZTX/CMuifIS
	 E1nSZIx1WG7QQ8w79aT+NqLQYD16FnXmKPewUgHxo48QmvF8JgNZ86mnXeFobfTSJl
	 c8yqYJFrejkUbpapXXUd5DfF3J5REv8Y2z7ieEXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Cengiz Can <cengiz.can@canonical.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 164/373] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Date: Tue, 29 Apr 2025 18:40:41 +0200
Message-ID: <20250429161129.899608952@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasiliy Kovalev <kovalev@altlinux.org>

commit bb5e07cb927724e0b47be371fa081141cfb14414 upstream.

Syzbot reported an issue in hfs subsystem:

BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:423 [inline]
 hfs_bnode_read fs/hfs/bnode.c:35 [inline]
 hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
 hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
 hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
 hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdir fs/namei.c:4300 [inline]
 __se_sys_mkdir fs/namei.c:4298 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdd6057a99

Add a check for key length in hfs_bnode_read_key to prevent
out-of-bounds memory access. If the key length is invalid, the
key buffer is cleared, improving stability and reliability.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://lore.kernel.org/20241019191303.24048-1-kovalev@altlinux.org
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hfs/bnode.c     |    6 ++++++
 fs/hfsplus/bnode.c |    6 ++++++
 2 files changed, 12 insertions(+)

--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -70,6 +70,12 @@ void hfs_bnode_read_key(struct hfs_bnode
 	else
 		key_len = tree->max_key_len + 1;
 
+	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfs_btree_key));
+		pr_err("hfs: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -69,6 +69,12 @@ void hfs_bnode_read_key(struct hfs_bnode
 	else
 		key_len = tree->max_key_len + 2;
 
+	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfsplus_btree_key));
+		pr_err("hfsplus: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 




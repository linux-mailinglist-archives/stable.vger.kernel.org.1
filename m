Return-Path: <stable+bounces-137213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E95AA122F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEB917376E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F22472A5;
	Tue, 29 Apr 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kFi/Za6F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF292459C9;
	Tue, 29 Apr 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945400; cv=none; b=Q8N2BDZX+cFvPtLQAYyOVk+gIv4Kju+j/7/M0c1HrDdectr3vlGBe2SaR0HONcDkRpIF3fZweCYjZ+npYM1CsDcpBvI21f0r89o+bHs6DoG6XcPFouCElfdDmbx0HBV1TfRi0qf30QyCbTJxE/rEAs9MY6m01MxHXGMhzQbZJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945400; c=relaxed/simple;
	bh=kJgfoueXQ28rLrqGNrJr8ODUQjKNYTF//kczDLNyFVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0dfNbgCO/1VbWtBxQo8/cCECmvLI37vxUBWPxcbU6bEf+oSv2SiJjn+vfoJkitJ3mF3hPyRCgv7VXm+kO6Sh/NXCXs664gYzpoTSEM/DztTx5aaHjyG/71PMOdwtJa+TIs9sUOFc5Zajyg4wcBAhnBrQh1rTC7T4uGhvbkdTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kFi/Za6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA980C4CEEA;
	Tue, 29 Apr 2025 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945400;
	bh=kJgfoueXQ28rLrqGNrJr8ODUQjKNYTF//kczDLNyFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFi/Za6F2shpqj7I2lNWidwoO6rSIqiwme+GD3EmGPvq+PZPrx/24qoYqqj1kNMHG
	 AIP6P1E2MUElQD2E6hd4e2zuUNqptpqNeDN8uv2B29EKxmbuPstvhUE6SPF8VyPbCW
	 Gc9YN38m2/CcXZmlg9JzzMiCzFHykMsBGGqkqioM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Cengiz Can <cengiz.can@canonical.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 100/179] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Date: Tue, 29 Apr 2025 18:40:41 +0200
Message-ID: <20250429161053.447069737@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
 




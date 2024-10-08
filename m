Return-Path: <stable+bounces-82572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B985E994D6A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96B283E0D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7561DE89D;
	Tue,  8 Oct 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CDoFu+RZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06C1C9B99;
	Tue,  8 Oct 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392711; cv=none; b=a+Go0KEMyvE0Lu88Ga/7/ZsG6DaqyFiFtcT+dn0uTwGeOKReoI0Ljah/oV+qIu01LQDeoNst+rOzy3cmCTTkXPdDokFIjklEGUF0iJCtcEjS6fR5w9DoclB4RHo6Q+MlRoTbBre4kh5WyDAgZNwnr7DDuW2FsH1/hKJgSi7RgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392711; c=relaxed/simple;
	bh=WCUWbjCEHI3/jg8qIAsvDAtwWGCuJVKiO3ZW/+U6xaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCFXAYDfs+KxcSIlbj9xV4dy8ZD6CfVkuYCLQX5F7W47bT3ABq8floFrP/bCw3+5mZxtaYmrNiPPx5/PIWHClxMUVGjgQyvND4/KL17yxFnfaTvzaMkEwK+FEWylXk0f6/yX0RM1Bge/6Cu7eO744zCHKLCMlYt5WAIcIDGoJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CDoFu+RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26901C4CEC7;
	Tue,  8 Oct 2024 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392711;
	bh=WCUWbjCEHI3/jg8qIAsvDAtwWGCuJVKiO3ZW/+U6xaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDoFu+RZ3xr8qF05TRa87u0PmLj6SMLDxuZh/kHsS304lOb57HPeRJEIDpqNGQ+Gl
	 5MGnA4RPXKNlKECKtbHI9ZS3m/5wX5mpDhFfdWJAMW9zrecM9WVy+7I/i3I+VkW7LB
	 MfKH/6Fon1PcF9lWnxiJ7fy7H1MjmSm/sPAH/bVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Arendt <admin@prnet.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.11 496/558] btrfs: send: fix buffer overflow detection when copying path to cache entry
Date: Tue,  8 Oct 2024 14:08:46 +0200
Message-ID: <20241008115721.749005732@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 96c6ca71572a3556ed0c37237305657ff47174b7 upstream.

Starting with commit c0247d289e73 ("btrfs: send: annotate struct
name_cache_entry with __counted_by()") we annotated the variable length
array "name" from the name_cache_entry structure with __counted_by() to
improve overflow detection. However that alone was not correct, because
the length of that array does not match the "name_len" field - it matches
that plus 1 to include the NUL string terminator, so that makes a
fortified kernel think there's an overflow and report a splat like this:

  strcpy: detected buffer overflow: 20 byte write of buffer size 19
  WARNING: CPU: 3 PID: 3310 at __fortify_report+0x45/0x50
  CPU: 3 UID: 0 PID: 3310 Comm: btrfs Not tainted 6.11.0-prnet #1
  Hardware name: CompuLab Ltd.  sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
  RIP: 0010:__fortify_report+0x45/0x50
  Code: 48 8b 34 (...)
  RSP: 0018:ffff97ebc0d6f650 EFLAGS: 00010246
  RAX: 7749924ef60fa600 RBX: ffff8bf5446a521a RCX: 0000000000000027
  RDX: 00000000ffffdfff RSI: ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
  RBP: ffff8bf548574080 R08: ffffffffa8c40e10 R09: 0000000000005ffd
  R10: 0000000000000004 R11: ffffffffa8c70e10 R12: ffff8bf551eef400
  R13: 0000000000000000 R14: 0000000000000013 R15: 00000000000003a8
  FS:  00007fae144de8c0(0000) GS:ffff8bf84e780000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fae14691690 CR3: 00000001027a2003 CR4: 00000000001706f0
  Call Trace:
   <TASK>
   ? __warn+0x12a/0x1d0
   ? __fortify_report+0x45/0x50
   ? report_bug+0x154/0x1c0
   ? handle_bug+0x42/0x70
   ? exc_invalid_op+0x1a/0x50
   ? asm_exc_invalid_op+0x1a/0x20
   ? __fortify_report+0x45/0x50
   __fortify_panic+0x9/0x10
  __get_cur_name_and_parent+0x3bc/0x3c0
   get_cur_path+0x207/0x3b0
   send_extent_data+0x709/0x10d0
   ? find_parent_nodes+0x22df/0x25d0
   ? mas_nomem+0x13/0x90
   ? mtree_insert_range+0xa5/0x110
   ? btrfs_lru_cache_store+0x5f/0x1e0
   ? iterate_extent_inodes+0x52d/0x5a0
   process_extent+0xa96/0x11a0
   ? __pfx_lookup_backref_cache+0x10/0x10
   ? __pfx_store_backref_cache+0x10/0x10
   ? __pfx_iterate_backrefs+0x10/0x10
   ? __pfx_check_extent_item+0x10/0x10
   changed_cb+0x6fa/0x930
   ? tree_advance+0x362/0x390
   ? memcmp_extent_buffer+0xd7/0x160
   send_subvol+0xf0a/0x1520
   btrfs_ioctl_send+0x106b/0x11d0
   ? __pfx___clone_root_cmp_sort+0x10/0x10
   _btrfs_ioctl_send+0x1ac/0x240
   btrfs_ioctl+0x75b/0x850
   __se_sys_ioctl+0xca/0x150
   do_syscall_64+0x85/0x160
   ? __count_memcg_events+0x69/0x100
   ? handle_mm_fault+0x1327/0x15c0
   ? __se_sys_rt_sigprocmask+0xf1/0x180
   ? syscall_exit_to_user_mode+0x75/0xa0
   ? do_syscall_64+0x91/0x160
   ? do_user_addr_fault+0x21d/0x630
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fae145eeb4f
  Code: 00 48 89 (...)
  RSP: 002b:00007ffdf1cb09b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fae145eeb4f
  RDX: 00007ffdf1cb0ad0 RSI: 0000000040489426 RDI: 0000000000000004
  RBP: 00000000000078fe R08: 00007fae144006c0 R09: 00007ffdf1cb0927
  R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffdf1cb1ce8
  R13: 0000000000000003 R14: 000055c499fab2e0 R15: 0000000000000004
   </TASK>

Fix this by not storing the NUL string terminator since we don't actually
need it for name cache entries, this way "name_len" corresponds to the
actual size of the "name" array. This requires marking the "name" array
field with __nonstring and using memcpy() instead of strcpy() as
recommended by the guidelines at:

   https://github.com/KSPP/linux/issues/90

Reported-by: David Arendt <admin@prnet.org>
Link: https://lore.kernel.org/linux-btrfs/cee4591a-3088-49ba-99b8-d86b4242b8bd@prnet.org/
Fixes: c0247d289e73 ("btrfs: send: annotate struct name_cache_entry with __counted_by()")
CC: stable@vger.kernel.org # 6.11
Tested-by: David Arendt <admin@prnet.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7f48ba6c1c77..5871ca845b0e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -346,8 +346,10 @@ struct name_cache_entry {
 	u64 parent_gen;
 	int ret;
 	int need_later_update;
+	/* Name length without NUL terminator. */
 	int name_len;
-	char name[] __counted_by(name_len);
+	/* Not NUL terminated. */
+	char name[] __counted_by(name_len) __nonstring;
 };
 
 /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
@@ -2388,7 +2390,7 @@ out_cache:
 	/*
 	 * Store the result of the lookup in the name cache.
 	 */
-	nce = kmalloc(sizeof(*nce) + fs_path_len(dest) + 1, GFP_KERNEL);
+	nce = kmalloc(sizeof(*nce) + fs_path_len(dest), GFP_KERNEL);
 	if (!nce) {
 		ret = -ENOMEM;
 		goto out;
@@ -2400,7 +2402,7 @@ out_cache:
 	nce->parent_gen = *parent_gen;
 	nce->name_len = fs_path_len(dest);
 	nce->ret = ret;
-	strcpy(nce->name, dest->start);
+	memcpy(nce->name, dest->start, nce->name_len);
 
 	if (ino < sctx->send_progress)
 		nce->need_later_update = 0;
-- 
2.46.2





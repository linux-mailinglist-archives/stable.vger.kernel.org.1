Return-Path: <stable+bounces-223780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI0AEnzOr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:55:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E5246B28
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D924F3032774
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28963364EA5;
	Tue, 10 Mar 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu5SWn+v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96111364954
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129300; cv=none; b=kfsIW6Q5DmM2SkzDWiZ2rMMDxZ1aHA17JFeiiYNq9pCga35H6L1I3+NGlrAGibkbfeecXfNxQCEiWOUrsj4qj8YqmlRJ+kN73Qr//CX18mq7QPrSB0dnrsJ1fgON1XakQ/SdhABZaiXfSDlhbhNfVHEWhdIYHT6b/kmTHUCMQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129300; c=relaxed/simple;
	bh=EIPl/s34jrAmGYpuXVIZW16E7Jf/p7GwvfRwqQMJ0pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLaMU0yBRrGPLiQBH+lo+GzI0Ctiej9gby0Z/ZC9Jg+G1O9I30IiD1mU9kWHxyhtdaB7WEmMTeRmkQi80sSjC1/5c6WxDHLn1QGtr/SKQmyNflTmm8yu/ks9b/5Q3veNM/6SMJ/5HmvkbEXWw4SqJLjN7JhnAZuazVNj9nvu3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu5SWn+v; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829a27414a3so2159618b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773129299; x=1773734099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MeGJ6/I7dDVsZynsQyzX66bp2Bn9p9ixrGY7BHboZCM=;
        b=fu5SWn+vTIkoNQ4YeL0CvdQAZUsjGFkOYYgrXYJaUNEeD4TLZ30wX2rJn1jXUCL1Yd
         LSuTZb3uid3Zy0gd97vZSPxbmAiJG+venJChWV9g5FtrAyO5/OlYWNSCtlb90UrMuCEE
         WDexVagKtlXwekNOljk+SJnjccg6KaNArr6QgAekUlWyvnF4FcQTndxcDe77tcLHY2eP
         16f50FuQQegoRAp0ZOSoK67t9yGIDAbFdbqCeFMN+CyvWLTFX/Mw22gdOMbxWsqOv1gW
         DrYi5HZBaypo0jDTRBqB2uNAYp2DSAX3ez2+Xi/kZUJ9ugEfjoxMi75Hbdt1nVgLc+ja
         vZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773129299; x=1773734099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeGJ6/I7dDVsZynsQyzX66bp2Bn9p9ixrGY7BHboZCM=;
        b=c9yt9SEQkIyMiLaQURTOtsT72E9vKtbrr4U2XG8onnxzgxlISp/rwCYzJTI//+n0Nz
         RVqzuAxvI5Fuqz1fzbLchvLwv4FeE2xYWZ/HLLo/0Ja2sqX9TthueWVqHlwxg9vPU29J
         ZfqQw+KbcHTkoJtyRFUpfc8qqgxlaN6z+KsyUw+P4/WS+DOIXYVyR8IjIajJo3wTegqD
         DTGu3hYS8AKUT6FJmu2ilB+fi8bDGmPWSaEJmS3pojnjQfdloj4s7sOfWn3YhVEo+hlD
         GS3Q0WF9AeTCcEQK9HKZqb2Dvpo8hOP/RaqaIb8AthwqiEpNjvKPBu2jqta8tx2DT7Zg
         2I9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Sw+HnECOI8lm9BXCvCmcIRXro4q1+I5eR6CXQpVyCSvSXOYmWoBtuhvEemofskWpkVzVms8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJV3PBUquI3zBeKUIy0hGjmtyMTZ/Hqfe8B2Sxf0rNadOyoxO
	t0+ay0cTX5cskWkiKJkeYgN3T7XdhaUYolU4noo+rG1snMKdnrZjSKtW
X-Gm-Gg: ATEYQzzuPkz1T9NexAkZuI8WBgYquWRvdPfVxdXtDZKOF72gwGMzM/q9Z9YXcj++BXW
	Wm0Iq8SqqX7hkDFKQKzV7wdru7hEeL7gU+hO1GqGuER+JHK3UNJMZSVTbkvVfytn3I5AG6vrmDg
	pCTvMZCCOmvwPpGcOLIiZWj8MZOe7pr67wyk4iE6Q0K1CfjnYbDpdV0CsemzoBJbvNcCSC3VFuu
	dFDAQiStGiJlPaqLe+g0VlHh2z2fPBBiswqs8UAxNf1PMcP2TlJDodMiN4nnqteb3I/EzYQAUq9
	2b4C6RrJjyODBBNzvGZFNuI3JxRrZEKW/rfckzMATX28H+3UKbAlFUQO2eU/ZdfI80ZSv+Pofiz
	javktF/F7M5/MYiJDK1tyFoguqJ9WHp+y9xCc+NkAFXeJam60gPTWyLcYFJejw0p2ifd+trYfVx
	VNJfJrqobFd8q4ZlmUZgtkNEgl42AcP7OiS7y+TBzL8jtEGIAY5fMNKlmldrxOFwIJWlAONA==
X-Received: by 2002:a05:6a00:2d1e:b0:827:32c1:a1cc with SMTP id d2e1a72fcca58-829a2f4fd83mr11578207b3a.42.1773129298723;
        Tue, 10 Mar 2026 00:54:58 -0700 (PDT)
Received: from kernel-fuzz.. ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b2c41sm12433318b3a.54.2026.03.10.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:54:58 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com,
	wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: reloc: unlink orphan reloc roots before dropping them
Date: Tue, 10 Mar 2026 15:54:47 +0800
Message-ID: <20260310075447.2088205-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 930E5246B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223780-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

clean_dirty_subvols() walks rc->dirty_subvol_roots during relocation
recovery at mount time. That list can contain both normal subvolume
roots and orphan relocation roots.

For normal subvolume roots, clean_dirty_subvols() first removes
root->reloc_dirty_list from rc->dirty_subvol_roots and then drops the
associated relocation tree. But for orphan relocation roots it directly
calls btrfs_drop_snapshot(root, false, true) without unlinking
root->reloc_dirty_list first.

This leaves a freed btrfs_root still linked in rc->dirty_subvol_roots.
Later list_del_init() on a neighboring entry writes through that stale
list node, triggering a slab-use-after-free in clean_dirty_subvols().

Fix this by removing orphan relocation roots from
rc->dirty_subvol_roots before calling btrfs_drop_snapshot().

The bug is reproducible on 7.0.0-rc2-next-20260309 with our dynamic
metadata fuzzing tool that corrupts btrfs metadata at runtime. After
the fix, orphan relocation roots are removed from the dirty_subvol_roots
list before they can be freed, so the recovery path no longer writes
into freed memory.

Fixes: 30d40577e322 ("btrfs: reloc: Also queue orphan reloc tree for cleanup to avoid BUG_ON()")
Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
Root cause
==========
clean_dirty_subvols() walks rc->dirty_subvol_roots, which can contain
both normal subvolume roots and orphan relocation roots.

For normal roots, it first removes root->reloc_dirty_list from the list
before dropping the related relocation tree. But for orphan relocation
roots it calls btrfs_drop_snapshot(root, false, true) directly, without
unlinking root->reloc_dirty_list first.

btrfs_drop_snapshot() can free the last reference to root via
btrfs_put_root(), leaving a freed btrfs_root still linked in
rc->dirty_subvol_roots. Later list_del_init() on a neighboring entry
writes through that stale list node and triggers the slab-use-after-free.

Reproduction (v6.18, x86_64, KASAN)
===================================
The PoC is relatively large, so it is provided separately through google drive:
https://drive.google.com/drive/folders/1-e2ynmoQ4JzWs4F-jMtndh5pe3Vce2Zm

To reproduce the issue:
  1. Build the ublk helper program from the ublk codebase, which is
	 used to provide the runtime corruption capability:
	  g++ -std=c++20 -fcoroutines -O2 -o standalone_replay \
      standalone_replay_btrfs.cpp targets/ublksrv_tgt.cpp \
      -I. -Iinclude -Itargets/include \
      -L./lib/.libs -lublksrv -luring -lpthread
  2. Attach the crafted image through ublk:
      ./standalone_replay add -t loop -f /path/to/image
  3. Mount the image:
	  mount -o loop /path/to/image /mnt
This reliably reproduces the bug.

Fix
===
Remove orphan relocation roots from rc->dirty_subvol_roots before
calling btrfs_drop_snapshot() on them.

That restores the normal list lifetime rule:
  unlink from external containers first,
  then allow the final put/free to happen.

This is a minimal fix. Since both branches now call
list_del_init(&root->reloc_dirty_list), it may be possible to move the
unlink before the if/else and simplify the flow. I left that out here to
avoid changing more than needed, but I can respin the patch that way if
preferred.

KASAN reports
=============
BUG: KASAN: slab-use-after-free in __list_del include/linux/list.h:204 [inline]
BUG: KASAN: slab-use-after-free in __list_del_entry include/linux/list.h:226 [inline]
BUG: KASAN: slab-use-after-free in list_del_init include/linux/list.h:295 [inline]
BUG: KASAN: slab-use-after-free in clean_dirty_subvols+0x2dc/0x350 fs/btrfs/relocation.c:1472
Write of size 8 at addr ffff888014172838 by task syz-executor/265

CPU: 1 UID: 0 PID: 265 Comm: syz-executor Not tainted 6.18.0+ #14 PREEMPT(voluntary) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xd1/0x650 mm/kasan/report.c:482
 kasan_report+0xfb/0x140 mm/kasan/report.c:595
 __asan_report_store8_noabort+0x17/0x30 mm/kasan/report_generic.c:386
 __list_del include/linux/list.h:204 [inline]
 __list_del_entry include/linux/list.h:226 [inline]
 list_del_init include/linux/list.h:295 [inline]
 clean_dirty_subvols+0x2dc/0x350 fs/btrfs/relocation.c:1472
 btrfs_recover_relocation+0xe64/0x11d0 fs/btrfs/relocation.c:4207
 btrfs_start_pre_rw_mount+0xa4d/0x1810 fs/btrfs/disk-io.c:3130
 open_ctree+0x5824/0x5fe0 fs/btrfs/disk-io.c:3640
 btrfs_fill_super fs/btrfs/super.c:987 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
 btrfs_get_tree+0x111c/0x2190 fs/btrfs/super.c:2128
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 x64_sys_call+0x1a7d/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7dcca37a8fde
Code: 0f 1f 40 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc521c2e08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc521c31b0 RCX: 00007dcca37a8fde
RDX: 00007ffc521c35d0 RSI: 00007ffc521c31b0 RDI: 00007dcca3865d4f
RBP: 00007dcca3865d4f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000400 R11: 0000000000000246 R12: 00007ffc521c35d0
R13: 00007dcca3865dde R14: 00000000ffffffff R15: 585858582e7a7973
 </TASK>

Allocated by task 265:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 kasan_save_alloc_info+0x37/0x60 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xc3/0xd0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x25f/0x800 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 btrfs_alloc_root+0xb6/0xd20 fs/btrfs/disk-io.c:643
 read_tree_root_path+0x15d/0xaa0 fs/btrfs/disk-io.c:1025
 btrfs_read_tree_root+0x42/0x70 fs/btrfs/disk-io.c:1086
 btrfs_recover_relocation+0x298/0x11d0 fs/btrfs/relocation.c:4104
 btrfs_start_pre_rw_mount+0xa4d/0x1810 fs/btrfs/disk-io.c:3130
 open_ctree+0x5824/0x5fe0 fs/btrfs/disk-io.c:3640
 btrfs_fill_super fs/btrfs/super.c:987 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
 btrfs_get_tree+0x111c/0x2190 fs/btrfs/super.c:2128
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 x64_sys_call+0x1a7d/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 265:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x6f/0xa0 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kfree+0x2bf/0x6b0 mm/slub.c:6849
 btrfs_put_root fs/btrfs/disk-io.c:1851 [inline]
 btrfs_put_root+0x1f7/0x2f0 fs/btrfs/disk-io.c:1832
 btrfs_drop_snapshot+0x1e78/0x2a60 fs/btrfs/extent-tree.c:6286
 clean_dirty_subvols+0x23e/0x350 fs/btrfs/relocation.c:1496
 btrfs_recover_relocation+0xe64/0x11d0 fs/btrfs/relocation.c:4207
 btrfs_start_pre_rw_mount+0xa4d/0x1810 fs/btrfs/disk-io.c:3130
 open_ctree+0x5824/0x5fe0 fs/btrfs/disk-io.c:3640
 btrfs_fill_super fs/btrfs/super.c:987 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
 btrfs_get_tree+0x111c/0x2190 fs/btrfs/super.c:2128
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 x64_sys_call+0x1a7d/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888014172000
 which belongs to the cache kmalloc-rnd-06-4k of size 4096
The buggy address is located 2104 bytes inside of
 freed 4096-byte region [ffff888014172000, ffff888014173000)
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0765e06d00b8..2bff2db7afbd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1492,7 +1492,8 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			}
 			btrfs_put_root(root);
 		} else {
-			/* Orphan reloc tree, just clean it up */
+			/* Orphan reloc tree, unlink it first and clean it up */
+			list_del_init(&root->reloc_dirty_list);
 			ret2 = btrfs_drop_snapshot(root, false, true);
 			if (ret2 < 0) {
 				btrfs_put_root(root);
-- 
2.43.0



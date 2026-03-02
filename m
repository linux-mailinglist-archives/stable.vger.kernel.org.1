Return-Path: <stable+bounces-222579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNrjIix7pWm6CAYAu9opvQ
	(envelope-from <stable+bounces-222579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 12:57:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E381D7F1D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1AA3053DEA
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E27363C66;
	Mon,  2 Mar 2026 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqVrWA0e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA235DA4E
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452311; cv=none; b=tLgRFrIffEf6/Iomd0qoguNNcP5Q4JuVBOH/jeeczs5af8y1YofFScJue26o31x+tlMItMwKb8lCY3itE6CcmYCd/mp/5R9AilHMtP+ZlRFwL1L2UViMFyFJdR9KM9KHnikP2tCDtMHg3Bllxa0peaHgvkUkMztyKq4eCokLU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452311; c=relaxed/simple;
	bh=cBTNTu8wsct4xDAP8x/eQ9LfCPn4dV0ZWB+allT59jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQxItSeHa1psTpoRYPO3s7iRwKAgVpndd+m/H3bLWxsFrV84WmeESqg2YmwuqUGkoxF4+/FOCWSD5reo0rtygQlApKcklfENCRcNSmaL9Qk0597ajuRK1TzCI3+7xaRzDvfD5MsRTrOxjB6rks00kp9p2rmulw//hqtiBlibHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqVrWA0e; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c635d5d594dso811444a12.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772452308; x=1773057108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sla4sp/CP820e3qyeuY5JJkg3AL2LpPHMERTPUsLeqo=;
        b=QqVrWA0eOhN3h/takAjKzk3UR5IFfD1bVy6caLq3bAGbIatQjzeGX7IMoi6uBwbV+M
         HwSki9g9DXgrvpX0BIUy4dCRfaYuh9uHUk1IFX+DH65WbBLSsa4Rgr0w5YphdrVUlwdC
         sYHBwmhGxmVdi7r2Msbt+EuoEQMZyPqmjJBCIRDU7q/VaaFRpiJ45VxXKEEl4vNVDYNd
         bDKdjwf3jj2GuAQpCMyo3es/c0WaUiGg6Iuu66ZVoAzBCNBfFHae7PneQZ9ao9dWOcBB
         5kEsiBttKEaIOtOeWTkkoEJnVi06tN7eZdIPB+I3EOyWPv72+fSSVHw+Zyx8ggARqmj2
         KMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452308; x=1773057108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sla4sp/CP820e3qyeuY5JJkg3AL2LpPHMERTPUsLeqo=;
        b=uCD/YVdPzyyW7azf3VWwmrkUK71f/UujA5iLkbw0S+aw2CXI1mzPrfy/xQBojFoQUX
         yrFDrB8f8aq+VYQTbuicwK+gz57Fm4ZB9zwREeFmJvi6efP7rBDm+ysd0eKGoZdJlE9z
         fX+/zyaSNe3HihwzNNc0D24+2gGmiMaGejjnCD65wwGNf0cmUl7hBTHLtO86+TYc1Vq9
         Xe6o5UnRgKTcHA18ZwS0eqFSOs3a4xDZPhYvJIPUnv5OyB4QtHPzAjRFIDlKiLuo2M/o
         1B7CRZRfk+bJweMKQupAyyZFTtUDgVexikolwAZrrPSZ+zH+kYXwh04ZRrxLnO7HrxnA
         KXJg==
X-Forwarded-Encrypted: i=1; AJvYcCXWNfPPvk1qGB2uCDSUnorlEPb2sKXVSMjED1OM+GTy//ERiSqLhFQKXQq0Txc6OGcrXACMwAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4pAWs2zq70owhysu0tXWriPIEsneXVnZXA92ri0ckRXjYwbY
	K5wZ2rk+CVcH7FWVsW1z37LNH+4x8LPCUtSXnEh/9sBtnSEc2mJnmBXl
X-Gm-Gg: ATEYQzzJrbiBZlWbBCrh11HW6aQeW8mXe4Gi+TIWkEyaocG8hubzBwroonI04AB4/mA
	PfBw9QZQVtLaZXyT0qOjzQvOBROShdLM2sO7OMjCqIYppCpqkYRU5ssoQoLBIWN6kdiI0WWI3r+
	1sLqeCH/DA9FNYnLAeFhtELnWGZ/5eckRoiXOX2gwUz5doqwXiphFAC3OrXSb2cM4rJ8OHvxT+i
	FMcvQrSY7+u/AaGcNLTyfAlsiRnSqisRrb81SJzTDbOs/pkm/0L2XlRUzvzsaS9dENyWZdM8Yg3
	8vsZyn+p27/yvfJMMIhnZBKQ0LoqG1c8/KnUWdIO9ZdLVpWbvqKQXfh62i1diwdVm9FGtszqW/v
	1Aq/ZWx/AvodxNr+RQHzMTGk/YXDM8ByK8QPtYwLTCmHN2k1l6MxA/tjEUM2M0FowreDTJuRsFx
	gOYeVpPuw5l940a5QNxQrpbXcfouwzVcNVxtsFXA==
X-Received: by 2002:a17:90a:e7d1:b0:359:8f7e:d337 with SMTP id 98e67ed59e1d1-3598f7edb33mr1524276a91.7.1772452307753;
        Mon, 02 Mar 2026 03:51:47 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3598c765b87sm3617325a91.17.2026.03.02.03.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:51:47 -0800 (PST)
Message-ID: <0eb5ec7c-8724-4aff-a0af-30557be56937@gmail.com>
Date: Mon, 2 Mar 2026 19:51:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject global extent/csum roots without offset 0
 when extent_tree_v2 is off
To: ZhengYuan Huang <gality369@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com,
 zzzccc427@gmail.com, stable@vger.kernel.org
References: <20260302110202.790279-1-gality369@gmail.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260302110202.790279-1-gality369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222579-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[fb.com,suse.com,toxicpanda.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28E381D7F1D
X-Rspamd-Action: no action



On 2026/3/2 19:02, ZhengYuan Huang wrote:
> Without EXTENT_TREE_V2, btrfs_extent_root() and btrfs_csum_root() always
> look up the global roots at offset 0. A crafted image can provide only
> non-zero offsets for the extent/csum global roots, so the offset 0 lookup
> returns NULL and later leads to a NULL dereference
> (e.g. in backup_super_roots()).
> 
> Fix this by detecting this at mount time: when loading extent/csum
> global roots without EXTENT_TREE_V2, require that an offset 0 root item
> exists, otherwise fail the mount with -EUCLEAN.
> 
> Tested with a crafted image that has only non-zero offset global roots,
> which triggers the KASAN null-ptr-deref in backup_super_roots() before
> the fix, and fails the mount with -EUCLEAN after the fix.
> 
> Fixes: f7238e509404 ("btrfs: add support for multiple global roots")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
> A KASAN null-ptr-deref was triggered when mounting a crafted btrfs
> image and then doing a simple write/rename workload (e.g. moving any
> file into the mountpoint). The crash happens later during a transaction
> commit, in the super backup roots path.
> 
> Root cause
> ==========
> 
> backup_super_roots() looks up both the extent and csum roots through
> the "global roots" rb-tree:
> 
> extent_root = btrfs_extent_root(fs_info, 0);
> csum_root = btrfs_csum_root(fs_info, 0);
> 
> and then unconditionally dereferences extent_root->node and
> csum_root->node.
> 
> Both btrfs_extent_root() and btrfs_csum_root() build a key with:
> 
> .offset = btrfs_global_root_id(fs_info, bytenr)
> 
> and btrfs_global_root_id() returns 0 when the filesystem does not have
> the EXTENT_TREE_V2 incompat feature. This means that for
> non-extent_tree_v2 filesystems, the implementation assumes that there is
> always a global root item for:
> 
> (BTRFS_EXTENT_TREE_OBJECTID, BTRFS_ROOT_ITEM_KEY, offset=0)
> (BTRFS_CSUM_TREE_OBJECTID, BTRFS_ROOT_ITEM_KEY, offset=0)
> 
> However, an image without an offset = 0 root item can still be
> successfully mounted. The mount-time validation logic for the csum tree
> resides in load_global_roots_objectid(). Currently,
> load_global_roots_objectid() loads whatever root items exist for
> a given objectid, but it does not validate that offset = 0
> exists when EXTENT_TREE_V2 is not enabled. With a crafted image,
> the first (and only) root item for the csum tree (and similarly for
> extent) can have a large non-zero offset (e.g. 0x10000000000).
> load_global_roots_objectid() inserts that root into the rb-tree, but
> there is no entry for offset 0. Later, btrfs_csum_root(..., 0) looks up
> offset 0, returns NULL, and backup_super_roots() dereferences it,
> causing the crash.
> 
> So the bug is an invariant mismatch:
> 
> - lookup side (btrfs_{extent,csum}_root) assumes offset=0 exists when
> extent_tree_v2 is off
> 
> - load side (load_global_roots_objectid) does not enforce that assumption
> 
> Fix
> ===
> Teach load_global_roots_objectid() to enforce the "offset 0 must exist"
> invariant for the extent and csum trees when EXTENT_TREE_V2 is not enabled.
> If at least one root item is found but none has offset 0, fail the mount
> with -EUCLEAN and emit an explicit error message. This prevents later
> NULL dereferences and also avoids propagating a corrupted/unsupported
> global-root layout into runtime.
> 
> Note: extent_root is subject to the same assumption and is fixed by the
> same check (backup_super_roots dereferences extent_root->node as well).
> 
> KASAN report
> ============
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 UID: 0 PID: 34 Comm: kworker/u8:1 Tainted: G           OE       6.18.0 #1 PREEMPT(voluntary)
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Workqueue: events_unbound btrfs_async_reclaim_data_space
> RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1680 [inline]
> RIP: 0010:write_all_supers+0x2d56/0x4980 fs/btrfs/disk-io.c:4022
> Code: 40 38 f2 7f 08 84 d2 0f 85 72 19 00 00 49 8d 7c 24 18 41 88 9e 9a 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 fe 48 c1 ee 03 <80> 3c 16 00 0f 85 33 19 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
> RSP: 0018:ffff88800a617758 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000003 RDI: 0000000000000018
> RBP: ffff88800a617898 R08: 1ffff110023f53a8 R09: 0000000000000000
> R10: ffff8880173a8000 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff888000000000 R14: ffff88800b676d23 R15: ffffea0000000000
> FS:  0000000000000000(0000) GS:ffff8880e4d3e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005baa3c26f678 CR3: 000000000e9b8000 CR4: 00000000000006f0
> Call Trace:
> <TASK>
> ? __pfx_write_all_supers+0x10/0x10 fs/btrfs/disk-io.c:3980
> ? btrfs_commit_transaction+0x2818/0x3d90 fs/btrfs/transaction.c:2526
> ? __lock_release kernel/locking/lockdep.c:5574 [inline]
> ? lock_release+0x122/0x2a0 kernel/locking/lockdep.c:5889
> btrfs_commit_transaction+0x28cc/0x3d90 fs/btrfs/transaction.c:2541
> ? __pfx_btrfs_commit_transaction+0x10/0x10 fs/btrfs/transaction.c:1919
> ? start_transaction+0x244/0x1740 fs/btrfs/transaction.c:780
> btrfs_commit_current_transaction+0x55/0xf0 fs/btrfs/transaction.c:2010
> flush_space+0x7d1/0xc40 fs/btrfs/space-info.c:888
> ? mark_usage kernel/locking/lockdep.c:4674 [inline]
> ? __lock_acquire+0x43e/0x21e0 kernel/locking/lockdep.c:5191
> ? __pfx_flush_space+0x10/0x10 include/trace/events/btrfs.h:2362
> ? instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> ? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
> ? queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
> ? do_raw_spin_lock+0x133/0x290 kernel/locking/spinlock_debug.c:116
> ? find_held_lock+0x31/0x90 kernel/locking/lockdep.c:5350
> ? spin_unlock include/linux/spinlock.h:391 [inline]
> ? do_async_reclaim_data_space+0x369/0x5e0 fs/btrfs/space-info.c:1441
> ? __kasan_check_read+0x11/0x20 mm/kasan/shadow.c:31
> ? instrument_atomic_read include/linux/instrumented.h:68 [inline]
> ? atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> ? queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
> ? debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
> ? do_raw_spin_unlock+0x59/0x200 kernel/locking/spinlock_debug.c:141
> do_async_reclaim_data_space+0x3c1/0x5e0 fs/btrfs/space-info.c:1410
> btrfs_async_reclaim_data_space+0x3f/0xb0 fs/btrfs/space-info.c:1458
> process_one_work+0x8e0/0x1980 kernel/workqueue.c:3263
> ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:226
> ? move_linked_works+0x1a8/0x2c0 kernel/workqueue.c:1165
> ? assign_work+0x19d/0x240 kernel/workqueue.c:1206
> ? __lock_is_held kernel/locking/lockdep.c:5601 [inline]
> ? lock_is_held_type+0xa3/0x130 kernel/locking/lockdep.c:5940
> process_scheduled_works kernel/workqueue.c:3346 [inline]
> worker_thread+0x683/0xf80 kernel/workqueue.c:3427
> ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3570
> kthread+0x3f0/0x850 kernel/kthread.c:463
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ? trace_hardirqs_on+0x53/0x60 kernel/trace/trace_preemptirq.c:79
> ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
> ? _raw_spin_unlock_irq+0x27/0x70 kernel/locking/spinlock.c:202
> ? spin_unlock_irq include/linux/spinlock.h:401 [inline]
> ? calculate_sigpending+0x7c/0xb0 kernel/signal.c:194
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ret_from_fork+0x50f/0x610 arch/x86/kernel/process.c:158
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1680 [inline]
> RIP: 0010:write_all_supers+0x2d56/0x4980 fs/btrfs/disk-io.c:4022
> Code: 40 38 f2 7f 08 84 d2 0f 85 72 19 00 00 49 8d 7c 24 18 41 88 9e 9a 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 fe 48 c1 ee 03 <80> 3c 16 00 0f 85 33 19 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
> RSP: 0018:ffff88800a617758 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000003 RDI: 0000000000000018
> RBP: ffff88800a617898 R08: 1ffff110023f53a8 R09: 0000000000000000
> R10: ffff8880173a8000 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff888000000000 R14: ffff88800b676d23 R15: ffffea0000000000
> FS:  0000000000000000(0000) GS:ffff8880e4d3e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005baa3c26f678 CR3: 000000000e9b8000 CR4: 00000000000006f0
> ----------------
> Code disassembly (best guess):
>     0:	40 38 f2             	cmp    %sil,%dl
>     3:	7f 08                	jg     0xd
>     5:	84 d2                	test   %dl,%dl
>     7:	0f 85 72 19 00 00    	jne    0x197f
>     d:	49 8d 7c 24 18       	lea    0x18(%r12),%rdi
>    12:	41 88 9e 9a 00 00 00 	mov    %bl,0x9a(%r14)
>    19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>    20:	fc ff df
>    23:	48 89 fe             	mov    %rdi,%rsi
>    26:	48 c1 ee 03          	shr    $0x3,%rsi
> * 2a:	80 3c 16 00          	cmpb   $0x0,(%rsi,%rdx,1) <-- trapping instruction
>    2e:	0f 85 33 19 00 00    	jne    0x1967
>    34:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>    3b:	fc ff df
>    3e:	49                   	rex.WB
>    3f:	8b                   	.byte 0x8b
> 
> Reproduction (v6.18, x86_64, KASAN)
> ===================================
> 1. Download the crafted image (tested with Linux v6.18 + KASAN):
>    https://drive.google.com/file/d/1xV0pjI3N-D83IzH62dphWCAD0RR-sV4U/view
> 2. Attach it as a block device (example assumes it shows up as /dev/vda),
> then mount it read-write:
>    mkdir -p /mnt/btrfs
>    mount /dev/vda /mnt/btrfs
> 3. Trigger any metadata update, e.g. move a file into the mountpoint:
>    echo test > /tmp/1.txt
>    mv /tmp/1.txt /mnt/btrfs/
> 4. Result:
> The system hits a NULL pointer dereference in the commit path, with KASAN
> reporting the fault at backup_super_roots() (fs/btrfs/disk-io.c).
> 
> Thanks,
> ZhengYuan Huang
> ---
>   fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..900e462d8ea1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2119,6 +2119,18 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
>   	};
>   	bool found = false;
>   
> +	/*
> +	 * Without EXTENT_TREE_V2 we only have a single global extent/csum root.
> +	 * btrfs_extent_root() and btrfs_csum_root() always look it up with offset
> +	 * 0 (btrfs_global_root_id() returns 0). If we load only non-zero offsets
> +	 * here, later users will see NULL and can crash (e.g. when backing up
> +	 * super roots during a commit).
> +	 */
> +	bool need_offset0 = !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2) &&
> +		      (objectid == BTRFS_EXTENT_TREE_OBJECTID ||
> +		       objectid == BTRFS_CSUM_TREE_OBJECTID);
> +	bool found_offset0 = false;
> +
>   	/* If we have IGNOREDATACSUMS skip loading these roots. */
>   	if (objectid == BTRFS_CSUM_TREE_OBJECTID &&
>   	    btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
> @@ -2144,6 +2156,8 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
>   		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>   		if (key.objectid != objectid)
>   			break;
> +		if (need_offset0 && key.offset == 0)
> +			found_offset0 = true;
>   		btrfs_release_path(path);
>   
>   		/*
> @@ -2169,6 +2183,13 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
>   	}
>   	btrfs_release_path(path);
>   
> +	if (need_offset0 && found && !found_offset0) {
> +		btrfs_err(fs_info,
> +			  "missing global %s root item with offset 0 (extent_tree_v2 not enabled)",
> +			  name);
> +		return -EUCLEAN;
> +	}
> +
>   	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
>   		fs_info->nr_global_roots = max_global_id + 1;
>   

I wonder if it would be better to put this check in 
read_tree_root_path() because that's where the trees are loaded so we 
can fail fast and prevent loading the corrupted root rather than 
allowing it to be inserted into the rb-tree first.

Thanks,
Sun YangKai



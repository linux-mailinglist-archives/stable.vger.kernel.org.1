Return-Path: <stable+bounces-124923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24FA68E84
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907D03B43A6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2911D54D6;
	Wed, 19 Mar 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lr4mL5vt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F91D514F;
	Wed, 19 Mar 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393086; cv=none; b=ItWYigyIO191QJPeUjnzB3kJMPLKAcBdEvANfy2lwAYe9mCadx667AXeafQD5R1FELsN3Hz8mOCOoT+ePP+yx9oA9LKwVxvUMgXa2lmLchxNsLD2JQrE3nj2zzqsdcpPWxj8JNQH3X7MliU7/zSTB/zjkCHootZAhKEdY5ji5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393086; c=relaxed/simple;
	bh=XLseAtVuZGTyV4UnXu78XBm/IOdbX1Pv0cEyqyRv/F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsF0PiFjkv4nDaSEuDxrbBGfPr4hCCeWsujj9YDIO5c7WBad81sqe9syMeaUuz08rfb8e2v93HVsZ4lsCvHQ39olMdmXOcyh2AeE12BF1UDQNW/MvOUgcouMZZoAL5FobQrSo+Q84YLgF0AyQditCNFMiDQmzFkE8UwUgl1vN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lr4mL5vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5491CC4CEE9;
	Wed, 19 Mar 2025 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742393085;
	bh=XLseAtVuZGTyV4UnXu78XBm/IOdbX1Pv0cEyqyRv/F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lr4mL5vthnchBidBqeX/PhFJeLNf2cnh6HwecJptmGMC2gwUNW0q6ind2lia+zL95
	 em7yXDmLmVipN7mxFXMmCONDhJk9RPEa1R5EKZ4jNpe2fzQpRwsdPHzYs9l7HBBquY
	 CfoW+Sg1E5rdq/RXH1Sei3lvac+cCZb433qzoQVA=
Date: Wed, 19 Mar 2025 07:03:26 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Cliff Liu <donghua.liu@windriver.com>
Cc: stable@vger.kernel.org, sfrench@samba.org, pc@cjr.nz,
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, paul@darkrain42.org,
	Zhe.He@windriver.com
Subject: Re: [PATCH 6.1.y] smb: prevent use-after-free due to open_cached_dir
 error paths
Message-ID: <2025031913-unclaimed-ocean-06f5@gregkh>
References: <20250319090839.3631424-1-donghua.liu@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319090839.3631424-1-donghua.liu@windriver.com>

On Wed, Mar 19, 2025 at 05:08:39PM +0800, Cliff Liu wrote:
> From: Paul Aurich <paul@darkrain42.org>
> 
> If open_cached_dir() encounters an error parsing the lease from the
> server, the error handling may race with receiving a lease break,
> resulting in open_cached_dir() freeing the cfid while the queued work is
> pending.
> 
> Update open_cached_dir() to drop refs rather than directly freeing the
> cfid.
> 
> Have cached_dir_lease_break(), cfids_laundromat_worker(), and
> invalidate_all_cached_dirs() clear has_lease immediately while still
> holding cfids->cfid_list_lock, and then use this to also simplify the
> reference counting in cfids_laundromat_worker() and
> invalidate_all_cached_dirs().
> 
> Fixes this KASAN splat (which manually injects an error and lease break
> in open_cached_dir()):
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in smb2_cached_lease_break+0x27/0xb0
> Read of size 8 at addr ffff88811cc24c10 by task kworker/3:1/65
> 
> CPU: 3 UID: 0 PID: 65 Comm: kworker/3:1 Not tainted 6.12.0-rc6-g255cf264e6e5-dirty #87
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> Workqueue: cifsiod smb2_cached_lease_break
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x77/0xb0
>  print_report+0xce/0x660
>  kasan_report+0xd3/0x110
>  smb2_cached_lease_break+0x27/0xb0
>  process_one_work+0x50a/0xc50
>  worker_thread+0x2ba/0x530
>  kthread+0x17c/0x1c0
>  ret_from_fork+0x34/0x60
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Allocated by task 2464:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  open_cached_dir+0xa7d/0x1fb0
>  smb2_query_path_info+0x43c/0x6e0
>  cifs_get_fattr+0x346/0xf10
>  cifs_get_inode_info+0x157/0x210
>  cifs_revalidate_dentry_attr+0x2d1/0x460
>  cifs_getattr+0x173/0x470
>  vfs_statx_path+0x10f/0x160
>  vfs_statx+0xe9/0x150
>  vfs_fstatat+0x5e/0xc0
>  __do_sys_newfstatat+0x91/0xf0
>  do_syscall_64+0x95/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Freed by task 2464:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x51/0x70
>  kfree+0x174/0x520
>  open_cached_dir+0x97f/0x1fb0
>  smb2_query_path_info+0x43c/0x6e0
>  cifs_get_fattr+0x346/0xf10
>  cifs_get_inode_info+0x157/0x210
>  cifs_revalidate_dentry_attr+0x2d1/0x460
>  cifs_getattr+0x173/0x470
>  vfs_statx_path+0x10f/0x160
>  vfs_statx+0xe9/0x150
>  vfs_fstatat+0x5e/0xc0
>  __do_sys_newfstatat+0x91/0xf0
>  do_syscall_64+0x95/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60
>  __kasan_record_aux_stack+0xad/0xc0
>  insert_work+0x32/0x100
>  __queue_work+0x5c9/0x870
>  queue_work_on+0x82/0x90
>  open_cached_dir+0x1369/0x1fb0
>  smb2_query_path_info+0x43c/0x6e0
>  cifs_get_fattr+0x346/0xf10
>  cifs_get_inode_info+0x157/0x210
>  cifs_revalidate_dentry_attr+0x2d1/0x460
>  cifs_getattr+0x173/0x470
>  vfs_statx_path+0x10f/0x160
>  vfs_statx+0xe9/0x150
>  vfs_fstatat+0x5e/0xc0
>  __do_sys_newfstatat+0x91/0xf0
>  do_syscall_64+0x95/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The buggy address belongs to the object at ffff88811cc24c00
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 16 bytes inside of
>  freed 1024-byte region [ffff88811cc24c00, ffff88811cc25000)
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Aurich <paul@darkrain42.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> [ Do not apply the change for cfids_laundromat_worker() since there is no
>   this function and related feature on 6.1.y. Update open_cached_dir()
>   according to method of upstream patch. ]
> Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
> Signed-off-by: He Zhe <Zhe.He@windriver.com>
> ---
> Verified the build test.
> ---
>  fs/smb/client/cached_dir.c | 39 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)

No upstream git id :(


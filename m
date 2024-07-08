Return-Path: <stable+bounces-58233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A6192A363
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9246281A92
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86E446AE;
	Mon,  8 Jul 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xAVVLQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9D1E487
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443705; cv=none; b=As5klDO5wa0QjFdRkfxevNEVuQoscibR++8haDInZGBulpKhmTwJi0z54M4bXCImDRD4RtGe8A12XfDZztdJsD0sByVeOonhgry+yO9Yoxgy6aRL8YVH7TxxF4dLWoXg8Kd9bSI2VpbNdXE862UpA+XTqO0A5J2Zvhnys+Rx3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443705; c=relaxed/simple;
	bh=/4WCjZczKccBGWquuYp3g0s4W+onyG2WoVqLhFIsgiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHDSRzgQHZ3+vsVCgcWSO5oZqo1Bap9luhRclsmoy9H0ru0EZ8U5PO7oc6jy8FwqlWXyz0qK6YZdNh9dhaA92jWMNBHY19hqA/4UE0DWgTx8hs2aCymXnVm33+I3BinzQplfxtqGfYnQaz+MXCbUW5ozpMV24E/g6jyy+5q2I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xAVVLQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7CC32786;
	Mon,  8 Jul 2024 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443704;
	bh=/4WCjZczKccBGWquuYp3g0s4W+onyG2WoVqLhFIsgiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0xAVVLQozQ6RNJNxteXn3BRCT3JeFXjPnTfO54lvgceX1rkddbIXisztfHAW5K2VM
	 6oCIsw3HzGQcRX4zy8u71RLaDB9NgpRyK8UerNhNCKFYwnyH+X3UA2nEXyuI9AWQGl
	 dGnU17IcHf6yV7xaGg6urn69XsZ1sHD2AD6kibmk=
Date: Mon, 8 Jul 2024 15:01:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: stable@vger.kernel.org, GUO Zihua <guozihua@huawei.com>,
	casey@schaufler-ca.com, john.johansen@canonical.com,
	paul@paul-moore.com, Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
Message-ID: <2024070828-untaken-depletion-4e4a@gregkh>
References: <20240707120439.34700-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707120439.34700-1-zohar@linux.ibm.com>

On Sun, Jul 07, 2024 at 08:04:39AM -0400, Mimi Zohar wrote:
> From: GUO Zihua <guozihua@huawei.com>
> 
> A panic happens in ima_match_policy:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh
> Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39
>       7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d
>       f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea
>       44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000)
> GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
> 
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
> 
> The root cause of this issue could be described as follows:
> |	Thread A	|	Thread B	|
> |			|ima_match_policy	|
> |			|  rcu_read_lock	|
> |ima_lsm_update_rule	|			|
> |  synchronize_rcu	|			|
> |			|    kmalloc(GFP_KERNEL)|
> |			|      sleep		|
> ==> synchronize_rcu returns early
> |  kfree(entry)		|			|
> |			|    entry = entry->next|
> ==> UAF happens and entry now becomes NULL (or could be anything).
> |			|    entry->action	|
> ==> Accessing entry might cause panic.
> 
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> [PM: fixed missing comment, long lines, !CONFIG_IMA_LSM_RULES case]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> (cherry picked from commit 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34)
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Backport notes:
> - Restore default return value parameter to call_int_hook() in
> security_audit_rule_init() in lieu of backporting commit 260017f31a8c
> ("lsm: use default hook return value in call_int_hook()").
> - Applies to linux-6.8.y -> linux-6.4.y

Now applied to 6.6.y, thanks.

greg k-h


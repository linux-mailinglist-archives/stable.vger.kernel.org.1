Return-Path: <stable+bounces-94499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2819D4814
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9EE282B32
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA61C6F54;
	Thu, 21 Nov 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k8BHl7OD"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BC74068
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173220; cv=none; b=muM/F5Ke61TvbV5EDszjAZVYh5uS8G7z9SKlKe1eXeAxNk+IDPcWFkW7iz3L9N5VozwtbCJmYp7OZ5lQUlwvT4kHD5GJRHFafQAuQifiMcHZUU9Rz4haiJykX+B1T0XhqZQe2dfHRlbrwStK0HR/5ZMQ1ZI29XEsalZ3E7p6VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173220; c=relaxed/simple;
	bh=ZdtcRGuoD+Ca4BKJDAGtcJ3uRdaPjR+5VXsrjmlCrkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFfi8w0DZyvYqcjCZkbNLnKH289i2ZlWO1t8/NtgSMPDIPEmrdbT5+UuOL/XoDpWyEk5Rwa4m68+Xp5YsSOn++cKXSUXj+8xsXTKOb1KeJmX5LL4nBLvCwhvqgXxs5BgpArfcu6TaIw3BgaSx/FHgou/xSJckeqKk+yWDx5s268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k8BHl7OD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Nov 2024 02:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732173215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWzfaTsisouCF2LkybWdw+yxRSbA4FHIaRn6cX6D6Qc=;
	b=k8BHl7OD2UxBhT3PEyFryrRZj3NNPozFDOTiIv2x7/T1uarvbC7CQvbWrT68z+b56INDV1
	kHFL1i6sTqTYUb4Lz7OU3Hn/sILuX1d5RB87DikqzNi+uO0Ug5AwMTJMLp4F9sMvq8Yu4w
	FoV5wgOYqqQzs6yjwYIc6M3rIVTJAsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bin Lan <bin.lan.cn@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] closures: Change BUG_ON() to WARN_ON()
Message-ID: <a6vuwspqjsba6hpparaas3knatqv7ictvoqc7tpgdujwzpcwxv@qudc5qgc52tq>
References: <20241121064607.3768607-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121064607.3768607-1-bin.lan.cn@windriver.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 21, 2024 at 02:46:07PM +0800, Bin Lan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [ Upstream commit 339b84ab6b1d66900c27bd999271cb2ae40ce812 ]
> 
> If a BUG_ON() can be hit in the wild, it shouldn't be a BUG_ON()
> 
> For reference, this has popped up once in the CI, and we'll need more
> info to debug it:
> 
> 03240 ------------[ cut here ]------------
> 03240 kernel BUG at lib/closure.c:21!
> 03240 kernel BUG at lib/closure.c:21!
> 03240 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> 03240 Modules linked in:
> 03240 CPU: 15 PID: 40534 Comm: kworker/u80:1 Not tainted 6.10.0-rc4-ktest-ga56da69799bd #25570
> 03240 Hardware name: linux,dummy-virt (DT)
> 03240 Workqueue: btree_update btree_interior_update_work
> 03240 pstate: 00001005 (nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> 03240 pc : closure_put+0x224/0x2a0
> 03240 lr : closure_put+0x24/0x2a0
> 03240 sp : ffff0000d12071c0
> 03240 x29: ffff0000d12071c0 x28: dfff800000000000 x27: ffff0000d1207360
> 03240 x26: 0000000000000040 x25: 0000000000000040 x24: 0000000000000040
> 03240 x23: ffff0000c1f20180 x22: 0000000000000000 x21: ffff0000c1f20168
> 03240 x20: 0000000040000000 x19: ffff0000c1f20140 x18: 0000000000000001
> 03240 x17: 0000000000003aa0 x16: 0000000000003ad0 x15: 1fffe0001c326974
> 03240 x14: 0000000000000a1e x13: 0000000000000000 x12: 1fffe000183e402d
> 03240 x11: ffff6000183e402d x10: dfff800000000000 x9 : ffff6000183e402e
> 03240 x8 : 0000000000000001 x7 : 00009fffe7c1bfd3 x6 : ffff0000c1f2016b
> 03240 x5 : ffff0000c1f20168 x4 : ffff6000183e402e x3 : ffff800081391954
> 03240 x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000a8000000
> 03240 Call trace:
> 03240  closure_put+0x224/0x2a0
> 03240  bch2_check_for_deadlock+0x910/0x1028
> 03240  bch2_six_check_for_deadlock+0x1c/0x30
> 03240  six_lock_slowpath.isra.0+0x29c/0xed0
> 03240  six_lock_ip_waiter+0xa8/0xf8
> 03240  __bch2_btree_node_lock_write+0x14c/0x298
> 03240  bch2_trans_lock_write+0x6d4/0xb10
> 03240  __bch2_trans_commit+0x135c/0x5520
> 03240  btree_interior_update_work+0x1248/0x1c10
> 03240  process_scheduled_works+0x53c/0xd90
> 03240  worker_thread+0x370/0x8c8
> 03240  kthread+0x258/0x2e8
> 03240  ret_from_fork+0x10/0x20
> 03240 Code: aa1303e0 d63f0020 a94363f7 17ffff8c (d4210000)
> 03240 ---[ end trace 0000000000000000 ]---
> 03240 Kernel panic - not syncing: Oops - BUG: Fatal exception
> 03240 SMP: stopping secondary CPUs
> 03241 SMP: failed to stop secondary CPUs 13,15
> 03241 Kernel Offset: disabled
> 03241 CPU features: 0x00,00000003,80000008,4240500b
> 03241 Memory Limit: none
> 03241 ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 03246 ========= FAILED TIMEOUT copygc_torture_no_checksum in 7200s
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> [ Resolve minor conflicts to fix CVE-2024-42252 ]
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>

I don't think this is needed on 6.1, this came up in bcachefs where
we're using closures for refcounting btree_trans objects, and there was
a crazy bug in the debugfs code... fixed awhile ago

harmless if you want it just in case, though

> ---
>  drivers/md/bcache/closure.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
> index d8d9394a6beb..18f21d4e9aaa 100644
> --- a/drivers/md/bcache/closure.c
> +++ b/drivers/md/bcache/closure.c
> @@ -17,10 +17,16 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
>  {
>  	int r = flags & CLOSURE_REMAINING_MASK;
>  
> -	BUG_ON(flags & CLOSURE_GUARD_MASK);
> -	BUG_ON(!r && (flags & ~CLOSURE_DESTRUCTOR));
> +	if (WARN(flags & CLOSURE_GUARD_MASK,
> +		 "closure has guard bits set: %x (%u)",
> +		 flags & CLOSURE_GUARD_MASK, (unsigned) __fls(r)))
> +		r &= ~CLOSURE_GUARD_MASK;
>  
>  	if (!r) {
> +		WARN(flags & ~CLOSURE_DESTRUCTOR,
> +		     "closure ref hit 0 with incorrect flags set: %x (%u)",
> +		     flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
> +
>  		if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
>  			atomic_set(&cl->remaining,
>  				   CLOSURE_REMAINING_INITIALIZER);
> -- 
> 2.43.0
> 


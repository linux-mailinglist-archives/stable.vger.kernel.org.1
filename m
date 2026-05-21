Return-Path: <stable+bounces-253623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP4+MTs/D2pNIQYAu9opvQ
	(envelope-from <stable+bounces-253623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:22:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752B5AA202
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E76713017474
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D38381B02;
	Thu, 21 May 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpAQ/8z3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75686285061;
	Thu, 21 May 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383906; cv=none; b=bEk8/gLKd3zWKimFBDlOMwaCTVlxGL1o6chtnrd01J4uwLI0OfV/7yN8RXiGfj+4lsaUBiV8M6p7KBD1zszTCvn7MGIUqPm+FjaWU5csFQwAukAHKTYt1m+D+vEZOopVq7a08dD2EYGH/fSrO0YFfHuCnqgrFSa42IfUgMqN9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383906; c=relaxed/simple;
	bh=1FFzbSET8Jfr0Rj/ispWGpVvBj4/otDQTXU2PVdHJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D21Sknj011ufSR1Mk1UJY/z7W5QTA2EB80KIvXfO/mVVi1uqOzmhGlnMCmUmtXbQUBTu9PHC4xXr79GkNA0ZGxx+nEGtTfmNKwfBQhEb2ZyEivANDzT12SLcce5T+RDHwW+sEpzyQG013HP9JCPoaWAnUNHcebk0xW11bO0eZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpAQ/8z3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E800C1F000E9;
	Thu, 21 May 2026 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383905;
	bh=utOrpvAt2DIKWC27h0eoljunYtuvUSFFvSGKLfKbA4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OpAQ/8z3b/0T/j75g6RvTPaFxzwduoCyRSu1Hv8cP67INeH/04GdK8etCF7aGOji6
	 ygSp77cLfon8klBEj8iSODK2HcW3qfCCZSvpymcHCsw27JkuAEBjSN7AhPNXiZcNdF
	 d26qqNzYl+bKpq6pQk8XDSEo2U95d994KkETuxXSbDf6cmwT6AxSbMbNG8ezkPnfd9
	 EovetmmdzoArAwceHaCwF3Lw1KYhk1dZBhKCYZgXbdyGgUWs6VObgOW0a4/rSWuQpT
	 pVA4NPxXOFU9kkB5tr1Up4V/l7Z71tQrdMp6uVHklLVlm+gPZEM9GsGt+/Xp2UWhrq
	 NknTsa+QaX8xg==
Date: Thu, 21 May 2026 07:18:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] writeback: fix race between
 cgroup_writeback_umount() and inode_switch_wbs()
Message-ID: <ag8-YOCHsfySqcdH@slm.duckdns.org>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
 <20260521095016.2791354-2-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521095016.2791354-2-libaokun@linux.alibaba.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,alibaba.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6752B5AA202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 05:50:14PM +0800, Baokun Li wrote:
> When a container exits, the following BUG_ON() is occasionally triggered:
> 
> ==================================================================
>  VFS: Busy inodes after unmount of sdb (ext4)
>  ------------[ cut here ]------------
>  kernel BUG at fs/super.c:695!
>  CPU: 3 PID: 6 Comm: containerd-shim Tainted: G OE K 6.6 #1
>  pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>  pc : generic_shutdown_super+0xf0/0x100
>  lr : generic_shutdown_super+0xf0/0x100
>  Call trace:
>   generic_shutdown_super+0xf0/0x100
>   kill_block_super+0x20/0x48
>   ext4_kill_sb+0x28/0x60
>   deactivate_locked_super+0x54/0x130
>   deactivate_super+0x84/0xa0
>   cleanup_mnt+0xa4/0x140
>   __cleanup_mnt+0x18/0x28
>   task_work_run+0x78/0xe0
>   do_notify_resume+0x204/0x240
> ==================================================================
> 
> The root cause is a race between cgroup_writeback_umount() and
> inode_switch_wbs()/cleanup_offline_cgwb(). There is a window between
> inode_prepare_wbs_switch() returning true and the subsequent
> wb_queue_isw() call. Following is the process that triggers the issue:
> 
>       CPU A (umount)           |          CPU B (writeback)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                  inode_switch_wbs/cleanup_offline_cgwb
>                                   atomic_inc(&isw_nr_in_flight)
>                                   inode_prepare_wbs_switch
>                                    -> passes SB_ACTIVE check
>                                    __iget(inode)
>  generic_shutdown_super
>   sb->s_flags &= ~SB_ACTIVE
>   cgroup_writeback_umount(sb)
>    smp_mb()
>    atomic_read(&isw_nr_in_flight)
>    rcu_barrier()
>     -> no pending RCU callbacks
>    flush_workqueue(isw_wq)
>     -> nothing queued, returns
>   evict_inodes(sb)
>    -> Inode skipped as isw still holds a ref.
>   sop->put_super(sb)
>    /* destroys percpu counters */
>   -> VFS: Busy inodes after unmount!
>                                   wb_queue_isw()
>                                    queue_work(isw_wq, ...)
>                                   /* later in work function */
>                                   inode_switch_wbs_work_fn
>                                    process_inode_switch_wbs
>                                     iput() -> evict
>                                      percpu_counter_dec() // UAF!
> 
> Fix this by extending the RCU read-side critical section in
> inode_switch_wbs() and cleanup_offline_cgwb() to cover from
> inode_prepare_wbs_switch() through wb_queue_isw().  Since there is
> no sleep in this window, rcu_read_lock() can be used.  Then add a
> synchronize_rcu() in cgroup_writeback_umount() before the existing
> rcu_barrier(), so that all in-flight switchers that have passed the
> SB_ACTIVE check have completed queue_work() before flush_workqueue()
> is called.
> 
> The existing rcu_barrier() is intentionally retained so this fix can
> be backported unchanged to stable kernels (5.10.y, 6.6.y, ...) that
> still queue switches via queue_rcu_work(). It is a no-op on current
> mainline (since commit e1b849cfa6b6 ("writeback: Avoid contention on
> wb->list_lock when switching inodes")) and is removed in a follow-up
> patch.
> 
> Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
> Cc: stable@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/all/mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun


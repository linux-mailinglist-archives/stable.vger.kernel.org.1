Return-Path: <stable+bounces-78476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F698BBD8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6032845CF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0991C1ACA;
	Tue,  1 Oct 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDc3RKZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A2186607
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784692; cv=none; b=Mk9Z8qY6WqVzx7aHK48wwbvbKt7ClI6ehV3O3aoWdOOomrT/gECsHkJavBkeEiNljgD7pcJVMK9fUa8pGYAYadn+oIGMu8C5ohNWlNQT6wy78jOfKPqGOvDRW+1tZOO1N0OC48myIITDm0KPuCT05yZEGv6mWdSo8frX6GDTZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784692; c=relaxed/simple;
	bh=K3ORtXA85326oUgcI1q3EVGjms5k5Y9v/9T2MrgVkK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAl7l5LDIjP7CQmxQLLR/aoeZkNSZko8rRf6j6MjtlICrTCKlvCo76pX8g1xpoXlAeOfQN9rpld2hhaiiR9kg3PWl6oi14qPRZ87rMD9kVQFlCifamPcSkmzTR+DkAbhRW57rfbnbF5BLCCwwssonuI+s7GGRhH90TC7rW/Vgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDc3RKZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D95DC4CEC6;
	Tue,  1 Oct 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727784690;
	bh=K3ORtXA85326oUgcI1q3EVGjms5k5Y9v/9T2MrgVkK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDc3RKZH72t8qSalvVQxSTJNf5haJH9Cjx2rdHo2xF11OFHDdgcSFzMoi5OUpjew9
	 36KrfXHTW+KqCBHI0/rz0RJFkfvBgqp/td9t/GHuVpcf5RtV/AyCUfCeZEs7+wnZcZ
	 TuPhmYd/sM+CfkR4/kX+Rv3rvwUyIkDTIKmNqx4A=
Date: Tue, 1 Oct 2024 14:11:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, jiri@nvidia.com,
	sashal@kernel.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <2024100135-siren-vocalist-0299@gregkh>
References: <20241001112035.973187-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001112035.973187-1-idosch@nvidia.com>

On Tue, Oct 01, 2024 at 02:20:35PM +0300, Ido Schimmel wrote:
> When a devlink instance is unregistered the following happens (among
> other things):
> 
> t0 - The instance is marked with 'DEVLINK_UNREGISTERING'.
> t1 - Blocking until an RCU grace period passes.
> t2 - The 'DEVLINK_UNREGISTERING' mark is cleared from the instance.
> 
> When iterating over devlink instances (f.e., when requesting a dump of
> available instances) and encountering an instance that is currently
> being unregistered, the current code will loop around until the
> 'DEVLINK_UNREGISTERING' mark is cleared.
> 
> The iteration over devlink instances happens in an RCU critical section,
> so if the instance that is currently being unregistered was encountered
> between t0 and t1, the system will deadlock and RCU stalls will be
> reported [1]. The task unregistering the instance will forever wait for an
> RCU grace period to pass and the task iterating over the instances will
> forever wait for the mark to be cleared.
> 
> The issue can be reliably reproduced by increasing the time window
> between t0 and t1 (used a 60 seconds sleep) and running the following
> reproducer [2].
> 
> Fix by skipping over instances that are currently being unregistered.
> 
> [1]
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-7): P344
>  (detected by 4, t=26002 jiffies, g=5773, q=12 ncpus=8)
> task:devlink         state:R  running task     stack:25568 pid:344   ppid:260    flags:0x00004002
> [...]
> Call Trace:
>  xa_get_mark+0x184/0x3e0
>  devlinks_xa_find_get.constprop.0+0xc6/0x2e0
>  devlink_nl_cmd_get_dumpit+0x105/0x3f0
>  netlink_dump+0x568/0xff0
>  __netlink_dump_start+0x651/0x900
>  genl_family_rcv_msg_dumpit+0x201/0x340
>  genl_rcv_msg+0x573/0x780
>  netlink_rcv_skb+0x15f/0x430
>  genl_rcv+0x29/0x40
>  netlink_unicast+0x546/0x800
>  netlink_sendmsg+0x958/0xe60
>  __sys_sendto+0x3a2/0x480
>  __x64_sys_sendto+0xe1/0x1b0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x68/0xd2
> 
> [2]
>  # echo 10 > /sys/bus/netdevsim/new_device
>  # echo 10 > /sys/bus/netdevsim/del_device &
>  # devlink dev
> 
> Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")
> Reported-by: Vivek Reddy Karri <vkarri@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> I read the stable rules and I am not providing an "upstream commit ID"
> since the code in upstream has been reworked, making this fix
> irrelevant. The only affected stable kernel is 6.1.y.

You need to document the heck out of why this is only relevant for this
one specific kernel branch IN the changelog text, so that we understand
what is going on, AND you need to get acks from the relevant maintainers
of this area of the kernel to accept something that is not in Linus's
tree.

But first of, why?  Why not just take the upstrema commits instead?

thanks,

greg k-h


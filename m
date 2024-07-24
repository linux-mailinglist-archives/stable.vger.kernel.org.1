Return-Path: <stable+bounces-61311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DD93B59F
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E822849B8
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC715F308;
	Wed, 24 Jul 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu0vtcwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925B15ECEC;
	Wed, 24 Jul 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841237; cv=none; b=r2bumrolDuz75BoVQMvvsHSbLNtklwNG6ZBlgVuU4kA81DZwNQTQ5b2u28RYtEmmFYb87Pw8UMp5prhyzUS00z4gjr/+4ioZtpHp1WLvJNwvMRTk2P/I7NVpntignoYXZhDyxQEjbn6MwmUXaoqy3pUb0fVvW9UVxb/G0ACEE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841237; c=relaxed/simple;
	bh=oa4BYzZy3kq1pbLBpJsb1owa8AeGXnIShl4WHE1XK7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpaVBYxD6V0uwANP/8vAnzteNAcFIcJImAhFhnqIBGjmDfKB9dSWbtAS1zR/20UyWE8rnQ674ztjQOowB7YzOQUYaOV5GoKEEvZXDc0vSarFsygLhgvKtSceQI/BDZaBO7PjgWnCNM3Bqr6Zt5faubuKE3BZw57k2/Dg7AkQEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu0vtcwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E45C32781;
	Wed, 24 Jul 2024 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841237;
	bh=oa4BYzZy3kq1pbLBpJsb1owa8AeGXnIShl4WHE1XK7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gu0vtcwliOaEFO9TQNOi8tIiHqSeJjdQ6j2SxxiNpd5k44RXf7PIXWgRMud8uXVw9
	 nkmdIt8VFqFuUcYc2446tfUM3jl/6V6w6kMI4JgB6f918SmVTxKrUQe1NieMoZa04D
	 fXCcajwz8+0QlyxOGe0fsiFw+yVpl4haL+cw+LzbDYOJunwe/q4MsFrEwsEtTm+yuh
	 TbDgzqEP8i45IpTgkvq9SeRDFwGB5EfjJbLNIi9XZzO9QyGTVYZ6BvEk19IBT75kBp
	 UtGA5LOnyo3xpZXwQBOqHAUl5MYsYpVt18lnkisTgsQG9DM7OoFtm0QpYl9PotjNzg
	 uIpqjEbU81oNA==
Date: Wed, 24 Jul 2024 18:13:51 +0100
From: Simon Horman <horms@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] Bluetooth: hci_core: fix suspicious RCU usage in
 hci_conn_drop()
Message-ID: <20240724171351.GD97837@kernel.org>
References: <20240723171756.13755-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723171756.13755-2-yskelg@gmail.com>

+ Handa-san

On Wed, Jul 24, 2024 at 02:17:57AM +0900, Yunseong Kim wrote:
> Protection from the queuing operation is achieved with an RCU read lock
> to avoid calling 'queue_delayed_work()' after 'cancel_delayed_work()',
> but this does not apply to 'hci_conn_drop()'.
> 
> commit deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing
>  hdev->{cmd,ncmd}_timer works")
> 
> The situation described raises concerns about suspicious RCU usage in a
> corrupted context.
> 
> CPU 1                   CPU 2
>  hci_dev_do_reset()
>   synchronize_rcu()      hci_conn_drop()
>   drain_workqueue()       <-- no RCU read protection during queuing. -->
>                            queue_delayed_work()
> 
> It displays a warning message like the following
> 
> Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
> =============================
> WARNING: suspicious RCU usage
> 6.10.0-rc6-01340-gf14c0bb78769 #5 Not tainted
> -----------------------------
> net/mac80211/util.c:4000 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syz-executor/798:
>  #0: ffff800089a3de50 (rtnl_mutex){+.+.}-{4:4},
>     at: rtnl_lock+0x28/0x40 net/core/rtnetlink.c:79
> 
> stack backtrace:
> CPU: 0 PID: 798 Comm: syz-executor Not tainted
>   6.10.0-rc6-01340-gf14c0bb78769 #5
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0x1b8/0x1d0 arch/arm64/kernel/stacktrace.c:317
>  dump_backtrace arch/arm64/kernel/stacktrace.c:323 [inline]
>  show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xf0/0x170 lib/dump_stack.c:114
>  dump_stack+0x20/0x30 lib/dump_stack.c:123
>  lockdep_rcu_suspicious+0x204/0x2f8 kernel/locking/lockdep.c:6712
>  ieee80211_check_combinations+0x71c/0x828 [mac80211]
>  ieee80211_check_concurrent_iface+0x494/0x700 [mac80211]
>  ieee80211_open+0x140/0x238 [mac80211]
>  __dev_open+0x270/0x498 net/core/dev.c:1474
>  __dev_change_flags+0x47c/0x610 net/core/dev.c:8837
>  dev_change_flags+0x98/0x170 net/core/dev.c:8909
>  devinet_ioctl+0xdf0/0x18d0 net/ipv4/devinet.c:1177
>  inet_ioctl+0x34c/0x388 net/ipv4/af_inet.c:1003
>  sock_do_ioctl+0xe4/0x240 net/socket.c:1222
>  sock_ioctl+0x4cc/0x740 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __arm64_sys_ioctl+0x184/0x218 fs/ioctl.c:893
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x90/0x2e8 arch/arm64/kernel/syscall.c:48
>  el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:131
>  el0_svc+0x48/0xc0 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x120/0x130 arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x198 arch/arm64/kernel/entry.S:598
> 
> This patch attempts to fix that issue with the same convention.
> 
> Cc: stable@vger.kernel.org # v6.1+
> Fixes: deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing hdev->
> {cmd,ncmd}_timer works")

nit: Fixes tags should not be line-wrapped.

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Tested-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>

...


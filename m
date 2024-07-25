Return-Path: <stable+bounces-61436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0697193C43D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F7E287657
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40B19ADB9;
	Thu, 25 Jul 2024 14:33:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238C13DDB8;
	Thu, 25 Jul 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918009; cv=none; b=rlBuFrElwKJZuVPzIl8iPreW53oykJdKChTM6XnQuNSp23VEYR3B/4zKxtEkBr89ycTzBY2+VB3EflK3Hl0Rxuar4FSGPrrE/+D5Q0QghqnzBwfZyuOTsLCPZE/tIMiJwFTsB034uslD0+ZpzA23uhnC6RE6gig3Hd2BWDjyFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918009; c=relaxed/simple;
	bh=tNUQXUfaXcK0xaAC/za+r66m32S553fXUMDEbyWs4ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrDKmAuGb1gjwhucZEqd/4/0ubeE72csReCZD525C7ajtgWWRW2zceH5HRA0TU0anxr/8zjPEjMQBhuEcrCP8mAVUDvpsMneTEXpekuUkYVmjmit5ImBKr1cgHdvcy4DONaCs6memg/dBt6nmosEIZT3voEN7N+9hVfPtXQL+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46PEWpQT013545;
	Thu, 25 Jul 2024 23:32:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Thu, 25 Jul 2024 23:32:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46PEWpf6013538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jul 2024 23:32:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9dc0399a-573a-40c1-b342-a81410864cd9@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jul 2024 23:32:48 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_core: fix suspicious RCU usage in
 hci_conn_drop()
To: Yunseong Kim <yskelg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yeoreum Yun <yeoreum.yun@arm.com>
References: <20240725134741.27281-2-yskelg@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240725134741.27281-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/25 22:47, Yunseong Kim wrote:
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

Excuse me, but I can't interpret why this patch solves the warning.

The warning says that list_for_each_entry_rcu() { } in
ieee80211_check_combinations() is called outside of rcu_read_lock() and
rcu_read_unlock() pair, doesn't it? How does that connected to
guarding hci_dev_test_flag() and queue_delayed_work() with rcu_read_lock()
and rcu_read_unlock() pair? Unless you guard list_for_each_entry_rcu() { }
in ieee80211_check_combinations() with rcu_read_lock() and rcu_read_unlock()
pair (or annotate that appropriate locks are already held), I can't expect
that the warning will be solved...

Also, what guarantees that drain_workqueue() won't be disturbed by
queue_work(disc_work) which will be called after "timeo" delay, for you are
not explicitly cancelling scheduled "disc_work" (unlike "cmd_timer" work
and "ncmd_timer" work shown below) before calling drain_workqueue() ?

	/* Cancel these to avoid queueing non-chained pending work */
	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
	/* Wait for
	 *
	 *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
	 *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
	 *
	 * inside RCU section to see the flag or complete scheduling.
	 */
	synchronize_rcu();
	/* Explicitly cancel works in case scheduled after setting the flag. */
	cancel_delayed_work(&hdev->cmd_timer);
	cancel_delayed_work(&hdev->ncmd_timer);

	/* Avoid potential lockdep warnings from the *_flush() calls by
	 * ensuring the workqueue is empty up front.
	 */
	drain_workqueue(hdev->workqueue);



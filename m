Return-Path: <stable+bounces-43096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC138BC644
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 05:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BBF1C215D1
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26F42062;
	Mon,  6 May 2024 03:46:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08201DDC9
	for <stable@vger.kernel.org>; Mon,  6 May 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967169; cv=none; b=BoytUS2EEhk3EUB5z8fZEfQFFKz7bPo7E6XmhZ8v0pZd30ZJlgf6WevbEH7xotfWHbvziCArUIZWgXxDfPv5NbynuOKTgBRt4lKYszCncfVvZ6ZisSePPAiahW47EOTW193bLXUpn+kbm2uh6YF+/QcvQx6WkNqM447a5pJx3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967169; c=relaxed/simple;
	bh=0AyUxwfNL4EgBEKrcfkH815CwXTJqh59135P2N1cOxY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=oBz04j+R1Xu4+cGWVvWf2NAKQVPdkHV3xGBVX+5ueqANCNsZMop/g7I1L1n4REz94H7XoTGtVnAq8fIHMESMPo80wvPWp2KeFgtGlZGnNnFc/BES2Lt5ImiZkiqco+XOdAWf0+DqsmoCO0fYu5hkZEfSp4JifaZl1tFypkyY8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VXnLY6mNqzNvyq;
	Mon,  6 May 2024 11:43:17 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 32B5C18007B;
	Mon,  6 May 2024 11:46:02 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 11:46:01 +0800
Message-ID: <539775fb-da20-b39c-c131-ff5b22825756@huawei.com>
Date: Mon, 6 May 2024 11:46:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 5.4 098/107] tcp: Clean up kernel listeners reqsk in
 inet_twsk_purge()
From: shaozhengchao <shaozhengchao@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, syzbot <syzkaller@googlegroups.com>, Eric
 Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub
 Kicinski <kuba@kernel.org>
References: <20240430103044.655968143@linuxfoundation.org>
 <20240430103047.550538724@linuxfoundation.org>
 <4ebb4956-65ed-fb35-d3ff-b00be6322527@huawei.com>
In-Reply-To: <4ebb4956-65ed-fb35-d3ff-b00be6322527@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/5/6 9:34, shaozhengchao wrote:
> 
> 
> On 2024/4/30 18:40, Greg Kroah-Hartman wrote:
>> 5.4-stable review patch.  If anyone has any objections, please let me 
>> know.
>>
>> ------------------
>>
>> From: Kuniyuki Iwashima <kuniyu@amazon.com>
>>
>> commit 740ea3c4a0b2e326b23d7cdf05472a0e92aa39bc upstream.
>>
>> Eric Dumazet reported a use-after-free related to the per-netns ehash
>> series. [0]
>>
>> When we create a TCP socket from userspace, the socket always holds a
>> refcnt of the netns.  This guarantees that a reqsk timer is always fired
>> before netns dismantle.  Each reqsk has a refcnt of its listener, so the
>> listener is not freed before the reqsk, and the net is not freed before
>> the listener as well.
>>
>> OTOH, when in-kernel users create a TCP socket, it might not hold a 
>> refcnt
>> of its netns.  Thus, a reqsk timer can be fired after the netns dismantle
>> and access freed per-netns ehash.
>>
>> To avoid the use-after-free, we need to clean up TCP_NEW_SYN_RECV sockets
>> in inet_twsk_purge() if the netns uses a per-netns ehash.
>>
>> [0]: 
>> https://lore.kernel.org/netdev/CANn89iLXMup0dRD_Ov79Xt8N9FM0XdhCHEN05sf3eLwxKweM6w@mail.gmail.com/
>>
>> BUG: KASAN: use-after-free in tcp_or_dccp_get_hashinfo
>> include/net/inet_hashtables.h:181 [inline]
>> BUG: KASAN: use-after-free in reqsk_queue_unlink+0x320/0x350
>> net/ipv4/inet_connection_sock.c:913
>> Read of size 8 at addr ffff88807545bd80 by task syz-executor.2/8301
>>
>> CPU: 1 PID: 8301 Comm: syz-executor.2 Not tainted
>> 6.0.0-syzkaller-02757-gaf7d23f9d96a #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS Google 09/22/2022
>> Call Trace:
>> <IRQ>
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>> print_address_description mm/kasan/report.c:317 [inline]
>> print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>> kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>> tcp_or_dccp_get_hashinfo include/net/inet_hashtables.h:181 [inline]
>> reqsk_queue_unlink+0x320/0x350 net/ipv4/inet_connection_sock.c:913
>> inet_csk_reqsk_queue_drop net/ipv4/inet_connection_sock.c:927 [inline]
>> inet_csk_reqsk_queue_drop_and_put net/ipv4/inet_connection_sock.c:939 
>> [inline]
>> reqsk_timer_handler+0x724/0x1160 net/ipv4/inet_connection_sock.c:1053
>> call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
>> expire_timers kernel/time/timer.c:1519 [inline]
>> __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
>> __run_timers kernel/time/timer.c:1768 [inline]
>> run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
>> __do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
>> invoke_softirq kernel/softirq.c:445 [inline]
>> __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
>> irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
>> sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1107
>> </IRQ>
>>
>> Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
>> Reported-by: syzbot <syzkaller@googlegroups.com>
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>> Link: https://lore.kernel.org/r/20221012145036.74960-1-kuniyu@amazon.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [shaozhengchao: resolved conflicts in 5.10]
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   net/ipv4/inet_timewait_sock.c |   15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> --- a/net/ipv4/inet_timewait_sock.c
>> +++ b/net/ipv4/inet_timewait_sock.c
>> @@ -268,8 +268,21 @@ restart_rcu:
>>           rcu_read_lock();
>>   restart:
>>           sk_nulls_for_each_rcu(sk, node, &head->chain) {
>> -            if (sk->sk_state != TCP_TIME_WAIT)
>> +            if (sk->sk_state != TCP_TIME_WAIT) {
>> +                /* A kernel listener socket might not hold refcnt for 
>> net,
>> +                 * so reqsk_timer_handler() could be fired after net is
>> +                 * freed.  Userspace listener and reqsk never exist 
>> here.
>> +                 */
>> +                if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
>> +                         hashinfo->pernet)) {
> 
> Hi Greg:
>    I'm very very sorry, there's no pernet variable in the struct 
> hashinfo. The pernet variable is introduced from v6.1-rc1. This patch
> has a problem and cannot be merged.
> 
> Zhengchao Shao
>> +                    struct request_sock *req = inet_reqsk(sk);
>> +
>> +                    
>> inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
>> +                }
>> +
>>                   continue;
>> +            }
>> +
>>               tw = inet_twsk(sk);
>>               if ((tw->tw_family != family) ||
>>                   refcount_read(&twsk_net(tw)->count))
>>
>>

Hi Greg:
   I'm sorry to bother you. Revert two patches, because when the ("tcp:
Clean up kernel listeners reqsk in inet_twsk_purge()") patch is
incorporated separately, which will cause compilation failure. To fix
CVE-2024-26865, should the two patches be combined into one?

Zhengchao Shao


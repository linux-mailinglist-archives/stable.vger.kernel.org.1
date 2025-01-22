Return-Path: <stable+bounces-110157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F16A190D8
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB51668B1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB021148F;
	Wed, 22 Jan 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LXocdvys"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736201BDA99
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546439; cv=none; b=aXxOsaBfdIjYzay47vL+HUTNY8f0bhxr3gRcLuqHkNjwq2BeGQaFDe2/pvSX3kMu7y7CPhKXQ5gsMVMar7QzamD1CC9dSjfAbQ1UwCvslimmIDOE2tkT3oRGhME1Gn07n9vKrd4bQbeGJWhM+5S/11MxJsT2Up9+2CssBxR6hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546439; c=relaxed/simple;
	bh=BsbeqEpFi+vU4QPLahP59yAGT9BngWdKvBhqyz27YlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdjeFGtpPT0fhSkA0ZhsW7iLmMRT849LDQQq+wxU6wn5PT4XnGAiadBMFCEVreTiuFxo3Dcb0nf7/BeNKY6/vm9t0bqPjlgPTebCS0VPfWhmGdksDpNzM9rgowIcBn8pF++KRveGkY8YCnyPSzmmaaErA7tiJ+L0DtXc9ihl7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=LXocdvys; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737546124;
	bh=BoQPBjKLgj7d9q7mtrzhIrsES8m1Xcw1erjLsLE1E9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LXocdvysgOhRMl+0pCqmmt1RYV+3iSjNdMkTgWBTBejz3EIa2kbtrFOq3dJznyZWr
	 DpUEtV4WChgtAvoLEvvpxNfl5ukteyNpXP+E7dx8CSoPGDpFX2AdnSeK+3znME2hTU
	 tQAUrd4XG+JWK8QcOhSPHzorJdo8r8/NdVsnst4A=
Received: from [192.168.3.47] ([120.244.194.224])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 73539823; Wed, 22 Jan 2025 19:28:53 +0800
X-QQ-mid: xmsmtpt1737545333tkuslqv0f
Message-ID: <tencent_CB5AB91ABE8F1D4917EB399C5598FC864107@qq.com>
X-QQ-XMAILINFO: M/k+jFccxxwBgVn+GntShCcuPRuhnr9hlSODoEDAEtnw3dx7H8uNZFs9j8O5IY
	 GV3Pv/nqDktdsx48Z9j1KqBKaYuFYJT55ePAbvaSm6aIE1bpbgbleS9BwzrZVMORl38CJWUOHIa5
	 VxDu3N2iYHO9EXYHsLWCeL6rivwo8KhbKTzOONxfPlInHc5Nzrz5c1mRSgfGbXQrpZG+pxwtOm7N
	 wIsQHPGIeBPKRRhX7vcpjqaLKGAUgkcxpUMDoWkxO7jjZak3q69mlBLHAGeKzb71u+e8kkM2/nDK
	 rvN0ZpIxus+/QkbKPJ5L0ujw+tcM70BJHPyk94KwvpyNnwWjc9KWeBgw4XLUZ1TJ4bxWMABqh58V
	 ZDCHASFVDRvJNiGDSIdsPh+eBxVH0/e9arGFkpDgWxopNuPQQjdxTU631YgLOd2wkbErb1YzsbbP
	 bL60MSO3I3fTDL566HocVwPphCBcIPJRT+MYXiIGQmbiUEfQieWjsBRP7eSiJFdQtrg7V2qea/pc
	 wjkOfPLfljyJyxjf1mZLfXyt4hprUC2sNjv1QR622ZlMdYrwrxc5yyELPgEC8b10NWbCStufVquz
	 BaLUq1OhWNM2jdjcW+QQJB1HJqhcqE5gjrtxcdEra+skOret4nc4zlHPb1Ej9bACOZOQoSma0m/S
	 m81Qiw+xtNwotqbuBbxnRxFJVP+TUGaLNGyb9QZ3s3E36BYFQevbj926zq+UN1ZjorYwqJaDgDWq
	 z+lc/VLSwi7B7oJJgQMSQhsMnxBCRSh++Cswdc5O52Moyhl3Y50QY5ZqD5nxf/a21GtXrRbcbVQI
	 K6SmSUhuAYc3lfKaF1Y5Rkn+8Vw5jswqJ0vv6s1EqJEvPbIh6zuLCrlOewO8xu5H2i+gcHfxxJWQ
	 hxqSr2ey1/fyhk4AAbRIjje5ZBmLOvf5V6dwDZw3pQSoxIZgdDvFGeHKrl8UkNYnRVY49ZptdJyI
	 Dit+mceAbtIoHycbHUJ6iS/tQmQnGWEsgUP7imgCj1AFWp13oL5A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <07d6fcab-bf1a-4475-b0ed-96b396628b80@foxmail.com>
Date: Wed, 22 Jan 2025 19:28:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] net: fix data-races around sk->sk_forward_alloc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Wang Liang <wangliang74@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <tencent_D660CC1BB869156A7C3EBA24B5ACF371BA09@qq.com>
 <2025012102-zero-tidiness-4632@gregkh>
Content-Language: en-US
From: Alva Lan <alvalan9@foxmail.com>
In-Reply-To: <2025012102-zero-tidiness-4632@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/21/2025 10:54 PM, Greg KH wrote:
> On Tue, Jan 21, 2025 at 10:22:43PM +0800, alvalan9@foxmail.com wrote:
>> From: Wang Liang <wangliang74@huawei.com>
>>
>> commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.
>>
>> Syzkaller reported this warning:
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>>   Modules linked in:
>>   CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>   RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>>   Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>>   RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>>   RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>>   RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>>   RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>>   R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>>   R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>>   FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   Call Trace:
>>    <TASK>
>>    ? __warn+0x88/0x130
>>    ? inet_sock_destruct+0x1c5/0x1e0
>>    ? report_bug+0x18e/0x1a0
>>    ? handle_bug+0x53/0x90
>>    ? exc_invalid_op+0x18/0x70
>>    ? asm_exc_invalid_op+0x1a/0x20
>>    ? inet_sock_destruct+0x1c5/0x1e0
>>    __sk_destruct+0x2a/0x200
>>    rcu_do_batch+0x1aa/0x530
>>    ? rcu_do_batch+0x13b/0x530
>>    rcu_core+0x159/0x2f0
>>    handle_softirqs+0xd3/0x2b0
>>    ? __pfx_smpboot_thread_fn+0x10/0x10
>>    run_ksoftirqd+0x25/0x30
>>    smpboot_thread_fn+0xdd/0x1d0
>>    kthread+0xd3/0x100
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork+0x34/0x50
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork_asm+0x1a/0x30
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>
>> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
>> concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
>> which triggers a data-race around sk->sk_forward_alloc:
>> tcp_v6_rcv
>>      tcp_v6_do_rcv
>>          skb_clone_and_charge_r
>>              sk_rmem_schedule
>>                  __sk_mem_schedule
>>                      sk_forward_alloc_add()
>>              skb_set_owner_r
>>                  sk_mem_charge
>>                      sk_forward_alloc_add()
>>          __kfree_skb
>>              skb_release_all
>>                  skb_release_head_state
>>                      sock_rfree
>>                          sk_mem_uncharge
>>                              sk_forward_alloc_add()
>>                              sk_mem_reclaim
>>                                  // set local var reclaimable
>>                                  __sk_mem_reclaim
>>                                      sk_forward_alloc_add()
>>
>> In this syzkaller testcase, two threads call
>> tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
>> this:
>>   (cpu 1)             | (cpu 2)             | sk_forward_alloc
>>   ...                 | ...                 | 0
>>   __sk_mem_schedule() |                     | +4096 = 4096
>>                       | __sk_mem_schedule() | +4096 = 8192
>>   sk_mem_charge()     |                     | -768  = 7424
>>                       | sk_mem_charge()     | -768  = 6656
>>   ...                 |    ...              |
>>   sk_mem_uncharge()   |                     | +768  = 7424
>>   reclaimable=7424    |                     |
>>                       | sk_mem_uncharge()   | +768  = 8192
>>                       | reclaimable=8192    |
>>   __sk_mem_reclaim()  |                     | -4096 = 4096
>>                       | __sk_mem_reclaim()  | -8192 = -4096 != 0
>>
>> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
>> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
>> Fix the same issue in dccp_v6_do_rcv().
>>
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
>> ---
> You sent this twice, which one is correct?  I'll drop both from my inbox
> just to be sure :)

No problem, please drop both. Thank you.

Actually, I did not see the patch in the mail list after I had sent this 
patch twenty minutes. It might have failed to send so I sent the patch 
again. Sorry for my mistake.

>
>> Backport to fix CVE-2024-53124.
>> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-53124
> Please don't point to random cve "enhancers" with unknown ways that they
> have modified our original cve record.  Just point at the cve.org record
> if you really want to link to something.
>
> thanks,
>
> greg k-h

OK.

B.R.

Alva Lan




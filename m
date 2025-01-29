Return-Path: <stable+bounces-111128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD86A21D96
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81167164B05
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3BEAC5;
	Wed, 29 Jan 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="C+EINIm2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvknCgP+"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D82CA9
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156332; cv=none; b=XfzUknnCiNvBOfN2yykkCl820yd/GTcI7l/OL1f7AwHRqr6zat45gFZN6ZQpKephY6ZmxbN6dGJWDSMj++RAuk3pZAGkMPb3lIeaDm3byox9BLclm1U41AK/V6KHOW7huFeBmIGVt0EeJWfp2AuMDevmkZtodILqQW5anGneYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156332; c=relaxed/simple;
	bh=gnY4et/h7DY6DDyYCoKe2Ped1jZox8dCpxxATBsJJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/AzHITSvdoXGO62bVsPVYm03vukFVWzkcU706nO25IjnQFxyLCKyMKIis1PgrsI61YESyS3XpjrMTvwT51ZeUSjbghObFIFoW+9yF5rZOWi/pgd5nOwUN4cLdMnCsFnIDjY8u23H53leffpSOLeJ13vab/sSKsjgBSoVeEYQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=C+EINIm2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UvknCgP+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB10811400FB;
	Wed, 29 Jan 2025 08:12:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jan 2025 08:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738156328; x=1738242728; bh=m7SnI2oRXh
	brb5cbr7sSO/FzrPHKiPNZaBHYPHhV9VU=; b=C+EINIm28KQQ0tKgdzv9nnyjWg
	naPLtLlir4clOZs3YZNr/k+UozekiXHYd8egnyEhhzyNBxQQaJOa9IoWkvPlxFPV
	tBSxuoVmldwzhb/uovPB04PjNs0sA8m/lM4T45tkxQU9lbu55JLvB8Vx/DrefNo4
	1KoGJ9awL3yOs4pI/5KRwqvWqhibSpKcjyrqOEBZwqngpfRuvTyQJyhJ/swgZ85/
	4PmAb8WVX6My3iJjx3yAGTYteaITV77XXmW8uWDHfdgXcNKgL1vL9OPt7ZjNIlyP
	BVpQadDL3FmbmKBsjEu4AyjtG3w78fmspSuf8kaAv+f3ydO5r+xFpX6MADBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738156328; x=1738242728; bh=m7SnI2oRXhbrb5cbr7sSO/FzrPHKiPNZaBH
	YPHhV9VU=; b=UvknCgP+pkQ5oDFz/HfJ/7MsO7Xd3hrSS69SdGjsYZZKfRpLmJ9
	JYWx6DkJqn8Ot/ehSh/xukMP0QiNXWK6LxFYqM2KHfB+zB2Zj7poG+sMlRtQh4bR
	RDdj14RZUmYo+29nAGlAFav3U+kSJBqjVa8yMOuLieqI2QrcnUqF7nu4BKBNVeb5
	uT5i/MUa6mnxeP7a5DvsC0rOIUCZESivBbnyYm2ePeol0zCmvn5re1K4EJdix0/g
	vyEQA0VXgVSDrqfFrEAMxZ/y3CEbYYkCGiY0BBNnoggArfjyCxZkoBxDFO6Rz11n
	euEX0vTMbXrlErnE/1hFqMgwaGfdTOTasKg==
X-ME-Sender: <xms:JymaZyik2WSCEyi9gb9CeTFNy4uvpF2qSnnEuYCWSnUg9FQC5Pl5Zg>
    <xme:JymaZzDx_MYadDut0iiiTjFl_qUT4fVrhft9AcIt3j4SxmnEt2KWztDb0y4kPUV8M
    JLvsPcWz-w6QA>
X-ME-Received: <xmr:JymaZ6EpBOqzbEijIBgwDetPNc713wXpFYWJblRqj_cJpaTSLevTiHjJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepjeetueehteekuefhleehkeffffeiffeftedtieegkedviefggfefueff
    kefgueffnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    hvrghlrghnleesfhhogihmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghhlihgrnhhgjeegsehhuh
    grfigvihdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JymaZ7TLe6Tu34vqXDwCpeoYvPggQF3jF7PMfkAyQVSQMPnpLN_bCQ>
    <xmx:JymaZ_w37V8GUlxi_xhRQ1A6-5_lLXif2lBExpd9YYe2qpJtbQxaHw>
    <xmx:JymaZ57ag50XJ-HMqeTiCl_HP1-SeFviuNYMtLM71rVX3iA2jkl-ZA>
    <xmx:JymaZ8ya04eVVcUVVaGy5RO7oSmLB7zmcfuj3IqPVjlLQETxEwCzsA>
    <xmx:KCmaZ0rBQaSnMUPr910wr8aB5aqaBnl5wZOuFUf0M3I3tiuoaYgG0uxf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 08:12:06 -0500 (EST)
Date: Wed, 29 Jan 2025 10:42:57 +0100
From: Greg KH <greg@kroah.com>
To: alvalan9@foxmail.com
Cc: stable@vger.kernel.org, Wang Liang <wangliang74@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y v2] net: fix data-races around sk->sk_forward_alloc
Message-ID: <2025012949-mouth-enable-e51c@gregkh>
References: <tencent_CBAD5F0DF387BE24BC3518CE3A4C56833D06@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CBAD5F0DF387BE24BC3518CE3A4C56833D06@qq.com>

On Wed, Jan 22, 2025 at 07:35:21PM +0800, alvalan9@foxmail.com wrote:
> From: Wang Liang <wangliang74@huawei.com>
> 
> commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.
> 
> Syzkaller reported this warning:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>  Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>  RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>  RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>  RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>  RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>  R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x88/0x130
>   ? inet_sock_destruct+0x1c5/0x1e0
>   ? report_bug+0x18e/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? inet_sock_destruct+0x1c5/0x1e0
>   __sk_destruct+0x2a/0x200
>   rcu_do_batch+0x1aa/0x530
>   ? rcu_do_batch+0x13b/0x530
>   rcu_core+0x159/0x2f0
>   handle_softirqs+0xd3/0x2b0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   run_ksoftirqd+0x25/0x30
>   smpboot_thread_fn+0xdd/0x1d0
>   kthread+0xd3/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
> concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
> which triggers a data-race around sk->sk_forward_alloc:
> tcp_v6_rcv
>     tcp_v6_do_rcv
>         skb_clone_and_charge_r
>             sk_rmem_schedule
>                 __sk_mem_schedule
>                     sk_forward_alloc_add()
>             skb_set_owner_r
>                 sk_mem_charge
>                     sk_forward_alloc_add()
>         __kfree_skb
>             skb_release_all
>                 skb_release_head_state
>                     sock_rfree
>                         sk_mem_uncharge
>                             sk_forward_alloc_add()
>                             sk_mem_reclaim
>                                 // set local var reclaimable
>                                 __sk_mem_reclaim
>                                     sk_forward_alloc_add()
> 
> In this syzkaller testcase, two threads call
> tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
> this:
>  (cpu 1)             | (cpu 2)             | sk_forward_alloc
>  ...                 | ...                 | 0
>  __sk_mem_schedule() |                     | +4096 = 4096
>                      | __sk_mem_schedule() | +4096 = 8192
>  sk_mem_charge()     |                     | -768  = 7424
>                      | sk_mem_charge()     | -768  = 6656
>  ...                 |    ...              |
>  sk_mem_uncharge()   |                     | +768  = 7424
>  reclaimable=7424    |                     |
>                      | sk_mem_uncharge()   | +768  = 8192
>                      | reclaimable=8192    |
>  __sk_mem_reclaim()  |                     | -4096 = 4096
>                      | __sk_mem_reclaim()  | -8192 = -4096 != 0
> 
> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
> Fix the same issue in dccp_v6_do_rcv().
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
> ---
> v2: For I had sent the patch two times, I added v2 to the subject to distinguish it from the v1 version.

Does not apply to 6.1.y at all :(


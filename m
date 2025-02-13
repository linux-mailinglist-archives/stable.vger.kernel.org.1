Return-Path: <stable+bounces-115152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EDA341BF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FFD188FA15
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87631281358;
	Thu, 13 Feb 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0lSsOyYT"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA828134A;
	Thu, 13 Feb 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455898; cv=none; b=VEx2qoBzA45nKQSu1qg7LydukZKLtvfUGyC/vZevaq3Namy/flDUV0pFG7lZR0oNuXhP3Z56cfr6AE7GFNSgBqCOhBL7BG+TmoZ97ZqW0n+a5rWKilfYKv1uXVWl0DnMoO34DdouBJwjRJ9E+Ia4sZu8L94FIAyT1mrz4IiTgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455898; c=relaxed/simple;
	bh=8S+dBSGXn2NPrrdxaY4V0CUCwo3cIMz7YbwxwuvOl2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0pbnXG5AKB3qV+MaAo8quOM46Ra1O7TkJl8aPtQnPerK6ch8URbDLtBpOF1vhsNU2hHwlY/7hWMbZK5FP491wRC9gBeWIpx5Dm1dgHOIc9D8bgxK25Do1LHecJ0ee/avPXXp+jHIxUEjkL3sgO7s3kgLi7SGwnKvzJWivoCbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0lSsOyYT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E4E591140176;
	Thu, 13 Feb 2025 09:11:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 13 Feb 2025 09:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739455894; x=1739542294; bh=YPHzRRNPSo5gcY9/oGQZ7LXTaEXNRyA1COm
	WFnIPaok=; b=0lSsOyYTemfUmYXref/Dz0IHfy+1Pg5yMvvQrND1sVO+oQCQaGJ
	H37hKpdy6X6tcDYZAya/QA+I+283JVkyZWBND2c2rp8hHjSfcUGJ5XGGNY15GTJU
	WvbzTQ1ezpnuFYSxDyeMxZLEg9Ah/2SXMK/KOnsBUa1VURT8HjksCPvCycBC4KJC
	LWl+LrKoUj5qRWd/0+OTzDjDwLJ1jg73cKfzN7jQAeQdmVVULhg+RMhxk3WXqqfd
	9RILVUz5JeUNutJvFXmNxDc4nk2kXdoNfSaaCSbXDM512vw43MjLp5Kpj3S8QVpD
	+yoCmwRc5ajgJe2CbDro2oA/XDsgeUosR8w==
X-ME-Sender: <xms:lP2tZ2f9H_ANvIABSZxQWIJ-WIMu-XTZnAlmlOneuG0siI9CSE68ww>
    <xme:lP2tZwOLMzAvqf9n9cksD7yWuRhKcY5AKEiquV6qlNelNxxw_YIam76cza90_kpmu
    gkvIuLzsW95t7E>
X-ME-Received: <xmr:lP2tZ3g6-4xInS_vTXEeSAFAZ6by-cKy_Lg7tWHbUv44sUlX5ZbdT8iC_iufCn3fVrb3yKGrOdo5qWFviVerFhuHRgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhlihgrrdhgrghvrh
    hilhhovhesihhnfhhothgvtghsrdhruhdprhgtphhtthhopehnhhhorhhmrghnsehtuhig
    ughrihhvvghrrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lP2tZz8hA_mYdNSAhDFuFK9jF0ur-a4oULmKz85lb7y8A67W6DvRow>
    <xmx:lP2tZyuGi1qvW5e3AeMl2OxGWPw7vSI4BN5QIekceX3b3AVeRyfvdg>
    <xmx:lP2tZ6FefWK_U4jYgfoax22rwb1cMZ8bJYdg9O-OEbFF4HGN8DdRNg>
    <xmx:lP2tZxOCb99g3zZhC7Y2bVZ3AP8VkPnr2eUOAREDKr-jewYGcY88XQ>
    <xmx:lv2tZzn5W5DZiB-rMei0D1HNK8auTBNa3YDo8n_hjvfy3iIi_IKBlqMK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 09:11:32 -0500 (EST)
Date: Thu, 13 Feb 2025 16:11:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] drop_monitor: fix incorrect initialization order
Message-ID: <Z639kSZBWuEpNkIP@shredder>
References: <20250212134150.377169-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212134150.377169-1-Ilia.Gavrilov@infotecs.ru>

On Wed, Feb 12, 2025 at 01:41:51PM +0000, Gavrilov Ilia wrote:
> Syzkaller reports the following bug:
> 
> BUG: spinlock bad magic on CPU#1, syz-executor.0/7995
>  lock: 0xffff88805303f3e0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 1 PID: 7995 Comm: syz-executor.0 Tainted: G            E     5.10.209+ #1
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x119/0x179 lib/dump_stack.c:118
>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>  do_raw_spin_lock+0x1f6/0x270 kernel/locking/spinlock_debug.c:112
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
>  _raw_spin_lock_irqsave+0x50/0x70 kernel/locking/spinlock.c:159
>  reset_per_cpu_data+0xe6/0x240 [drop_monitor]
>  net_dm_cmd_trace+0x43d/0x17a0 [drop_monitor]
>  genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/genetlink.c:739
>  genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>  genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink.c:2497
>  genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0x54b/0x800 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x914/0xe00 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec net/socket.c:651 [inline]
>  __sock_sendmsg+0x157/0x190 net/socket.c:663
>  ____sys_sendmsg+0x712/0x870 net/socket.c:2378
>  ___sys_sendmsg+0xf8/0x170 net/socket.c:2432
>  __sys_sendmsg+0xea/0x1b0 net/socket.c:2461
>  do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x62/0xc7
> RIP: 0033:0x7f3f9815aee9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3f972bf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f3f9826d050 RCX: 00007f3f9815aee9
> RDX: 0000000020000000 RSI: 0000000020001300 RDI: 0000000000000007
> RBP: 00007f3f981b63bd R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f3f9826d050 R15: 00007ffe01ee6768
> 
> If drop_monitor is built as a kernel module, syzkaller may have time
> to send a netlink NET_DM_CMD_START message during the module loading.
> This will call the net_dm_monitor_start() function that uses
> a spinlock that has not yet been initialized.
> 
> To fix this, let's place resource initialization above the registration
> of a generic netlink family.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/core/drop_monitor.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> index 6efd4cccc9dd..9755d2010e70 100644
> --- a/net/core/drop_monitor.c
> +++ b/net/core/drop_monitor.c
> @@ -1734,6 +1734,11 @@ static int __init init_net_drop_monitor(void)
>  		return -ENOSPC;
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		net_dm_cpu_data_init(cpu);
> +		net_dm_hw_cpu_data_init(cpu);
> +	}
> +
>  	rc = genl_register_family(&net_drop_monitor_family);

This might be fine as-is, but it would be cleaner to move the
registration of the netlink family to the end of the module
initialization function, so that it's exposed to user space after all
the preparations have been done, including the registration of the net
device notifier.

>  	if (rc) {
>  		pr_err("Could not create drop monitor netlink family\n");
> @@ -1749,11 +1754,6 @@ static int __init init_net_drop_monitor(void)
>  
>  	rc = 0;
>  
> -	for_each_possible_cpu(cpu) {
> -		net_dm_cpu_data_init(cpu);
> -		net_dm_hw_cpu_data_init(cpu);
> -	}
> -
>  	goto out;
>  
>  out_unreg:
> @@ -1772,13 +1772,12 @@ static void exit_net_drop_monitor(void)
>  	 * Because of the module_get/put we do in the trace state change path
>  	 * we are guaranteed not to have any current users when we get here
>  	 */
> +	BUG_ON(genl_unregister_family(&net_drop_monitor_family));

Similarly, unregister the netlink family at the beginning of the module
exit function, before unregistering the net device notifier.

>  
>  	for_each_possible_cpu(cpu) {
>  		net_dm_hw_cpu_data_fini(cpu);
>  		net_dm_cpu_data_fini(cpu);
>  	}
> -
> -	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
>  }
>  
>  module_init(init_net_drop_monitor);
> -- 
> 2.39.5
> 


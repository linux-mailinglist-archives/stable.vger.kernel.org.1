Return-Path: <stable+bounces-116512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7745A3732B
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 10:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CF1168DCA
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58512189916;
	Sun, 16 Feb 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zzZEo4yj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABE433A0;
	Sun, 16 Feb 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698263; cv=none; b=fGNE9LcQ2L1JRyJVjqZbRibYeIS9Kg9HGoygFmD8l1N+2P/35Gncm06FShooi1/F5wUYG8P27Fvv1YdOxftacSPEyKZIx+dSLqrYqXMxLamCm57UIbrVYa1MQtACaBpELfPEFTwKDzkOeVtbFiRBQNvTeJDGy7oSJp6kE+o6sXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698263; c=relaxed/simple;
	bh=YycW8ro2VftsQjHvrgvBkrK3WDsRY9Wr78hI4vwmwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5we3F1nJU0or+6zr1jA5ZMmUf5VxRUxhXT5Y0FLikpCW+VWOzRBDg2GmIo3MbAcOuoyEfohitLn+XCiClXDg8Xe4qJjVwI5xgZzHyALsdJzc0uxToyAtpvqBalIVl/oxFNSGMec9eLWfDzScqcJ06bnictBm9odnceL41aYMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zzZEo4yj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D7A92540123;
	Sun, 16 Feb 2025 04:31:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Feb 2025 04:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739698259; x=1739784659; bh=qx/SJG5ijmT0Xa4nxgZmBXmRB69O0r8beqb
	QPBqwIS8=; b=zzZEo4yjwGDmU5if/IV5GZpfCiWFDYeBmDGERWTHbqk8NdxZVmP
	ehrM/xkVhNCKFziS8b6FgApqabx/IxYUpBocuOPmqBif4GDbfPhIUfxPTbTEbn3I
	sSvLibtESN8t7akiB3v3kkGvSAB9BPpbwGaAkEEyo4mZBXTYDKHlRskxLDgYYGgq
	vhyX5ZlOyx4sIHQR17xTm4LG2rD/JopB9bZL2HjUoryvSNLU/yRolnHBQ4Me09o4
	xplAEGU28UegynV+xacvrQqS9uXij8mXBMQwSnK5dhTEA/6uKy7/aWyL64b1C+K9
	muYzA4J/y66FlAcnC0Civl54CqnJa1xJiSQ==
X-ME-Sender: <xms:UrCxZ_eDSVpsraW3p6A8cDqbURZ6u-eWvN7-ywNkNpaRW_RJ3sxvCA>
    <xme:UrCxZ1M2h5-MQEs99ZywZIRRsJ2nwmHHQE5vIKYzkN7frWK-nyyyG7douKwNRlo-t
    Bo7alYHPY9shZw>
X-ME-Received: <xmr:UrCxZ4gLRW0hNuIV14P371PwXIwOBRH-O1txIPKqIamITUF5rdmWf1dmp_ey>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehheduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UrCxZw-FBWVbSp35ufaCHUq_EIbohO5GaH9KiyqCem4euKfkLJZUPg>
    <xmx:UrCxZ7vl_OCnxlWWNL0e5aTVYi5MBJ-sXYKNu8KMzsN8N_10iAOSOg>
    <xmx:UrCxZ_FuXnX2IkqpNKOpPBwITdj6w7KMyCYhxNY7WIyBDhHV7TjPvw>
    <xmx:UrCxZyNUq4eyJRuXICbTzCfgqg6hkFY6-eKXS2ddB1rkSoDG0roVUA>
    <xmx:U7CxZ8lcJOOfNRpPhu8MFK32DNezGT_bkeXpkA6zKpWt0mXz0HUMc7Px>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 04:30:57 -0500 (EST)
Date: Sun, 16 Feb 2025 11:30:55 +0200
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
Subject: Re: [PATCH net v2] drop_monitor: fix incorrect initialization order
Message-ID: <Z7GwT6d-9ZFuzUcL@shredder>
References: <20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru>

On Thu, Feb 13, 2025 at 03:20:55PM +0000, Gavrilov Ilia wrote:
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
> (linuxtesting.org) with Syzkaller.
> 
> Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I wouldn't object if someone requested to remove these archaic
{BUG,WARN}_ON()s, but figured this cleanup is more of a net-next
material.


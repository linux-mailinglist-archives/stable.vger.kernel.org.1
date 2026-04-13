Return-Path: <stable+bounces-236002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG0ELkPZ3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-236002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:53:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A873EB95F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18ECA300D72C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCE359A74;
	Mon, 13 Apr 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3IP8+BU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76335A3B6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081075; cv=none; b=E9CZQiNCn7A4IwctI2TYTNut2boBQ571GjYfxln0tvuuIVYI02Q5Xe+qVzvcjoV46fWrWi0AsEfynXMcUKw21SC4tbQgWQdxxw7IRl9fAeNzSL+QOaAs6JOzAHpfbiE7qyRC+RHk+M4xlAyl9M5SMnYGPbx15Tb4F/U/Eo425p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081075; c=relaxed/simple;
	bh=RxSraddUffyU9jQA6QtBHxd6Xa+dQTKP5DaSnWRl7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5aBZ/TO3lhhtLe2eBYpIvDiLO0m5Hk0hsZYCYsGsc+/rKzVxZ4IAePyvdnpLGotnYx9oKB2iNZWrwqIR88+B58U71PH0SxpXZtHgFQDAdOJmlJCbYx66UjyjRdAHJkr1wQ67aAeLx3BvTpfEmjzgBoSZr9Ib9boXBm12HHV3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3IP8+BU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23515C116C6;
	Mon, 13 Apr 2026 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776081074;
	bh=RxSraddUffyU9jQA6QtBHxd6Xa+dQTKP5DaSnWRl7B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3IP8+BU2IMkcqFZ0T0sVeIvJy3TfXD0gY6HfgthWLSmub6HI4Av2rmsyZqNuPjlQ
	 h3AVjcUaRkNIB7ma37xmi3eanPFgOE/J7GHouG2Jzi0Vj9pa0d+dLHYF6KwVYXcRtk
	 j+cjr9uRyIY6heJzi9WgpgPhrewBo+MMywYF34T0=
Date: Mon, 13 Apr 2026 13:51:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chenglong Tang <chenglongtang@google.com>
Cc: stable@vger.kernel.org, xmei5@asu.edu, pabeni@redhat.com,
	sashal@kernel.org, Kevin Berry <kpberry@google.com>,
	Lee Jones <joneslee@google.com>
Subject: Re: [PATCH 6.12.y] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
Message-ID: <2026041300-devotee-glowworm-db70@gregkh>
References: <CAOdxtTZ7=S=oEK1TPHoXWtw9V6=QWh5Jygad_-SjtF66_vv-cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOdxtTZ7=S=oEK1TPHoXWtw9V6=QWh5Jygad_-SjtF66_vv-cQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-236002-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 35A873EB95F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:09:42PM -0700, Chenglong Tang wrote:
> commit 2884bf72fb8f03409e423397319205de48adca16 upstream.
> 
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop. This
> causes the original skb to be double-consumed (double-freed).
> 
> Replace the racy bond_is_last_slave() check with a simple index
> comparison (i + 1 == slaves_count) against the pre-snapshot slave
> count taken via READ_ONCE() before the loop. This preserves the
> zero-copy optimization for the last slave while making the "last"
> determination stable against concurrent list mutations.
> 
> The UAF can trigger the following crash:
> ==================================================================
> BUG: KASAN: slab-use-after-free in skb_clone Read of size 8 at addr
> ffff888100ef8d40 by task exploit/147 CPU: 1 UID: 0 PID: 147 Comm:
> exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY Call Trace: <TASK>
> dump_stack_lvl (lib/dump_stack.c:123) print_report
> (mm/kasan/report.c:379 mm/kasan/report.c:482) kasan_report
> (mm/kasan/report.c:597) skb_clone (include/linux/skbuff.h:1724
> include/linux/skbuff.h:1792 include/linux/skbuff.h:3396
> net/core/skbuff.c:2108) bond_xmit_broadcast
> (drivers/net/bonding/bond_main.c:5334) bond_start_xmit
> (drivers/net/bonding/bond_main.c:5567
> drivers/net/bonding/bond_main.c:5593) dev_hard_start_xmit
> (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334
> net/core/dev.c:3871 net/core/dev.c:3887) __dev_queue_xmit
> (include/linux/netdevice.h:3601 net/core/dev.c:4838)
> ip6_finish_output2 (include/net/neighbour.h:540
> include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
> ip6_finish_output (net/ipv6/ip6_output.c:208
> net/ipv6/ip6_output.c:219) ip6_output (net/ipv6/ip6_output.c:250)
> ip6_send_skb (net/ipv6/ip6_output.c:1985) udp_v6_send_skb
> (net/ipv6/udp.c:1442) udpv6_sendmsg (net/ipv6/udp.c:1733) __sys_sendto
> (net/socket.c:730 net/socket.c:742 net/socket.c:2206) __x64_sys_sendto
> (net/socket.c:2209) do_syscall_64 (arch/x86/entry/syscall_64.c:63
> arch/x86/entry/syscall_64.c:94) entry_SYSCALL_64_after_hwframe
> (arch/x86/entry/entry_64.S:130) </TASK> Allocated by task 147: Freed
> by task 147: The buggy address belongs to the object at
> ffff888100ef8c80 which belongs to the cache skbuff_head_cache of size
> 224 The buggy address is located 192 bytes inside of freed 224-byte
> region [ffff888100ef8c80, ffff888100ef8d60) Memory state around the
> buggy address: ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc
> fc fc fc fc ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc
> fc fc ^ ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
> fb ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return
> value error bug")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [Kevin Berry <kpberry@google.com>: fixed merge conflicts and adapted
> to 6.12 struct]
> Signed-off-by: Chenglong Tang <chenglongtang@google.com>
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 2ac455a9d1bb..fb8d7fec27ee 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5346,23 +5346,33 @@ static netdev_tx_t bond_3ad_xor_xmit(struct
> sk_buff *skb,
> return bond_tx_drop(dev, skb);
> }
> -/* in broadcast mode, we send everything to all usable interfaces. */
> +/* in broadcast mode, we send everything to all or usable slave interfaces.
> + * under rcu_read_lock when this function is called.
> + */

This is totally corrupted and can not be applied :(


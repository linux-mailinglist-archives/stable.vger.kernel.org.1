Return-Path: <stable+bounces-231006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCkBMnYOymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC7355B12
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B5CE3010145
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06815382F32;
	Mon, 30 Mar 2026 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHJvGTbk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB03822B7
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849504; cv=none; b=LvmllJgUFEnZDrVjF69kwVFehgKmrZcejHPMofL8CVESA+qmQjbWwrLeUDlfq/EoD8buainh9nnY6BiWiuzIuzPN14d6YWJ7W7CP8PlCyizb/XXVYjCWL284lU0Lv8VzdDQvLEBcJYbp87LGU0EBBiC2mQ3hBiDiFs9ZqWRCE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849504; c=relaxed/simple;
	bh=7CsbheAqXZdCKr8ORK4lf7tuQ/x3D8IpJmB75IGdgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWq3aILxQ4a8Vc6JfFJ5D0r9YjaqTnaT5pP/IEiARX5XSq5onag+DTI/+h6v58vtOnSrg1+dweUeSQmjvFoo1MOZHDxdbg8nZcm4xWjQKmPhnF7MIHuUTLI+XpZRsH/zPruu01qL135WX96Wwk4n1lWxEybQnlLeg/AZ8HSZ8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHJvGTbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95BEC4CEF7;
	Mon, 30 Mar 2026 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774849504;
	bh=7CsbheAqXZdCKr8ORK4lf7tuQ/x3D8IpJmB75IGdgMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHJvGTbkmE9anytYn6QzQRVi4jwX5B2MKyva4FKfjWdnuHgkcPBSYO94kzJgMBs/+
	 fS7wXx7zBey4f+HOEg3cSh8vL18QCGtu277FrcbowMN3wEUfCPMlN5W02Du3bBh9jY
	 GnQqs6wXO/CieHT0QzdPlteJ6ctnxF1M9SQj0u0Q=
Date: Mon, 30 Mar 2026 07:45:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: stable@vger.kernel.org, Kai Aizen <kai@snailsploit.com>
Subject: Re: Subject: [PATCH net] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Message-ID: <2026033051-primate-headache-5bf9@gregkh>
References: <CALynFi5UR5NUQLn8-rx66AoD72Qn0Chji_m+hVFrXL4cReNJ1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALynFi5UR5NUQLn8-rx66AoD72Qn0Chji_m+hVFrXL4cReNJ1A@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231006-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 25AC7355B12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 11:23:49PM +0300, Kai Zen wrote:
> CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
> workqueue without RTNL.  That patch closed the workqueue path by adding
> rtnl_lock() around the call.
> 
> However, three additional functions in the same subsystem access
> tipc_net->monitors[] from softirq context with no RCU protection at all:
> 
>   tipc_mon_peer_up()      - called from tipc_node_write_unlock()
>   tipc_mon_peer_down()    - called from tipc_node_write_unlock()
>   tipc_mon_remove_peer()  - called from tipc_node_link_down()
> 
> These three are invoked from the packet receive path (tipc_rcv ->
> tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
> rwlock, not RTNL.
> 
> Concurrently, bearer_disable() -- which always holds RTNL per its own
> inline documentation -- calls tipc_mon_delete(), which:
> 
>   1. acquires mon->lock
>   2. sets tn->monitors[bearer_id] = NULL
>   3. frees all peer entries
>   4. releases mon->lock
>   5. calls kfree(mon)                     <-- no synchronize_rcu()
> 
> The race is structural: there is no shared lock between the data-path
> reader (which reads monitors[id] then acquires mon->lock) and the
> teardown path (which acquires mon->lock, NULLs the slot, then frees).
> A softirq thread can read a non-NULL mon pointer, get preempted, and
> resume after kfree(mon) has run on another CPU, then call
> write_lock_bh(&mon->lock) on freed memory:
> 
>   CPU 0 (softirq / tipc_rcv)            CPU 1 (RTNL / bearer_disable)
>   tipc_mon_peer_up()
>     mon = tipc_monitor(net, id)
>     [mon is non-NULL]
>                                          tipc_mon_delete()
>                                            write_lock_bh(&mon->lock)
>                                            tn->monitors[id] = NULL
>                                            ...
>                                            write_unlock_bh(&mon->lock)
>                                            kfree(mon)
>     write_lock_bh(&mon->lock)   <-- UAF
> 
> The fix mirrors the existing bearer_list[] pattern in the same module:
> convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
> RCU_INIT_POINTER() + synchronize_rcu() on deletion (before the kfree),
> and the appropriate rcu_dereference_bh() vs rtnl_dereference() variant
> at each read site depending on execution context.
> 
> synchronize_rcu() in tipc_mon_delete() is placed after the
> write_unlock_bh() and before timer_shutdown_sync() + kfree() to ensure
> all softirq-context readers that already observed the old pointer have
> completed before the memory is freed.
> 
> Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
>  net/tipc/core.h    |  2 +-
>  net/tipc/monitor.c | 51 ++++++++++++++++++++++++++++++++--------------
>  2 files changed, 37 insertions(+), 16 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


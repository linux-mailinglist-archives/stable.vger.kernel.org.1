Return-Path: <stable+bounces-77862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE3D987E4F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B954428422C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271FD165F13;
	Fri, 27 Sep 2024 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCX3LdM+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F115ADAB;
	Fri, 27 Sep 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417970; cv=none; b=vBzpfCKZtyoYetGRiUBVdgZJkdKfjBAcn2GRpLmLD6zHo/3xpNfF4LLS5ggY35o5/o9esAETBJ6n2qlzFitPHuoolq7JIBb6PKNBXkv+TeDtJYlGa8ENen8smu5sSSXtvVoNvAGNGdLfUhqQWUmH6xNG/hKDW36Nh0QhoRPTFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417970; c=relaxed/simple;
	bh=M1g64ODESgVjB+4k2PjQZfMxNaXIE2b3a7xe5fzqKBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7sKvUmjaC54ub0el3+BnzP7I4nMxOiaHP1aEcGhjwx6new1JjpQsBM87SJBHKFA+ISLcWnAejs962AKnb0tiAIaMRb09dlvhonKKvQ+hbVeZvgGw4t/TL2t1+lWXXy9g+4tRDqIVvzeWEusGLPyQy8ZZHbJ2I+KwP8disQOzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCX3LdM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997D7C4CEC4;
	Fri, 27 Sep 2024 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727417970;
	bh=M1g64ODESgVjB+4k2PjQZfMxNaXIE2b3a7xe5fzqKBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCX3LdM+mZGYvz/cO5Xpe89Dzj5JKB9GJkEKqys5mTHnDe+B1mXuDWTHLTZTGzxyG
	 lHJWpV71yfpnCsZux6V3OXa4atQ3WThpMgAiPZFRYC2ct8+zjqchY9K3ROrGUaMDi+
	 baM1PB/UdHlpk0sBpD1Ien2IzGcE/bWXLV0O1VP4=
Date: Fri, 27 Sep 2024 08:19:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
Message-ID: <2024092711-amends-sincere-18df@gregkh>
References: <20240925185216.1990381-1-greearb@candelatech.com>
 <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
 <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>

On Thu, Sep 26, 2024 at 11:19:53AM -0700, Ben Greear wrote:
> On 9/26/24 02:03, Willem de Bruijn wrote:
> > greearb@ wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > > 
> > > This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> > > 
> > > dev_queue_xmit_nit needs to run with bh locking, otherwise
> > > it conflicts with packets coming in from a nic in softirq
> > > context and packets being transmitted from user context.
> > > 
> > > ================================
> > > WARNING: inconsistent lock state
> > > 6.11.0 #1 Tainted: G        W
> > > --------------------------------
> > > inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> > > btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
> > > ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
> > > {IN-SOFTIRQ-W} state was registered at:
> > >    lock_acquire+0x19a/0x4f0
> > >    _raw_spin_lock+0x27/0x40
> > >    packet_rcv+0xa33/0x1320
> > >    __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
> > >    __netif_receive_skb_list_core+0x2c9/0x890
> > >    netif_receive_skb_list_internal+0x610/0xcc0
> > >    napi_complete_done+0x1c0/0x7c0
> > >    igb_poll+0x1dbb/0x57e0 [igb]
> > >    __napi_poll.constprop.0+0x99/0x430
> > >    net_rx_action+0x8e7/0xe10
> > >    handle_softirqs+0x1b7/0x800
> > >    __irq_exit_rcu+0x91/0xc0
> > >    irq_exit_rcu+0x5/0x10
> > >    [snip]
> > > 
> > > other info that might help us debug this:
> > >   Possible unsafe locking scenario:
> > > 
> > >         CPU0
> > >         ----
> > >    lock(rlock-AF_PACKET);
> > >    <Interrupt>
> > >      lock(rlock-AF_PACKET);
> > > 
> > >   *** DEADLOCK ***
> > > 
> > > Call Trace:
> > >   <TASK>
> > >   dump_stack_lvl+0x73/0xa0
> > >   mark_lock+0x102e/0x16b0
> > >   __lock_acquire+0x9ae/0x6170
> > >   lock_acquire+0x19a/0x4f0
> > >   _raw_spin_lock+0x27/0x40
> > >   tpacket_rcv+0x863/0x3b30
> > >   dev_queue_xmit_nit+0x709/0xa40
> > >   vrf_finish_direct+0x26e/0x340 [vrf]
> > >   vrf_l3_out+0x5f4/0xe80 [vrf]
> > >   __ip_local_out+0x51e/0x7a0
> > > [snip]
> > > 
> > > Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
> > > Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/
> > > 
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > 
> > Please Cc: all previous reviewers and folks who participated in the
> > discussion. I entirely missed this. No need to add as Cc tags, just
> > --cc in git send-email will do.
> > 
> > > ---
> > > 
> > > v2:  Edit patch description.
> > > 
> > >   drivers/net/vrf.c | 2 ++
> > >   net/core/dev.c    | 1 +
> > >   2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > > index 4d8ccaf9a2b4..4087f72f0d2b 100644
> > > --- a/drivers/net/vrf.c
> > > +++ b/drivers/net/vrf.c
> > > @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
> > >   		eth_zero_addr(eth->h_dest);
> > >   		eth->h_proto = skb->protocol;
> > > +		rcu_read_lock_bh();
> > >   		dev_queue_xmit_nit(skb, vrf_dev);
> > > +		rcu_read_unlock_bh();
> > >   		skb_pull(skb, ETH_HLEN);
> > >   	}
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index cd479f5f22f6..566e69a38eed 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
> > >   /*
> > >    *	Support routine. Sends outgoing frames to any network
> > >    *	taps currently in use.
> > > + *	BH must be disabled before calling this.
> > 
> > Unnecessary. Especially patches for stable should be minimal to
> > reduce the chance of conflicts.
> 
> I was asked to add this, and also asked to CC stable.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


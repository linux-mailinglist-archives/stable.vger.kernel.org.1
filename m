Return-Path: <stable+bounces-73146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E696D0A8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC4EB2285C
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B8193411;
	Thu,  5 Sep 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tDFw401i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDE192D70;
	Thu,  5 Sep 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522239; cv=none; b=QY8YcvBrca1Ho5/vaaqh2TvqY9gAn3CUx9uo/uGk2MWIw7cUFnlGyUvTbMmxsD7OJmgAkIpKstSXwICVZ+UHz8LDc2/qSJaNRWRq0as1gREb9AbxDgp5eqR7CJGcMk9Gtc9VEJwN0ZGWTd59h9PUSpowwR5idS87gZA7wc8AC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522239; c=relaxed/simple;
	bh=S8/TtXkZj7uHoxHpMVYmtyHnnkcgrFhlb9iCKy4r99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKvWnzlqjFndcb1Xez0/wteLciCGKAmAERI+TSS7AACB4BO+ug46E8mZQ60/W79o//GYcsthGrZ5mPPPRqJvmqFfhOfkximJpL21XINFkZurmkpSOFVjPhf5W2B9q3MMfC9E46xs8W8F77Wjll2AjrLoAy92vgzw+4q3t94/8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDFw401i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97229C4CEC4;
	Thu,  5 Sep 2024 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725522239;
	bh=S8/TtXkZj7uHoxHpMVYmtyHnnkcgrFhlb9iCKy4r99Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDFw401iokMtFH2bA5JxkYOmfH1nCuTNu1/4QFFmaScBfbMGEiNimT5yp2hNNzmmx
	 0UolQCF/sZ+mBWHcafzAKthmfhQ2HCfmQSzoZGWIX+tgj3TakdiWr0ocp1pgRClPCY
	 nfZHoB8AIgJhG7HLUA1OMbIghKa8aOtwFFH42I2w=
Date: Thu, 5 Sep 2024 09:43:55 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 5.10, 5.4] net: set SOCK_RCU_FREE before inserting socket
 into hashtable
Message-ID: <2024090543-itinerary-marina-3814@gregkh>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
 <2024090305-starfish-hardship-dadc@gregkh>
 <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
 <2024090344-repave-clench-3d61@gregkh>
 <64688590d5cf73d0fd7b536723e399457d23aa8e.camel@oracle.com>
 <2024090401-underuse-resale-3eef@gregkh>
 <004b3dec44fe2fe6433043c509d52e72d8a8ca9d.camel@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004b3dec44fe2fe6433043c509d52e72d8a8ca9d.camel@oracle.com>

On Wed, Sep 04, 2024 at 01:06:45PM +0000, Siddh Raman Pant wrote:
> [ Upstream commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 ]
> 
> We've started to see the following kernel traces:
> 
>  WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0
> 
>  Call Trace:
>   <IRQ>
>   __bpf_skc_lookup+0x10d/0x120
>   bpf_sk_lookup+0x48/0xd0
>   bpf_sk_lookup_tcp+0x19/0x20
>   bpf_prog_<redacted>+0x37c/0x16a3
>   cls_bpf_classify+0x205/0x2e0
>   tcf_classify+0x92/0x160
>   __netif_receive_skb_core+0xe52/0xf10
>   __netif_receive_skb_list_core+0x96/0x2b0
>   napi_complete_done+0x7b5/0xb70
>   <redacted>_poll+0x94/0xb0
>   net_rx_action+0x163/0x1d70
>   __do_softirq+0xdc/0x32e
>   asm_call_irq_on_stack+0x12/0x20
>   </IRQ>
>   do_softirq_own_stack+0x36/0x50
>   do_softirq+0x44/0x70
> 
> __inet_hash can race with lockless (rcu) readers on the other cpus:
> 
>   __inet_hash
>     __sk_nulls_add_node_rcu
>     <- (bpf triggers here)
>     sock_set_flag(SOCK_RCU_FREE)
> 
> Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
> the socket into hashtables. Note, that the race is really harmless;
> the bpf callers are handling this situation (where listener socket
> doesn't have SOCK_RCU_FREE set) correctly, so the only
> annoyance is a WARN_ONCE.
> 
> More details from Eric regarding SOCK_RCU_FREE timeline:
> 
> Commit 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under
> synflood") added SOCK_RCU_FREE. At that time, the precise location of
> sock_set_flag(sk, SOCK_RCU_FREE) did not matter, because the thread calling
> __inet_hash() owns a reference on sk. SOCK_RCU_FREE was only tested
> at dismantle time.
> 
> Commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> started checking SOCK_RCU_FREE _after_ the lookup to infer whether
> the refcount has been taken care of.
> 
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [Resolved conflict for 5.10 and below.]
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  net/ipv4/inet_hashtables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now  queued up, thanks.

greg k-h


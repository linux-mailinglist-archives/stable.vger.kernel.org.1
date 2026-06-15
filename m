Return-Path: <stable+bounces-263189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WjhlBQDuL2rvJAUAu9opvQ
	(envelope-from <stable+bounces-263189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:20:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9B68620D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K6wpq9JP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263189-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263189-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 128BF300516F
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8323E7BA0;
	Mon, 15 Jun 2026 12:20:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44A3E5A0D;
	Mon, 15 Jun 2026 12:20:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526008; cv=none; b=K49xamgy5XTlppWTTz7/jYfmNHRIuycd8b+Aw/gSrMLGdo8eTE2GDBbLtTe/APzzoOFTPgac/oqKoYSPW46CPf1csxSkUqSkEpZisELppsHbgAz6aT8oJ63tzQwYO9ejuzV03gikZ8ppiBismn7p8AFZNZ5/O0g29ohDUXG06Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526008; c=relaxed/simple;
	bh=dy29tVzMoV4uAAOjnnZkN02UucShY5QCfp+RR0vrzLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/8/03BmGorZzmIi31a1sKPNESxClqGeNp5riXEjV7BDmkRWggZ1ByUXUG0otbv3b74mnMv5nk22BKfEeKqqhtDMSo0vtO5Q0jIDto9jd1B9IbeGLAhwGi4g0v4Vz7lWkpRcr+pDwZB4pMBbXLWAvKhMvKajpRwSEBfHdBROuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6wpq9JP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B451F000E9;
	Mon, 15 Jun 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781526006;
	bh=7LQqKV6QBy633oBWUbkYfYVg4sCe3qRO7gkX1CZFGTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6wpq9JPZiOtS6o2eFoFCYVaMmzwyeFy5kY8lei4Bm2r4qqP5wJzbrUhGpyyspkA0
	 DRR1NN8QXmIKyopYFYfEo+lrRdE4/8YpEeCfOJBSi8luZWw2uoGlJeoxH+LR9vyhzZ
	 4oKrsRR+rIRAcr0h2ixHJn0VsJrMPc147QB5rOARt49uPLyoF0PPMoAn8wCahtntV5
	 FScMEqI97WyVQjNDC3ZkiNCkddD4IhRjLTwxdWaFd2SXcKGALAR8eoTge+apA+tY6/
	 B2xK4mkA/XDOyHYLuDWbcP6atnsslLCBlNDuTRQDNyS/jBohnHbNC4u6TIuUzgOHaj
	 BfCIrnTINPYBw==
Date: Mon, 15 Jun 2026 13:20:01 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: aarp: fix proxy probe conflict lookup
Message-ID: <20260615122001.GH712698@horms.kernel.org>
References: <20260613150104.1985-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613150104.1985-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263189-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hxzene@gmail.com,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tsinghua.edu.cn:email,horms.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06E9B68620D

On Sat, Jun 13, 2026 at 11:00:59PM +0800, Yizhou Zhao wrote:
> aarp_rcv() computes hash from the packet source node and later uses it
> for the normal AARP reply lookup against the unresolved table. The same
> hash is also reused earlier for the proxy probe conflict check, but that
> check builds its lookup key from the packet destination address.
> 
> Proxy AARP entries are inserted into the proxy table using the proxied
> address node as the hash key. AARP packets are not required to have the
> same source and destination node numbers, so the proxy probe conflict
> check can search the wrong bucket and miss an entry that is still in
> ATIF_PROBE state.
> 
> If that happens, SIOCSARP can accept a proxy address even though a
> conflicting AARP packet was observed on the wire. This can create
> duplicate AppleTalk address ownership. Depending on the network setup,
> traffic for that address may then be misdirected, or the address may
> become intermittently unreachable.
> 
> Look up the proxy probe entry using a hash derived from da.s_node, which
> matches how proxy entries are inserted and removed. Leave the source-node
> hash unchanged for the later unresolved-entry reply handling.
> 
> In a veth/SNAP/AARP reproducer on a KASAN-enabled kernel, a conflicting
> AARP packet with different source and destination nodes allowed SIOCSARP
> to succeed before this change. With this change, the same conflict
> returns EADDRINUSE, while a no-conflict proxy add still succeeds.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  net/appletalk/aarp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
> index 078fb7a6efa5..1352ede79668 100644
> --- a/net/appletalk/aarp.c
> +++ b/net/appletalk/aarp.c
> @@ -755,7 +755,8 @@ static int aarp_rcv(struct sk_buff *skb, struct net_device *dev,
>  	da.s_net  = ea->pa_dst_net;
>  
>  	write_lock_bh(&aarp_lock);
> -	a = __aarp_find_entry(proxies[hash], dev, &da);
> +	a = __aarp_find_entry(proxies[da.s_node % (AARP_HASH_SIZE - 1)],
> +			      dev, &da);

Hi Yinzhou,

I wonder if __aarp_proxy_find() can be used here.

>  
>  	if (a && a->status & ATIF_PROBE) {
>  		a->status |= ATIF_PROBE_FAIL;


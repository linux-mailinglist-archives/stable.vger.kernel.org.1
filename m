Return-Path: <stable+bounces-268761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5lqjH6whPmrjAAkAu9opvQ
	(envelope-from <stable+bounces-268761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A56CAC3C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:52:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2tjalHeR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268761-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268761-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE7FE300E3C0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B673DB992;
	Fri, 26 Jun 2026 06:52:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6991A38F9;
	Fri, 26 Jun 2026 06:52:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456741; cv=none; b=DnAEjMmXR6yOTYYsQ0bBiRHuC/h8s3nHm3UnJdB4Q4oeqRH0YwQt9ZxMkIsfgChyXOp2Med2+ocOsv9b3Tx+/H3DdWHPgpGEQswm5MrsR1riQuW+UyQPR+ZVImibn1vot3iu8slHK0El1wekTVkZzgKw1189SjmeZ3O05fO6u+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456741; c=relaxed/simple;
	bh=f15NUJf2D8gd3Uz7i/TVeIpGoFG6ZaBR8N9+UBH5I7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1D8fhYdznYKwrGtcoQ2Q3BgHRDS5Y1uN3CinctCSL8Z0rm/MZLGMTgLNA+fx23EgnU2IaaSTDWSD41Hsxzcn+7dGiQA7k2FyPwuh/wjbX8+aSOZFjB8AIgUnVrqKO/uWobAkC8TQN0fdWug/Nfssww8m62h/hzWag6ogzSzaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2tjalHeR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812FE1F00A3A;
	Fri, 26 Jun 2026 06:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782456738;
	bh=FNa5qRwhRr6rryVW7TDlnD7K0wtIjPsL5cMW4Y31S24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2tjalHeRT7aBQocMURvgN2j7iBuRFOLN9actXuzaCNWwT2DQ1K1I9uJZglEio5Dv+
	 57oA40zqDE3Aqtb/G4LNCZSCA/3u9BYtyRQ3qoClTP/9eslISDYSxay/vc5coDFM4S
	 J8dbh/MFue4QvKQbhxYhfNWwLU0Y1ltQi3kzE5eY=
Date: Fri, 26 Jun 2026 07:51:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: sashal@kernel.org, bestswngs@gmail.com, coreteam@netfilter.org,
	davem@davemloft.net, fw@strlen.de, kaber@trash.net,
	kadlec@netfilter.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel, pablo@netfilter.org,
	stable@vger.kernel.org, xmei5@asu.edu, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2] netfilter: nf_log: validate MAC header was set before
 dumping it
Message-ID: <2026062658-pregame-buggy-ccbc@gregkh>
References: <20260625054005.0003.nflog-510@kernel.org>
 <20260625164755.161383-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625164755.161383-1-alexevgmart@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexevgmart@gmail.com,m:sashal@kernel.org,m:bestswngs@gmail.com,m:coreteam@netfilter.org,m:davem@davemloft.net,m:fw@strlen.de,m:kaber@trash.net,m:kadlec@netfilter.org,m:kuba@kernel.org,m:kuznet@ms2.inr.ac.ru,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel,m:pablo@netfilter.org,m:stable@vger.kernel.org,m:xmei5@asu.edu,m:yoshfuji@linux-ipv6.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268761-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,netfilter.org,davemloft.net,strlen.de,trash.net,ms2.inr.ac.ru,vger.kernel.org,vger.kernel,asu.edu,linux-ipv6.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E60A56CAC3C

On Thu, Jun 25, 2026 at 07:47:55PM +0300, Alexander Martyniuk wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream.
> 
> The fallback path of dump_mac_header() guards the MAC header access
> only with "skb->mac_header != skb->network_header", without checking
> skb_mac_header_was_set(). When the MAC header is unset, mac_header is
> 0xffff, so the test passes and skb_mac_header(skb) returns
> skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> dev->hard_header_len bytes out of bounds into the kernel log.
> 
> This is reachable via the netdev logger: nf_log_unknown_packet() calls
> dump_mac_header() unconditionally, and an skb sent through AF_PACKET
> with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
> unset (__dev_queue_xmit(), which would reset it, is bypassed).
> 
> Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
> uses, and replace the open-coded MAC header length test with
> skb_mac_header_len(). Only skbs with an unset MAC header are affected;
> valid ones are dumped as before.
> 
>  BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
>  Read of size 1 at addr ffff88800ea49d3f by task exploit/148
>  Call Trace:
>   kasan_report (mm/kasan/report.c:595)
>   dump_mac_header (net/netfilter/nf_log_syslog.c:831)
>   nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
>   nf_log_packet (net/netfilter/nf_log.c:260)
>   nft_log_eval (net/netfilter/nft_log.c:60)
>   nft_do_chain (net/netfilter/nf_tables_core.c:285)
>   nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
>   nf_hook_slow (net/netfilter/core.c:619)
>   nf_hook_direct_egress (net/packet/af_packet.c:257)
>   packet_xmit (net/packet/af_packet.c:280)
>   packet_sendmsg (net/packet/af_packet.c:3114)
>   __sys_sendto (net/socket.c:2265)
> 
> Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
> ---
>  net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
>  net/ipv6/netfilter/nf_log_ipv6.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
> index d07583fac8f8..d6164e8e2c73 100644
> --- a/net/ipv4/netfilter/nf_log_ipv4.c
> +++ b/net/ipv4/netfilter/nf_log_ipv4.c
> @@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
>  
>  fallback:
>  	nf_log_buf_add(m, "MAC=");
> -	if (dev->hard_header_len &&
> -	    skb->mac_header != skb->network_header) {
> +	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
> +	    skb_mac_header_len(skb) != 0) {
>  		const unsigned char *p = skb_mac_header(skb);
>  		unsigned int i;
>  
> diff --git a/net/ipv6/netfilter/nf_log_ipv6.c b/net/ipv6/netfilter/nf_log_ipv6.c
> index 8210ff34ed9b..cc724870a467 100644
> --- a/net/ipv6/netfilter/nf_log_ipv6.c
> +++ b/net/ipv6/netfilter/nf_log_ipv6.c
> @@ -309,8 +309,8 @@ static void dump_ipv6_mac_header(struct nf_log_buf *m,
>  
>  fallback:
>  	nf_log_buf_add(m, "MAC=");
> -	if (dev->hard_header_len &&
> -	    skb->mac_header != skb->network_header) {
> +	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
> +	    skb_mac_header_len(skb) != 0) {
>  		const unsigned char *p = skb_mac_header(skb);
>  		unsigned int len = dev->hard_header_len;
>  		unsigned int i;
> -- 
> 2.43.0
> 
> 

What kernel(s) is this for?


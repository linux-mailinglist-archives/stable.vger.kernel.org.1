Return-Path: <stable+bounces-268147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tLbSOmbEO2pGcggAu9opvQ
	(envelope-from <stable+bounces-268147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:49:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4846BDD48
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=RzcORzDA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268147-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268147-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF07E3046EED
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD72E228D;
	Wed, 24 Jun 2026 11:48:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADB2DF153;
	Wed, 24 Jun 2026 11:48:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301722; cv=none; b=jkjjM93U/xlIkjkkPMOwZNOgcGCe/+WSHxch+xJqrZtc5XETL5os+euLX20c/a1NeTD+CoXvg8ab1GIc2A2dpvvzVQaDsrqbh1jxqiywPBZ92EbjRnSjzLF+vr20MgI7vyhWkxrnkK14VcinuzQowzH3ost8ZPvgroB3v8mx+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301722; c=relaxed/simple;
	bh=Tb+d2AAtLwTqkgvKXoUk3ISGmsbGCps99DXhFcY4tik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX/ggXJ2YWTTZAmrMETIujDdxxiQFRy2im8kAca3YatIEJxF11QBJ2y0RRabgJLAuRxmgJwqmo8rLxhniS93erjaohNaBuyCEOwcfpR3StmB+TaWEW84I4IIGrc4FM3kEeTzT7+e0e4k0xTyarLSRbv1W8eNw11qIP2nBindlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=RzcORzDA; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 188ED6057B;
	Wed, 24 Jun 2026 13:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782301711;
	bh=5EJ4tt0BF14PyUb1G8s5DQNcfkPtXwzrKk/jyjeL05k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzcORzDAnE8unbh+no/SvQkRTf9ugPpAbvfTtE7jF8cRTX54p5fmV9rv0v6w6FGBY
	 oDb9OIleW+MoQhxD/TK0E47Y03d94dk9/0ghrgZoaJcCNKjMPxpDz7sxlDxzXEEHJv
	 jKQr3BGXhW+H+QtYicDIRIgC+UXyui61xv1w20N8UaiibZdPX4IXbikRjarUoFXI+R
	 iqqMqjaZBZg/t4SSR6+FrF3DDaGJycqJ+JzJC1M+KUMPlnL9XoxjMjlWvf6p++e9ia
	 kc2NhyEs4I3PQzO307hxePimRRuHIIOpSYry8zG9cbl8Ui+Xe5CkweXPZWIIDxeEV6
	 aW7kTdto/ipNg==
Date: Wed, 24 Jun 2026 13:48:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set
 before dumping it
Message-ID: <ajvEDFOlP7Bqb-3j@chamomile>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624140117.19799-1-alexevgmart@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS(0.00)[m:alexevgmart@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,kernel.org,trash.net,vger.kernel,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268147-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,chamomile:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4846BDD48

Hi,

Thanks but why only 5.10?

On Wed, Jun 24, 2026 at 02:01:15PM +0000, Alexander Martyniuk wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream
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
> Backport fix for CVE-2026-52942
>  net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
> -- 
> 2.43.0
> 


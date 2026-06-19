Return-Path: <stable+bounces-267360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCVfLncSNWqBmgYAu9opvQ
	(envelope-from <stable+bounces-267360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:57:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 513536A5114
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:57:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=I1GC+9f7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267360-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABDA530058EA
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29B367B74;
	Fri, 19 Jun 2026 09:57:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE50369991;
	Fri, 19 Jun 2026 09:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863027; cv=none; b=Rr1l/GZ5UBIuTWGk/gpi7xOVsM6yvc6C2C9Cm4MTBIjB8wXDG+uMfwPjVZZTDcArgPnC7+8KPigfg0QjZNGcckeFGXAKcYyWyhdap2JsGjeRJ6cb2QXPIsSJR2njToT6SZeTRO1u55X9pk2qCf1ACgW9nipRwQ8mQedW83iXPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863027; c=relaxed/simple;
	bh=5nn0vOFfEC8IB7QEw+QjZpLzYA1Lz8v2GLiPO0g9xsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEwrhz4wadRzdetUSSL13UfN5QBHesNEVIlLpnHgDhXfs+RRWwMzkrdzkVIz+0yfI1y7cB7DJYjcnRQT3w0Y8iizxWyWhsKum2p4iMAOZgvFU51NW6PjXkTWVVXneSsrZ2w5qWJ7igWf70zQV2uiGZ3cn7OHISJXbJSmc1O+m+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1GC+9f7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AFB1F000E9;
	Fri, 19 Jun 2026 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781863020;
	bh=DiFPSAGm3QGqD5XdKFqj9fbqyoJ+B1hzp8sXWp75HQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1GC+9f7yX3P3COKWIaUtw1Eb2qTl4squBDTA0mNPUZdzie+DoBKGfyNe7Fwe8VUH
	 hwqyaAI2x0WWuJJCe24F8dYSZwW0XbDcBhBICqV069Jcp0ypuTWj/eS1LNXsshWS41
	 zwNml85wJ2PfaRbVoTP3DK0mp1HX1aiokJ9kAmPw=
Date: Fri, 19 Jun 2026 11:55:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.15 193/411] netfilter: nf_log: validate MAC header was
 set before dumping it
Message-ID: <2026061924-treat-enjoyably-08c8@gregkh>
References: <20260616145100.376842714@linuxfoundation.org>
 <20260616145110.984893387@linuxfoundation.org>
 <167562b4-4472-4ead-a107-6eb83275825c@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167562b4-4472-4ead-a107-6eb83275825c@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,asu.edu,netfilter.org,kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:pablo@netfilter.org,m:sashal@kernel.org,m:ramanan.govindarajan@oracle.com,m:vegard.nossum@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 513536A5114

On Fri, Jun 19, 2026 at 10:58:54AM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> 
> On 16/06/26 20:27, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Xiang Mei <xmei5@asu.edu>
> > 
> > [ Upstream commit a84b6fedbc97078788be78dbdd7517d143ad1a77 ]
> > 
> > The fallback path of dump_mac_header() guards the MAC header access
> > only with "skb->mac_header != skb->network_header", without checking
> > skb_mac_header_was_set(). When the MAC header is unset, mac_header is
> > 0xffff, so the test passes and skb_mac_header(skb) returns
> > skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> > dev->hard_header_len bytes out of bounds into the kernel log.
> > 
> > This is reachable via the netdev logger: nf_log_unknown_packet() calls
> > dump_mac_header() unconditionally, and an skb sent through AF_PACKET
> > with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
> > unset (__dev_queue_xmit(), which would reset it, is bypassed).
> > 
> > Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
> > uses, and replace the open-coded MAC header length test with
> > skb_mac_header_len(). Only skbs with an unset MAC header are affected;
> > valid ones are dumped as before.
> > 
> >   BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
> >   Read of size 1 at addr ffff88800ea49d3f by task exploit/148
> >   Call Trace:
> >    kasan_report (mm/kasan/report.c:595)
> >    dump_mac_header (net/netfilter/nf_log_syslog.c:831)
> >    nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
> >    nf_log_packet (net/netfilter/nf_log.c:260)
> >    nft_log_eval (net/netfilter/nft_log.c:60)
> >    nft_do_chain (net/netfilter/nf_tables_core.c:285)
> >    nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
> >    nf_hook_slow (net/netfilter/core.c:619)
> >    nf_hook_direct_egress (net/packet/af_packet.c:257)
> >    packet_xmit (net/packet/af_packet.c:280)
> >    packet_sendmsg (net/packet/af_packet.c:3114)
> >    __sys_sendto (net/socket.c:2265)
> > 
> > Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> 
> I ran an AI assisted backport review over the 5.15.210 queue, and thr report
> looks valid to me:
> 
> this 5.15.y backport fixed the IPv4 split helper but missed the equivalent
> IPv6 helper.
> 
> So we would need a 5.15.y backport slightly deviate from upstream patch.
> 
> Upstream a84b6fedbc97 uses this guard before dumping fallback MAC bytes:
> 
>         if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
>             skb_mac_header_len(skb) != 0) {
>                 const unsigned char *p = skb_mac_header(skb);
> 
> The 5.15.y IPv4 helper has that guard, but final 5.15.y still has this in
> dump_ipv6_mac_header():
> 
>         if (dev->hard_header_len &&
>             skb->mac_header != skb->network_header) {
>                 const unsigned char *p = skb_mac_header(skb);
> 
> Upstream has one shared helper, so the new guard covers both IPv4 and IPv6.
> 5.15.y still has split helpers, and the backport mapped the fix only to the
> IPv4 side. The IPv6 netdev logging path can therefore still call
> skb_mac_header(skb) after the old unsafe fallback predicate.
> 
> I think 5.15.y needs the same skb_mac_header_was_set() /
> skb_mac_header_len() guard added to dump_ipv6_mac_header(), thoughts?
> 
> And this is because 5.15.y doesn't have commit: 39ab798fc14d ("netfilter:
> nf_log_syslog: Merge MAC header dumpers") so we need a similar adaption in
> 5.15.y
> 
> I am still thinking having a TODO for these sorts of things might be worth
> it, particularly because we will miss these easily where upstream commit is
> backported(so nothing to backport from a git perspective) but that doesn't
> fit downstream perfectly(so more work to do). Btw, its just a thought :)

Yes, a TODO would be great for this type of thing, if you can come up
with a way it can be tracked/handled, I'd be all for it.

tanks,

greg k-h


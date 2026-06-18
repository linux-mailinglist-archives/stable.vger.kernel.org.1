Return-Path: <stable+bounces-267101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7cHVCh3TM2qJGwYAu9opvQ
	(envelope-from <stable+bounces-267101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:14:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93869FABD
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DjWnCt5x;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267101-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267101-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B45B13158542
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED13F0ABE;
	Thu, 18 Jun 2026 11:11:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBB3EC2DE;
	Thu, 18 Jun 2026 11:11:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781062; cv=none; b=uZp899LNMDAHFAaJ/E5Z0t9P9MUlt+JQABC5fTKy2gLBFllP1hyInSul/JwYTL+xIoFPZQ8bHE6XzxcpEt1XgTcgfKz02biTeKcTat6vAz24e+27crRFqaIKE9dhGEKarjmUyzNbFFhhiiDyy7Ra5BuOoJJr1Z+PQJHTtGiM5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781062; c=relaxed/simple;
	bh=VHc08RQlm2skduyrGOzG6Sm5yYaIzrhPqYDsLBcegZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVFg2SZKBLaHrW9DggraBSLmY67K8zKy99TcCz2nzOtfjOW8lYWy88ot60RSpQGI3FDprmkYeX4KieQmeJ33VuyJCtKgyqvgWffWJ1XvfDmERLoK/FG5yosZmutg1WXwuGurk/TMYyFCwNulMqMz2vLTrN3A2n+Oh9qA+iDuSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjWnCt5x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F921F00A3A;
	Thu, 18 Jun 2026 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781781060;
	bh=83dxZpVPhXc1E3WQioF1CMaRijrM+LA2h9R+oXG5gRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DjWnCt5xWeN/blgB9dJlM+hKZe21UmZp8qbZbZqThhns+P0STUwOciuSkkAiWD5Wf
	 P0miwIWqzb7JfANCL+kXT7BtZvVQVqEaRgesmlBudiyGBQ6hMsxT+g56ZqwQyleEUn
	 ealzZqVBwyKNDDH77l5DVqku+oMMi8H/LyZXU/h4=
Date: Thu, 18 Jun 2026 13:11:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.12 100/261] netfilter: nf_log: validate MAC header was
 set before dumping it
Message-ID: <2026061823-film-pastrami-44cf@gregkh>
References: <20260616145044.869532709@linuxfoundation.org>
 <20260616145049.667194632@linuxfoundation.org>
 <ed09740a-561f-41e4-8d7b-ade8f6ae0763@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed09740a-561f-41e4-8d7b-ade8f6ae0763@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267101-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:pablo@netfilter.org,m:sashal@kernel.org,m:vegard.nossum@oracle.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,asu.edu,netfilter.org,kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A93869FABD

On Thu, Jun 18, 2026 at 04:27:58PM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> On 16/06/26 20:28, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
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
> 
> I have run an AI assisted backport review and it spotted an issue: I
> have taken a look and the issue goes like:
> 
> Upstream has this before the eth_hdr() users in dump_mac_header():
> 
>     if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
>         return;
> 
>     nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
>                    eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
> 
> 
> but 6.12.y still has:
> 
>       nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
>                      eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
>       nf_log_dump_vlan(m, skb);
> 
> 
> 
> 
> > Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
> > uses, and replace the open-coded MAC header length test with
> > skb_mac_header_len(). Only skbs with an unset MAC header are affected;
> > valid ones are dumped as before.
> ...
> 
> The posted backport fixes the fallback MAC dump path, but upstream only
> assumes the Ethernet decode path is already safe because of 62443dc21114
> ("netfilter: require Ethernet MAC header before using eth_hdr()"). I donot
> see that commit in 6.12.y, so NF_LOG_MACDECODE can still reach
> eth_hdr(skb) without proving the MAC header was set and long enough.
> 
> I think 6.12.y misses commit: 62443dc21114 ("netfilter: require
> Ethernet MAC header before using eth_hdr()") so this backport might not
> be complete, thoughts?
> 
> Maybe we need to backport 62443dc21114 ("netfilter: require
> Ethernet MAC header before using eth_hdr()") as well ?

So that would need to be backported to all stable queues, as that commit
showed up in 7.1, right?

Note, it was part of the AUTOSEL group, but those were dropped en-mass
as people were complaining about them.

thanks,

greg k-h


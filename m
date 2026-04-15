Return-Path: <stable+bounces-238102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBuWDL5132lWTQAAu9opvQ
	(envelope-from <stable+bounces-238102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DE403BFB
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871393045AB1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEA36494B;
	Wed, 15 Apr 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="iACIfECx"
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579337B00E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252054; cv=none; b=uqdhpawWoaApO91EFVvRtzB/ddAwRCs4/RB1uquVq93a4fDRGdrjr2SDEueRcdnhxAl0K01dK+bNf15ouqhqmrWPh4X47IiOLX+LpWy7JsLgNheU3FcUys1aD7+MWz4q0QXAyWE16aokiw0niOYEAEts8yMF5jy3UlpYlWRRqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252054; c=relaxed/simple;
	bh=VYJ9mL1wjZITxA7vMyRCHfik/LPjrJxnNOXZx7fqDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJRYG91fmwYDaFMULmPns3qqSUDK7yDdEwVwmBvqJqKBxkkUcHh8qPh2pby83rFVn2mN4BcykMcKh9G71wqJv+TeshjzRlbhf/FK8bYMGh7GnVvDooWrgjhCduKQJ2BMh35AhvXMFubiDN+290diRMZOGHwtZCsGryPdo/f8exA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iACIfECx; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7A9E16017D;
	Wed, 15 Apr 2026 13:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776252050;
	bh=UnwfL7k8OPnbJ/ufbG+zJTVtDPTxAIbmOOIhQVnyKnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iACIfECxa/4fEut8Q+7i6HFK428+cLbS05qZopGGc2lrL7lS8AhX+GJg4IjS5vhUE
	 veV6syVEYGdes0K1ajaHVToWpdlEBuJw5caokY4abQG1EJLG7a52sRFtA9nw7q33Qc
	 2VaxWLdAbw7g5nFcy5zgvwnrNjKHmKEvg7RwuZg+c6EKODrfjhcy7kTgMcM5ZUjx9g
	 Z7SXy20kAzt+smtozrVJBqBvsVHYZ819iHNwTbCD/hImAycgaQNEtFe5v3tqt23u68
	 TFlsOilVioqR1EIxc1sVkZ5rKUqI++clw3Um4bdFfiVJKVjpbK25VyIGNacrtYIFea
	 G6KhYzHJHvl1Q==
Date: Wed, 15 Apr 2026 13:20:48 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.15 336/570] netfilter: nf_conntrack_expect: skip
 expectations in other netns via proc
Message-ID: <ad90kM0wXIrO6aqu@chamomile>
References: <20260413155830.386096114@linuxfoundation.org>
 <20260413155843.080326747@linuxfoundation.org>
 <18260c94-4eca-434d-8a54-e556bc2057c9@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18260c94-4eca-434d-8a54-e556bc2057c9@oracle.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-238102-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 761DE403BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:45:49PM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> On 13/04/26 21:27, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > 
> > [ Upstream commit 3db5647984de03d9cae0dcddb509b058351f0ee4 ]
> > 
> > Skip expectations that do not reside in this netns.
> > 
> > Similar to e77e6ff502ea ("netfilter: conntrack: do not dump other netns's
> > conntrack entries via proc").
> > 
> 
> AI assisted review spotted a probable issue: I have gone through the
> analysis and the summary is:
> 
> I think this fix relies on commit: 02a3231b6d82 ("netfilter:
> nf_conntrack_expect: store netns and zone in expectation")
> 
> This references commit explicitly states:
> "  This patch is required by the follow up fix not to dump expectations that
> do not belong
>   to this netns." which is this patch.
> 
> 
> Also part of patch series 4 and 5:
> https://lore.kernel.org/all/20260320125947.305117-5-pablo@netfilter.org/
> 
> Given that we haven't taken 02a3231b6d82 ("netfilter: nf_conntrack_expect:
> store netns and zone in expectation") to 5.15.y should we drop this ?
> 
> Why ? Without it, the 5.15 backport still uses master-conntrack-derived
> context instead of expectation-owned stored netns/zone state
> 
> i.e Upstream has:
> 
> possible_net_t net;
> 
> static inline struct net *nf_ct_exp_net(struct nf_conntrack_expect *exp)
> {
>       return read_pnet(&exp->net);
> }
> 
> Downstream has:
> 
> static inline struct net *nf_ct_exp_net(struct nf_conntrack_expect *exp)
> {
>       return nf_ct_net(exp->master);
> }
> 
> 
> I don't know the internals of this fully, but looks like we might not want
> to take this fix without 02a3231b6d82 ("netfilter: nf_conntrack_expect:
> store netns and zone in expectation")

Yes:

02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")

is good to have as a Stable-Dep.

> Thanks,
> Harshit
> 
> 
> 
> 
> 
> 
> > Fixes: 9b03f38d0487 ("netfilter: netns nf_conntrack: per-netns expectations")
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   net/netfilter/nf_conntrack_expect.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
> > index 6d056ebba57c6..10d4dfbdde226 100644
> > --- a/net/netfilter/nf_conntrack_expect.c
> > +++ b/net/netfilter/nf_conntrack_expect.c
> > @@ -627,11 +627,15 @@ static int exp_seq_show(struct seq_file *s, void *v)
> >   {
> >   	struct nf_conntrack_expect *expect;
> >   	struct nf_conntrack_helper *helper;
> > +	struct net *net = seq_file_net(s);
> >   	struct hlist_node *n = v;
> >   	char *delim = "";
> >   	expect = hlist_entry(n, struct nf_conntrack_expect, hnode);
> > +	if (!net_eq(nf_ct_exp_net(expect), net))
> > +		return 0;
> > +
> >   	if (expect->timeout.function)
> >   		seq_printf(s, "%ld ", timer_pending(&expect->timeout)
> >   			   ? (long)(expect->timeout.expires - jiffies)/HZ : 0);
> 


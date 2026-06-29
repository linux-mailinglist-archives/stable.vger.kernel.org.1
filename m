Return-Path: <stable+bounces-269790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S+d1JJaPQmoc9wkAu9opvQ
	(envelope-from <stable+bounces-269790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:30:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F05136DCB18
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269790-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269790-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A8CD3065EA3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB39426EAB;
	Mon, 29 Jun 2026 15:23:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB54266B2;
	Mon, 29 Jun 2026 15:23:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746604; cv=none; b=V2KwQxsCaCmCUJOro1pQ5L4YkNL7dPw0fgZmX5bp88gASkI0VG3L548+C1vuerJ94mRPsPNJb2eY8pC4iJCxCA2oghtzC5gefoCdvY3XcF005lBl/OdLdG1/wg+oNeww0JdyJMvP0vd4gNLecA+cPtO/ZxdbHhx1spLkqrePoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746604; c=relaxed/simple;
	bh=buJd/u9F+wdKD3YLkBTjVFqrcSmXSGPZ5mhyiIdWO/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glAkpymYTuCgBt27s6jcMb0K0XdO7qA1UiWnnU0SeAmMzbl/YMSseec8KxnczVyBvqv8HCfi8Wp8MOb/pSjMRYveCl/gOj7PD++mOh/LPLQmQSFkTMYPDKXBPpxBcvHs55CuCppVSk/tPVS5txOiFV/vXqDMmInLxAQmng/G1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 743DE60370; Mon, 29 Jun 2026 17:23:19 +0200 (CEST)
Date: Mon, 29 Jun 2026 17:23:13 +0200
From: Florian Westphal <fw@strlen.de>
To: xietangxin <xietangxin@h-partners.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	gaoxingwang <gaoxingwang1@huawei.com>,
	huyizhen <huyizhen2@huawei.com>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_nat_masquerade: recalculate TCP TS
 offset when port is randomized
Message-ID: <akKN4cywAsFRdefX@strlen.de>
References: <20260629093408.3927103-1-xietangxin@h-partners.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629093408.3927103-1-xietangxin@h-partners.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@h-partners.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gaoxingwang1@huawei.com,m:huyizhen2@huawei.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269790-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime,h-partners.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F05136DCB18

xietangxin <xietangxin@h-partners.com> wrote:
> Problem observed in Kubernetes environments where MASQUERADE target with
> --random-fully is configured by default. after commit
> 165573e41f2f ("tcp: secure_seq: add back ports to TS offset") TCP short
> connection QPS dropped from ~20000 to ~10000. This added source and
> destination ports into TS offset calculation.
> 
> However, with MASQUERADE --random-fully, when multiple internal connections
> (e.g sport 10000,20000) are mapped to the same external port (e.g 30000),
> their TS offsets are calculated as ts_offset(10000) and ts_offset(20000).
> If the server reuses the TIME_WAIT slot from the first connection, there is
> a chance that ts_offset(20000) < ts_offset(10000), breaking TSval
> monotonicity for the same 4-tuple and causing RST packets:
>   Client -> Server 24870 -> 80 [SYN] TSval=2294041168
>   Server -> Client 80 -> 24870 [ACK] TSecr=2846236456
>   Client -> Server 24870 -> 80 [RST] Seq=855605690
> 
> After nf_nat_setup_info() successfully assigns a new randomized
> source port, recalculate the TS offset using the new port and
> update the SYN packet's TSval accordingly.

I don't think this is related to masquerade but to snat (port address
rewrite) in general.

I think you could place your new helper in nf_nat_core.c and call it
from nf_nat_l4proto_unique_tuple() once we've found a usable tuple:

 668 another_round:
 669         for (i = 0; i < attempts; i++, off++) {
 670                 *keyptr = htons(min + off % range_size);
 671                 if (!nf_nat_used_tuple_harder(tuple, ct, attempts - i))

	 		     ... here.
 672                         return;
 673         }



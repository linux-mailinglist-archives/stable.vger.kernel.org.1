Return-Path: <stable+bounces-270586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gYuWIbmcRmqPaAsAu9opvQ
	(envelope-from <stable+bounces-270586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:15:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B06FB2A8
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BHcljZkj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270586-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270586-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705553055C50
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BD3368BF;
	Thu,  2 Jul 2026 16:22:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400D340416;
	Thu,  2 Jul 2026 16:21:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009320; cv=none; b=BxgsEp/11l885MpJzrotttucK5aoQHr4rlcEugCdQbFChi/c6f0q526cM0FnzS5i8FrfGFKbcUkm+4U/TEo8WNx/xs6gzWBhJZmQW+arg/8aaC4dQXs1UdampoYtGxF++jEcngPhsbRtwuUdobjSuJZWId6Doa38ZmIvkwX2gsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009320; c=relaxed/simple;
	bh=UPz1caS229fhiPRiNKdfCyDvXtRx3JTcdXJWGDsFx78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBxOO3Wk56qXXU9GLIFiyGK9OZDdrLTj0EbwG1m9xH2ZRunAP0RP/PjxyM3Y9KAGH0TekbUwt4PMD927iehK0W6rkkUptiLQlSjz++U7cPPDXta1NuUdmXrZot4/mmrXxSOcGrJPI4vz1J5aLV7+d6euWHrT3iyUGG1CbDQS3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHcljZkj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6501F000E9;
	Thu,  2 Jul 2026 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009318;
	bh=ROoQa62ubq9FXVO6wuqNUEh5aSLdXA0Ebod/FRT1SmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHcljZkjg9chiEMW/g80ApiFQrsR8GjwzUKtJdJoqKb5Re+q9PI7gU0q38TXuEyKN
	 oCsed1pP72GLpzKU7TNJP6DmZXx6spLnIIGnfWqIYRa6RWS5itCQuyq0Q14KaAY3Zd
	 RZiDpqQ8Hk23PX9mPJKeJafp0bdzQ0jvHS2nk07M=
Date: Thu, 2 Jul 2026 18:16:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: 00107082 <00107082@163.com>, iklatzco <iklatzco@gmail.com>,
	patches <patches@lists.linux.dev>, peterz <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	"yeoreum.yun" <yeoreum.yun@arm.com>
Subject: Re: [PATCH] perf: Fix dangling cgroup pointer in cpuctx backport
Message-ID: <2026070200-uneaten-smock-4130@gregkh>
References: <2026062455-obtrusive-sandbox-d6d1@gregkh>
 <20260624095920.2558406-1-guanwentao@uniontech.com>
 <2026062404-unusual-nutmeg-87d5@gregkh>
 <tencent_5FDA609363B90C6249A050FD@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5FDA609363B90C6249A050FD@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[163.com,gmail.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:00107082@163.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
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
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD7B06FB2A8

On Wed, Jun 24, 2026 at 06:07:41PM +0800, Wentao Guan wrote:
> > On Wed, Jun 24, 2026 at 05:59:21PM +0800, Wentao Guan wrote:
> > > recently backport of ("perf: Fix dangling cgroup pointer in cpuctx")
> > > use a middle version, so aligned with the upstream commit:
> > > 3b7a34aebbdf2a4b7295205bf0c654294283ec82
> > >
> > > > Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> > > ---
> > >  kernel/events/core.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index a4187dea6402a..73a86db06cc9b 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2384,10 +2384,9 @@ __perf_remove_from_context(struct perf_event *event,
> > >  */
> > >  if (flags & DETACH_EXIT)
> > >  state = PERF_EVENT_STATE_EXIT;
> > > - if (flags & DETACH_DEAD) {
> > > - event->pending_disable = 1;
> > > + if (flags & DETACH_DEAD)
> > >  state = PERF_EVENT_STATE_DEAD;
> > > - }
> > > +
> > >  event_sched_out(event, ctx);
> > > 
> > >  if (event->state > PERF_EVENT_STATE_OFF)
> > > --
> > > 2.30.2
> > >
> > 
> > What kernel tree(s) is this for?  What git id does this fix?
> 1. v6.6.143 and v6.12.94
> 2. 
> ae1ada0af16249a3ed15e33fa6719a6a2f96f537 in v6.6.143
> 46f5623f9b0ef66127e1de16fb857850cdb14e68 in v6.12.94

Please put all of this information in the changelog and provide
versions for all of the branches you want it for.

thanks,

greg k-h


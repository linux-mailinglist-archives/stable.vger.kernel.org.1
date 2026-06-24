Return-Path: <stable+bounces-268134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsjaOnqrO2pebAgAu9opvQ
	(envelope-from <stable+bounces-268134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AFD6BD2BA
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Mng0XmTb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268134-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268134-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 005CC30028B8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D33ACF0C;
	Wed, 24 Jun 2026 10:03:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BD22126C;
	Wed, 24 Jun 2026 10:03:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295414; cv=none; b=WD1zqtcW1zDb4O+Qv5y7j4kvTHyon9nZLQ07WsGfnrw2vL58WgVfItGhibXOIEiZXUd+3JSFvU3Ht2PVXNvDjwUZizGWjHG4oHZmjV9a7U+ArnFJIaEnlBmcKtBtNKudaz275LYuDmEg3qpucuSSu5tw4BbyOg3IDeQFsEvEMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295414; c=relaxed/simple;
	bh=FVXutdEyC0x0cYFJWy0uhvg1KlpMoLrmECvCw+Pc0rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPsB5ggwpJGKW03uMiYmAotv/jLNGsk4kEeryTQT0F64FcbSFeKsjOkEEfYY/9VLnjkrtE2P+Zi05NRhcadTUXO5ZSigPTHo3IIdZDJB8jvyx72ES+u+OWN6MKEk4Y0zfsaeN6qr39+hYdpfpI735g6Lbv32RwKYJUArfHeVEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mng0XmTb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432671F000E9;
	Wed, 24 Jun 2026 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782295412;
	bh=954vwfv0onOMTvLBwot3VrPpWzQAzKYexf8k6owoKRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mng0XmTbHJolB4hGA0HOv7x4doOtSehYCzZ1XaUA8kpa7UiBYSxPhwWYAA2E6MxdI
	 fjJC8kbO3yBodd/oMNgj09pwGrLNSD+6b7hOAz3ZevrHrOHUOTuHtmnnBsbUtbFnoO
	 pN1y8RFs7Uhh/53EtKNZZBhKTYf1MS9Zbo7OZaCk=
Date: Wed, 24 Jun 2026 11:02:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: 00107082@163.com, iklatzco@gmail.com, patches@lists.linux.dev,
	peterz@infradead.org, sashal@kernel.org, stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [PATCH] perf: Fix dangling cgroup pointer in cpuctx backport
Message-ID: <2026062404-unusual-nutmeg-87d5@gregkh>
References: <2026062455-obtrusive-sandbox-d6d1@gregkh>
 <20260624095920.2558406-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624095920.2558406-1-guanwentao@uniontech.com>
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
	TAGGED_FROM(0.00)[bounces-268134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:00107082@163.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[163.com,gmail.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniontech.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83AFD6BD2BA

On Wed, Jun 24, 2026 at 05:59:21PM +0800, Wentao Guan wrote:
> recently backport of ("perf: Fix dangling cgroup pointer in cpuctx")
> use a middle version, so aligned with the upstream commit:
> 3b7a34aebbdf2a4b7295205bf0c654294283ec82
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  kernel/events/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a4187dea6402a..73a86db06cc9b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2384,10 +2384,9 @@ __perf_remove_from_context(struct perf_event *event,
>  	 */
>  	if (flags & DETACH_EXIT)
>  		state = PERF_EVENT_STATE_EXIT;
> -	if (flags & DETACH_DEAD) {
> -		event->pending_disable = 1;
> +	if (flags & DETACH_DEAD)
>  		state = PERF_EVENT_STATE_DEAD;
> -	}
> +
>  	event_sched_out(event, ctx);
>  
>  	if (event->state > PERF_EVENT_STATE_OFF)
> -- 
> 2.30.2
> 

What kernel tree(s) is this for?  What git id does this fix?

thanks,

greg k-h


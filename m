Return-Path: <stable+bounces-238648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3FybC87w5GkvcQEAu9opvQ
	(envelope-from <stable+bounces-238648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C758424709
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44A43300E602
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CE37DEBB;
	Sun, 19 Apr 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LktWiIge"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A937DEA5;
	Sun, 19 Apr 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776611530; cv=none; b=LkaFTw+7vQyORlkRYMh9zUxagSy4sLaquMuzQrL2q8J3Qj7bXzhvvBko4Mo5l56IYsK1a3t+7a6q1j+aB33XgBSsbw/5fH68vRyqp/uDKi6Lgw4zLW9GYEtx0mfpD/mk2tU/BOfutC+rfDkvYdZJlbD8c55yU6ptTp89JmhXm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776611530; c=relaxed/simple;
	bh=+YW5pgbvt2xYzlng6JlHZSlyIwgl5OtlzmM40Xo/EOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMjGYi96GNVoLtBVg9J/upbJaBrZlRmPRgiRoYdzzttALp4YInldmCiLrkbGquN6k/w5ulpolSBZtyg2bXIzQblbOMJUthQkV3RKWFXK0+8so9nrpMIA6I5lOHBmHjHr9hOqhs0EU+r+QPn6pKkuFjXwyc8pRK19nbDPDK/L6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LktWiIge; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fzBt70NH0z6CKC;
	Sun, 19 Apr 2026 17:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776611519;
	bh=+YW5pgbvt2xYzlng6JlHZSlyIwgl5OtlzmM40Xo/EOE=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=LktWiIgelNzMtip69HqlPovP0mzBtUDQyi3givapaU5ycJJT41tyN8ko3/ZIJTBIy
	 e65DQbs7WAZuVYAoxNKY2VSi3qzIcvplG9YGGOt/dstTpfSOYLsJOlO/Bki/QDQ7L7
	 7ct+I6KTgDy+OzSkDPu9rOE1XXdHuhibzfdCBGmLegYAF2Pr5G9WTKwWo/ejg7mczP
	 OSHhO73qxx1dhn6ZOqIPFkGTTvSDW0ex42uIbeqVWj82WqrEVxHOtU9RD/SuVbbQZt
	 D+Jl4Qgmmo4rAfJHA00TNQgvflm4MWankpdIBbxifLyspctlXn9OlxCcNXziUAWSYV
	 hz/P+cwUYRNfg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fzBt66mK2z4xZB;
	Sun, 19 Apr 2026 17:11:58 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fzBt61PwKz8sWT;
	Sun, 19 Apr 2026 17:11:58 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2D8D6632AE;
	Sun, 19 Apr 2026 17:11:57 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5cbb14d8-46f9-4197-917f-51da852d7500@leemhuis.info>
Date: Sun, 19 Apr 2026 17:11:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/urgent] clockevents: Add missing resets of the
 next_event_forced flag
To: Thomas Gleixner <tglx@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 Eric Naim <dnaim@cachyos.org>, stable@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <87340xfeje.ffs@tglx>
 <177636758252.1323100.5283878386670888513.tip-bot2@tip-bot2>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <177636758252.1323100.5283878386670888513.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177661151754.731094.16057225096151116723@mxe9fb.netcup.net>
X-NC-CID: jGD2kGasqSZ0A0TqCuqGdueid9VDNEO5s2ph8OBZfufbz1XnD0Q=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cachyos.org,vger.kernel.org,kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-238648-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gitlab.freedesktop.org:url];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[regressions@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C758424709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 21:26, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     4096fd0e8eaea13ebe5206700b33f49635ae18e5
> Gitweb:        https://git.kernel.org/tip/4096fd0e8eaea13ebe5206700b33f49635ae18e5
> Author:        Thomas Gleixner <tglx@kernel.org>
> AuthorDate:    Tue, 14 Apr 2026 22:55:01 +02:00
> Committer:     Thomas Gleixner <tglx@kernel.org>
> CommitterDate: Thu, 16 Apr 2026 21:22:04 +02:00
> 
> clockevents: Add missing resets of the next_event_forced flag

Just wondering: what's the plan to mainline this? I wonder if this is
worth mainlining rather quickly and the tell the stable team right
afterwards to queue it up for 7.0.1, as in addition to the two affected
people in this thread (one of which stated that "several users from
CachyOS reported this regression as well") I noticed three more 7.0 bug
reports in the past few days that likely are fixed by the quoted patch:

https://gitlab.freedesktop.org/drm/amd/-/work_items/5178#note_3432195
https://bugzilla.kernel.org/show_bug.cgi?id=221370
https://bugzilla.kernel.org/show_bug.cgi?id=221377

Ciao, Thorsten

> The prevention mechanism against timer interrupt starvation missed to reset
> the next_event_forced flag in a couple of places:
> 
>     - When the clock event state changes. That can cause the flag to be
>       stale over a shutdown/startup sequence
> 
>     - When a non-forced event is armed, which then prevents rearming before
>       that event. If that event is far out in the future this will cause
>       missed timer interrupts.
> 
>     - In the suspend wakeup handler.
> 
> That led to stalls which have been reported by several people.
> 
> Add the missing resets, which fixes the problems for the reporters.
> 
> Fixes: d6e152d905bd ("clockevents: Prevent timer interrupt starvation")
> Reported-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
> Reported-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com
> Link: https://patch.msgid.link/87340xfeje.ffs@tglx
> ---
>  kernel/time/clockevents.c    | 7 ++++++-
>  kernel/time/tick-broadcast.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index b4d7306..5e22697 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -94,6 +94,9 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
>  	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
>  		return 0;
>  
> +	/* On state transitions clear the forced flag unconditionally */
> +	dev->next_event_forced = 0;
> +
>  	/* Transition with new state-specific callbacks */
>  	switch (state) {
>  	case CLOCK_EVT_STATE_DETACHED:
> @@ -366,8 +369,10 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires, b
>  	if (delta > (int64_t)dev->min_delta_ns) {
>  		delta = min(delta, (int64_t) dev->max_delta_ns);
>  		cycles = ((u64)delta * dev->mult) >> dev->shift;
> -		if (!dev->set_next_event((unsigned long) cycles, dev))
> +		if (!dev->set_next_event((unsigned long) cycles, dev)) {
> +			dev->next_event_forced = 0;
>  			return 0;
> +		}
>  	}
>  
>  	if (dev->next_event_forced)
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 7e57fa3..115e0bf 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
>  
>  static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
>  {
> +	wd->next_event_forced = 0;
>  	/*
>  	 * If we woke up early and the tick was reprogrammed in the
>  	 * meantime then this may be spurious but harmless.
> 



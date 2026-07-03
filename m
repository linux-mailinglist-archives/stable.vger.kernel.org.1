Return-Path: <stable+bounces-271763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dssUOs+yR2rLdgAAu9opvQ
	(envelope-from <stable+bounces-271763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:02:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD0702A11
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=UcShzKe0;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271763-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271763-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2543300FEEE
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D73B2FD8;
	Fri,  3 Jul 2026 12:46:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465182D1907
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:46:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082778; cv=none; b=NegqkmX7Y5mxDAVJauVsMAGEGt2/YD+n4izjRiRHSp6WJBlIjLEp49rbf5d36tpOcMIrhJpr7GaA7fL/qX1FRy0q4z7mwLfH6SgxzWKq9S8QwcanUVz1ZZAQjj4q04j14cS210KC5y6rZ1L3zzoOUbowA4/mMvgOaJxUx0bKhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082778; c=relaxed/simple;
	bh=9MIfOtxcNTg7a3h9kPi2UFAZtg/Kb7FVaxR4XCit7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WadBvrVtSkow8NXxq+P0Q9TfRGm50tcgCcZnT6MGdYIykoHYcvdeKdjNU2is4vyDvs9ZhOlkrFEXR6sCPssq+uAAb90WitnQ40cIp4s94cE2SVXqD8WH1QEiDqZrJaldOxYjyQQk8wvUPETBJUML0jnUAuvhBtusA7Vp566gHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UcShzKe0; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47640541585so351300f8f.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783082775; x=1783687575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsBLm+/j8lRVOopPYicPuZIR3XyWb+EmA3UL37jV8mE=;
        b=UcShzKe0cBag30bkm/m9c6G5rGwi8jHiQMWtrGddgeJx6rzeuuhS1IOLPFna1oa3w6
         APUo9ouyOJibENGU/mV8TpEkQjWs95Vl2DF81kge0Yis2lNdpNYlH7wy58TBRcqClqzC
         GeK0wu8DY9iKzIgNj08YLA2x5jzyoYnhKj9w/BhNdfdW7H3cuM36R+pkMc4LTYtUCAxj
         HvoKI/cgxXmJa/Cx2DUrFs53Gon34hs5gwTp/YMOuB+DpvejrNQc76v+WQ7M9iJZqber
         Fy8MtJGoDX8JmGEneQBsWlsnvSZrZp9FMPeevGZqLPIf7QUB/Q5qYvLYkZbCN3E5535h
         ZvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082775; x=1783687575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsBLm+/j8lRVOopPYicPuZIR3XyWb+EmA3UL37jV8mE=;
        b=NKj1furfPi6ZRBH1aXN+GMABcaCRfRWZlEU2XsjSPTIE+VoDniZXQ7KKj7xJ0LHt9H
         l35MlBNl1PJkqFoz7uFfe5IXRgCg/CvKx0rH6Bs3foekzZolyiLMa0R3aSL6jiM6+5m5
         9OBATW+OODc569iRL/3phPvpjuF2Ecq7ri2GaEoONSr4xswWUrmiX2pHo7AEecKp0GQr
         F6oR9AVC/SbZ4qtuOhtd7LXDDppuLDmXSxKnPSV0ioGs2d25sRDOZbNbdXvrebr25iCG
         MfmbH2Usjvfq5wyFb2mFqpjMC/QihccIEmwJOM2vCPDtRLDiDpBVVdsRHfMXQYD+wijo
         1HBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5mnWEDhtIoppyiW83fj+Vay/1ahM3Cy8wsq402yvtmCeueLZg7fVQNH7+VD2RaF9VHXvcqQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPe8P+zgIXl5gL20V03XvkVY3ZXecF0h/vDgRJY3UCNQnJ2pdJ
	5cVyDdGlFQho5jY8uHzj7GVHAcjXuX2yWF7b2wkbD2zXel2cMyaOvamMQf8QMF9VFDk=
X-Gm-Gg: AfdE7cnPUBoLNk9dRFYJvZrWVLw9BCZOOMStR+pUep7f6f3G8bnurSq9J0pNJMnPvr+
	/B25nwD+fMjTymjzEIU04dFgp5KsCRJKqK0vhEN/u1UE4iqFdtUj9FwZzr55e/jvkiA0jCqk+uh
	M3yr5AHvemvhuzlK/l0yNIlzQOQmD/SLlKlY1OmyfyVenXcxobsGEehPKUJvZtp9jgy4x3Pyn7E
	suXO5E7bLpIPVSArA5WypitmkK6S64YZVgtxccREIateY1M19nAkDiOrBuhOP5/VvSC0udEXSLH
	tFMn302esHu5zNy6Th4GlnTXnyiwUTpMAP/0S1fX+vu7lwk6iAZnT9IqcOjJqkthhlTnFTG/iKi
	lK95oOHq+hB7Ho212jGbGAzlgYMPhrWAfVvyzwAVF8eut4rd+15fG/qnq+YHL2SNVAh+CjLyAcP
	TYwc+VgBZz02/9Srs=
X-Received: by 2002:a05:600c:5805:b0:493:b163:42e8 with SMTP id 5b1f17b1804b1-493c2b7f204mr94148515e9.21.1783082774690;
        Fri, 03 Jul 2026 05:46:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm54494835e9.8.2026.07.03.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:46:14 -0700 (PDT)
Date: Fri, 3 Jul 2026 14:46:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <akevFNCaXnt0kRVC@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
 <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
 <akYq1YaCpZ0b4SBS@pathway.suse.cz>
 <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux-foundation.org,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[pathway.suse.cz:query timed out,grrlz.net:query timed out,alibaba.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out,pmladek@suse.com:query timed out,feng.tang.linux.alibaba.com:query timed out,include.grrlz.net:query timed out,pmladek.suse.com:query timed out];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alibaba.com:email,grrlz.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EDD0702A11

On Thu 2026-07-02 19:13:26, Bradley Morgan wrote:
> On July 2, 2026 10:09:41 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
> >> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
> >> wrote:
> >> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
> >> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> >> In watchdog, panic, and hung task detection scenarios, sys_info() can
> >> >> be called multiple times or alongside direct backtrace triggers like
> >> >> trigger_allbutcpu_cpu_backtrace(). This results in identical
> >backtraces
> >> >> being dumped repeatedly from all CPUs, cluttering the kernel log and
> >> >> delaying or obscuring critical debug details.
> >> 
> >> im feeling a new file to do all the force panic jazz, but putting tape
> >> on sys_info.c isn't bd either.
> >
> >I wonder how to move forward with this.
> >
> >Honestly, I am not sure what exactly you mean by creating another
> >API for tracking the reports so I could not judge it. Feel free
> >to sent some POC.
> 
> sup petr, here's my poc
> 
> This should make my entire thing make sense
> 
> >From eb587ed749ff5993c517f29799b369185c5ee7d8 Mon Sep 17 00:00:00 2001
> From: Bradley Morgan <include@grrlz.net>
> Date: Thu, 2 Jul 2026 18:09:23 +0000
> Subject: [POC] sys_info: Introduce incident state-tracking to prevent
>  duplicate diagnostics
> 
> In watchdog, panic, and hung task detection scenarios, sys_info()
> can be called multiple times or alongside direct debug output
> functions (like trigger_allbutcpu_cpu_backtrace(), print_modules(),
> print_irqtrace_events(), and dump_stack()). This leads to identical
> diagnostics and stack traces being dumped repeatedly, cluttering the
> kernel log and delaying critical panics.
> 
> Introduce a state tracking bitmask and helpers in a new file,
> lib/sys_info_filter.c:

New file suggests that it would implement an API using
sys_info_filter() prefix.

> - sys_info_filter_and_set(mask): Atomically tests which bits in a mask
>   have not yet been printed during the current incident, marks them as
>   printed, and returns that subset.

The name of the funtion is a kind of puzzle. I think that we
could do a better job.

> - sys_info_reset(): Clears the printed mask state.

This function has sys_info* prefix. It would expect it in sys_info.c

> Add SYS_INFO_MODULES, SYS_INFO_IRQTRACE, and SYS_INFO_STACK flags to
> include/linux/sys_info.h, and handle them inside sys_info's diagnostic
> dispatch.

I though about adding an information that we printed backtrace for this
CPU as well. But it not trivial. Different API shows different extra
info, like modules, IRQ backtrace, registers, code. I would leave
this complexity aside for now.

> Update the watchdogs, hung task detector, and panic core to call
> sys_info_filter_and_set() to deduplicate their diagnostic printouts, and
> sys_info_reset() when a warning incident concludes (e.g., when a stuck
> CPU recovers, or a new hung task check round begins).
> 
> This ensures each piece of system diagnostic is printed at most once per
> lockup/panic event, preventing console log spam.
> 
> Assisted-by: Gemini:gemini-3.5-flash
> Signed-off-by: Bradley Morgan <include@grrlz.net>

> --- /dev/null
> +++ b/lib/sys_info_filter.c
> @@ -0,0 +1,120 @@
> +static unsigned long sys_info_printed;
> +
> +unsigned long sys_info_filter_and_set(unsigned long si_mask)
> +{
> +	unsigned long old, new;
> +
> +	if (!si_mask)
> +		return 0;
> +
> +	do {
> +		old = READ_ONCE(sys_info_printed);
> +		if (!(si_mask & ~old))
> +			return 0;
> +		new = old | si_mask;
> +	} while (cmpxchg(&sys_info_printed, old, new) != old);

It is a good question whether to update the info using atomic
operations. One problem is that the mask is "unsigned long".
I am not sure if it natively atomic on all architectures.
32-bit architecures use extra locking when implementing
atomic operations with 64-bit values. And we should rather
avoid any locking in this code.

Well, long seems to be 32-bit on 32-bit x86 so it might be
safe after all.

> +void sys_info_reset(void)
> +static void __sys_info(unsigned long si_mask)
> +void sys_info(unsigned long si_mask)

I wonder why this sys_info*() API implementation has been moved
from sys_info.c to sys_info_filter.c.

I am sorry but I do not see any advantage in adding the new file
sys_info_filter.c

> NOTE!!: This is AI generated!! This **MAY** not be the finished product,
> this is ONLY the model!

IMHO, Gemini did pretty bad job in this case. Please, try to review
the AI generated before you send it. And send it only when you think
that it is reasonable enough. :-)

It is even fine to send "crap" but you should start the mail
with a warning that you send it just give us an idea what you
had it mind. And you should explain why you actually do not like.

Best Regards,
Petr


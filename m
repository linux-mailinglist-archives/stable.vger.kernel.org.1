Return-Path: <stable+bounces-268867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oCwNFOxrPmpWFwkAu9opvQ
	(envelope-from <stable+bounces-268867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4D6CCD5B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:09:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=wV7Ngncp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268867-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268867-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C020F3066B6E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCF3F413E;
	Fri, 26 Jun 2026 12:06:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAF3F411F;
	Fri, 26 Jun 2026 12:06:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475604; cv=none; b=FIA11OUZpHRf/kq9rfIG5fy7xpLpL7KGMsE7UA5AMIX8B4ioGM9UF4fzaea8+k0FGfMtHIVlEhBG9hANNxZZbbpGf1lNaYIksQRWX7RQJ4/Nwspn33vUi6FeD3BNhUzZ/+SbhQPOm0A+olWBgnewB5SwzWmmxQ9+3NPwvUPzsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475604; c=relaxed/simple;
	bh=mcnd45m9iaSfOflkxyHGds0Du5OyNPMd9m09tACMtgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi8rJl5AZa1DFN91e5jsc2KKffIGTmj4l3Rxjn1cj9ZQ8WYNCY27cAoPV+vy3oymscX0+bMR5oAG9gPgCIK2AfgEMYNadaJ9tvtI6IbthK3iwScGeGsS6uzI5IVo8XjBgpq3jJnos4vl8wBfmyML3AcKPzz9Muj3f6oQS5qeBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wV7Ngncp; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782475592; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=xh7XI+TiHLJYLAr/894grpqUh7uVtoi8+UIaxKwNZeY=;
	b=wV7NgncpXJrbs0BMvAsSh8tkGgRO9TUTqmSqn9LMGDt1q0ul38eEE0U0btGoxY8eqzk5Hj/d6JW4w3skh2/p2rwXrb500qbZXDLtMYyQWrVtOjNEs7X/NgU6sIr2f7nxFj89phqtQ3BNWLTFCCUeOkilFCvJLfBZ2xULSXg2P04=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5et9EI_1782475590;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5et9EI_1782475590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 20:06:31 +0800
Date: Fri, 26 Jun 2026 20:06:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <include@grrlz.net>,
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
Message-ID: <aj5rRV14OQact38f@U-2FWC9VHC-2323.local>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj5TNB8cRtMNTtIT@pathway.suse.cz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268867-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[grrlz.net,linux-foundation.org,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:include@grrlz.net,m:akpm@linux-foundation.org,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[feng.tang@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng.tang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95E4D6CCD5B

On Fri, Jun 26, 2026 at 12:23:48PM +0200, Petr Mladek wrote:
> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> > other CPUs. Do not ask sys_info() to handle that bit again later in the
> > panic path.
> > 
> > Use sys_info_with_filter() so panic_print=all_bt does not request more
> > output after the CPUs are stopped.
> > 
> > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/panic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 213725b612aa..eb842823df61 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> >  	 */
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >  
> > -	sys_info(panic_print);
> > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> 
> Hmm, this prevents printing backtraces from all CPUs completely.
> But what if they were not printed?
> 
> They might be printed by:
> 
> static void panic_other_cpus_shutdown(bool crash_kexec)
> {
> 	if (panic_print & SYS_INFO_ALL_BT)
> 		panic_trigger_all_cpu_backtrace();
> 
> [...]
> }
> 
> But it checks only "panic_print" variable. It won't do anything
> when (panic_print == 0).
> 
> In this case, we might still want to print the backraces when
> SYS_INFO_ALL_BT is set in kernel_si_info.

Yep.

> 
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> 
> Of course, we might fix panic_other_cpus_shutdown() to check also
> kernel_si_info.
> 
> But it all becomes very hairy. We have several levels:
> 
>    + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
> 
>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> 
>    + panic-specific si_info: panic_print
> 
>    + universal fallback for any layer: kernel_si_info
> 
> Now, we try to check all these variables back and forth to
> trigger all backtraces or to avoid triggering them.
> And it clearly does not work well and the code is more and more
> hairy.

Agree :)
 
> I think about another approach. The word "waterfall" comes to my mind.
> Instead of checking all the settings back and forth, let's process
> each setting one by one and just remember what has been done and
> skip this in the next level.

When initially reviewing V2's 4th patch, I thought about the
'panic_this_cpu_backtrace_printed', but it's a local variable which
records the state.

> All the si_info actions seems to dump a global system state.
> So, it would make sense to remember the state in a global variable
> even when it might be modified by more CPUs in parallel.

IIUC, panic case is kind of special, as it has to separate the
'sys_info()' op in different stage. Can we do a merge in the start
of vpanic() by:

	panic_print = panic_print ?: kernel_si_mask;

 as a addon patch ?

Thanks,
Feng

> I am going to think more about it.
> 
> Please, do not send v4 until the discussion settles!
> 
> Best Regards,
> Petr


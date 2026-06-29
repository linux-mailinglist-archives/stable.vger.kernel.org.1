Return-Path: <stable+bounces-269753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQR2H9BtQmrT6wkAu9opvQ
	(envelope-from <stable+bounces-269753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED7C6DABE8
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=WDetH3qX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269753-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269753-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C260309A6E1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469C3FFADA;
	Mon, 29 Jun 2026 12:54:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172B15E97;
	Mon, 29 Jun 2026 12:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737671; cv=none; b=So5vEfs4kaa4bRvQxwMsrTsqmLKxr+yaf+091nGu7MytoZip4SAEWQERgGqB6lYlEMpJ87PQyXTJ/+PlBOivDpdQ7XpFFvGMfkks489h33d3E535oEQuVmac//hwpgcIg9BjkMk/J/Or02U2tdxRi+7Ua1+hoJQKGcL7CbRpycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737671; c=relaxed/simple;
	bh=Yr2zKvkug4dI0FoY6gt9HvqCWNEGS51SOMCCAsq+dWY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TrCdku3InoLFPBjEJnPVvazzULT008zO/XM4YU5Ktxq4vuh2x2rI69Vq6NilQtYnf7IBdmykZqJDRQHy1yV50LkoTefyadZENcNtt7LDkiSNfTeZ+BxwtoGEc4MQhMdPmYmO3GHpsc2KGktCoYJDK81RwUvXM6xD4yDH84YxApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WDetH3qX; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782737660;
	bh=UHUQRvDxYITmVwJqOWXIA6FbFpYX5crfejyYhqfNw4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WDetH3qXTPfYUMMVLgKKdgLCjJGFOGE1hzMktByZ01Y6g2pLwMGDqIOWJWebNLGm9
	 82z4IAsviEKmPgjYzNAIaix1+rB/YoHBQlVLZFpKBms2BKk/HjzcBgbvgyDi3z9pbw
	 Z7zg4HxqRbVZl1AfxIy7SVjU67evtbCAhg+xPeQk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gpmSX3Q7bz110G;
	Mon, 29 Jun 2026 12:54:20 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gpmSX0XQWz110B;
	Mon, 29 Jun 2026 12:54:20 +0000 (UTC)
Date: Mon, 29 Jun 2026 13:54:18 +0100
From: Bradley Morgan <include@grrlz.net>
To: Feng Tang <feng.tang@linux.alibaba.com>, Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
Message-ID: <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-269753-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:feng.tang@linux.alibaba.com,m:pmladek@suse.com,m:akpm@linux-foundation.org,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DED7C6DABE8

On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
wrote:
>On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
>> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping
>the
>> > > other CPUs. Do not ask sys_info() to handle that bit again later in
>the
>> > > panic path.
>> > > 
>> > > Use sys_info_with_filter() so panic_print=all_bt does not request
>more
>> > > output after the CPUs are stopped.
>> > > 
>> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys
>info on system lockup")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> > > ---
>> > >  kernel/panic.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > 
>> > > diff --git a/kernel/panic.c b/kernel/panic.c
>> > > index 213725b612aa..eb842823df61 100644
>> > > --- a/kernel/panic.c
>> > > +++ b/kernel/panic.c
>> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>> > >  	 */
>> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> > >  
>> > > -	sys_info(panic_print);
>> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
>> > 
>> > Hmm, this prevents printing backtraces from all CPUs completely.
>> > But what if they were not printed?
>> > 
>> > They might be printed by:
>> > 
>> > static void panic_other_cpus_shutdown(bool crash_kexec)
>> > {
>> > 	if (panic_print & SYS_INFO_ALL_BT)
>> > 		panic_trigger_all_cpu_backtrace();
>> > 
>> > [...]
>> > }
>> > 
>> > But it checks only "panic_print" variable. It won't do anything
>> > when (panic_print == 0).
>> > 
>> > In this case, we might still want to print the backraces when
>> > SYS_INFO_ALL_BT is set in kernel_si_info.
>> > 
>> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>> > 
>> > Of course, we might fix panic_other_cpus_shutdown() to check also
>> > kernel_si_info.
>> > 
>> > But it all becomes very hairy. We have several levels:
>> > 
>> >    + watchdog-all_bt-specific option, e.g.
>sysctl_hardlockup_all_cpu_backtrace
>> > 
>> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>> > 
>> >    + panic-specific si_info: panic_print
>> > 
>> >    + universal fallback for any layer: kernel_si_info
>> > 
>> > Now, we try to check all these variables back and forth to
>> > trigger all backtraces or to avoid triggering them.
>> > And it clearly does not work well and the code is more and more
>> > hairy.
>> > 
>> > I think about another approach. The word "waterfall" comes to my mind.
>> > Instead of checking all the settings back and forth, let's process
>> > each setting one by one and just remember what has been done and
>> > skip this in the next level.
>> > 
>> > All the si_info actions seems to dump a global system state.
>> > So, it would make sense to remember the state in a global variable
>> > even when it might be modified by more CPUs in parallel.
>> > 
>> > I am going to think more about it.
>> 
>> I have created a POC using Gemini. I haven't tested it.
>> But it looks acceptable. And the logic seems to be more
>> straightforward.
>> 
>> One drawback is that it requires adding the _reset()
>> call for all sys_info() callers. It is fine in principle
>> but it might complicate back-porting because all changes
>> have to be done in one patch.
>> 
>> But honestly, this is a nice to have fix. Most people could
>> live happily without it.
>> 
>> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
>> From: Petr Mladek <pmladek@suse.com>
>> Date: Fri, 26 Jun 2026 13:55:41 +0200
>> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent
>duplicate
>>  backtraces
>> 
>> In watchdog, panic, and hung task detection scenarios, sys_info() can
>> be called multiple times or alongside direct backtrace triggers like
>> trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
>> being dumped repeatedly from all CPUs, cluttering the kernel log and
>> delaying or obscuring critical debug details.
>> 
>> Introduce a state tracking bitmask and associated helpers:
>> - sys_info_done(mask): Marks specific sys_info bits as already printed.
>> - sys_info_reset(): Resets the tracking state.
>> - sys_info_is_done(mask): Checks if all bits in the mask have been
>printed.
>> 
>> Update sys_info() to automatically filter out already printed bits
>> using this state. Integrate these APIs with the generic hardlockup
>> and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
>> and the panic core. This ensures that each piece of system information
>> and backtrace output is printed at most once per lockup/panic event,
>> and the state is reset cleanly when a lockup does not trigger a panic.
>> 
>> Races between sys_info() callers are ignored. It should be acceptable
>> because the output from various watchdogs has never been synchronized.
>> And panic() never returns.
>> 
>> Assisted-by: gemini-1.5-flash
>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>
>Yep. There are cases that people want panic on task-hung or sw/hw lockup,
>and this could remove much duplication of sys info dump, thanks!
>
>Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,

im feeling a new file to do all the force panic jazz, but putting tape
on sys_info.c isn't bd either.

>> ---
>>  arch/powerpc/kernel/watchdog.c | 13 ++++++++++---
>>  include/linux/sys_info.h       |  3 +++
>>  kernel/hung_task.c             |  2 ++
>>  kernel/panic.c                 |  4 +++-
>>  kernel/watchdog.c              | 10 ++++++++--
>>  lib/sys_info.c                 | 30 +++++++++++++++++++++++++++++-
>>  6 files changed, 55 insertions(+), 7 deletions(-)
>

Thanks!


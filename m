Return-Path: <stable+bounces-268957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxiCO3mUPmq8IQkAu9opvQ
	(envelope-from <stable+bounces-268957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:02:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08E6CE43D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b="hgRbxt/Q";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268957-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268957-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43C9308AE24
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA737F007;
	Fri, 26 Jun 2026 14:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F843F99F3;
	Fri, 26 Jun 2026 14:59:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485946; cv=none; b=bxFflxIcHOoxXQcOR5nYUpFEFHIgZhTojyEY9pUdkBxISKs7zlfwdEgCUBoUJ+hhLHqSltm2nZNAj9axP5GpKSqjA86NY6BtZ+HZgloLVNE5rBJ2Zmr0Iuv524V8YZ/2BRqmAOFIH++cU+d9vcf0Mw3mdNyJ5MtWQ8VNO+9vXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485946; c=relaxed/simple;
	bh=i0yvbmZYJWfV8i/MzpTyTPQWEb0YMs2FwmlAgLjaTgI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z+AWiD4aGqLmLT17/qGQlvTGyBQGfUAEXw6nTIz+KbVufyPOUeJ+Tuu+nkjTP9iPHjKGXeYwDzxUHlnxhIeOQajgL68/1Shjk9nm26MsGq/YV5dZFER3ooM2K9oeO/FsM/1xvxhd816WvRSkL448+IKgSTzlWKQ3Fg0AFmWl/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=hgRbxt/Q; arc=none smtp.client-ip=198.167.222.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782485938;
	bh=qwtFANDyCgGd4fu1Y4yzO6yO2Mco8QTEc/2pzxC6z20=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hgRbxt/QTju9ZiWOuA9mwQVb+tgD1LO26f2iL0ZAGVy9gjILfXzGzZnOUEFkQW+Gq
	 qtuFtPZUGlYt2kik+zFURyKUdyibcotDz/utoUYFXxLqQahspOJbnRRmTSs8f5IESb
	 44ul3PhuqudzDlVkwXSNrXklqk3cVSTz9QIuzV2s=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmzMk2JHsz6vfC;
	Fri, 26 Jun 2026 14:58:58 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmzMj655lz4y2q;
	Fri, 26 Jun 2026 14:58:57 +0000 (UTC)
Date: Fri, 26 Jun 2026 15:58:55 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <aj6Q8JcogaIaQit4@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net> <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net> <aj6MAxQKpLeK1Mp6@pathway.suse.cz> <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net> <aj6Q8JcogaIaQit4@pathway.suse.cz>
Message-ID: <A0A9AAFD-E954-463F-8D9F-61DDBCFDDA5A@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.alibaba.com,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-268957-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:akpm@linux-foundation.org,m:feng.tang@linux.alibaba.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D08E6CE43D

On June 26, 2026 3:47:12 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Fri 2026-06-26 15:35:19, Bradley Morgan wrote:
>> On June 26, 2026 3:26:11 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>> wrote:
>> >On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
>> >> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan
>> ><include@grrlz.net>
>> >> wrote:
>> >> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek
><pmladek@suse.com>
>> >> >wrote:
>> >> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> >> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> >> >>> But it all becomes very hairy. We have several levels:
>> >> >>> 
>> >> >>>    + watchdog-all_bt-specific option, e.g.
>> >> >>sysctl_hardlockup_all_cpu_backtrace
>> >> >>> 
>> >> >>>    + watchdog-specific si_info preferences, e.g.
>hardlockup_si_mask
>> >> >>> 
>> >> >>>    + panic-specific si_info: panic_print
>> >> >>> 
>> >> >>>    + universal fallback for any layer: kernel_si_info
>> >> >>> 
>> >> >>> Now, we try to check all these variables back and forth to
>> >> >>> trigger all backtraces or to avoid triggering them.
>> >> >>> And it clearly does not work well and the code is more and more
>> >> >>> hairy.
>> >> >>> 
>> >> >>> I think about another approach. The word "waterfall" comes to my
>> >mind.
>> >> >>> Instead of checking all the settings back and forth, let's
>process
>> >> >>> each setting one by one and just remember what has been done and
>> >> >>> skip this in the next level.
>> >> >>> 
>> >> >>> All the si_info actions seems to dump a global system state.
>> >> >>> So, it would make sense to remember the state in a global
>variable
>> >> >>> even when it might be modified by more CPUs in parallel.
>> >> >>> 
>> >> Hmm.. new idea 
>> >> 
>> >> kernel/dump_filter.c ?
>> >> 
>> >> What this file could do is to handle a generic lockup state machine
>> >> so any subsystem can log what it already dumped?
>> >> 
>> >> I know it may bloat, but it's better then cramming fixes in.
>> >
>> >I am not sure what exactly you would like to achieve but it sounds
>> >a bit scary ;-)
>> >
>> >Anyway, we should not synchronize the watchdog reports against
>> >each other, definitely. They are running in non-compatible contexts
>> >(task vs interrupt vs NMI). Also we should not add any locking
>> >because they usually print something when the system has enough
>> >troubles.
>> >
>> >Also I think that it is not worth preventing duplicated backtraces
>> >or reports from a single CPU. IMHO, it is not a big problem
>> >in practice.
>> >
>> >So, we are down to large reports, like backtraces from all CPUs,
>> >timers, locks, ... which are handled by sys_info(). So, I think
>> >that it should be enough to handle this inside the sys_info() API.
>> >
>> >I do not want to say that my proposal was the best solution.
>> >I am sure that there are better ones. But we need to consider
>> >the gain vs. complexity.
>> >
>> >Honestly, I am already a bit scared by the complexity which
>> >we the sys_info() API added. And it is hard to imagine that
>> >adding another API would make it easier. But I might be wrong.
>> >
>> >Instead, it might make sense to integrate the conflicting
>> >subsystem-specific calls under the sys_info() API.
>> >I mean that, for example watchdog_hardlockup_check() won't
>> >call trigger_allbutcpu_cpu_backtrace() directly but
>> >it would call it via sys_info() API so that sys_info()
>> >could keep track of it. Something like:
>> >
>> >void sys_info_allbutcpu_bt(int cpu)
>> >{
>> >	trigger_allbutcpu_cpu_backtrace(cpu);
>> >	/*
>> >	 * The caller likely printed backtrace of the given @cpu
>> >	 * on its own. Prevent duplicate backtraces from all
>> >	 * CPUs with potential next sys_info() call.
>> >	 */
>> >	sys_info_done(SYS_INFO_ALL_BT);
>> >}
>> >
>> >But I am not sure if it is really easier to follow
>> >than calling sys_info_done() from the watchdog code.
>> >
>> >Some watchdogs try to optimize the output and print backtraces
>> >only from CPUs which are relevant for the given lockup.
>> >We should keep the logic for selecting the set of CPUs
>> >in the watchdog code. We just need to solve how to elegantly
>> >make sys_info() aware of it or at least about the more massive
>> >reports.
>> >
>> >Anyway, I would prefer to keep it simple until we see some problems
>> >in practice.
>> >
>> >Best Regards,
>> >Petr
>> >
>> 
>> 
>> I understand it's scary. To make a new file in the first place.
>> 
>> But I was a bit vague of what I wanted, and I'm sorry.
>> 
>> So, the reason why I'd suggest a new file, is because if any subsystem
>> Theoretically bypasses sys_info to log a lockup, this completely misses
>> the filter and duplicates the dump
>> 
>> My file would act as a generic lockless state machine that any
>> subsystem can update regardless of how they dump logs.
>> 
>> If you have any questions, feel absolutely free to ask! :)
>> 
>> Discussion is a way to make everyone happy!
>
>Honestly, I am more and more wondering whether your are a real person
>or AI bot.

Sigh..

I can verify myself through video call if you don't believe I am human :)

why I suggested a new file is because AI said it would be a good idea.

I told it what I should do, and it told me to do a new file.

I knew it was over engineering slightly, but I was a bit stressed, 
and I wanted some sort of just new API which is less buggy imho

I should've told you that I used AI to figure the whole new file idea, 


Really sorry petr..

>Best Regards,
>Petr
>

Thanks!


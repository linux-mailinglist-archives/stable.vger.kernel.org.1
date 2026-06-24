Return-Path: <stable+bounces-268185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NchbLwP+O2pGhwgAu9opvQ
	(envelope-from <stable+bounces-268185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:55:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CD6BFD4D
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=O6AJsQtu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268185-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268185-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4121530567E8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3733DB336;
	Wed, 24 Jun 2026 15:54:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E23DB32D;
	Wed, 24 Jun 2026 15:54:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316493; cv=none; b=LszUGX6tn0MbsGmX5nb4ow3wcxG6L/r8rS5qtoB0jBdz7ZEh15RYuoPVUPXe+jNw/1p0ErLCpFz74PbPgOeIM7YgK9Q2gT9+0INpEV2v/R5XZTHlpf9ClDWURsoYpVipE0JMvpYaWNl8Yue6PQkELlZ8Arvt2EnJEAhE59nNb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316493; c=relaxed/simple;
	bh=NjcimBHhYhyUVeKIVsbIG5WVJPXJyXOdjqO9MP7tWss=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mXXaSOPSOXZ6zac7OGYtr7fCHNyPaYaI5/+nb4wz1Iol+cNxkDpNh2v4sAYAJXTfuGOjPXW+jRXw/EyCXVNEOQx8Hsrv2JhWVZgWkSf4ZyHmC0cg+CNFmFnDp080PI9a1O7ARgRDhHuS/vZe2mK4M11gl/CZOzjG5HwLwvybVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=O6AJsQtu; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782316482;
	bh=N2uM8IFzJXU/KYrQm6OrWpu3ImWdNi/x5fLXpRlNRPs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O6AJsQtu6MI5gp54x8VHXXQd1VEi31BzGBLm9MeOCuEGQt7lBEIetBd/TVw6gdcHL
	 YgGVC1eksgjcyYS8X55+bVhlhnZOdHaf0A0USWsjUe5Zm9AKY2pQIEtMxuB9HUoZwJ
	 uyYblGGQfAdAVkHS/PnjGI0hEU+CVNN1Zv/M0tg0=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4glmhy2JNKzGp7r;
	Wed, 24 Jun 2026 15:54:42 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4glmhx6V7VzGp6g;
	Wed, 24 Jun 2026 15:54:41 +0000 (UTC)
Date: Wed, 24 Jun 2026 16:54:40 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
CC: Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Adrian Huang <adrianhuang0701@gmail.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <ajv9KWlTGqNV_yi_@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net> <ajpv5bW01_xtlZ6R@redhat.com> <87bjd0c5xk.fsf@email.froward.int.ebiederm.org> <ajv9KWlTGqNV_yi_@redhat.com>
Message-ID: <A35F5FF8-4FCB-4CE9-8DC5-E0A22071010E@grrlz.net>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268185-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,goodmis.org,efficios.com,linux-foundation.org,infradead.org,google.com,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:ebiederm@xmission.com,m:brauner@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:elver@google.com,m:nogikh@google.com,m:tglx@kernel.org,m:adrianhuang0701@gmail.com,m:kexinsun@smail.nju.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 701CD6BFD4D

On June 24, 2026 4:52:09 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/24, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Add Eric.
>> >
>> > OK, I agree, it seems we need a simple fix.
>> >
>> > Acked-by: Oleg Nesterov <oleg@redhat.com>
>> >
>> >
>-------------------------------------------------------------------------
>> > But let me add some "offtopic" notes... Why do we actually need this
>fix?
>> >
>> > kill_something_info(). But at first glance
>sys_kill/kill_something_info
>> > can simply use SEND_SIG_NOINFO? If yes, this makes sense anyway, I
>will
>> > re-check...
>
>....
>
>> So I think tracing the basic kill syscall is interesting.
>>
>> It uses an explicit siginfo.  It does that so it can choose
>> between setting si_code to SI_TKILL and SI_USER.
>>
>> If the signal number is -1 it sends to every process in the
>> system (or at least the pid namespace).
>>
>> That will require translation.
>
>Most probably I was wrong, I didn't try to re-check yet.
>
>But at first glance kill_something_info() never use SI_TKILL, and
>__send_signal_locked(SEND_SIG_NOINFO) will do the necessary translation,
>in this case si_pid/si_uid are the current task's pid/uid.
>
>But again, I am not sure. Didn't have to to actually look at this code.
>
>> I suspect just fixing send_signal_locked looks the easiest,
>> especially if you make the siginfo parameter const.
>
>Yes, agreed, and I have already acked this patch.
>
>I think we can improve this unconditional rewrite later, on top of this
>fix.
>
>Oleg.
>
>

Hey you two, sorry to impede in your conversation, but could we write
your "conflicting" patch over my Patch 2?

It's fine if you don't want to, it kind of kills two birds with one stone.

Thanks!


Return-Path: <stable+bounces-272689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /KpGBMR1TmrKNAIAu9opvQ
	(envelope-from <stable+bounces-272689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:07:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F4728721
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:07:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WJmp4l6v;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272689-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272689-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52AE8300D1DD
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4F403AEB;
	Wed,  8 Jul 2026 16:06:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32246370ACF;
	Wed,  8 Jul 2026 16:06:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526815; cv=none; b=DU9y8P134JcVr2D+M30Y6R1GQ4qpURyLc9dYuHMK4jKn1upj0O/cV0h8fIyWz2l37gsCl+n5qaErHj/lIigWyx3p0XL8sRDyZ5YZ5LcsfRXAmEpr6iU2spB8tQbQ6O85vP56b5oh2jS4eBPKSXfnBYUDsC79bFtlE/7qPcJAWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526815; c=relaxed/simple;
	bh=4DyLX7ztsjau2xNNs74LDM8VPlXEUXS5Vj9o7IW9Sv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKqKH+CwJNoqNh+H9OWtEUTg3hZgy0xv3ydQFAmAYn283Imy9lETQKD0tEcNyTPmAr5p0ZvysrFUnDPrPsDD2T1RfwU3IKOfuuxAYbXTunaI6TJDm9lmzZF96YbezwTpSZqDWxOKTPUQC+s819RPdvGQfIBLs1P8UdHrciR/XTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJmp4l6v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F91F000E9;
	Wed,  8 Jul 2026 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783526814;
	bh=2NYlb8B9kSU0O7c73Z6//cg01o1P4GX1YsoZOg5imiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WJmp4l6vK2LU4pQ67WZoDUqoAx1vlqCNmEFfbFEJ0/SwGWRhC3dVlpHrqB0sXMAWQ
	 2vPS0NHysAKWTFP1r39CbykWEmIPWrwOD+2MCdDpGW4gf1IAGhwIn4nPvyjQYZTPLP
	 IWzG4CC/TjQB2Kp2qZxV5wNe1RCQWaVU9oMneq0K1OdrIxQAb6zof8Ebj8RdwgurKw
	 bephX4p4ymg+BMBBBPHVds2Tb3plcN7xEFUWVpKXEuYzJEBwaVJ1A1F2l3HeZU7eXE
	 +CIiSSxjBt+FDKxRCGY7k8G+s7Ws0UK5O9oipXsK7njEJOUK+k1My8zdFghv+8Xmu3
	 ESDIF4I+OFj2w==
Date: Wed, 8 Jul 2026 18:06:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
Message-ID: <ak51mpHPzsQrGFmv@localhost.localdomain>
References: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272689-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-tip-commits@vger.kernel.org,m:qw3rtyp0@gmail.com,m:jwlee2217@gmail.com,m:tglx@kernel.org,m:oleg@redhat.com,m:stable@vger.kernel.org,m:x86@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[frederic@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A11F4728721

Le Sun, Jul 05, 2026 at 09:46:36AM -0000, tip-bot2 for Thomas Gleixner a écrit :
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     920f893f735e92ba3a1cd9256899a186b161928d
> Gitweb:        https://git.kernel.org/tip/920f893f735e92ba3a1cd9256899a186b161928d
> Author:        Thomas Gleixner <tglx@kernel.org>
> AuthorDate:    Fri, 03 Jul 2026 12:02:38 +02:00
> Committer:     Thomas Gleixner <tglx@kernel.org>
> CommitterDate: Sun, 05 Jul 2026 11:44:06 +02:00
> 
> posix-cpu-timers: Prevent UAF caused by non-leader exec() race
> 
> Wongi and Jungwoo decoded and reported a non-leader exec() related race
> which can result in an UAF:
> 
>  sys_timer_delete()			exec()
>    posix_cpu_timer_del()
>    // Observes old leader
>    p = pid_task(pid, pid_type);		de_thread()
>    					  switch_leader();
> 					  release_task(old_leader)
> 					    __exit_signal(old_leader)
> 					      sighand = lock(old_leader, sighand);
> 					      posix_cpu_timers*_exit();
>    sighand = lock_task_sighand(p)	      unhash_task(old_leader);
>      sh = lock(p, sighand)	    	      old_leader->sighand = NULL;
> 					      unlock(sighand);
>      (p->sighand == NULL)
> 	unlock(sh)
> 	return NULL;
> 
>    // Returns without action
>    if(!sighand)
>       return 0;
>    free_posix_timer();
> 
> This is "harmless" unless the deleted timer was armed and enqueued in
> p->signal because on exec() a TGID targeted timer is inherited.
> 
> As sys_timer_delete() freed the underlying posix timer object
> run_posix_cpu_timers() or any timerqueue related add/delete operations on
> other timers will access the freed object's timerqueue node, which results
> in an UAF.
> 
> There is a similar problem vs. posix_cpu_timer_set(). For regular posix
> timers it just transiently returns -ESRCH to user space, but for the use
> case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
> allocated on the stack.

do_cpu_nanosleep() only targets current and since it's on the stack, no
other task can access it. And the current task can't be exiting/exec'ing
while calling posix_cpu_timer_set() on that stack timer.

> + * That's problematic for several functions:
> + *
> + *  - posix_cpu_timer_del(): If the timer is still enqueued on the task the
> + *    underlying k_itimer will be freed which results in a UAF in
> + *    run_posix_cpu_timers() or on timerqueue related add/delete operations.
> + *    If the timer is not enqueued, the failure is harmless
> + *
> + *  - posix_cpu_timer_set(): Independent of the enqueued state that results in a
> + *    transient failure which is user space visible (-ESRCH) for regular posix
> + *    timers. But for the use case in do_cpu_nanosleep() it's the same UAF
> + *    problem just that the timer is allocated on the stack.

Ditto.

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs


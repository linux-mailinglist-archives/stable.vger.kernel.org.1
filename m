Return-Path: <stable+bounces-254580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLgzCwflFmpIvAcAu9opvQ
	(envelope-from <stable+bounces-254580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:35:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 962185E43F2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42BDF30080B6
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929F3FFADB;
	Wed, 27 May 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5WLwQUD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3E3EDAD3;
	Wed, 27 May 2026 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885079; cv=none; b=mzPiKgGOOa3P3/kdnv1SWAsBNDt0H4esoT++tYPmymuW/ct7HPASMK2D5e6thlRtPjkkuEoMFNQpYAAkEU+wcRdISAyTSKr7khmiWCp6wNkIZGIzmDe9/71UaesSEguI1+KHSrR1XMvUXUJx1pEcRQxLicDh51RqDJpfLXixJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885079; c=relaxed/simple;
	bh=9nBU4FPn54w6P/rytsi0a46TUYIybqZtGkHVk9CfJsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl4YZfi2RnUDxSWktc5TCCKFsqLNPBzAqkyxeHfBkQEXRkqhfop6IMzmAU5WdgaR/xXn/riT894S++dh2M5GnOWXzdLnZSaL29Tk3AXkmCr9qAJys0+kpZ9fM53N18GXef4OqW2NdkHoG0dPMbXJYcFSMYQmEX/FadGTsOZmY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5WLwQUD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C12D1F000E9;
	Wed, 27 May 2026 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779885078;
	bh=LkTWtOa3FgrmPDUEN+Fn/k8hZETPMbie7Nlo8leDO3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5WLwQUDHmZNjItR67tLSqM5Q3qYtp0cJDOBVp2I4aHjZqKVQDHkst+w2jkiyzZM1
	 aa47Vd3kcAila2CatWeiY3nJ7Tq8eX5Zv3AeN0+tmxBepzhEgV+DBY5lYJtOROLjox
	 VmlvDELTs0KogeAZixP7WCW4Y2q1SUdb8gk/XmXJv+j2Rkfq5I5TjXwXPE/i6Tq1G7
	 z05YwcU88n8d09oacDcGR60X+wbDNwxoHGGhBgx+JDpn5OUgK70PPVIrTJ+TFHRqGn
	 SuDLLvejX8uFH6adEk5FpCKlKV1yIwk/AJbPrVJBWssh5VcHSUUceYqkVHWuc/Wcb8
	 s1nVwa7qlqVIA==
Date: Wed, 27 May 2026 14:31:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Message-ID: <20260527-auslosung-checken-gebacken-e3973bd13112@brauner>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
 <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xmission.com:email]
X-Rspamd-Queue-Id: 962185E43F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:01:51PM +0200, Christian Brauner wrote:
> On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> > On Mon, May 25, 2026 at 9:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > I have added a couple more people who might be interested.
> > >
> > > Kees Cook because as you have structured this it is an exec problem.
> > >
> > > Oleg Nesterov as he is knowledgable about ptrace.
> > >
> > > Jann Horn <jannh@google.com> writes:
> > >
> > > > My understanding is that procfs is effectively maintained by the VFS
> > > > maintainers (though scripts/get_maintainer.pl claims that there are
> > > > no maintainers for procfs because the VFS entry only claims files
> > > > directly in fs/, and the procfs entry has no maintainers listed on
> > > > it).
> > > >
> > > > In procfs, most uses of ptrace_may_access() should use
> > > > exec_update_lock to avoid TOCTOU issues with concurrent privileged
> > > > execve() (like setuid binary execution).
> > > >
> > > > This series doesn't fix all the remaining issues in procfs, but it fixes
> > > > the easy cases for now; I will probably follow up with fixes for the
> > > > gnarlier cases later unless someone else wants to do that.
> > > >
> > > > I have checked that procfs files still work with these changes and that
> > > > CONFIG_PROVE_LOCKING=y doesn't generate any warnings.
> > > >
> > > > (checkpatch complains about missing argument names in
> > > > proc_op::proc_get_link, but that was already the case before my
> > > > patch.)
> > >
> > >
> > > I think I finally have my context paged back in so I can intelligently
> > > say something about this series.
> > >
> > > The scenario you are worried about is when exec gains privileges,
> > > and we read through proc and authenticate with the old credentials
> > > instead of the new credentials.
> > >
> > > Question 1.
> > >
> > > Assuming the executable is world readable (which they generally are)
> > > is there anything that becomes accessible in that race that was
> > > not already accessible?
> > 
> > I believe so - the gnarliest example I am thinking of is:
> > Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
> > sets S_IRWXUGO), so their access control is purely based on being able
> > to pathwalk to the memfd's inode. If you can race
> > open(/proc/$pid/fd/$n) with the process $pid going through setuid
> > execution and calling memfd_create(), you should be able to get
> > read+write access to the memfd created by the setuid binary that was
> > supposed to be private.
> > 
> > (But I have not tested that and don't know if there are actually any
> > setuid binaries that happen to use memfds.)
> > 
> > > Question 2.
> > >
> > > How does this race compare to racing with setresuid?
> > > Do we need to fix the setresuid case as well?
> > 
> > Which setresuid case? setresuid clears the dumpable flag and has a
> > memory barrier that is supposed to make that properly ordered against
> > ptrace_may_access(); so setresuid() should normally not cause a task
> > to become traceable, though that could maybe happen in weird
> > scenarios.
> > 
> > I think another case we should probably care about is what happens if
> > a process which is only protected against ptrace by being non-dumpable
> > goes through execve() - it shouldn't be possible to access resources
> > associated with the pre-execve state while checking against the
> > post-execve dumpability. It might be important for this that the
> > do_close_on_exec() logic currently happens after committing the
> > dumpable state in exec_mmap()...
> > 
> > > Question 3.
> > > Do we care about the case when a privileged process calls a setuid
> > > process and drops privileges?
> > 
> > I don't understand the question. Hmm - do you mean a case where a
> > process with ruid=1000, euid=0, suid=1000 does execve() on a setuid
> > 1000 binary? I think we probably don't specifically care about that...
> > 
> > I think another scenario that we ideally might want to care about is
> > what happens if a process which runs with a normal user's UIDs, but is
> > non-dumpable, goes through execve() of a normal binary while another
> > process tries to inspect its FDs or address space layout - it probably
> > shouldn't be possible to get information about the pre-execve MM and
> > O_CLOEXEC file descriptors.
> > 
> > > Question 4.
> > > Is it possible to use a seq_lock instead of reader writer semaphore?
> > > Or is that only for non-sleeping readers?
> > 
> > Linux seqcounts are 32-bit, which means they are always kind of dodgy,
> > but they are particularly dodgy if a reader can be forced to sleep for
> > an extended amount of time. I don't see a reason why we couldn't, in
> > general, use a 64-bit sequence count for readers that may need to
> > sleep while reading.
> 
> I have a patch series for this that I started working after merging your
> series for precisely this reason: performance. It's a few days old now.
> I've tried various approaches and I started with a simple 32-bit counter
> as the POC. See appended (untested) patches.

In a bunch of cases we know that the critical section the callers cares
about just is very small: creds + mm. So in that case it is easy to
switch the credential computation into a prepare stage and a commit
stage and then the targeted critical section just becomes:
task->signal->seq_mm++ + task->cred = new_cred + task->mm = mm +
task->active_mm = mm + task->signal->seq_mm--. And then the reader
doesn't need to sleep at all and can just spin on the seqcount for the
small window they need.

I wasn't convinced it was valuable to use a fine-grained/multi-seqcount
approach though.


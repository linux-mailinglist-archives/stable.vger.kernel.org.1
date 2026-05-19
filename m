Return-Path: <stable+bounces-249483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdBIiwUDGoZVQUAu9opvQ
	(envelope-from <stable+bounces-249483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:41:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F031E579471
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A19E30975CB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A153DA7C3;
	Tue, 19 May 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRi5sAV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302F3D6474
	for <stable@vger.kernel.org>; Tue, 19 May 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176252; cv=none; b=bBfRX4FVR3xfNA9blAdtehiAULgLSchSZKCEDLVzz1veQvpO30xX/IQnMUNXziKElDQarof76YhrOWKzb9Dd38nHv3vb1YkhwyVJSgear7F98TtDtjYrng39+LrTpkmrHBO4eHXQ9xld9XHnxk0Ct3+hIaF/0JMAGcMZjpoLeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176252; c=relaxed/simple;
	bh=fkFPHH8Hwthih9xO706d0W1LBmGMYkEa5LnsmoqZSYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMj0w/GaodHpjOBQAm2Cezva+SsAA8ZlhwaNC1M9gJTakhvcVSqTjAICJN7wakGO9q2682hZR3K6dVU7pbJwRnkrIon8wYCKzgD5rBsh3GVQSfbmtlxYY5zwPTIN4FHovfJinRYtnzbSrIy1Siv27C6O7qeXCTL9xPYbUlMMb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRi5sAV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC8AC2BCC9;
	Tue, 19 May 2026 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779176251;
	bh=fkFPHH8Hwthih9xO706d0W1LBmGMYkEa5LnsmoqZSYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRi5sAV8zWXUXd6aF16BSAQn/V7t1LwiM4AmJ2/tFlH/4CmchiQZNU1j9lsw0ESqx
	 iCLhEaTnteltFsp3mZiKMut1GcYMzsXROYduPhBOQtYbDXRExzA/zvOYe+aHFs67BH
	 J6ulQWOB+OT4WrNDV0UvJPNVyycndUiMkCCvjt2vb7Q+sID07BKDVRNZHQ9m+HTpoQ
	 obGDiPZbrlP2fWiCpW7H/lwB9VaYqkliNasczcFWhg4vkXf+UST+QcbDOxySYh5fXb
	 s0EOwLmVsReyq8/A7YphoIyCajr004WqQVgnFfq7hms5u6WyfFvC5I6bSfkACHBMa1
	 1RyEuq5YJWe5Q==
Date: Tue, 19 May 2026 09:37:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field
 post-exit
Message-ID: <20260519-gehversuche-lokomotive-cd720c53bab1@brauner>
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
 <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
 <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249483-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: F031E579471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:41:43PM +0200, Jann Horn wrote:
> On Mon, May 18, 2026 at 8:11 PM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> > On Mon, 18 May 2026 at 10:20, Jann Horn <jannh@google.com> wrote:
> > >
> > > I mean... /proc/$pid/task/fd/$n probably has the same problem, no?
> >
> > Possibly. That said, the permissions on that directory changes when
> > the process becomes a zombie, so it might almost accidentally be ok.
> >
> > > pidfd_getfd() is just more severe because it directly creates an FD
> > > for the file, instead of going through normal VFS open() permission
> > > checks. But /proc/$pid/task/fd/$n is theoretically also dangerous for
> > > stuff like anonymous pipes or memfds, where security mainly relies on
> > > not being able to reach the inode.
> >
> > If your security depends on "not reading the inode", your security is
> > not security, it's a joke.
> 
> I mean... __shmem_file_setup() explicitly creates files with
> S_IRWXUGO, and that is what memfd_create() uses. So the security of
> memfds in particular always relies on the inode not being reachable,
> unless LSM restrictions are involved.
> 
> user@vm:/tmp$ cat memfd_test.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> 
> int main(void) {
>   system("grep ^Umask /proc/$PPID/status");
> 
>   int memfd = memfd_create("foo", MFD_CLOEXEC);
>   char cmd[1000];
>   sprintf(cmd, "stat --dereference /proc/$PPID/fd/%d", memfd);
>   system(cmd);
> }
> user@vm:/tmp$ gcc -o memfd_test memfd_test.c
> user@vm:/tmp$ ./memfd_test
> Umask:0002
>   File: /proc/699/fd/3
>   Size: 0         Blocks: 0          IO Block: 4096   regular empty file
> Device: 0,1 Inode: 2064        Links: 0
> Access: (0777/-rwxrwxrwx)  Uid: ( 1000/    user)   Gid: ( 1000/    user)
> Access: 2026-05-18 18:24:31.669411864 +0000
> Modify: 2026-05-18 18:24:31.669411864 +0000
> Change: 2026-05-18 18:24:31.669411864 +0000
>  Birth: 2026-05-18 18:24:31.669411864 +0000
> user@vm:/tmp$
> 
> 
> (Anonymous pipes are less problematic in this aspect, get_pipe_inode()
> uses the current_fsuid() and sets mode 0600.)
> 
> > The /proc/pid/ interface has been around forever, and that's ignoring
> > regular ptrace too. Files have absolutely *never* been private, and
> > anybody who thinks they are some private thing is just wrong.
> >
> > And being a zombie doesn't even change that - files can stay around
> > afterwards, and it's not a problem.
> >
> > I really think the *only* bug was literally the whole "people didn't
> > think about mm->dumpable as a security thing wrt zombies"
> >
> > (And the entirely unrelated bug of IO-time vs open-time, which we've
> > had many many times because it's such an easy mistake to make).
> >
> > > I think that would be kind of ugly because here, the MM is not
> > > actually used for memory management thing; instead, the MM is just
> > > used as the one place we have that stores state that is shared between
> > > threads
> >
> > I agree. Except it is *not* "the one place". We have multiple shared places.
> >
> > In fact, I wonder if we should simply just move "dumpable" into
> > "struct sighand_struct" instead (or "signal_struct"). Those stay
> > around until the task is released, and they kind of are more natural
> > for core dumping, since it's about signals.
> 
> I think signal_struct is not unshared on exec; so in this sequence of events:
> 
>  - task T1 is a non-dumpable task
>  - task T1 creates another thread T2
>  - T2 exits
>  - T1 goes through execve and becomes dumpable
> 
> I believe T1 and T2 are still associated with the same signal_struct,
> which means that even though T2 is part of the pre-execve process, it
> shares state with the post-execve process and it would wrongly be
> considered dumpable.
> 
> I hadn't realized that the sighand_struct is unshared on execve, I
> guess putting it in sighand_struct might be an option. (An
> implementation detail regarding that is that a task can currently lose
> its sighand_struct while there are still references held to the task,
> but I guess changing that would be easy.)

struct sighand_struct is not unshared on CLONE_VM (without CLONE_THREAD)
during fork(). IOW, it's possible to do CLONE_VM without CLONE_SIGHAND.
Right now commit_creds() broadcasts dumpability changes to all tasks
using the given mm. If we move it to struct sighand_struct we break
that. Forcing CLONE_VM to imply CLONE_SIGHAND would break vfork().


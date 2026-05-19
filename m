Return-Path: <stable+bounces-249631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDJGLPiJDGo1iwUAu9opvQ
	(envelope-from <stable+bounces-249631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:04:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56256581E8A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E761F309A80F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C03AFD1B;
	Tue, 19 May 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMdOb61l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1733AFD0A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205740; cv=none; b=GHlgZMpLPUKdHEtSUJMr7QjygkLJJSVcOI8DDJ9+KNegjI6WoUh3IRMfc2G7A6DN2qBl80IQNdNFjEfzb1zi33JVV6oyuUr73F3WFAg1PHnicNNzXBJLO0g9XERtv8nGpeBs9YBY+KkvsCmnfHs5PtPphk4afj30N1+hYNaYVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205740; c=relaxed/simple;
	bh=BmArmLUFabXkv1FN5bMis9iz2OEPjQisfyx08p2TqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlapATDg/6C/w62TzUhaEXYfwliGVaNOHGARHysffWQPb/BEVxypEhm5UnjvtVFXkk6JC3EHWBselm9PoZcioZd1dW79GBwFOdJdxFjQowdPou42nMa0ikdKo1fvMplIAuOEh73Nbw6rLxeQ0py5V5lXq6AfbFB3XKqUo37krWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMdOb61l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7404BC2BCB3;
	Tue, 19 May 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779205740;
	bh=BmArmLUFabXkv1FN5bMis9iz2OEPjQisfyx08p2TqZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMdOb61loSo+TYmzJxw3rQ+H2q7bhA0m4nvzpCWSkkkBRASzRBUH0RDW6JviAUgh3
	 0gfylxFkCJeL5GiKrVcIUE5MNw+GvsftDHC0Kam+HT0ZMntGQT1u/9G1XIfGeM5qYm
	 W0zXLwX456416FGSFdqtblXKR8RLnShbjlLa4b3FuKQTeomTkTcRKdWbFzxteW5ZsR
	 hbaolGCxFd1Rgt2OxaW9l5et7+UggRJaKET0W85BHOtjYMmVsN85Hxv4RBQ9bQaW7o
	 6U+EN8HFYaxe2voKkafM1l53xlt7fmF2D8fawJR5UiXK2SGPPlHGNg8W+GKnFGu43I
	 tj4VxDndWi9Vw==
Date: Tue, 19 May 2026 17:48:52 +0200
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
Message-ID: <20260519-lehrling-backt-261d022de809@brauner>
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com>
 <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
 <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
 <20260519-gehversuche-lokomotive-cd720c53bab1@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ej5tgo2oo7zqhnzi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519-gehversuche-lokomotive-cd720c53bab1@brauner>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249631-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vm:email]
X-Rspamd-Queue-Id: 56256581E8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ej5tgo2oo7zqhnzi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 19, 2026 at 09:37:25AM +0200, Christian Brauner wrote:
> On Mon, May 18, 2026 at 08:41:43PM +0200, Jann Horn wrote:
> > On Mon, May 18, 2026 at 8:11 PM Linus Torvalds
> > <torvalds@linuxfoundation.org> wrote:
> > > On Mon, 18 May 2026 at 10:20, Jann Horn <jannh@google.com> wrote:
> > > >
> > > > I mean... /proc/$pid/task/fd/$n probably has the same problem, no?
> > >
> > > Possibly. That said, the permissions on that directory changes when
> > > the process becomes a zombie, so it might almost accidentally be ok.
> > >
> > > > pidfd_getfd() is just more severe because it directly creates an FD
> > > > for the file, instead of going through normal VFS open() permission
> > > > checks. But /proc/$pid/task/fd/$n is theoretically also dangerous for
> > > > stuff like anonymous pipes or memfds, where security mainly relies on
> > > > not being able to reach the inode.
> > >
> > > If your security depends on "not reading the inode", your security is
> > > not security, it's a joke.
> > 
> > I mean... __shmem_file_setup() explicitly creates files with
> > S_IRWXUGO, and that is what memfd_create() uses. So the security of
> > memfds in particular always relies on the inode not being reachable,
> > unless LSM restrictions are involved.
> > 
> > user@vm:/tmp$ cat memfd_test.c
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <sys/mman.h>
> > 
> > int main(void) {
> >   system("grep ^Umask /proc/$PPID/status");
> > 
> >   int memfd = memfd_create("foo", MFD_CLOEXEC);
> >   char cmd[1000];
> >   sprintf(cmd, "stat --dereference /proc/$PPID/fd/%d", memfd);
> >   system(cmd);
> > }
> > user@vm:/tmp$ gcc -o memfd_test memfd_test.c
> > user@vm:/tmp$ ./memfd_test
> > Umask:0002
> >   File: /proc/699/fd/3
> >   Size: 0         Blocks: 0          IO Block: 4096   regular empty file
> > Device: 0,1 Inode: 2064        Links: 0
> > Access: (0777/-rwxrwxrwx)  Uid: ( 1000/    user)   Gid: ( 1000/    user)
> > Access: 2026-05-18 18:24:31.669411864 +0000
> > Modify: 2026-05-18 18:24:31.669411864 +0000
> > Change: 2026-05-18 18:24:31.669411864 +0000
> >  Birth: 2026-05-18 18:24:31.669411864 +0000
> > user@vm:/tmp$
> > 
> > 
> > (Anonymous pipes are less problematic in this aspect, get_pipe_inode()
> > uses the current_fsuid() and sets mode 0600.)
> > 
> > > The /proc/pid/ interface has been around forever, and that's ignoring
> > > regular ptrace too. Files have absolutely *never* been private, and
> > > anybody who thinks they are some private thing is just wrong.
> > >
> > > And being a zombie doesn't even change that - files can stay around
> > > afterwards, and it's not a problem.
> > >
> > > I really think the *only* bug was literally the whole "people didn't
> > > think about mm->dumpable as a security thing wrt zombies"
> > >
> > > (And the entirely unrelated bug of IO-time vs open-time, which we've
> > > had many many times because it's such an easy mistake to make).
> > >
> > > > I think that would be kind of ugly because here, the MM is not
> > > > actually used for memory management thing; instead, the MM is just
> > > > used as the one place we have that stores state that is shared between
> > > > threads
> > >
> > > I agree. Except it is *not* "the one place". We have multiple shared places.
> > >
> > > In fact, I wonder if we should simply just move "dumpable" into
> > > "struct sighand_struct" instead (or "signal_struct"). Those stay
> > > around until the task is released, and they kind of are more natural
> > > for core dumping, since it's about signals.
> > 
> > I think signal_struct is not unshared on exec; so in this sequence of events:
> > 
> >  - task T1 is a non-dumpable task
> >  - task T1 creates another thread T2
> >  - T2 exits
> >  - T1 goes through execve and becomes dumpable
> > 
> > I believe T1 and T2 are still associated with the same signal_struct,
> > which means that even though T2 is part of the pre-execve process, it
> > shares state with the post-execve process and it would wrongly be
> > considered dumpable.
> > 
> > I hadn't realized that the sighand_struct is unshared on execve, I
> > guess putting it in sighand_struct might be an option. (An
> > implementation detail regarding that is that a task can currently lose
> > its sighand_struct while there are still references held to the task,
> > but I guess changing that would be easy.)
> 
> struct sighand_struct is not unshared on CLONE_VM (without CLONE_THREAD)
> during fork(). IOW, it's possible to do CLONE_VM without CLONE_SIGHAND.
> Right now commit_creds() broadcasts dumpability changes to all tasks
> using the given mm. If we move it to struct sighand_struct we break
> that. Forcing CLONE_VM to imply CLONE_SIGHAND would break vfork().

One thing I played with is to move dumpability and exec namespace into
struct task_exec_state which hangs around until the task is freed. This
kind of works and effectively splits the permission related stuff out of
struct mm_struct. The problem is that callers now need to take care that
exec_state and mm_struct are in-sync. And we have various interactions
there. There's at least task_lock() and exec_update_lock(). For example,
mm_access() relies on exec_update_lock() so task->exec_state needs to be
updated alongside task->mm during exec_mmap(). It's all doable but it's
certainly subtle on its own. One advantage one could argue for, is that
this move makes it clear that dumpability is not just a concept tied to
mm but is used for permission checks beyond it.

Anyway, I have a draft of this. Please, it's not pretty and it's a PoC
I've done it so that we can look at something rather than just wave
hands. I don't even know if it compiles.

--ej5tgo2oo7zqhnzi
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-pidfd-refuse-access-to-tasks-that-have-started-exiti.patch"

From c64938bbcf9f473db0e95b714746e57b03efc334 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 18 May 2026 10:32:11 +0200
Subject: [PATCH] pidfd: refuse access to tasks that have started exiting
 harder

The recent ptrace fix closed a hole where someone could rely on task->mm
becoming NULL during do_exit() to bypass dumpability checks. This api
here leans on on the very same check and so inherits the fix.

But there is no good reason to let it succeed at all once the target has
entered do_exit(). PF_EXITING is set by exit_signals() at the very top
of do_exit(), before exit_mm() and exit_files() run. Once we observe it,
the task is committed to dying and exit_files() will release the fdtable
shortly.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/pid.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index fd5c2d4aa349..f55189a3d07d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -885,10 +885,12 @@ static struct file *__pidfd_fget(struct task_struct *task, int fd)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
-		file = fget_task(task, fd);
-	else
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
 		file = ERR_PTR(-EPERM);
+	else if (task->flags & PF_EXITING)
+		file = ERR_PTR(-ESRCH);
+	else
+		file = fget_task(task, fd);
 
 	up_read(&task->signal->exec_update_lock);
 
-- 
2.47.3


--ej5tgo2oo7zqhnzi--


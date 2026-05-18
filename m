Return-Path: <stable+bounces-249247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLo/NUnmCmqJ9AQAu9opvQ
	(envelope-from <stable+bounces-249247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:13:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16556A7B9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A8713001D76
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E2322B72;
	Mon, 18 May 2026 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwKW3rQh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D3317163
	for <stable@vger.kernel.org>; Mon, 18 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099205; cv=none; b=N8L0rKAqvGtcFRfRioClD+bAJUXD2QcIDbzFyS6E2LfDqrfIN4I3sLQxoPZMcIJahrELblHqI83Rb2UkSdQleS5pZ4LNribLTS9QJdXQI43mwC2nywZ/bPQz7Z+lhOtGUiz0fFIdGI61f5C4Bc0wNjEDkT5h3MtXo5RxMD/JAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099205; c=relaxed/simple;
	bh=AQneTqU2WjWy5WuAxxdRDOEovifMPzhrmkykBj8ZD5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT+9GJHZGDRNPdL8d5n2VVoA2xQS2G9hJI/Uq1ojCcXMm7mw/BunuZBeaEsjy5OqC1OTCElWrPFwSN39Cnu4NKL556EwfvkPjGq2MK/R6d4gaDqPk3Pr3xu5ez04gF1WjGBvSrWNbepZgMZ7vXuQ1FoHjKu8G3cmwPdKZ/gO70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwKW3rQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0DFC2BCB7;
	Mon, 18 May 2026 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779099204;
	bh=AQneTqU2WjWy5WuAxxdRDOEovifMPzhrmkykBj8ZD5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwKW3rQhKBH8cdlFDdj3odVBujABo+7iuXPrB3HlcTJyS9yZd1aF8qQQxCYkJbcvH
	 2LP1+9jI7/NU9hSqOO/uLXqxvsP0+wD5pOF2QKscstWgx3IZ2lMKuMk4mCQ1W4h2nE
	 Ext8/sLcftJbD2vgZ49PlJNWUhnYcx7P6oIFg93xeyDwUqDqFR/CIajElxxYkmfM67
	 CoqB/Bs6k+Vjad8QDB1f7H432fTcUyQQlB/NA2VkA6Lm/dG6CbE19xLo2iqYxoL4ie
	 bK3hY6jJtEelOj+ZVQGCfF9jBqcutbpbQ3bcvp5N6GtRaYCDE02aKfx+SpOQNZ181s
	 FCIAi3I+131rw==
Date: Mon, 18 May 2026 12:13:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field
 post-exit
Message-ID: <20260518-obgleich-petersilie-2d77ccccf9b9@brauner>
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wu6enxnrzjkfmb2m"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
X-Rspamd-Queue-Id: 7E16556A7B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249247-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--wu6enxnrzjkfmb2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> So the problem really is ptrace_may_access(), and that thing needs
> fundamental fixes. We should not add exit_mm to try to paper over the
> real issues.

If we can improve ptrace_may_access() in additional ways I'm very happy.

One thing that I would like to mention is that forcing callers of this
api to reason about post-exit, zombie, or mm behavior has potential for
a lot of subtle bugs. Dealing with mm sharing and dumpability
implications is rather subtle so I think doing it within the api itself
would be preferable.

I've also appended a patch that makes pidfd_getfd() check for exiting
tasks after a successful ptrace check. Please do feel free to apply it
directly if you agree.

--wu6enxnrzjkfmb2m
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


--wu6enxnrzjkfmb2m--


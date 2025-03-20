Return-Path: <stable+bounces-125693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0CA6AF94
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516F4486F10
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235322A4FD;
	Thu, 20 Mar 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FE1P8bHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15846B5
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504776; cv=none; b=hKk5a65Yz49W2qv1JvTuOLWXLEjjLA6uNbn0Pp9hYJchQmlay/oWAcAWKFAGRazJWLoCx5bgAb+68OIjzZ1F+4duBuc6RwqfRBzi8vp8ugNcripjA18Gc5rXhDfGKyCmtgD7xb6v8Ipg0cIJgIeMM16kRibb1pIUO6YiYvMYULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504776; c=relaxed/simple;
	bh=8YK8gEtI06y+pQqv1+lAtw4gYDT6ElW3udJy3zGarU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQEuSQag4iHrSPx6MJpY6K+BDYkCvBVMZ8QWt/j1VcjPgNr2Q1xLHG9LGZtYtAPAh+eDB3VxwmL+u0GDFMT49jwEsWal6AGpbN1vmuvFQQErnirfVZ3+flhY4VhN4LE4l3l7/Rkql1ru9DHpTbXdg8OvFH9BaqSpWrRyCzgsxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FE1P8bHf; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJdR54jhVzSDT;
	Thu, 20 Mar 2025 22:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742504769;
	bh=x7Mh94NSn2KPNj8EF1RUEY7NFZ+qiXAJyN6mSl93rjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FE1P8bHfxN0R5WczBQNWdcS8S+Ok+e58SMwG1H0UderYlXfoRXdlIQehwexs3+1wh
	 tX9zfF8Odwc2AoJgNnCjkqo53zjpJgZGXN3gk+NJHQLCDlKOM1SKryzizP8xtuOoGn
	 GKclc3thjvIBJslQeAY9vyH8Qnak6OnCnHOPL2Qo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJdR43X8DzYZl;
	Thu, 20 Mar 2025 22:06:08 +0100 (CET)
Date: Thu, 20 Mar 2025 22:06:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] landlock: Always allow signals between threads of
 the same process
Message-ID: <20250320.zahqueisoeT6@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
 <20250318161443.279194-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318161443.279194-6-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Tue, Mar 18, 2025 at 05:14:40PM +0100, Mickaël Salaün wrote:
> Because Linux credentials are managed per thread, user space relies on
> some hack to synchronize credential update across threads from the same
> process.  This is required by the Native POSIX Threads Library and
> implemented by set*id(2) wrappers and libcap(3) to use tgkill(2) to
> synchronize threads.  See nptl(7) and libpsx(3).  Furthermore, some
> runtimes like Go do not enable developers to have control over threads
> [1].
> 
> To avoid potential issues, and because threads are not security
> boundaries, let's relax the Landlock (optional) signal scoping to always
> allow signals sent between threads of the same process.  This exception
> is similar to the __ptrace_may_access() one.
> 
> hook_file_set_fowner() now checks if the target task is part of the same
> process as the caller.  If this is the case, then the related signal
> triggered by the socket will always be allowed.
> 
> Scoping of abstract UNIX sockets is not changed because kernel objects
> (e.g. sockets) should be tied to their creator's domain at creation
> time.
> 
> Note that creating one Landlock domain per thread puts each of these
> threads (and their future children) in their own scope, which is
> probably not what users expect, especially in Go where we do not control
> threads.  However, being able to drop permissions on all threads should
> not be restricted by signal scoping.  We are working on a way to make it
> possible to atomically restrict all threads of a process with the same
> domain [2].
> 
> Add erratum for signal scoping.
> 
> Closes: https://github.com/landlock-lsm/go-landlock/issues/36
> Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
> Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
> Depends-on: 26f204380a3c ("fs: Fix file_set_fowner LSM hook inconsistencies")
> Link: https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/psx [1]
> Link: https://github.com/landlock-lsm/linux/issues/2 [2]
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Cc: stable@vger.kernel.org
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250318161443.279194-6-mic@digikod.net

> index 71b9dc331aae..47c862fe14e4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -27,7 +27,9 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/path.h>
> +#include <linux/pid.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched/signal.h>
>  #include <linux/spinlock.h>
>  #include <linux/stat.h>
>  #include <linux/types.h>
> @@ -1630,15 +1632,27 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>  
>  static void hook_file_set_fowner(struct file *file)
>  {
> -	struct landlock_ruleset *new_dom, *prev_dom;
> +	struct fown_struct *fown = file_f_owner(file);
> +	struct landlock_ruleset *new_dom = NULL;
> +	struct landlock_ruleset *prev_dom;
> +	struct task_struct *p;
>  
>  	/*
>  	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
>  	 * file_set_fowner LSM hook inconsistencies").
>  	 */
> -	lockdep_assert_held(&file_f_owner(file)->lock);
> -	new_dom = landlock_get_current_domain();
> -	landlock_get_ruleset(new_dom);
> +	lockdep_assert_held(&fown->lock);
> +
> +	/*
> +	 * Always allow sending signals between threads of the same process.  This
> +	 * ensures consistency with hook_task_kill().
> +	 */
> +	p = pid_task(fown->pid, fown->pid_type);
> +	if (!same_thread_group(p, current)) {

There is a missing pointer check.  I'll apply this:

-       if (!same_thread_group(p, current)) {
+       if (!p || !same_thread_group(p, current)) {

> +		new_dom = landlock_get_current_domain();
> +		landlock_get_ruleset(new_dom);
> +	}
> +
>  	prev_dom = landlock_file(file)->fown_domain;
>  	landlock_file(file)->fown_domain = new_dom;
>  


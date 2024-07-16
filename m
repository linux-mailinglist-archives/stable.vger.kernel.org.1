Return-Path: <stable+bounces-59393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4593210F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 09:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE962821BE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054F2263A;
	Tue, 16 Jul 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMKQKFmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCE224DD
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114183; cv=none; b=MwTE8gPU22VCUfwRKtyWnbpJurhREbM3wdZLRtTH4z1Xq6jHWZ5zuq+wxBWx+d8JJlKqgOTWVbbzeAR1hdAkjV/82BNC+sQy1d4Zl3UB6eRfrc8/vAm7i44tDGm9tp3zPaZA4Kpa2dJompbwKOWD2frUvaeB6YVWB/KdbRcfvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114183; c=relaxed/simple;
	bh=4QYqfuYU9SkBDGdsjgDDUH90J8cVK89QlH4G2E0YYqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC+fOOpZ/ZHiDajnhfHwxTvyWRjkhvtWNtW6S3ILmL2YrobyiFJ+P7EZSHHVF8o742odU2Iv+LrrWPmHwp5LBxXU9nF8Z7bpINVk9EsA4K3NBkKNpqyvZKaTQatAGQM4lfkxN45ag+hBtoGHpxrPBU3qmC6CUpwQenuTzUfCO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMKQKFmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F88CC116B1;
	Tue, 16 Jul 2024 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721114182;
	bh=4QYqfuYU9SkBDGdsjgDDUH90J8cVK89QlH4G2E0YYqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zMKQKFmKfaWKPGtOJOeDrgdXzN8FwjvRqEwoU0mwe5p072bqOSrkb/qJOhpUs1eNk
	 knWPn7ysjHxiHYvooeaT21sNFkgf9VlEjTKWKJJgY+WQtHTLQp+eo4o9u8qOT5m8oV
	 /j4xyrsOpE74TgFVQI95ZOuC2ALPdIqHWThFFUvE=
Date: Tue, 16 Jul 2024 09:16:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively
 when max_nr_regions" failed to apply to 6.1-stable tree
Message-ID: <2024071625-bless-undivided-0af3@gregkh>
References: <2024071519-janitor-robe-779f@gregkh>
 <20240715195946.1043767-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715195946.1043767-1-sj@kernel.org>

On Mon, Jul 15, 2024 at 12:59:45PM -0700, SeongJae Park wrote:
> On Mon, 15 Jul 2024 19:12:29 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Jul 15, 2024 at 09:57:17AM -0700, SeongJae Park wrote:
> > > Hi Greg,
> > > 
> > > On Mon, 15 Jul 2024 13:34:48 +0200 <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > 
> > > > The patch below does not apply to the 6.1-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > > 
> > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > > 
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> > > 
> > > But this doesn't reproduce the failure on my machine, like below?
> > > 
> > >     $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > >     [...]
> > >     $ git checkout FETCH_HEAD
> > >     [...]
> > >     HEAD is now at cac15753b8ce Linux 6.1.99
> > >     $ git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> > >     Auto-merging mm/damon/core.c
> > >     [detached HEAD ecd04159c5f3] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
> > >      Date: Mon Jun 24 10:58:14 2024 -0700
> > >      1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > Try building it:
> > 
> >   DESCEND objtool
> >   CALL    scripts/checksyscalls.sh
> >   CC      mm/damon/core.o
> > In file included from ./include/linux/kernel.h:26,
> >                  from ./arch/x86/include/asm/percpu.h:27,
> >                  from ./arch/x86/include/asm/preempt.h:6,
> >                  from ./include/linux/preempt.h:79,
> >                  from ./include/linux/spinlock.h:56,
> >                  from ./include/linux/swait.h:7,
> >                  from ./include/linux/completion.h:12,
> >                  from ./include/linux/damon.h:11,
> >                  from mm/damon/core.c:10:
> > mm/damon/core.c: In function \u2018kdamond_merge_regions\u2019:
> > ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
> >    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >       |                                   ^~
> > ./include/linux/minmax.h:26:18: note: in expansion of macro \u2018__typecheck\u2019
> >    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
> >       |                  ^~~~~~~~~~~
> > ./include/linux/minmax.h:36:31: note: in expansion of macro \u2018__safe_cmp\u2019
> >    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
> >       |                               ^~~~~~~~~~
> > ./include/linux/minmax.h:52:25: note: in expansion of macro \u2018__careful_cmp\u2019
> >    52 | #define max(x, y)       __careful_cmp(x, y, >)
> >       |                         ^~~~~~~~~~~~~
> > mm/damon/core.c:946:29: note: in expansion of macro \u2018max\u2019
> >   946 |                 threshold = max(1, threshold * 2);
> >       |                             ^~~
> > cc1: all warnings being treated as errors
> > make[3]: *** [scripts/Makefile.build:250: mm/damon/core.o] Error 1
> > make[2]: *** [scripts/Makefile.build:503: mm/damon] Error 2
> > make[1]: *** [scripts/Makefile.build:503: mm] Error 2
> 
> Thank you for sharing this.
> 
> I found the issue can be fixed in two ways.  I'd like to know what way you'd
> prefer.
> 
> The first way is adding below simple fix to mm/damon/core.c file.
> 
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -943,7 +943,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>                         damon_merge_regions_of(t, threshold, sz_limit);
>                         nr_regions += damon_nr_regions(t);
>                 }
> -               threshold = max(1, threshold * 2);
> +               threshold = max(1U, threshold * 2);
>         } while (nr_regions > c->attrs.max_nr_regions &&
>                         threshold / 2 < max_thres);
>  }
> 
> The second way is adding upstream commits that avoids the warning of DAMON code
> on >=6.6 kernels.  Specifically, commit 867046cc7027 ("minmax: relax check to
> allow comparison between unsigned arguments and signed constants") is needed.
> However, the commit cannot cleanly cherry-picked on its own.  Cherry-picking
> the commit together with below commits (listed latest one first) made all
> commits cleanly be picked and the warning disappears.
> 
> 4ead534fba42 minmax: allow comparisons of 'int' against 'unsigned char/short'
> d03eba99f5bf minmax: allow min()/max()/clamp() if the arguments have the same signedness.
> 2122e2a4efc2 minmax: clamp more efficiently by avoiding extra comparison
> 5efcecd9a3b1 minmax: sanity check constant bounds when clamping

I just tried the above, and then added your commit, but I still get the
same build error.  Did you try it?

I would love to get the minmax stuff properly backported to 6.1 (and
older if possible), as we have run into this same issue with many
changes over the years.

> Same warning happens on 5.15.y.  In the case, adding the minmax.h upstream
> commits only adds more build errors.  To remove those, yet another upstream
> commit, namely commit a49a64b5bf19 ("tracing: Define the is_signed_type() macro
> once") need to be cherry-picked.
> 
> IMHO, the second way is more complex but right for long term, since future
> commits for stable tree may also have similar issue.  It is not a strong
> opinion, and either ways work for me.
> 
> So, Greg, what would you prefer?

I would prefer the second way, IF it works.  In my limited testing right
now, I couldn't get it to work at all.  Can you send a series of
backported patches that work for you so that I ensure that I'm not just
doing something stupid on my end?

thanks,

greg k-h


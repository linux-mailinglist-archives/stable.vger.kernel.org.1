Return-Path: <stable+bounces-59363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8289318FF
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8711F22744
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D043AC0D;
	Mon, 15 Jul 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGA69nfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49B46522
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063552; cv=none; b=ZSSmSnguxZ+dU3qNCcMaRaF8wxaRFuIv/liAkljQH/eusTvHAGVbFjvKS1+7VVZxI9FimWkDkJ7vKSvuu0jaPKdxNAabp6dPxNAsqfZDP3/tKGwQ4sG1BBLJx7Aw7LZFlFh7vsKymylPunAdAaXhCcjlNYSQMBB1/dVKRhWIWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063552; c=relaxed/simple;
	bh=8RDP7z6ia46Xb3htnE+KpcStx81inhmwJJNQ7laEIQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkP3XGqrnisxzYj+9N7LdrbsryDhCubllT8JMSExU1TlPwOMudvqV5d31x4IKDOnvjDUKBFam/hO1gJoTTUG1Br3WajFWWu/10/S1kQHog6XBsXUBW1tw7qaEfPlLPfD70uUiSYudZu0H82W27N+9AUjDW4UxunheGNtfSdDyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGA69nfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE87DC32782;
	Mon, 15 Jul 2024 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721063552;
	bh=8RDP7z6ia46Xb3htnE+KpcStx81inhmwJJNQ7laEIQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGA69nfxdnqWj9RfdY8pegWFG2e5fEr1EkqJmwC8MN3Ihrpt+qolgUNwg/TTgviRh
	 opQ+tYYGiCKpOG6iuhQBl6JkAdz/BG7f2ediBJWyo/PoeGLLq0MMM2pXHuyGD0DXXT
	 UsTsmsyO+ZIZZT2sRe4f+vXVO6oDA/L5yc/bONfM=
Date: Mon, 15 Jul 2024 19:12:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively
 when max_nr_regions" failed to apply to 6.1-stable tree
Message-ID: <2024071519-janitor-robe-779f@gregkh>
References: <2024071547-slum-anemic-a0cc@gregkh>
 <20240715165717.73852-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715165717.73852-1-sj@kernel.org>

On Mon, Jul 15, 2024 at 09:57:17AM -0700, SeongJae Park wrote:
> Hi Greg,
> 
> On Mon, 15 Jul 2024 13:34:48 +0200 <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> 
> But this doesn't reproduce the failure on my machine, like below?
> 
>     $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>     [...]
>     $ git checkout FETCH_HEAD
>     [...]
>     HEAD is now at cac15753b8ce Linux 6.1.99
>     $ git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
>     Auto-merging mm/damon/core.c
>     [detached HEAD ecd04159c5f3] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
>      Date: Mon Jun 24 10:58:14 2024 -0700
>      1 file changed, 19 insertions(+), 2 deletions(-)

Try building it:

  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  CC      mm/damon/core.o
In file included from ./include/linux/kernel.h:26,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/preempt.h:6,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from ./include/linux/damon.h:11,
                 from mm/damon/core.c:10:
mm/damon/core.c: In function ‘kdamond_merge_regions’:
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro ‘__careful_cmp’
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
mm/damon/core.c:946:29: note: in expansion of macro ‘max’
  946 |                 threshold = max(1, threshold * 2);
      |                             ^~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:250: mm/damon/core.o] Error 1
make[2]: *** [scripts/Makefile.build:503: mm/damon] Error 2
make[1]: *** [scripts/Makefile.build:503: mm] Error 2




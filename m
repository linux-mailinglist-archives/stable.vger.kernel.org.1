Return-Path: <stable+bounces-204366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C065CEC2C1
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42931303136F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D51925BC;
	Wed, 31 Dec 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwgTUA9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CE27E1C5;
	Wed, 31 Dec 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194785; cv=none; b=NOqXwnqSy2YQAD+3zOsrFcMUYie5NYa0zmu13u/y0h8s0xW1S3+Fxd7COGGhVgCm0d+VaBtXYiy1wNqjTTN04993LZPgMiolkPYFdDgvD4WeUaY6RWQ5M/BgO8Kk8a2lvT58vIeqbVVzxL6lEG1ru7lWD5DOAnGmrAYicBKeYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194785; c=relaxed/simple;
	bh=JzGS4bo9AEHd9uEqNevElOW0FoRxhHNAv/dVhm19Igs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Guft8f0OyVgeuLYyhqAdIYTnNCA8UIc/Kku5NX4Uj3J8ngAn53wQjGy5l4UB0Pd3vRJObU9sRDovDj22yuiJtf9mm8aLHyLVtXfouvHRh9RFxo16izxXo0PzIQtNxY3oVDuFS+RUofGSop3bKL33J/FW9fpjBy2sPXVg5v/MKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwgTUA9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F05C113D0;
	Wed, 31 Dec 2025 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767194784;
	bh=JzGS4bo9AEHd9uEqNevElOW0FoRxhHNAv/dVhm19Igs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwgTUA9FYr4mYFVd6xyDozLB83BwIlj0A2rTYaJ9gB54HsYl57jEDc6egzI9cVjpY
	 RyaNoTSgGN/aP7V9jLpssR05usdrRRfpewVartIW90tZjzWyJaDslu31/5KniwXvlB
	 AXgpMZucEcvocRrAYwf/vC/CDGcjElF4G8de59z8r3WHlQ6Y6/Xh7A2S2mM5ETToAL
	 aU2Qu6JFxLPe13JJ0LyUNKTMkQawCCJTidR8PlUaHMMJQde6NLvQUtZsTN5/steuzx
	 edV2eglkhXjK4m4x3aoGcXimj/V5ydiYEhmKD9uR00PLSx8LPTgbdgCW8heq9J+ROK
	 lRh0IizCafiJg==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Wed, 31 Dec 2025 07:26:16 -0800
Message-ID: <20251231152617.82118-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6F5zLnBF=v7G5k1WdDZZmkBAK94ixzLiPF0W53wdtyeA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 14:27:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > [...]
> > > > > I will send a new version of this fix soon.
> > > >
> > > > So far, I got two fixup ideas.
> > > >
> > > > The first one is keeping the current code as is, and additionally modifying
> > > > kdamond_call() to protect all call_control object accesses under
> > > > ctx->call_controls_lock protection.
> > > >
> > > > The second one is reverting this patch, and doing the DAMON running status
> > > > check before adding the damon_call_control object, but releasing the
> > > > kdamond_lock after the object insertion is done.
> > > >
> > > > I'm in favor of the second one at the moment, as it seems more simple.
> > >
> > > I don't really like both approaches because those implicitly add locking rules.
> > > If the first approach is taken, damon_call() callers should aware they should
> > > not register callback functions that can hold call_controls_lock.  If the
> > > second approach is taken, we should avoid holding kdamond_lock while holding
> > > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > > but I want to avoid that if possible.
> > >
> > > The third idea I just got is, keeping this patch as is, and moving the final
> > > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > > removes the race condition between the final kdamond_call() and
> > > damon_call_handle_inactive_ctx(), without introducing new locking rules.
> >
> > I just posted the v2 [1] with the third idea.
> >
> > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> 
> I generally agree with what you've said so far.  However, it's inefficient
> to continue executing damon_call_handle_inactive_ctx() while kdamond is
> "off".  There's no need to add a new damon_call_handle_inactive_ctx()
> function.

As I mentioned before on other threads with you, we care not only efficiency
but also maintainability of the code.  The inefficiency you are saying about
happens only in corner cases because damon_call() is not usually called while
kdamond is off.  So the gain of making this efficient is not that big.

Meanwhile, to avoid this, as I mentioned on the previous reply to the first and
the second idea of the fix, we need to add locking rule, which makes the code
bit difficult to maintain.

I therefore think the v2 is a good tradeoff.

> As shown below, it's better to call list_add only when kdamond
> is "on" (true), and then use the existing code to end with
> kdamond_call(ctx, true) when kdamond is "off."
> 
> +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> +
>  /**
>   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
>   * @ctx:       DAMON context to call the function for.
> @@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         control->canceled = false;
>         INIT_LIST_HEAD(&control->list);
> 
> -       if (damon_is_running(ctx)) {
> -               mutex_lock(&ctx->call_controls_lock);
> +       mutex_lock(&ctx->call_controls_lock);
> +       if (ctx->kdamond) {

This is wrong.  You shouldn't access ctx->kdamond without holding
ctx->kdamond_lock.  Please read the comment about kdamond_lock field on damon.h
file.

>                 list_add_tail(&control->list, &ctx->call_controls);
> -               mutex_unlock(&ctx->call_controls_lock);
>         } else {
> -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> +               mutex_unlock(&ctx->call_controls_lock);
> +               if (!list_empty_careful(&ctx->call_controls))
> +                       kdamond_call(ctx, true);
>                 return -EINVAL;
>         }
> +       mutex_unlock(&ctx->call_controls_lock);
> +
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);


Thanks,
SJ

[...]


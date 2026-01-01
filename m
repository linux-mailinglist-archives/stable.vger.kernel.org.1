Return-Path: <stable+bounces-204404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0249CECBF6
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 02:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A1C300DA79
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489727F724;
	Thu,  1 Jan 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP+R3BPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870E1A3029;
	Thu,  1 Jan 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767231675; cv=none; b=qXpcCwmEkNug5eCVi44B5Nh0X8ggqMW19QaLzYik+KnC91IcwudbEDh2HpVqA+No4w3U9LIXPAzIlNWuiA0FVj10icfZ/CK4ja3LCyfK5FiRXg21vbDY7K6L86bMXp74hCiW/Dh9lPg+EwSgNpviY+TasD8LYZWZX5I9CzZw1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767231675; c=relaxed/simple;
	bh=i+DdC/S+p6yii9OoNviXUJbL2K6hEFLW+od5/f/n/Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbHmXnB+E2MbUpniXFoco0W1cCIa5AQBfPmkDRzOVXV+wlQQIwnJoKoYeghcNmdNRcPXc/QK3ynQkYSl1W8ElsB5ydyPkC+Xg3rbTJfjGjSjtGrnJs2ZIU1V1KvZs59dSbdPl1unCvENv4ZibiZ5VpVKENeeGCkQv8bmet5CeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP+R3BPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E0AC113D0;
	Thu,  1 Jan 2026 01:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767231675;
	bh=i+DdC/S+p6yii9OoNviXUJbL2K6hEFLW+od5/f/n/Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DP+R3BPKrBXAZp35hZceNI/0P1oEljZQ0xQNN2EJcKKah58GDrhXYxp+5ugPPBMt0
	 Mi2hLM6V88EPtnQktQh1aPdrRiVtf5eWxinXGwgYUhco5O64nusbCRDJzisM28jQBP
	 4AJ23oPfDlGWg7q4XdOSGTmS0amZOVol6bRzN9Ia9CGDoWKb2LK00NWI1EV2IOmJDr
	 MDJN0zTvc+27lszYmK0TnOuTZT/jhdY1V9ELHKhIYMJzMXDlirTMy1w/HfNuMKY15X
	 sFL4MPgmVZEWf1MLsj4HuEroxGeJvjxXsG+s6c0Ch7T0/XKMvyXtO6uj7rjE9WBPy/
	 NTwAwoNrs6/Bg==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Wed, 31 Dec 2025 17:41:06 -0800
Message-ID: <20260101014107.87821-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4_unsc9u4kEDBTNxfS3rsiQi5QBTaiu3fGDcGrdryyBA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Jan 2026 09:55:56 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 1 Jan 2026 at 00:26, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 31 Dec 2025 14:27:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > >
> > > > > [...]
> > > > > > > I will send a new version of this fix soon.
> > > > > >
> > > > > > So far, I got two fixup ideas.
> > > > > >
> > > > > > The first one is keeping the current code as is, and additionally modifying
> > > > > > kdamond_call() to protect all call_control object accesses under
> > > > > > ctx->call_controls_lock protection.
> > > > > >
> > > > > > The second one is reverting this patch, and doing the DAMON running status
> > > > > > check before adding the damon_call_control object, but releasing the
> > > > > > kdamond_lock after the object insertion is done.
> > > > > >
> > > > > > I'm in favor of the second one at the moment, as it seems more simple.
> > > > >
> > > > > I don't really like both approaches because those implicitly add locking rules.
> > > > > If the first approach is taken, damon_call() callers should aware they should
> > > > > not register callback functions that can hold call_controls_lock.  If the
> > > > > second approach is taken, we should avoid holding kdamond_lock while holding
> > > > > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > > > > but I want to avoid that if possible.
> > > > >
> > > > > The third idea I just got is, keeping this patch as is, and moving the final
> > > > > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > > > > removes the race condition between the final kdamond_call() and
> > > > > damon_call_handle_inactive_ctx(), without introducing new locking rules.
> > > >
> > > > I just posted the v2 [1] with the third idea.
> > > >
> > > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > >
> > > I generally agree with what you've said so far.  However, it's inefficient
> > > to continue executing damon_call_handle_inactive_ctx() while kdamond is
> > > "off".  There's no need to add a new damon_call_handle_inactive_ctx()
> > > function.
> >
> > As I mentioned before on other threads with you, we care not only efficiency
> > but also maintainability of the code.  The inefficiency you are saying about
> > happens only in corner cases because damon_call() is not usually called while
> > kdamond is off.  So the gain of making this efficient is not that big.
> 
> The overhead isn't that high, but I think it's better to keep things
> simple.
> I think it's better to use list_add_tail() when kdamond is "on".
> 
> >
> > Meanwhile, to avoid this, as I mentioned on the previous reply to the first and
> > the second idea of the fix, we need to add locking rule, which makes the code
> > bit difficult to maintain.
> 
> I think it's better to solve it with the existing kdamond_call(ctx,
> cancel=true) rather than adding the damon_call_handle_inactive_ctx().

On my previous reply, I was saying I think your suggested approach is not
making it simple but only more complicated in the next paragraph.  And I was
again further explaining why I think so.  More specifically, the added locking
rule, that I previously explained with the third fix idea.

Your above reply is saying it is "better", without any reason.  It even not
addressing my concern that I explained more than once.  As a result, I again
fail at finding why you keep repeating the argument.

So, let me again ask you.  Please explain.

> 
> >
> > I therefore think the v2 is a good tradeoff.
> >
> > > As shown below, it's better to call list_add only when kdamond
> > > is "on" (true), and then use the existing code to end with
> > > kdamond_call(ctx, true) when kdamond is "off."
> > >
> > > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > > +
> > >  /**
> > >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> > >   * @ctx:       DAMON context to call the function for.
> > > @@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
> > > damon_call_control *control)
> > >         control->canceled = false;
> > >         INIT_LIST_HEAD(&control->list);
> > >
> > > -       if (damon_is_running(ctx)) {
> > > -               mutex_lock(&ctx->call_controls_lock);
> > > +       mutex_lock(&ctx->call_controls_lock);
> > > +       if (ctx->kdamond) {
> >
> > This is wrong.  You shouldn't access ctx->kdamond without holding
> > ctx->kdamond_lock.  Please read the comment about kdamond_lock field on damon.h
> > file.
> 
> That's right, I misjudged.
> I've reorganized the code below.

Your reply is not explaining how the reorganized code is solving it.  Let me
ask you again.  Please explain.

> 
> >
> > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > -               mutex_unlock(&ctx->call_controls_lock);
> > >         } else {
> > > -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > > +               mutex_unlock(&ctx->call_controls_lock);
> > > +               if (!list_empty_careful(&ctx->call_controls))
> > > +                       kdamond_call(ctx, true);
> > >                 return -EINVAL;
> > >         }
> > > +       mutex_unlock(&ctx->call_controls_lock);
> > > +
> > >         if (control->repeat)
> > >                 return 0;
> > >         wait_for_completion(&control->completion);
> >
> 
> +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> +
>  /**
>   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
>   * @ctx:       DAMON context to call the function for.
> @@ -1457,11 +1459,15 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         control->canceled = false;
>         INIT_LIST_HEAD(&control->list);
> 
> -       mutex_lock(&ctx->call_controls_lock);
> -       list_add_tail(&control->list, &ctx->call_controls);
> -       mutex_unlock(&ctx->call_controls_lock);
> -       if (!damon_is_running(ctx))
> +       if (damon_is_running(ctx)) {
> +               mutex_lock(&ctx->call_controls_lock);
> +               list_add_tail(&control->list, &ctx->call_controls);
> +               mutex_unlock(&ctx->call_controls_lock);
> +       } else {
> +               if (!list_empty_careful(&ctx->call_controls))
> +                       kdamond_call(ctx, true);
>                 return -EINVAL;
> +       }
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);

I think my previous concern that raised to your two previous approach [1,2] is
again samely applied to the above diff.  And now you are suggesting a similar
approach here.  Please explain and answer all questions before you move on, or
explain why your new apprach is different from your previous one and how it
addresses raised concerns..

[1] https://lore.kernel.org/20251225194959.937-1-sj@kernel.org
[2] https://lore.kernel.org/20251226184111.254674-1-sj@kernel.org
[3] https://lore.kernel.org/20251229151440.78818-1-sj@kernel.org


Thanks,
SJ

[...]


Return-Path: <stable+bounces-204409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68ECECC64
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 03:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33384300252F
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 02:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD9257827;
	Thu,  1 Jan 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYEcsTYY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4A24E4AF
	for <stable@vger.kernel.org>; Thu,  1 Jan 2026 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767236316; cv=none; b=OfMi/QTIOitTa/GvKIQRfyRhOFPytrws9R5umknXHdK8qEQeKg9yYLyBbQMI8apbPJT7ySklawYzZTiYZGLmQJLjBc5KqagOejlavo2Hg9MihgVm8sj07CZwYF5DCnNeEhD7Scevbj87cLkktBjjNI/Keoj5wptCZK8rx5rEQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767236316; c=relaxed/simple;
	bh=m75hsT8RWIPq7UtpZnmnezUHE9721/YA2vWe47dXprc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elxMilyCuuXIbo00Ds7MTU8v14w+A3vKpa600UtvT5eTM6qEOouKtdp7im/I9HaeikIVefALBSCmOjuYV6iJgJUEb56a+8HV9tMNmvYeJFxYW2k8YlnWCUOO/VAx34xB19GOsbzbYDVD7Fq3FLqaSrQ75RB9oPs91jf+Xv8YvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYEcsTYY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78d6a3c3b77so117849567b3.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 18:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767236313; x=1767841113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qPVyC1carZwgVVH75m9TaECbDsPsKfFm26AaARR8o=;
        b=bYEcsTYYlQb0WIc6ou1eMQws+SXz3MKbYNFjjbeQD/x/4EXQb2xcpeuKAkuDRX84XN
         7S4hgYxEhs4eeNDhFSvj2CQXuJENTeyQvQvLXyZfiCOQx/l4nWTR5tOrEOLFDfjzJkVz
         929Rd7mGpnvv2WIEy9NlIrJd/34rnqLL0Lf7Ujf3GAqlThN5hcPTfgXvMhjn4EENJqR8
         2IxNpBdtAkEjh5CG+qaapemgUg4Z4sUbRGF1SEqBErwAEcnxIidbnC+CFemqGqeVZFOo
         3fv9AL/x9UsbugDIRjO5xqsFpd624CtgMwT+6dM1JZpTRLQnRkrcG8qKZnjqI98cMAUj
         jrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767236313; x=1767841113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9qPVyC1carZwgVVH75m9TaECbDsPsKfFm26AaARR8o=;
        b=eO+Ix0Q7qg2fAZMIl1KnPb/gluIfVT5IMT2MyyHmWEwZ59/EidIOZBmMrlHPCU+wt+
         aTpAvskK45NIhp0Ltr8jDzH1g50ikb9H7jyfAyD35lqjdf66yOuqhBp9ufFaYPIum+ck
         4KslDsVqV4Mp2hLSxNMj3rYcO4lhxbYDFAym72GYjEoD6HF9OsYceTe+ya09TNhjFEMo
         4E+uBK5VLFdHSpat1Af62FVKK7N0Tx4W9rkANQhVjalPbxDANJzJyUhsVTa9OaJ74EWf
         l0UziR2IqZvB3Sh7HYNybE8wwRDTvV9MQRVdpCi7qi7Rb9YzaX9w59IsGNVho9Icp1fC
         tdng==
X-Forwarded-Encrypted: i=1; AJvYcCV+Nk1H/9SdANeTU37TxvjBMHOBHo5eN+7iCW0aE6E4WCOPaj/mdRm8HQ3aRc1NNAkbHFskDXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFiSg+ngJoQPRuV12ukP9cVjuzw5/04/XqUUHZADn2aeOhe6F
	tJ6/1h2RFysBmC/qqx34ouwWGxF4xyFfx1kw7qi1PVxWgUbZjXLUcyznXRG807bbrjpuZ3jpB24
	AryecKKj1y0ztkYhwXaBWcr4ai8hjWLs=
X-Gm-Gg: AY/fxX6hz5pVS3XamjhM0+q/lTnfZmYqPzT7kJVB+6+TDcf8B5d8+K6+ClhLbZMQ/7U
	xMRT3JWKcO+tUT+LWt238rBTDnnnYW2VyWBrPxxw5vfbspAasaHyvnM2rWuZNaNUxz9s1RlXaia
	fhlT8ISEOODA/vpXcMQ2MCZKiPdL3ynHCJG+Ozz6rWyLuQiymrZ3G95VRFpkpjELCBfvd8KHWZw
	yw5oJnw7dpAWy82kZgA94GOUSQIttfAj5JJcqJghTQ0qVcRBcxI63Xft/GqFGBG0R0GRv/T
X-Google-Smtp-Source: AGHT+IEykEkaPCHD0X0I6L0ptnL+oTDQcPJEkuriAyEDUp0ZrlA4011Fv2iFVPiLKJUYRQYPeI0lIJC47Kv+zgF/GSs=
X-Received: by 2002:a53:d009:0:b0:63f:b2b3:8c2d with SMTP id
 956f58d0204a3-64663252770mr33509496d50.17.1767236313054; Wed, 31 Dec 2025
 18:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHOvCC4_unsc9u4kEDBTNxfS3rsiQi5QBTaiu3fGDcGrdryyBA@mail.gmail.com>
 <20260101014107.87821-1-sj@kernel.org>
In-Reply-To: <20260101014107.87821-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 11:58:21 +0900
X-Gm-Features: AQt7F2qk60Y9SeYysM-zJgRnvUfmjuZOg6-DbWG6PFvxlPWAHpnRRFpuE3nJJkI
Message-ID: <CAHOvCC6UEaWx=Jj+x3Mfo5HAGL+6yAnEvJCrkiLe0M2cL+3wsQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "# 6 . 14 . x" <stable@vger.kernel.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 10:41, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 1 Jan 2026 09:55:56 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 1 Jan 2026 at 00:26, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 31 Dec 2025 14:27:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > >
> > > > > > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > > >
> > > > > > [...]
> > > > > > > > I will send a new version of this fix soon.
> > > > > > >
> > > > > > > So far, I got two fixup ideas.
> > > > > > >
> > > > > > > The first one is keeping the current code as is, and additionally modifying
> > > > > > > kdamond_call() to protect all call_control object accesses under
> > > > > > > ctx->call_controls_lock protection.
> > > > > > >
> > > > > > > The second one is reverting this patch, and doing the DAMON running status
> > > > > > > check before adding the damon_call_control object, but releasing the
> > > > > > > kdamond_lock after the object insertion is done.
> > > > > > >
> > > > > > > I'm in favor of the second one at the moment, as it seems more simple.
> > > > > >
> > > > > > I don't really like both approaches because those implicitly add locking rules.
> > > > > > If the first approach is taken, damon_call() callers should aware they should
> > > > > > not register callback functions that can hold call_controls_lock.  If the
> > > > > > second approach is taken, we should avoid holding kdamond_lock while holding
> > > > > > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > > > > > but I want to avoid that if possible.
> > > > > >
> > > > > > The third idea I just got is, keeping this patch as is, and moving the final
> > > > > > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > > > > > removes the race condition between the final kdamond_call() and
> > > > > > damon_call_handle_inactive_ctx(), without introducing new locking rules.
> > > > >
> > > > > I just posted the v2 [1] with the third idea.
> > > > >
> > > > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > > >
> > > > I generally agree with what you've said so far.  However, it's inefficient
> > > > to continue executing damon_call_handle_inactive_ctx() while kdamond is
> > > > "off".  There's no need to add a new damon_call_handle_inactive_ctx()
> > > > function.
> > >
> > > As I mentioned before on other threads with you, we care not only efficiency
> > > but also maintainability of the code.  The inefficiency you are saying about
> > > happens only in corner cases because damon_call() is not usually called while
> > > kdamond is off.  So the gain of making this efficient is not that big.
> >
> > The overhead isn't that high, but I think it's better to keep things
> > simple.
> > I think it's better to use list_add_tail() when kdamond is "on".
> >
> > >
> > > Meanwhile, to avoid this, as I mentioned on the previous reply to the first and
> > > the second idea of the fix, we need to add locking rule, which makes the code
> > > bit difficult to maintain.
> >
> > I think it's better to solve it with the existing kdamond_call(ctx,
> > cancel=true) rather than adding the damon_call_handle_inactive_ctx().
>
> On my previous reply, I was saying I think your suggested approach is not
> making it simple but only more complicated in the next paragraph.  And I was
> again further explaining why I think so.  More specifically, the added locking
> rule, that I previously explained with the third fix idea.
>
> Your above reply is saying it is "better", without any reason.  It even not
> addressing my concern that I explained more than once.  As a result, I again
> fail at finding why you keep repeating the argument.
>
> So, let me again ask you.  Please explain.

I've already answered your question.
Please understand my lack of expressiveness.

>
> >
> > >
> > > I therefore think the v2 is a good tradeoff.
> > >
> > > > As shown below, it's better to call list_add only when kdamond
> > > > is "on" (true), and then use the existing code to end with
> > > > kdamond_call(ctx, true) when kdamond is "off."
> > > >
> > > > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > > > +
> > > >  /**
> > > >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> > > >   * @ctx:       DAMON context to call the function for.
> > > > @@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         control->canceled = false;
> > > >         INIT_LIST_HEAD(&control->list);
> > > >
> > > > -       if (damon_is_running(ctx)) {
> > > > -               mutex_lock(&ctx->call_controls_lock);
> > > > +       mutex_lock(&ctx->call_controls_lock);
> > > > +       if (ctx->kdamond) {
> > >
> > > This is wrong.  You shouldn't access ctx->kdamond without holding
> > > ctx->kdamond_lock.  Please read the comment about kdamond_lock field on damon.h
> > > file.
> >
> > That's right, I misjudged.
> > I've reorganized the code below.
>
> Your reply is not explaining how the reorganized code is solving it.  Let me
> ask you again.  Please explain.

I will explain this in the code I have summarized below.

>
> >
> > >
> > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > >         } else {
> > > > -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > > > +               mutex_unlock(&ctx->call_controls_lock);
> > > > +               if (!list_empty_careful(&ctx->call_controls))
> > > > +                       kdamond_call(ctx, true);
> > > >                 return -EINVAL;
> > > >         }
> > > > +       mutex_unlock(&ctx->call_controls_lock);
> > > > +
> > > >         if (control->repeat)
> > > >                 return 0;
> > > >         wait_for_completion(&control->completion);
> > >
> >
> > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > +
> >  /**
> >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> >   * @ctx:       DAMON context to call the function for.
> > @@ -1457,11 +1459,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         control->canceled = false;
> >         INIT_LIST_HEAD(&control->list);
> >
> > -       mutex_lock(&ctx->call_controls_lock);
> > -       list_add_tail(&control->list, &ctx->call_controls);
> > -       mutex_unlock(&ctx->call_controls_lock);
> > -       if (!damon_is_running(ctx))
> > +       if (damon_is_running(ctx)) {
> > +               mutex_lock(&ctx->call_controls_lock);
> > +               list_add_tail(&control->list, &ctx->call_controls);
> > +               mutex_unlock(&ctx->call_controls_lock);
> > +       } else {
> > +               if (!list_empty_careful(&ctx->call_controls))
> > +                       kdamond_call(ctx, true);
> >                 return -EINVAL;
> > +       }
> >         if (control->repeat)
> >                 return 0;
> >         wait_for_completion(&control->completion);
>
> I think my previous concern that raised to your two previous approach [1,2] is
> again samely applied to the above diff.  And now you are suggesting a similar
> approach here.  Please explain and answer all questions before you move on, or
> explain why your new apprach is different from your previous one and how it
> addresses raised concerns..

The code above applies mutex and the locking method is the same.
The difference is that control->list does list_add_tail() in the "on" state in
damon_is_running(ctx).
Another difference is that when damon_is_running(ctx) is false("off"),
the existing call_controls list is cleared with kdamond_call(ctx, cancel=true).

Regarding spin_lock,
I'm sure you're familiar with spin_lock, It can apply like this:

spin_lock(&ctx->call_controls_lock);
list_add_tail(&control->list, &ctx->call_controls);
spin_unlock(&ctx->call_controls_lock);

I have expressed my opinion sufficiently,
and I believe you will make a better judgment than I.

Thanks,
JaeJoon

>
> [1] https://lore.kernel.org/20251225194959.937-1-sj@kernel.org
> [2] https://lore.kernel.org/20251226184111.254674-1-sj@kernel.org
> [3] https://lore.kernel.org/20251229151440.78818-1-sj@kernel.org
>
>
> Thanks,
> SJ
>
> [...]


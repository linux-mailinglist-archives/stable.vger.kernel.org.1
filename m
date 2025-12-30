Return-Path: <stable+bounces-204175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33DCE895C
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66E8301A1A6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A070F2DC774;
	Tue, 30 Dec 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZg1G1wE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E17222599;
	Tue, 30 Dec 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767062492; cv=none; b=PFC/kRznGIMXlN7QgY2YQkN0WxJN7kaIdxQX9cCkMi3NsLaU6ZL+1gjfwvoeQlWEy+zTXbS0r8ys37Un7hiF4UkQfCw3Eg0+OvpYVdxZ2pATcG4720qRd2OtjNielIzHLheC8o7HrFwjqUb4WmY4otsNlvJj97OGtJYcnuISQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767062492; c=relaxed/simple;
	bh=E7R2JNPP0Sm+zHEC5831SvjLWutIcdgzGdYdaqNbxA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfGEbL8OXnXvy5gXeeZhowwmXjAxMi5fEQxXZ0EGxBR+APaUFVl3V6XVeAEWRHlLqhPS5km2VKzspuOJ8H/3MYmtyRFwk1Oq3rzrG1pe087GwijclV70lwCHKxrXIKijXm6GphGpmA9AWVKPJ5DsqBnl3Ao3T1U0XZQv8FWjgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZg1G1wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264AC4CEF7;
	Tue, 30 Dec 2025 02:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767062491;
	bh=E7R2JNPP0Sm+zHEC5831SvjLWutIcdgzGdYdaqNbxA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZg1G1wEqOMDnaRYx1lMVafjCwInzBKXz9x5AHA/6WN8a275yIh/MWHlGzC+/HzaP
	 QmTBKqR1TQS/seMWat8mfljG/YAQw1xKaiwVI0Rhc1DJot+/3GmP/g5tlY6yEPIEl1
	 8H08P3ySMRGtLe48DU8gBZIy4XXLweRDsp42xmcerGQKNIydDyrPkC7vaAMIbU8v7s
	 6KwMuLC39Soj4mjmqyr7Q0bcYkf4vPnkimWc/JCrpkKZcdeNwlBHk1nzflrk1Am5Gx
	 LSnrsru6IBazzZOY8IGlQZeSRQc4ZJLL8YTiHbVnZbIUlg9a5IlXcNFav6hSddu//i
	 4xXZ0eMHZP1iA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Mon, 29 Dec 2025 18:41:28 -0800
Message-ID: <20251230024129.47591-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230014532.47563-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > If damon_call() is executed against a DAMON context that is not running,
> > the function returns error while keeping the damon_call_control object
> > linked to the context's call_controls list.  Let's suppose the object is
> > deallocated after the damon_call(), and yet another damon_call() is
> > executed against the same context.  The function tries to add the new
> > damon_call_control object to the call_controls list, which still has the
> > pointer to the previous damon_call_control object, which is deallocated.
> > As a result, use-after-free happens.
> > 
> > This can actually be triggered using the DAMON sysfs interface.  It is
> > not easily exploitable since it requires the sysfs write permission and
> > making a definitely weird file writes, though.  Please refer to the
> > report for more details about the issue reproduction steps.
> > 
> > Fix the issue by making damon_call() to cleanup the damon_call_control
> > object before returning the error.
> > 
> > Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
> > Closes: https://lore.kernel.org/20251224094401.20384-1-rgbi3307@gmail.com
> > Fixes: 42b7491af14c ("mm/damon/core: introduce damon_call()")

The above Fixes: tag is wrong.  At the moment of the commit, only single
damon_call() request was allowed.  Hence only a pointer instead of the linked
list was used.  In the problematic scenario, repeated damon_call() would simply
return -EBUSY.

The correct Fixes: should be,

Fixes: 004ded6bee11 ("mm/damon: accept parallel damon_call() requests")
Cc: <stable@vger.kernel.org> # 6.17.x

> > Cc: <stable@vger.kernel.org> # 6.14.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2d3e8006db50..65482a0ce20b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1442,6 +1442,35 @@ bool damon_is_running(struct damon_ctx *ctx)
> >  	return running;
> >  }
> >  
> > +/*
> > + * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
> > + *				      an inactive context.
> > + * @ctx:	The inactive DAMON context.
> > + * @control:	Control variable of the call request.
> > + *
> > + * This function is called in a case that @control is added to @ctx but @ctx is
> > + * not running (inactive).  See if @ctx handled @control or not, and cleanup
> > + * @control if it was not handled.
> > + *
> > + * Returns 0 if @control was handled by @ctx, negative error code otherwise.
> > + */
> > +static int damon_call_handle_inactive_ctx(
> > +		struct damon_ctx *ctx, struct damon_call_control *control)
> > +{
> > +	struct damon_call_control *c;
> > +
> > +	mutex_lock(&ctx->call_controls_lock);
> > +	list_for_each_entry(c, &ctx->call_controls, list) {
> > +		if (c == control) {
> > +			list_del(&control->list);
> > +			mutex_unlock(&ctx->call_controls_lock);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	mutex_unlock(&ctx->call_controls_lock);
> > +	return 0;
> > +}
> > +
> >  /**
> >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> >   * @ctx:	DAMON context to call the function for.
> > @@ -1472,7 +1501,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  	list_add_tail(&control->list, &ctx->call_controls);
> >  	mutex_unlock(&ctx->call_controls_lock);
> >  	if (!damon_is_running(ctx))
> > -		return -EINVAL;
> > +		return damon_call_handle_inactive_ctx(ctx, control);
> >  	if (control->repeat)
> >  		return 0;
> >  	wait_for_completion(&control->completion);
> 
> TL; DR: This patch introduces another UAF bug under a race condition.  I will
> send a new version of the fix that solves the another issue.  Andrew, could you
> please remove this from mm tree for now?
> 
> kdamond_fn() resets ->kdamond, which is read by damon_is_running(), and then
> make the final kdamond_call() for cancelling any remaining damon_call()
> requests.  Hence, if the above damon_is_running() was invoked between the
> ->kdamond reset and the final kdamond_call() invocation,
> damon_call_handle_inactive_ctx() and the final kdamond_call() could
> concurrently run.
> 
> kdamond_call() safely get a pointer to a damon_call_control object in
> ctx->call_controls, and then access it without a lock.  Only after that, it
> removes the object from the list while holding the lock.  The intermediate
> lock-less access is safe because kdamond_call() is the only code that removes
> items from ctx->call_controls.  But this patch makes it no more safe, because
> this patch is introducing another ctx->call_controls item removing code, namely
> damon_call_handle_inactive_ctx().
> 
> To see this in details, let's suppose kdamond_call() got the pointer, and
> released the call_controls_lock.  After that, damon_call_handle_inactive_ctx()
> shows the object is still in the ctx->call_controls, and removes it from the
> list.  The damon_call() caller further deallocates the object.  Then, continued
> execution of kdamond_call() accesses the already deallocated object.
> 
> I will send a new version of this fix soon.

So far, I got two fixup ideas.

The first one is keeping the current code as is, and additionally modifying
kdamond_call() to protect all call_control object accesses under
ctx->call_controls_lock protection.

The second one is reverting this patch, and doing the DAMON running status
check before adding the damon_call_control object, but releasing the
kdamond_lock after the object insertion is done.

I'm in favor of the second one at the moment, as it seems more simple.


Thanks,
SJ


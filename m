Return-Path: <stable+bounces-230469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH3HJt47xWn/8AQAu9opvQ
	(envelope-from <stable+bounces-230469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:59:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9D3366E8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 375143068D22
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0F306B31;
	Thu, 26 Mar 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paK2t53d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62C231A23;
	Thu, 26 Mar 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533113; cv=none; b=m4dA3a8b6jsZc5S5koajUGlSS16A/GlAuBCLXspVIm6W+UbRe6c7DlIWf2LbDAc9e1ewfHNKLxQzATu+n6uuMtIfudV4QOaXnTmzgKXgXpF3NsN3cA9DdroAd6BzU2jEA9BcGwsJF2/BxJ84s74gQ+6ioBW9aKcmXVsTPxX95SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533113; c=relaxed/simple;
	bh=1KHahd11zjguvDsCZzGR0L8yXI0OCjg5sN+45sTqLVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGXGK7EOaEF5cX7cmCL77OePQykEEAoJ7kDD2HmXct3KvzZW1y4whdJXJhnW83lLF2G+RKEt3Fhs0EDh00RW6PqHn41spBo6MO0svIJUUeINdo7I/LoG7p7REaA6y2cKl1fScBkEFd1vmpqCLjFKsm6y6UTNu6yafbrqWWJgEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paK2t53d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5048DC116C6;
	Thu, 26 Mar 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533113;
	bh=1KHahd11zjguvDsCZzGR0L8yXI0OCjg5sN+45sTqLVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paK2t53dHROwCP0aPc3ZYmUcs/U0tmfJ5YGPVFG42cdFYBIuHVx0mT3yOll/7NTCl
	 MjG5HF3q1q1tIv5RyKQYUOwQvf4xZ9e2dg2B4ZO2pAshgEj9uTJlgN1JT4R+dBuP5u
	 Sj6ldaiRhaVHOEXK/Ki9TdNQD489wTOsUaTR91xmqwbzgFzsQwNldWXWbk9Kh7WrOx
	 /Rm+qvVUEaZZkTUkjfJA9urR4N6g/HEtaMeeqOd84UxM24b7MKV1dSQi75iCZHCogw
	 pvYXuRUOuC0b9iYEHXfR9+c9BPMqLx3HswttmWgOMHliLkXZJ9w8sI32ZWNXQYCBwY
	 VV9TGQOP5pygQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 06:51:46 -0700
Message-ID: <20260326135146.90670-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326134330.90521-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230469-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22A9D3366E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 06:43:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260326062347.88569-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit b886bf00a72b1462f29533c91c431cd2ba3fa3a6
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
> 
> This commit introduces a call_controls_obsolete flag to protect damon_call()
> from racing with the kdamond termination sequence. This replaces the previous
> after-registration damon_is_running() check.
> 
> Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b8..a2b553e2c5a81 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1629,10 +1600,12 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  	INIT_LIST_HEAD(&control->list);
> >  
> >  	mutex_lock(&ctx->call_controls_lock);
> > +	if (ctx->call_controls_obsolete) {
> > +		mutex_unlock(&ctx->call_controls_lock);
> > +		return -ECANCELED;
> > +	}
> >  	list_add_tail(&control->list, &ctx->call_controls);
> >  	mutex_unlock(&ctx->call_controls_lock);
> > -	if (!damon_is_running(ctx))
> > -		return damon_call_handle_inactive_ctx(ctx, control);
> 
> Does this removal cause an indefinite wait if damon_call() is invoked on an
> unstarted context?
> 
> For a newly allocated damon_ctx, call_controls_obsolete is zero-initialized
> to false. Without the damon_is_running() check, if a caller invokes
> damon_call() before damon_start(), it appears the request will be queued and
> block on wait_for_completion() indefinitely since no kdamond thread is
> running to handle or cancel it.

Yes.  But it is clearly wrong usage of this function.  I will add a comment
clarifying this, e.g., "this function shouldn't be called for unstarted DAMON
context.  In the case, it could be indefinitely sleep."

> 
> >  	if (control->repeat)
> >  		return 0;
> >  	wait_for_completion(&control->completion);
> [ ... ]
> > @@ -3062,6 +3038,9 @@ static int kdamond_fn(void *data)
> >  	damon_destroy_targets(ctx);
> >  
> >  	kfree(ctx->regions_score_histogram);
> > +	mutex_lock(&ctx->call_controls_lock);
> > +	ctx->call_controls_obsolete = true;
> > +	mutex_unlock(&ctx->call_controls_lock);
> >  	kdamond_call(ctx, true);
> >  	damos_walk_cancel(ctx);
> 
> Can this sequence also cause a spurious -ECANCELED failure when a context is
> restarted?
> 
> When restarting a context, kdamond_fn() signals kdamond_started before
> calling kdamond_init_ctx():
> 
>         complete(&ctx->kdamond_started);
>         kdamond_init_ctx(ctx);
> 
> If damon_start() unblocks and immediately invokes damon_call(), couldn't it
> observe the stale call_controls_obsolete == true from the previous run and
> return -ECANCELED, since kdamond_init_ctx() has not yet reset the flag?

Good catch, I will do the call_controls_obsolete unset before the complete()
call.

> 
> Also, is damos_walk() vulnerable to the same termination race being fixed
> here for damon_call()?
> 
> In kdamond_fn(), damos_walk_cancel() processes cancellations before
> ctx->kdamond is set to NULL. If damos_walk() is called during this window,
> it checks damon_is_running() (which still returns true), sets the walk
> control, and blocks on wait_for_completion().
> 
> Since cancellations are already processed, will it wait indefinitely?

Yes.  I'm working on it for another patch.


Thanks,
SJ

[...]


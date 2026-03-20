Return-Path: <stable+bounces-227420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGgnC++7vGkd2gIAu9opvQ
	(envelope-from <stable+bounces-227420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:15:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24442D5612
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7A13011140
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832C1C84A0;
	Fri, 20 Mar 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/KLyr1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08F40DFC8;
	Fri, 20 Mar 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976556; cv=none; b=TsfrAOiCPBHKWlsxH2dadrpr5gVDl6dQIX2N8sJ5KGSsPJxBFM003wuoiIKyjjlhwPmZ6U2C/UBQ+ewmNLcZRqyNXjFtudM8dwec8gRVrqvk+EXNteUNY6RP0BZ1HPJzizhomXNmeprWoaLo7PkHZvHT6lBCOo8L5r9TmisVu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976556; c=relaxed/simple;
	bh=c5SOlNAOAR6OFkxJkGh3j24Vwi+ZKbz8x5WFx0lPK0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf59HFGcre+3aP3g9OL65emcSU+ROF+oOd68TsY4zghmu7uP+gb8FyVm374vB12zCdsV54OFPMH57eZbhd1QbUJUmOSjsYxuvF2maZF8mjNI6ZaHE6gXLNK+lLElsis1rnHNgQ6yhnoztIdWVMtVasD+4siMXGwbZiJvg7TVrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/KLyr1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD83AC19424;
	Fri, 20 Mar 2026 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773976555;
	bh=c5SOlNAOAR6OFkxJkGh3j24Vwi+ZKbz8x5WFx0lPK0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/KLyr1VFAFLErYWLwwlICfRuQ791uyq7AxLA9drqoktor4arUOIvZ+0dFn6IAk6X
	 x0PMfMpb0QCmpIc+tSY4hVXZnvU3J04/cvXBCLAa/FmPc+m1N5LyYErOaBjflkSWqT
	 GZs16IZX8F4qr4tOaopbAZp5SfOBjb+ojG/j/POLjMqxukcedrP0zQ5/1C79+z3XQP
	 e+SpOvu1j1kRpPPy4bna75Jgj+oP8MtqyE1aFcwogUTBVhoqr5N46HIr44NvvekmIy
	 mPaIh+zqNA0GW1CDFujEy0oD+Hqwu0pE6Bn9pwl1hpao1ubT6NAS5nquklapjXl91/
	 dui3NyLhk8f/w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Thu, 19 Mar 2026 20:15:53 -0700
Message-ID: <20260320031553.2479-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319194849.64b0911e2a7a6d8b1c22005a@linux-foundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227420-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email,sashiko.dev:url]
X-Rspamd-Queue-Id: B24442D5612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 19:48:49 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 19 Mar 2026 07:52:17 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > One major usage of damon_call() is online DAMON parameters update.  It
> > is done by calling damon_commit_ctx() inside the damon_call() callback
> > function.  damon_commit_ctx() can fail for two reasons: 1) invalid
> > parameters and 2) internal memory allocation failures.  In case of
> > failures, the damon_ctx that attempted to be updated (commit
> > destination) can be partially updated (or, corrupted from a
> > perspective), and therefore shouldn't be used anymore.  The function
> > only ensures the damon_ctx object can safely deallocated using
> > damon_destroy_ctx().
> > 
> > The API callers are, however, calling damon_commit_ctx() only after
> > asserting the parameters are valid, to avoid damon_commit_ctx() fails
> > due to invalid input parameters.  But it can still theoretically fail if
> > the internal memory allocation fails.  In the case, DAMON may run with
> > the partially updated damon_ctx.  This can result in unexpected
> > behaviors including even NULL pointer dereference in case of
> > damos_commit_dests() failure [1].  Such allocation failure is arguably
> > too small to fail, so the real world impact would be rare.  But, given
> > the bad consequence, this needs to be fixed.
> > 
> > Avoid such partially-committed (maybe-corrupted) damon_ctx use by saving
> > the damon_commit_ctx() failure on the damon_ctx object.  For this,
> > introduce damon_ctx->maybe_corrupted field.  damon_commit_ctx() sets it
> > when it is failed.  kdamond_call() checks if the field is set after each
> > damon_call_control->fn() is executed.  If it is set, ignore remaining
> > callback requests and return.  All kdamond_call() callers including
> > kdamond_fn() also check the maybe_corrupted field right after
> > kdamond_call() invocations.  If the field is set, break the
> > kdamond_fn() main loop so that DAMON sill doesn't use the context that
> > might be corrupted.
> 
> I guess you saw the AI review?
> 	https://sashiko.dev/#/patchset/20260319145218.86197-1-sj%40kernel.org

Yes :)  Pasting it and my reply in line below.  TL; DR: We need a fixup that
attached below.

: > --- a/mm/damon/core.c
: > +++ b/mm/damon/core.c
: > @@ -1252,6 +1252,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
: >  {
: >       int err;
: >
: > +     dst->maybe_corrupted = true;
: >       if (!is_power_of_2(src->min_region_sz))
: >               return -EINVAL;
: 
: Could this prematurely mark the context as corrupted?
: 
: If the power-of-2 validation fails, the function returns -EINVAL without
: modifying dst at all. However, because maybe_corrupted is already set to
: true, wouldn't the kdamond thread assume its state is corrupted and
: unconditionally shut down?
: 
: Should the flag be set immediately prior to the first mutating operation
: like damon_commit_schemes() instead?

Good suggestion.  But marking it as corrupted here doesn't make something
really bad.  Meanwhile, ksensKeep being aware of what function here is really
making change to the struct will make it complicated to maintain in long term.
I'd prefer keeping the code as is for the simplicity.

: 
: [ ... ]
: 
: > @@ -2678,6 +2680,8 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
: >                       complete(&control->completion);
: >               else if (control->canceled && control->dealloc_on_cancel)
: >                       kfree(control);
: > +             if (ctx->maybe_corrupted)
: > +                     break;
: >       }
: 
: Does this early break cause a deadlock during cancellation?
: 
: When damon_commit_ctx() fails, it sets ctx->maybe_corrupted = true.
: This corruption triggers an exit from the main loop in kdamond_fn() to the
: done: label, which invokes kdamond_call(ctx, true) to cancel and complete
: all remaining pending callbacks.
: 
: However, inside kdamond_call(), this loop now unconditionally checks
: if (ctx->maybe_corrupted) break; at the end of each iteration. Because
: the flag is true, won't the loop process exactly one callback and then
: break, leaving the rest of the callbacks in ctx->call_controls unprocessed?
: 
: If the worker thread then exits, wouldn't any callers waiting on
: wait_for_completion(&control->completion) for those remaining callbacks
: hang indefinitely?
: 
: Would it make sense to bypass this break condition when cancel is true?

Good catch!  Andrew, could you please add below attaching fixup?


Thanks,
SJ

[...]
=== >8 ===
From cafd5152c6d42e4153c54569b44b249e27939ad6 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Thu, 19 Mar 2026 20:09:27 -0700
Subject: [PATCH] mm/damon/core: let kdamond_call() with cancel regardless of
 maybe_corrupted

Otherwise, damon_call() callers could indefinitely wait [1].

[1] https://sashiko.dev/#/patchset/20260319145218.86197-1-sj%40kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 37454e8c9c510..3e1890d64d067 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2680,7 +2680,7 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			complete(&control->completion);
 		else if (control->canceled && control->dealloc_on_cancel)
 			kfree(control);
-		if (ctx->maybe_corrupted)
+		if (!cancel && ctx->maybe_corrupted)
 			break;
 	}
 
-- 
2.47.3



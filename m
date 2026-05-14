Return-Path: <stable+bounces-247123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OvrERpnBWoZWAIAu9opvQ
	(envelope-from <stable+bounces-247123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659053E352
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E8F3022949
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28BE372042;
	Thu, 14 May 2026 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjtxiSIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BE1E515;
	Thu, 14 May 2026 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738967; cv=none; b=MBRVv6oWPRFwUmgJID/PZPGkw+BPW29d7P/tA5/5aFovv0dZ+asoV6w57I+TH/091AUMWaS7oYgBthwTiEzhAe1xSpFWpp1n1dvvjiWabXW24DoY+yIMur7Dp2N62gqcgKcooAfv/d9J9KHad5L3OrKMCeg1+tT34PJHNJamezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738967; c=relaxed/simple;
	bh=p2XBVd76V1ydxwfAVS5opv0UC9uh2kJmZRZqxF3t94M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DunltMNmArcRC8fn0Eyya5/lVi9z7sngw4TfhFfrQb4fodheE3h8ytlW/j6K7glIY1csZr3KMl2avU0nbrAZOdPqKzhZWsIOnGF2qeZH4MGvpQtqdqze1Uo8+/NWrqnhTXrxO8qQlb9URQ0GWCpFW9OYjD1Hb4kl85rLMVQZ6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjtxiSIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA96C2BCB7;
	Thu, 14 May 2026 06:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778738967;
	bh=p2XBVd76V1ydxwfAVS5opv0UC9uh2kJmZRZqxF3t94M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjtxiSIB2+k1DcKKEoA+BGK+1dRUTvYiCjS4wS9AhKChOKbyBct3WElq2iZ63K/7d
	 yZxqEllkFoPidI7KZiZtK8HipX8HhhhRG3Ccg80Y71gFjnQd1Gx/XgtkS3kL/BkeBC
	 4Jz58AZefSwFN/4LbXAPsVM4ZxcyjiFHrA5q8B0D496X5Q0UgGJAI4h7R5S304JAHg
	 3uVPfjZ6A/TKMQgl3r5QVzOnU/M5blKa27n7a25Cf9R7S7/d9nZb8kYdbn1t89HsRr
	 F2FMubSR50TUvQ8QbnTLwk6A2Cy6OEGF7Wy1ih1daaXDOHddYZ2E+u3H2qOkykZC4o
	 2GJkAo0HFmAKw==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 23:09:18 -0700
Message-ID: <20260514060919.117041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514021838.B3997C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9659053E352
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247123-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Rspamd-Action: no action

On Thu, 14 May 2026 02:18:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] A race condition during module initialization allows userspace to trigger a use-after-free kernel panic via the `enabled` sysfs parameter.
> - [High] `damon_reclaim_apply_parameters()` incorrectly applies schemes and attributes to the global `ctx` instead of `param_ctx`, causing them to be destroyed by `damon_commit_ctx()`.
> - [Low] The patch introduces calls to undeclared functions `damon_is_running()` and `damon_kdamond_pid()`, causing a build failure.

TL; DR: Sashiko found upstream commit fed48693bdfe ("mm/damon/reclaim: use
parameter context correctly") is required for 6.12.y regardless of this patch,
but not yet picked by stable kernel maintainers.  Stable kernel maintainers,
could you please add the patch to 6.12.y?

Other Sashiko-found issues are no issue in my opinion.

Please read below if you are interested in more details.

> --
> 
> commit e5b3e77c68d72139966a3f423a04c39c6310ef66
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
> 
> This commit updates DAMON_RECLAIM to dynamically detect and use the fresh
> running status and process id for the enabled and kdamond_pid parameters.
> It avoids caching the status, which can become stale when the thread stops
> unexpectedly.
> 
> Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
> Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 65842e6854fd1..9df096218beb7 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -247,60 +238,93 @@ static int damon_reclaim_turn(bool on)
> >  {
> >  	int err;
> >  
> > -	if (!on) {
> > -		err = damon_stop(&ctx, 1);
> > -		if (!err)
> > -			kdamond_pid = -1;
> > -		return err;
> > -	}
> > +	if (!on)
> > +		return damon_stop(&ctx, 1);
> >  
> >  	err = damon_reclaim_apply_parameters();
> 
> Does damon_reclaim_apply_parameters() correctly configure the scheme?
> 
> Looking at its implementation in mm/damon/reclaim.c:
> 
>     err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
>     ...
>     err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
>     ...
>     scheme = damon_reclaim_new_scheme();
>     ...
>     damon_set_schemes(ctx, &scheme, 1);
>     ...
>     err = damon_commit_ctx(ctx, param_ctx);
> 
> It seems damon_set_attrs() and damon_set_schemes() are called on the global
> ctx rather than param_ctx.
> 
> Since param_ctx has zero schemes when damon_commit_ctx(ctx, param_ctx) is
> called, will this aggressively destroy the schemes that were just added to
> ctx, leaving DAMON_RECLAIM non-functional?

The bug is introduced by commit 11ddcfc257a3 ("mm/damon/reclaim: use
damon_commit_ctx()"), which was merged into the mainline by 6.11.  So the
broken commit is in 6.12.y.

The fix was made by commit fed48693bdfe ("mm/damon/reclaim: use parameter
context correctly") which was merged into the mainline by 6.17.  And the fix
commit has correct Fixes: tag, but somehow didn't picked by stable kernel
maintainers.

Stable kernel maintainers, could you please backport the fix commit to 6.12.y?
Let me know if any different action from my side is needed.

> 
> >  	if (err)
> >  		return err;
> >  
> > -	err = damon_start(&ctx, 1, true);
> > -	if (err)
> > -		return err;
> > -	kdamond_pid = ctx->kdamond->pid;
> > -	return 0;
> > +	return damon_start(&ctx, 1, true);
> > +}
> > +
> > +static bool damon_reclaim_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> 
> Does this code compile?
> 
> It appears that damon_is_running() was introduced in a newer kernel version.
> Because this is a cherry-pick, are we missing a prerequisite refactoring
> patch that provides this function?

I informed this and where the dependent patches can be found, on the commentary
area of the patch.

> 
> >  
> >  static int damon_reclaim_enabled_store(const char *val,
> >  		const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> > -	bool enable;
> >  	int err;
> >  
> > -	err = kstrtobool(val, &enable);
> > +	err = kstrtobool(val, &enabled);
> >  	if (err)
> >  		return err;
> >  
> > -	if (is_enabled == enable)
> > +	if (damon_reclaim_enabled() == enabled)
> >  		return 0;
> >  
> >  	/* Called before init function.  The function will handle this. */
> >  	if (!ctx)
> > -		goto set_param_out;
> > +		return 0;
> >  
> > -	err = damon_reclaim_turn(enable);
> > -	if (err)
> > -		return err;
> > +	return damon_reclaim_turn(enabled);
> > +}
> 
> Is there a race condition between module initialization and this sysfs
> parameter store?
> 
> The sysfs file for enabled is exposed to userspace by load_module() before
> damon_reclaim_init() completes. damon_reclaim_init() allocates ctx early.
> 
> If userspace writes to enabled after ctx is allocated but before
> initialization finishes, this function will start the kdamond thread.
> 
> When damon_reclaim_init() resumes, it will see enabled is true and attempt to
> start the thread again, resulting in -EBUSY.
> 
> If initialization fails and the module memory is freed, could the
> already-running kdamond thread execute unmapped memory and cause a
> use-after-free regression?

DAMON_RECLAIM is a static module.  Userspace cannot write sysfs files before
the static module initializations are finished to my understanding.  So this
kind of race cannot happen.  Please let me know if I'm wrong.

> 
> [ ... ]
> 
> > +static int damon_reclaim_kdamond_pid_load(char *buffer,
> > +		const struct kernel_param *kp)
> > +{
> > +	int kdamond_pid = -1;
> > +
> > +	if (ctx) {
> > +		kdamond_pid = damon_kdamond_pid(ctx);
> > +		if (kdamond_pid < 0)
> > +			kdamond_pid = -1;
> > +	}
> > +	return sprintf(buffer, "%d\n", kdamond_pid);
> > +}
> 
> Likewise, is damon_kdamond_pid() available in this kernel tree, or will this
> result in an implicit function declaration error?

I informed this and where the dependent patches can be found on the commentary
area of this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260513045238.194161-1-sj@kernel.org?part=1


Thanks,
SJ


Return-Path: <stable+bounces-230751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC2WJSkmx2nUTgUAu9opvQ
	(envelope-from <stable+bounces-230751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:51:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52E34CD3D
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F849303C68E
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD31B279355;
	Sat, 28 Mar 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE+0i+EK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8D258EFF;
	Sat, 28 Mar 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659110; cv=none; b=Wcs5bwcZsZN7LQaDSmTKVIYNuRK2h5lGHk0kN/x9Eh+Qv1BuXeNMR9aMZew6yCW9GUD+muRQJvmnPpJAYmol6cTWjx3TGHuytuVkL/7N6zRv6n4ybHhmgaPzi08r8mEjgjQlajc+uS/1RHxsyy4qF1ZlcXaEPSV5623QbSxQg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659110; c=relaxed/simple;
	bh=pJYyQZiMQ0KPSvyjj3o15XFMXdymXNI8R8k9OQyW7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvaUNBipWI61bcOtyOJsL8ED8AO5KDYmJDQL4RmqXUW2WnsDPdAHZq5XKcKy1+cysrEmnGo88gZVBVeezqirYXGR8PMWqaD24I+uGz7Cj7WmGv7i7EQnvfIZDtBj5m88PkrKbFv4wgVUirtBkMTPdSu4FJbif60LSfzoyZ5QZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE+0i+EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5851C19423;
	Sat, 28 Mar 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774659110;
	bh=pJYyQZiMQ0KPSvyjj3o15XFMXdymXNI8R8k9OQyW7BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EE+0i+EKbV8nAM1Rna0by0it8TnMuHnF+wWs/zCypZDeJe6H6EHXmg/TY7yhBB+J1
	 SF+3XRzpgS6g2Xp9MoYM7Qq9qKBJHYGdFL34L6idTK26zhkSNuwuPI8FWbLa2MlwtR
	 aMeQTLyXem6nTb4z+arXYuwTSx3QOEF8BxVP7++OEs+A8BXkM0JyDyhN+Pu3uvWc2D
	 16ewrDi2BIJIrN5fLwXvqzwpXRrOZ4Iudq/NuSjNKbd+Mf7GNBEKUkZYrc6CK1Fvli
	 IMohZ3miuTSyDTdnaj9mw7jaO2BUIaFcLMxQcexXoiKPnqc3Z2tQ8ZRt+L9+/pA5zO
	 pSCw5YRQqTOUQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race
Date: Fri, 27 Mar 2026 17:51:48 -0700
Message-ID: <20260328005148.7435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328004307.7244-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230751-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 3D52E34CD3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 17:43:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260327233319.3528-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 9cf54c95f0c4bda07c5dbaf4019d0d731f6c58fd
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: fix damon_call() vs kdamond_fn() exit race
> 
> This commit introduces a new call_controls_obsolete flag to prevent
> damon_call() from adding requests to a terminating kdamond context.
> It removes the after-registration DAMON context termination check.
> 
> Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..9bcda2765ac9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1629,10 +1604,12 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
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
> >  	if (control->repeat)
> >  		return 0;
> >  	wait_for_completion(&control->completion);
> 
> Can this code trigger a use-after-free on control?
> 
> This appears to be a pre-existing issue that remains unfixed. If
> kdamond_fn() is terminating, it executes kdamond_call(ctx, true). This
> function removes the request, sets it as canceled, and calls kfree(control)
> if control->dealloc_on_cancel is true.
> 
> Since ctx->call_controls_lock is dropped right before the control->repeat
> check:
> 
> CPU1 (kdamond_fn)
> kdamond_call(ctx, true)
>     list_del(&control->list);
>     kfree(control);
> 
> CPU2 (damon_call)
>     mutex_unlock(&ctx->call_controls_lock);
>     if (control->repeat)
> 
> Could kdamond_call() free control before damon_call() evaluates
> control->repeat?

No.  kdamond_call(ctx, true) is called only after call_controls_obsolete is
set, under the call_control_lock.  And damon_call() reads the
call_controls_obsolete just after acquiring the call_control_lock, and return
if it is set.

Hence CPU2 in this scenario cannot execute the mutex_unlock() part after CPU1
entered kdamond_call().

> 
> Furthermore, if memory poisoning causes the freed memory to evaluate
> control->repeat as false, would this proceed to call wait_for_completion()
> on the freed memory and cause wait queue corruption?

So this is also wrong.


Thanks,
SJ

[...]


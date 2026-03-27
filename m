Return-Path: <stable+bounces-230573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGCHLsDrxWlTDQUAu9opvQ
	(envelope-from <stable+bounces-230573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:30:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D60033E57D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE9E30CA87C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54263368940;
	Fri, 27 Mar 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTukcn8d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15000366DD5;
	Fri, 27 Mar 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774578016; cv=none; b=fGdXpWEOVuZN7wHAsWR7J/isUR3Vo7BZNmounTUVIY5pkR9qMCn0YPaXmEdjtwf6N0jMqB0QtZ0OWAXgmfVmFI6DaDxsd/Mu+8u++MLkDnpWTsiYNduGQjHKcait/IN49+xxmEIoVOfHHgUaHV3PuLIA3smxWL0NPo70ILHEPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774578016; c=relaxed/simple;
	bh=t6YKrGmnU6MgoUyeGbPCbgppVxSefPrhITRIGb7IYOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOWSY98eOOav72uvGU0S+gvLMHFyJO5nhQPyEw9CvXmPOySSSDSS7dmzHCbQi1amRTKIJkW8wnmvjL83ph1ehD3E5Saf3R4uhBsuOOL8U6uJ8L29M7rnEqpt2xS1C0ThILuR3vvkIB1attq5b2lUsIdkWpOfcJYeIFBdfg2SPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTukcn8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6FFC19423;
	Fri, 27 Mar 2026 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774578015;
	bh=t6YKrGmnU6MgoUyeGbPCbgppVxSefPrhITRIGb7IYOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTukcn8dQ36D/HHne38+LBRSK/7+gdDAwVZFKcv/OKNn8LqRyqd06O+ooPx6t1RNY
	 FpB20+Q2KTHs9H/Hmfnriw4hQfTuellJe6yJJY32tmhLorS5GW7hBTf4i37nHoEjyL
	 6CQQp9fsA8N5L4je/6umM8HvN2CfkrPi53a0iGK7dQm0qqImDBNxkJ9cwnKh13DHQI
	 PtD2mJBH78Cm926mlTEqJVyRRsqRw9AhVdXVBZm0srt2al6zotqnOatAlSL7StgDLt
	 iVAdvOLqY+MkGPcjd+VeqBiWyz8YBS9gVi31wOiituBRQEgdzIXQBCepMY2hWxBi8/
	 x6BAZuqYffsAQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 19:20:13 -0700
Message-ID: <20260327022014.66567-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327021546.66441-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-230573-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D60033E57D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 19:15:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 36b78ee39968830aca3d375219a2cfce73d0d1d0
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
> 
> This commit fixes a race condition between damon_call and the
> kdamond_fn exit path that could result in a deadlock. It introduces a
> call_controls_obsolete flag to prevent damon_call from waiting
> indefinitely for a terminating thread.
> 
> Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3062,6 +3042,9 @@ static int kdamond_fn(void *data)
> >  	damon_destroy_targets(ctx);
> >  
> >  	kfree(ctx->regions_score_histogram);
> > +	mutex_lock(&ctx->call_controls_lock);
> > +	ctx->call_controls_obsolete = true;
> > +	mutex_unlock(&ctx->call_controls_lock);
> >  	kdamond_call(ctx, true);
> >  	damos_walk_cancel(ctx);
> 
> Does damos_walk suffer from the same exit race regression that this patch
> fixes for damon_call?
> 
> In kdamond_fn, the thread termination sequence executes damos_walk_cancel
> and only later sets ctx->kdamond = NULL under the kdamond_lock.
> 
> damos_walk appears to use the same pattern as the old damon_call where it
> registers ctx->walk_control, checks damon_is_running (which verifies
> ctx->kdamond != NULL), and then unconditionally blocks on wait_for_completion.
> 
> If a user triggers a DAMOS walk in the exact window after damos_walk_cancel
> has finished but before ctx->kdamond = NULL is executed, wouldn't damos_walk
> successfully register its control and pass the damon_is_running check?
> 
> If so, it would then block indefinitely on wait_for_completion because the
> cancellation phase has already passed and the thread is exiting.
> 
> Because damos_walk is invoked via state_store with the global
> damon_sysfs_lock held, could this infinite wait block the entire DAMON sysfs
> interface for all users on the system?

Yes, and I'm working on it separately, as I also replied [1] to the previous
version.

[1] https://lore.kernel.org/20260326135146.90670-1-sj@kernel.org


Thanks,
SJ

[...]


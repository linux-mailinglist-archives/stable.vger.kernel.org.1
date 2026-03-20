Return-Path: <stable+bounces-227417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH2vHAG2vGlv2QIAu9opvQ
	(envelope-from <stable+bounces-227417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:50:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DB2D53AD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A03930AA538
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6346274670;
	Fri, 20 Mar 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BjGNWz7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7740DFC1;
	Fri, 20 Mar 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974930; cv=none; b=aQRpI0xad6TjgK9yCXsbaVWzcNnwJHzNEBZtIjBNf4y3dM8W9F5lWQVo9aJXn8cHcrLdPvWQph5C0wAKkCaXrjmH1/zpTlI92b2mU2UAezKY5ZucyjQtOJ5xD6BhYMHMTIxvrflQQZYFnN7wFGJ7JAutiH85O/GbQpr0nJZIjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974930; c=relaxed/simple;
	bh=ZwzkqrrfmnwzSwwehE9MFr/f1r47yObrEGfeUmVXDLM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ge4XhGzqVgtY9v/JPB6wiSZWPL9NVGbA8PENL2TgMAWlpAryH0bXADd6NwGHXY0rcxXgeGSg6PAQlzuvUAy3cftvfn4ib8GsA8MLSnjIgWVH5FnsyudpxqKZ7FbrYdmry61xbO11X0n52jMuAzb68BrrGHgOCLJ9JS9fCpsyr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BjGNWz7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3095FC19425;
	Fri, 20 Mar 2026 02:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773974930;
	bh=ZwzkqrrfmnwzSwwehE9MFr/f1r47yObrEGfeUmVXDLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjGNWz7FRCFlJKphV2wMLCwL/9jERXlzggS1owTY5OU7rCYTJDogUWtxO1TDi3tEO
	 LlAMxnBepVoIOzcHpUiuD3+KREjdThvJqzkb8cY4IJwYaI87qCc8EwneRXtxWcE2ki
	 6pJvMVrlcRTvbdjtmtHvfdcvfWXEMl0urNlsH2Ws=
Date: Thu, 19 Mar 2026 19:48:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 15 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed
 context
Message-Id: <20260319194849.64b0911e2a7a6d8b1c22005a@linux-foundation.org>
In-Reply-To: <20260319145218.86197-1-sj@kernel.org>
References: <20260319145218.86197-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227417-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.878];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: C68DB2D53AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 07:52:17 -0700 SeongJae Park <sj@kernel.org> wrote:

> One major usage of damon_call() is online DAMON parameters update.  It
> is done by calling damon_commit_ctx() inside the damon_call() callback
> function.  damon_commit_ctx() can fail for two reasons: 1) invalid
> parameters and 2) internal memory allocation failures.  In case of
> failures, the damon_ctx that attempted to be updated (commit
> destination) can be partially updated (or, corrupted from a
> perspective), and therefore shouldn't be used anymore.  The function
> only ensures the damon_ctx object can safely deallocated using
> damon_destroy_ctx().
> 
> The API callers are, however, calling damon_commit_ctx() only after
> asserting the parameters are valid, to avoid damon_commit_ctx() fails
> due to invalid input parameters.  But it can still theoretically fail if
> the internal memory allocation fails.  In the case, DAMON may run with
> the partially updated damon_ctx.  This can result in unexpected
> behaviors including even NULL pointer dereference in case of
> damos_commit_dests() failure [1].  Such allocation failure is arguably
> too small to fail, so the real world impact would be rare.  But, given
> the bad consequence, this needs to be fixed.
> 
> Avoid such partially-committed (maybe-corrupted) damon_ctx use by saving
> the damon_commit_ctx() failure on the damon_ctx object.  For this,
> introduce damon_ctx->maybe_corrupted field.  damon_commit_ctx() sets it
> when it is failed.  kdamond_call() checks if the field is set after each
> damon_call_control->fn() is executed.  If it is set, ignore remaining
> callback requests and return.  All kdamond_call() callers including
> kdamond_fn() also check the maybe_corrupted field right after
> kdamond_call() invocations.  If the field is set, break the
> kdamond_fn() main loop so that DAMON sill doesn't use the context that
> might be corrupted.

I guess you saw the AI review?
	https://sashiko.dev/#/patchset/20260319145218.86197-1-sj%40kernel.org


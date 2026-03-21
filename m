Return-Path: <stable+bounces-227646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HfIE4n/vWm8FAMAu9opvQ
	(envelope-from <stable+bounces-227646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:16:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E422E2E01
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E968030467CC
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D11C7012;
	Sat, 21 Mar 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxBE6pmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EF40DFC3;
	Sat, 21 Mar 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059395; cv=none; b=Qpq/LR/HJMnI1+t8CSkK9Ekdxjmor3bGzVxSBp1HyUbgTXkUL/peQd2OpkUlmyOgkRp3tRPHlAnYaQLNS61LjnS/c8oUOrrdfBRLd22NGA1doKxdVqFkHnVsG++gAxbvLxkvbLuv4+UqZTqWfx/E/Ep9pBMlGGy8IAwWMWrk6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059395; c=relaxed/simple;
	bh=dSExaxgt6R5ldvLDLyR5uIt0k34SJYEnW9Izck2/aUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUaFg+8OPWar28ecLfKYm9YD4wIqzJhnHkt2zCsQYRJcHeK6V6lBYCH68X1heVJgOYe44R6KSyKWuPlloiXCZhnJCIHg/CFejCPs3FE/XqxvHVWHYDQKa1iUGiOVTapuY8FUXqHEz/C5bwXIparjxx1tPvZZ7eEj5yQe6OBYy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxBE6pmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EAAC4CEF7;
	Sat, 21 Mar 2026 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059395;
	bh=dSExaxgt6R5ldvLDLyR5uIt0k34SJYEnW9Izck2/aUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxBE6pmUjzBw8X/vSAoaJgCPYiZsiY77HLBcz2e5ZMAnr5PMmO14Kb26I8ltmiFXI
	 m/5vtkkMyHe40rMQil8dcWgyZd36DinyeXcQBOTLG0IIwaMlxnkjP+jl0c0augEF7p
	 vPa2navhz8nyfwi0F+tVv3SPzSdRwFJa4xNzfznc0AK7Biow3gcUWqB1Dyr/q6DrAA
	 I8aqDkvAh6qy0Tdddqj9vv++PSsjvSuwN6aEgG5hyTSNH+vE2jwUAWJ8qhli9cvpEr
	 UJQg5uluHHcN5qtwdb024EQYO0IZ9wFCEcLWqgGhBEAVGfujIPgd92mMySLKRETW96
	 1qOzRTkwV2rGg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Fri, 20 Mar 2026 19:16:27 -0700
Message-ID: <20260321021628.78887-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227646-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1E422E2E01
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

By the way, I am also doing monitoring of sashiko.dev for all DAMON patches.
It will be much easier once sashiko.dev's email feature is ready, since I
already onboarded DAMON for that.

Meanwhile, the monitoring using web browser is somewhat tedious for me, so I
just implemented an hkml feature, namely
'hkml patch sashiko_dev --thread_status'.  It receives a message id of a mail,
and prints the review status/result of all patches of the thread.

E.g.,

    $ hkml patch sashiko_dev --thread_status 20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com
    - [PATCH RFC v2 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 2/7] mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
      - Pending (None)
    - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
      - Reviewed (Review completed successfully.)
    - [PATCH RFC v2 7/7] KVM: selftests: Test guest_memfd behavior with respect to stage 2 page tables
      - Reviewed (Review completed successfully.)

I'm planning to implement another feature for formatting and sending the review
result and inline comments as emails, probably this weekend.


Thanks,
SJ


Return-Path: <stable+bounces-227647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ns/HpQBvmkaFQMAu9opvQ
	(envelope-from <stable+bounces-227647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C74212E2E7F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C603303C637
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53429BD88;
	Sat, 21 Mar 2026 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+/9ST3P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61846175A8A;
	Sat, 21 Mar 2026 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059918; cv=none; b=DjifxSPJmASfenhYdnVl6qT9HyhZW9LjCfxpp6QqCTj/h25Hw2ViSFg/qLYfQs7IP0H2HbWMNd1GeTa/cNLSisZ6sKyQeZN26Ux3oP6YpNf7KEKOEC2gR7Y+dB8IqkNpPIYQlKNCJBMaDrrki1Bl693Wfi0syTj9eqIuV4tvn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059918; c=relaxed/simple;
	bh=odSqb8C84HqMzpdiY32+MdnK999M7twGXHvwdKhHd58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr89QeMHnftPOuPH+yuUGnBxprs3m4qNUj+lYWiPuwltaaEM/qX/iNsJ2DZbNRmNbbEncR3Y0XsidF6KZgH674ziPwHpL+9TbvjBOZK2LTMiZlFF+NwPRHHP1gGmEN+QpjIAbtcfRtlCTYEkiwOAkdpUoEV7PizaH6lMdAyspYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+/9ST3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94DC4CEF7;
	Sat, 21 Mar 2026 02:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059918;
	bh=odSqb8C84HqMzpdiY32+MdnK999M7twGXHvwdKhHd58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+/9ST3PGkPi1y5hG0RIrAS/NuJn6hslhp3Gipi/d9GijnRwr2umKOd8vR8sHoAmz
	 O7lUlcHrso/j4ZRWPjacyR/UOTGBjKqnpjkMF2FXF/yBsvNmDzLBH6uoSNthDMK2Sl
	 jfoIbroFu8FIx4yh5ZoyzsG/CQExbhl8lynXDfYvu98Yjvy6ZDJZ50VWdxO8Vu7rmc
	 D36WHitrvXq7Bb7Nw4/TEp4De02IWlJ+1LjzOie5vWv4L/dC9ZPQ9ucn3EkQQLbztY
	 2+SKiyOrW0r9ugf0EdULJTTU3F8XIJEXOdiz3LB2Hzua7iDs8bYbTUtCp9jNvfDIjX
	 Vmsbly21Hloqg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Fri, 20 Mar 2026 19:25:10 -0700
Message-ID: <20260321022510.79038-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321021628.78887-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227647-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: C74212E2E7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 19:16:27 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 19 Mar 2026 19:48:49 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 19 Mar 2026 07:52:17 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > One major usage of damon_call() is online DAMON parameters update.  It
> > > is done by calling damon_commit_ctx() inside the damon_call() callback
> > > function.  damon_commit_ctx() can fail for two reasons: 1) invalid
> > > parameters and 2) internal memory allocation failures.  In case of
> > > failures, the damon_ctx that attempted to be updated (commit
> > > destination) can be partially updated (or, corrupted from a
> > > perspective), and therefore shouldn't be used anymore.  The function
> > > only ensures the damon_ctx object can safely deallocated using
> > > damon_destroy_ctx().
> > > 
> > > The API callers are, however, calling damon_commit_ctx() only after
> > > asserting the parameters are valid, to avoid damon_commit_ctx() fails
> > > due to invalid input parameters.  But it can still theoretically fail if
> > > the internal memory allocation fails.  In the case, DAMON may run with
> > > the partially updated damon_ctx.  This can result in unexpected
> > > behaviors including even NULL pointer dereference in case of
> > > damos_commit_dests() failure [1].  Such allocation failure is arguably
> > > too small to fail, so the real world impact would be rare.  But, given
> > > the bad consequence, this needs to be fixed.
> > > 
> > > Avoid such partially-committed (maybe-corrupted) damon_ctx use by saving
> > > the damon_commit_ctx() failure on the damon_ctx object.  For this,
> > > introduce damon_ctx->maybe_corrupted field.  damon_commit_ctx() sets it
> > > when it is failed.  kdamond_call() checks if the field is set after each
> > > damon_call_control->fn() is executed.  If it is set, ignore remaining
> > > callback requests and return.  All kdamond_call() callers including
> > > kdamond_fn() also check the maybe_corrupted field right after
> > > kdamond_call() invocations.  If the field is set, break the
> > > kdamond_fn() main loop so that DAMON sill doesn't use the context that
> > > might be corrupted.
> > 
> > I guess you saw the AI review?
> > 	https://sashiko.dev/#/patchset/20260319145218.86197-1-sj%40kernel.org
> 
> By the way, I am also doing monitoring of sashiko.dev for all DAMON patches.
> It will be much easier once sashiko.dev's email feature is ready, since I
> already onboarded DAMON for that.
> 
> Meanwhile, the monitoring using web browser is somewhat tedious for me, so I
> just implemented an hkml feature, namely
> 'hkml patch sashiko_dev --thread_status'.  It receives a message id of a mail,
> and prints the review status/result of all patches of the thread.
> 
> E.g.,
> 
>     $ hkml patch sashiko_dev --thread_status 20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com
>     - [PATCH RFC v2 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 2/7] mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
>       - Pending (None)
>     - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 7/7] KVM: selftests: Test guest_memfd behavior with respect to stage 2 page tables
>       - Reviewed (Review completed successfully.)
> 
> I'm planning to implement another feature for formatting and sending the review
> result and inline comments as emails, probably this weekend.

I wanted to add the link to the commit that implementing the feature, but
forgot that, sorry.  Here it is:
https://github.com/sjp38/hackermail/commit/cf1b4e167067e5684823137c5296dfb268364175

FWIW, iiuc, 'b4 review' should also provide similar or better feature.


Thanks,
SJ

[...]


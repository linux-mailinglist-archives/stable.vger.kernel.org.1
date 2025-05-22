Return-Path: <stable+bounces-145969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42076AC0213
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DCB4A753F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766312B9B7;
	Thu, 22 May 2025 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMErpAzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340EB1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879501; cv=none; b=aUCIhHBTMceGFzM6ZZwUAj6VJ4zvJ8H+GL8YOGPDQyOB3CIypOTNZcp5U08BuqD5/oWbE/muK5XEHuLNw5dO49/4ZxMFRLusnPjEntehWi0SREWw/Pmja9fbnNkv4NjQV/q+LdUgeNoYYrg4RJ1jWP+BP2QU+u/+PAzZSCv8EZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879501; c=relaxed/simple;
	bh=esPH33EDvGYUrBdxuFye4qPJkTVFw6uHCkSYkJKkMz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0JKyvLpEPwnTuskjX6ZoDaN7T81REw8PuJll1JdlRAuGKyys+zMVumlktmerNJJRTCAevA1Y9v16T/CnWjLhtUIOvsoiy96rZcXbbFOZxeo1BMQaUevfKBDINPF5gaIqUZ43HeZzQRBEPkjvyWthqJjo4r3VRFFLM5ngj4RbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMErpAzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFFFC4CEE4;
	Thu, 22 May 2025 02:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879500;
	bh=esPH33EDvGYUrBdxuFye4qPJkTVFw6uHCkSYkJKkMz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMErpAzNZycTNUqAEhEjrR1+gSLGKswN4R2gEFMTHbhXE2w4Lzus9ngQNKm70JQnJ
	 jfPDgg4mBLGi503MALFfkCXwgvfkSqjh/1GHDhWIE0pEge8K/pGQkku+GlC79KJiSO
	 1zkn3fUiQwY48qBY6tJPAQDxaNGQGsqJa2T0bMo39tF8fUKF/uPUCV2JrelkpQoZ0e
	 qdRIZ6gWp08HCPtTgDY86cxB9iYrUZGPPJ+7MpCHHnc4GKDyBVa70fr9QuGnNuthpQ
	 aix2Fzx3+PgtrXGzRUlwj67IsI8aQODmYZLE0r60xDdufJinSTE+LS94Nir1HA6lri
	 3aveX12OSb52A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 20/26] af_unix: Replace garbage collection algorithm.
Date: Wed, 21 May 2025 22:04:56 -0400
Message-Id: <20250521181718-2d01e73e74af8be1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-21-lee@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 20/26 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 4090fa373f0e763c43610853d2774b5979915959

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
041933a1ec7b af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS

Note: The patch differs from the upstream commit:
---
1:  4090fa373f0e7 ! 1:  d7a21a2945e50 af_unix: Replace garbage collection algorithm.
    @@ Metadata
      ## Commit message ##
         af_unix: Replace garbage collection algorithm.
     
    +    [ Upstream commit 4090fa373f0e763c43610853d2774b5979915959 ]
    +
         If we find a dead SCC during iteration, we call unix_collect_skb()
         to splice all skb in the SCC to the global sk_buff_head, hitlist.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-15-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 4090fa373f0e763c43610853d2774b5979915959)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
    @@ net/unix/garbage.c: static void unix_walk_scc_fast(void)
     -	 * receive queues.  Other, non candidate sockets _can_ be
     -	 * added to queue, so we must make sure only to touch
     -	 * candidates.
    +-	 *
    +-	 * Embryos, though never candidates themselves, affect which
    +-	 * candidates are reachable by the garbage collector.  Before
    +-	 * being added to a listener's queue, an embryo may already
    +-	 * receive data carrying SCM_RIGHTS, potentially making the
    +-	 * passed socket a candidate that is not yet reachable by the
    +-	 * collector.  It becomes reachable once the embryo is
    +-	 * enqueued.  Therefore, we must ensure that no SCM-laden
    +-	 * embryo appears in a (candidate) listener's queue between
    +-	 * consecutive scan_children() calls.
     -	 */
     -	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
    +-		struct sock *sk = &u->sk;
     -		long total_refs;
     -
    --		total_refs = file_count(u->sk.sk_socket->file);
    +-		total_refs = file_count(sk->sk_socket->file);
     -
     -		WARN_ON_ONCE(!u->inflight);
     -		WARN_ON_ONCE(total_refs < u->inflight);
    @@ net/unix/garbage.c: static void unix_walk_scc_fast(void)
     -			list_move_tail(&u->link, &gc_candidates);
     -			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
     -			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
    +-
    +-			if (sk->sk_state == TCP_LISTEN) {
    +-				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
    +-				unix_state_unlock(sk);
    +-			}
     -		}
     -	}
     -
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |


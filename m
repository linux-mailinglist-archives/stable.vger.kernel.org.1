Return-Path: <stable+bounces-145972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4EAC0217
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3AF7AC085
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490CE35953;
	Thu, 22 May 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8qv43u1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADE18E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879510; cv=none; b=WzJD7k0O/x7MCSLdxZlY494Qs7C/TYOCWd9V/hyeWQMDxDPo8JbCPuo2nR4EB7lN6DU+jolaZOMkfmTkjurlvJoYcbHTjwjWRY9yy4pTz2zmXnbEmFeJ6VIIgU1bQ3pqd7Tx0V5v4/QCv++YljQgSwOMwGWCZ2piUNIIdKZDbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879510; c=relaxed/simple;
	bh=FdJrTPUf1mQ1cWUcqlRRCuGOj4ouHyIGEYhKj/XWp2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjBTm0cneWUKdvt3CQq4lfaK0vvAb2HmfJTKxVrgqi89w3/sQtkZIMXdvDADCXzekdmYrOI0TytrcGWJjeohY6qwoO+YBa6/jnVQp+tBC+LZuXJB/x0W9xXLN6YB1BnXopEm7s5jeDDmGXCVulIpooCsb4xMJNGaBnuH9G0JJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8qv43u1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7163BC4CEE4;
	Thu, 22 May 2025 02:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879509;
	bh=FdJrTPUf1mQ1cWUcqlRRCuGOj4ouHyIGEYhKj/XWp2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8qv43u1vqGBPxdodh3KuPazCHjGTgRVUu4VtclBpgKmMaUnMnqI7v9dh4hERl2Ep
	 y2O6uNdgjBxlOa+UMVZQ/IdgrPjF0ZofbWUk3N2vbKIn3KSHG9Znu8gRRKbItnJ15k
	 IoD1yrlMiL/72erSVpGzBm37HkwHvxhQJw9JN2maMnc3oqR0GGfZ3kjdqyEiso1xvO
	 RrE0JudDJON2+1f0rcc20rAoW5cahfluUC+zjFNgiUU52TQHg3B/8YIO6WSpDS23kf
	 fNamXb+WIuxs+J87EqOWax7/8VkwMcTPnvmnvzEYTDOe8AMH2KQWHx4VYmZLdaxFGM
	 TjNPFxVw0hEKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 06/27] af_unix: Remove io_uring code for GC.
Date: Wed, 21 May 2025 22:05:06 -0400
Message-Id: <20250521193529-edf67856ebed56ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-7-lee@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 11498715f266a3fb4caabba9dd575636cbcaa8f1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  11498715f266a ! 1:  70f88da83e058 af_unix: Remove io_uring code for GC.
    @@ Metadata
      ## Commit message ##
         af_unix: Remove io_uring code for GC.
     
    +    [ Upstream commit 11498715f266a3fb4caabba9dd575636cbcaa8f1 ]
    +
         Since commit 705318a99a13 ("io_uring/af_unix: disable sending
         io_uring over sockets"), io_uring's unix socket cannot be passed
         via SCM_RIGHTS, so it does not contribute to cyclic reference and
    @@ Commit message
         Acked-by: Jens Axboe <axboe@kernel.dk>
         Link: https://lore.kernel.org/r/20240129190435.57228-3-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    -
    - ## include/net/af_unix.h ##
    -@@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
    - void unix_inflight(struct user_struct *user, struct file *fp);
    - void unix_notinflight(struct user_struct *user, struct file *fp);
    - void unix_destruct_scm(struct sk_buff *skb);
    --void io_uring_destruct_scm(struct sk_buff *skb);
    - void unix_gc(void);
    - void wait_for_unix_gc(struct scm_fp_list *fpl);
    - struct sock *unix_peer_get(struct sock *sk);
    +    (cherry picked from commit 11498715f266a3fb4caabba9dd575636cbcaa8f1)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static bool gc_in_progress;
    @@ net/unix/garbage.c: static void __unix_gc(struct work_struct *work)
     -	 * release.path eventually putting registered files.
     -	 */
     -	skb_queue_walk_safe(&hitlist, skb, next_skb) {
    --		if (skb->destructor == io_uring_destruct_scm) {
    +-		if (skb->scm_io_uring) {
     -			__skb_unlink(skb, &hitlist);
     -			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
     -		}
    @@ net/unix/garbage.c: static void __unix_gc(struct work_struct *work)
      	/* All candidates should have been detached by now. */
      	WARN_ON_ONCE(!list_empty(&gc_candidates));
      
    -
    - ## net/unix/scm.c ##
    -@@ net/unix/scm.c: void unix_destruct_scm(struct sk_buff *skb)
    - 	sock_wfree(skb);
    - }
    - EXPORT_SYMBOL(unix_destruct_scm);
    --
    --void io_uring_destruct_scm(struct sk_buff *skb)
    --{
    --	unix_destruct_scm(skb);
    --}
    --EXPORT_SYMBOL(io_uring_destruct_scm);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


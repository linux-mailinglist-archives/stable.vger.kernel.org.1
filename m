Return-Path: <stable+bounces-145978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C739CAC021E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D01B64375
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404144C7C;
	Thu, 22 May 2025 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adTlfIpI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DB35977
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879535; cv=none; b=VgmMpzMHER6SWph6/JsQtllajk55lIX5sc/QX25mEZBZseHd3Pw+stAg3vD724UOdOna6JaSA5mPpauocT6fxXA8+KCTvw8VernYOSIK+MDdXukaxVJT3Ct54HvBjMAb4tz39ZKTw53pi4Cm4KWngS0dJuLct+LKSaCwQCwamrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879535; c=relaxed/simple;
	bh=/mhsdzUmtdARU3dtQ7Cz33nC3s0yHIeBjPKczPA31Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fn6uwFrSk8N6AQ6M+dqcEAD/+ZMUS4vCa4JtGo9Ttb2xpCHWzY04C59lYU4wtqFE02N3Pp6VmFu/yvditD7ZjJN5MizPfYYfBpDv997wgdIRId/uzd9fy3Ki5Ar6ae89hjltb8dcU2dFIAugTPWebIdY8s4ZMb/ZNrwsEmNZmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adTlfIpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13266C4CEE4;
	Thu, 22 May 2025 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879535;
	bh=/mhsdzUmtdARU3dtQ7Cz33nC3s0yHIeBjPKczPA31Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adTlfIpIdI2+JWUNHthbVyNUh4ty2uC1i6CeZ0g88CMu2qBhNj44G9dcVvWi8jR10
	 qS7+RT9VwvypOwYj1lSCrhcBPXuXxgb7svX/YebxFlRY+LVFipIKe908WEIFXx5Ptm
	 hoXgLOCFObRzgpbmPetdBk6Ku4ND4Wc5qMXgBWk9+zV97+TuQvyhYxIQoKFQLlv/Xr
	 TnY8t6MJjnvRBDvIa42i5izdF3uxzAZNhDwwRThRQGS6Q8Pkv0WePSjes3YE3v0TLE
	 wIOKAoPUNSoxf0fz/p3JL59bv59NPEl8bTss/w/KLb2ngChLkPjFMqL2fnJuG4fza9
	 gErbNKRd1xWFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 05/27] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Wed, 21 May 2025 22:05:31 -0400
Message-Id: <20250521193104-44c0865b191af9be@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-6-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: d0f6dc26346863e1f4a23117f5468614e54df064

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d0f6dc2634686 ! 1:  8d734ba6e6dbe af_unix: Replace BUG_ON() with WARN_ON_ONCE().
    @@ Metadata
      ## Commit message ##
         af_unix: Replace BUG_ON() with WARN_ON_ONCE().
     
    +    [ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]
    +
         This is a prep patch for the last patch in this series so that
         checkpatch will not warn about BUG_ON().
     
    @@ Commit message
         Acked-by: Jens Axboe <axboe@kernel.dk>
         Link: https://lore.kernel.org/r/20240129190435.57228-2-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit d0f6dc26346863e1f4a23117f5468614e54df064)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
    @@ net/unix/garbage.c: static void scan_children(struct sock *x, void (*func)(struc
      		spin_unlock(&x->sk_receive_queue.lock);
     @@ net/unix/garbage.c: static void __unix_gc(struct work_struct *work)
      
    - 		total_refs = file_count(u->sk.sk_socket->file);
    + 		total_refs = file_count(sk->sk_socket->file);
      
     -		BUG_ON(!u->inflight);
     -		BUG_ON(total_refs < u->inflight);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


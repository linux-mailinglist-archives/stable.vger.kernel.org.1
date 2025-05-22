Return-Path: <stable+bounces-145979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCACAC021F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B9C4A75F1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FB2D7BF;
	Thu, 22 May 2025 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfg5tsOO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A518E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879542; cv=none; b=pdBQ2YPdpo9twMoekFduaRPmLu+vjgoEoLoeFk5icC7NwwBMyrQ/5cu9wDMaQZyzDgJfNrtCjx4Zvg9FgAbRvsIi1y0kvi0lYvF8XPfC4pQILy6IlXOpGBpoL4knfkKK0g5PvORsIwTy85deMpOD98hYNfWYHdX4tk5ybB6uY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879542; c=relaxed/simple;
	bh=d4aY2DNjR1rCxbJY9u3765i2iRjrK11lfiEQzcYd23U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtMs0rUo2GPWb7RwpHKEgCsrYo2CF9kiCZuCqFSlbBmcBk6LDDj0W5qybuDnDxmUdAUF2NgirWuH+3+w6EzZ6D1pyATYKYzhTVwnobiUj9BMOGqDCtRk7akRooSz5BaDE5pAFRZz4MZ21KB5Ol4VgHNR9pg1fpvbwdJaWoiNyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfg5tsOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78245C4CEE4;
	Thu, 22 May 2025 02:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879539;
	bh=d4aY2DNjR1rCxbJY9u3765i2iRjrK11lfiEQzcYd23U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfg5tsOOiGVNzye/oKnFu/RhtXFjGU2NbpgdTZcSVGDIi497PO+nAd+wM5j59gVzu
	 jbKi1U6v77lyEbTxcM64SswjiprUYyOsu3AnXG4lSFPlR5gx/6QmfdJGi1YR43uD2Z
	 toyB+jTP42jFPxLjriYIp++06VOyyhMe+JdUJ50NIgMXr2Hzf2AV9lfyeD/N+qHjnU
	 x7mFHNQEHzH1hjWiVxPR2N2Th0gLmXwFinOFlsd52yYDKz95+glNpPhKGnFycmUPL/
	 1svse4yppMNxK5OEpPI45kcc1JIB2DEg1GEJDqUBz0S1ghLSYa5n2K08gQceGtXeP8
	 TiPB+bgXQWCMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 11/27] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Wed, 21 May 2025 22:05:35 -0400
Message-Id: <20250521203337-9e8486e58c6b53f4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-12-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 22c3c0c52d32f41cc38cd936ea0c93f22ced3315

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  22c3c0c52d32f ! 1:  98babb0b1635c af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
    @@ Metadata
      ## Commit message ##
         af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
     
    +    [ Upstream commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315 ]
    +
         Currently, we track the number of inflight sockets in two variables.
         unix_tot_inflight is the total number of inflight AF_UNIX sockets on
         the host, and user->unix_inflight is the number of inflight fds per
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-5-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void unix_free_vertices(struct scm_fp_list *fpl)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


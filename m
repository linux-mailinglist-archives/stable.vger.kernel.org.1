Return-Path: <stable+bounces-146005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDCAC023E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1277B43B2
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082062B9B7;
	Thu, 22 May 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCHO1XAM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E76FBF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879683; cv=none; b=QTxFCTnRrVOZCEbMqRuYXPYC+RkxdL5vKGNY68dtw+HauI/yX3rQuB8rKa4N02cnBTGqoIU9VgTjv8rk9ux2veWGWw5JwtzYj3PF+/w+9F/kzB1fWtMtbQPPf9M1+AhxxLjS9l+EaqVHW9pld3KUPMLLeje5MQPtja6RNu6Xlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879683; c=relaxed/simple;
	bh=Wom4BVHJ2u9WLALPv3ZsLd/6tv0kVu3vFnDNaX0Of8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2jvHdnSdqmvD8yoDszsooAeLLAtDVKDg8/tBoTB1xpBBZRXFTIrLgYEUrGjjDHLt/BubLH/3fz32uV6mXIYw2OERtWWlxRp6fdcENgG7RfWVW3eaRh6H1aNN0pCE4feRyURH3/BXj4cx/34/E6SnSa/n8HmySO73FKh2qqW5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCHO1XAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B5C4CEE4;
	Thu, 22 May 2025 02:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879683;
	bh=Wom4BVHJ2u9WLALPv3ZsLd/6tv0kVu3vFnDNaX0Of8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCHO1XAMEUtHQO6lfJqwXo40WWAypWp4D+zBP+F6sRpVyMGbR7+py4pddeF8456gL
	 m6YH73px5K37VU5pHuopoNT5/enQfKLithfqg2ZoGnd05Fyb8UcnnlllAuSPLGfkiu
	 aL/fVZzvdnoV3wuPhCmTUS6T7XTLiL4WUEdRv014t2d6/uny3XwaVTid42n78YzqsF
	 xq0APMe/yxUjAe03gd6/IL+CfR1sqSVUbUcWQbtSn4y/Pyl3nazbSuz/VAIhFVp5RW
	 j1V1oDiXrUTlFBuAAE+X5g1i/R1O0OlSakm5rr7Zw0ZF0uhE7Qsl026eSECIRm1pqw
	 u9DCkt0qLDfQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 05/26] af_unix: Remove io_uring code for GC.
Date: Wed, 21 May 2025 22:07:59 -0400
Message-Id: <20250521163340-c9fad9f0bb608eb0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-6-lee@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  11498715f266a ! 1:  06b13b36a7de5 af_unix: Remove io_uring code for GC.
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
    +    (cherry picked from commit 11498715f266a3fb4caabba9dd575636cbcaa8f1)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |


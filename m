Return-Path: <stable+bounces-165700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40DB17910
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A27F1AA68FE
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9702777E8;
	Thu, 31 Jul 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjhlOyOO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA3265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000412; cv=none; b=t0IapK4FHu43mVqoyTlwckDDVgM97ywmxzEK5n3G6zPteVVbnL4toDM0lgFtoYO/jijoZz7NsI68SVmxGd5VBS2rOv5XVR9S/zCpxTI+0vU1feI1m0AmO0N56/K2CsijDdBlWLQpVcL/ddHwoiqf4Vyqh0JZ/I3+L4CElNfW2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000412; c=relaxed/simple;
	bh=nAt7lAg5MZNrsSbkKMg9RSe6NwYe2s0KifZLycGr0rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPyl0UJT7xwEO1bC4kPn1cDscVvhMBN+w5OgWohH1zadtvU3kzNKmHeSiXBFeTJ1iKLnnF9WJEw5LMguOfLNVZVwoNelR2fV+P5x5oNdKCe8XxQjLAx6Okq+l8f2nRTdO8wkLgxiJgLUcPcqt0wZ5xQZZ3/LDi7ccM3UFzmUBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjhlOyOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89914C4CEEF;
	Thu, 31 Jul 2025 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000412;
	bh=nAt7lAg5MZNrsSbkKMg9RSe6NwYe2s0KifZLycGr0rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjhlOyOOtsc2++IX+v8RMZLD/7WlvY75YFuLERz/ZPvwP0h1oGeL65MoWV2Fcm1vf
	 pMDHmNDZe4kq8UGKt3B1xFp3MApCZW2goONXJZANvv56Y5gcPwnsTPOgtlbe97DkAH
	 sYkRwGzKZEH2YdxMN+cM//8aLp3a5opyu+Pidly9QU4/mww4b5Qxcr5yd1iURrT8FX
	 sKLt/7XpKH3K6vBAQSSGTNv/j+r5KdvO03KDBL3bcWMPeFFhqJpBAong8oo6JDhARH
	 nXFVqvWK8KQ/MdJxIz/T8XBoQ9tspQuBQyqfu/WOK/gVDkX6Iy75GjPBzkJiNu/UVz
	 KP8vu+qWU5QTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] Revert "bcache: remove heap-related macros and switch to generic min_heap"
Date: Thu, 31 Jul 2025 18:20:09 -0400
Message-Id: <1753977078-7402f072@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731130315.33984-1-visitorckw@gmail.com>
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

The upstream commit SHA1 provided is correct: 48fd7ebe00c1cdc782b42576548b25185902f64c

Status in newer kernel trees:
6.15.y | Present (different SHA1: 875dd4b6b0f3)

Note: The patch differs from the upstream commit:
---
1:  48fd7ebe00c1 ! 1:  eda391cecfa0 Revert "bcache: remove heap-related macros and switch to generic min_heap"
    @@ Metadata
      ## Commit message ##
         Revert "bcache: remove heap-related macros and switch to generic min_heap"
     
    +    [ Upstream commit 48fd7ebe00c1cdc782b42576548b25185902f64c ]
    +
         This reverts commit 866898efbb25bb44fd42848318e46db9e785973a.
     
         The generic bottom-up min_heap implementation causes performance
    @@ Commit message
         Cc: Kent Overstreet <kent.overstreet@linux.dev>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
     
      ## drivers/md/bcache/alloc.c ##
     @@ drivers/md/bcache/alloc.c: static void bch_invalidate_one_bucket(struct cache *ca, struct bucket *b)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |


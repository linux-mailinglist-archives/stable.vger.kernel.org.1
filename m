Return-Path: <stable+bounces-135267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3ADA98975
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866487AEA35
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A271EB1B7;
	Wed, 23 Apr 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjToRyb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9681119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410609; cv=none; b=bd2gFCZ9DHrjUKU8ZA44N7JGSyfhz8u6Bu93dccNqbmTIUEVsOhepyY2qN61BlnA+J+aHqjGKsdOMj1sskAwUPOZrsB4F4BVeuE6oUl4kgI+JkUPfxUz7Tvu+pJCahvv/Own9WIrYB3UEArb7Prf2Lz4XB66DetJNam3OaMH8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410609; c=relaxed/simple;
	bh=P93qZkPvLwimJcOk7xzbheZauTIIFqRjBv5skM1ZVEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHF2XPxI2DQsoR/+gRO8an9XYWa1qJyh4OmkR14c0WlKdVbUasql934UsV4+ZgffzWbwGKe7uhUYOxADlkfrFc8s0h80p9Zbk8L8tX4988bBz9n80GxJdrezBaKhfLLQeTx4Ma+nmawUlug8eX25vPf/m4V77LqmeaUnDaOY74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjToRyb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6562C4CEE2;
	Wed, 23 Apr 2025 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410609;
	bh=P93qZkPvLwimJcOk7xzbheZauTIIFqRjBv5skM1ZVEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjToRyb1waRW3g43g8S10ExsZcsVTrXffS5GmGcc6zAa2zeJWX9E5UvlgawOGGOxv
	 NRK9NXccl5M0VCDvNGavHHeEWjf5oVirwyFG6yDzVFe96aub4VSbn/gUAAAKtTaaft
	 8H77lBzkPCtuYs86yotdEZ1svAfyEK8jCi8FZ9MRACgMmIYXzskqSv4vGq+WVGnFJG
	 4ubOPfMavLiM411tc2493sphJ66puoxXy4XJ6VVckt4lbWBmP4XYtffFiK7DHnc1oO
	 OyvwNmdfmky3Eyyw80Kn6TVcs0BBzqlUX4yx4D5te0HZLaUDxiV78CGphx5CmJThUO
	 IeNhlojoge9LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 3/8] selftests/bpf: test for changing packet data from global functions
Date: Wed, 23 Apr 2025 08:16:47 -0400
Message-Id: <20250423074847-a1c5105ac1d60c7c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-4-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 3f23ee5590d9605dbde9a5e1d4b97637a4803329

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  3f23ee5590d96 ! 1:  8dbc5d4ccc8a2 selftests/bpf: test for changing packet data from global functions
    @@ Metadata
      ## Commit message ##
         selftests/bpf: test for changing packet data from global functions
     
    +    commit 3f23ee5590d9605dbde9a5e1d4b97637a4803329 upstream.
    +
         Check if verifier is aware of packet pointers invalidation done in
         global functions. Based on a test shared by Nick Zavaritsky in [0].
     
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-5-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/progs/verifier_sock.c ##
    -@@ tools/testing/selftests/bpf/progs/verifier_sock.c: __naked void sock_create_read_src_port(void)
    +@@ tools/testing/selftests/bpf/progs/verifier_sock.c: l1_%=:	r0 = *(u8*)(r7 + 0);				\
      	: __clobber_all);
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |


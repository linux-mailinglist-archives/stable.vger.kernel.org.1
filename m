Return-Path: <stable+bounces-152432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B9AD56E0
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C90188EE2F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923FC2882C5;
	Wed, 11 Jun 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XprQ676b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041221B9D3
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648278; cv=none; b=Fa2dC7XqLJtgO4vApAQ5vL3+2/WJPihlQAj3X8Mf01jXeGvo1WQZNGZaUN/988PNmmthng885DurL0wu2uIsKB25LAvDYOhevGuUiq1IlxGNq42KODWJxVpdoQrKnYpUTdWE++9X/PcUBvSm0+N8H6l8O+nx8Mocrg8cmmepDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648278; c=relaxed/simple;
	bh=Ltk9Vl9GvJLqmU2OaoRR5X20Pr3tObTgjQT+8R6nKAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2AzmSlbfy5j+hcDRC1LnO5giflV4qWNAlqbnAD3LLll0OBIDCOrly/a1mAioJ7UEnXzct1LXUbCtOKCJMs4DrKQIkdYjzUDPZnhKpsMzFAln0kKqCTb0LqF+GycZQ4XlRUxnariuqWiO7jTvfhueEzVkx10K97qDOxySZQVJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XprQ676b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67489C4CEEE;
	Wed, 11 Jun 2025 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648277;
	bh=Ltk9Vl9GvJLqmU2OaoRR5X20Pr3tObTgjQT+8R6nKAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XprQ676b/ZFPLP9jXBDpFNyVYfJqFhi84HsLTgAUMXCbaHeaij9qk6RSe1u6B9f1U
	 bjqkPK6qddSD61wWesqNwfu1mXZzCDCTyqPsnAAbPil4P4V80Y4QuW4si7nVnxDqxy
	 /ivGirgf1/vP0dRfO6L8ToDAzIAs8KHOp/IC8PDEL+nknyrSQafH05W3pqxcjVE4xd
	 W2IpyIKw6jPK7zP0OVJil6AISVf4KJCFpBz9f1QgvOvGs0BhSt4hLDum4q+fTdomL7
	 WO2ZY5BdGLKVZ4wi1wYpjd0H//E084EY/BO9yVhY+K2zRag+wkteRYKcR2UkUD5cNu
	 B9c8hT9tg3gbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/3] rtc: Improve performance of rtc_time64_to_tm(). Add tests.
Date: Wed, 11 Jun 2025 09:24:36 -0400
Message-Id: <20250610175140-9e8c5ce35d7b59ba@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:   <b301ceb67e1ab9fd522e17433540de464aec2c0b.1749539184.git.u.kleine-koenig@baylibre.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 1d1bb12a8b1805ddeef9793ebeb920179fb0fa38

WARNING: Author mismatch between patch and upstream commit:
Backport author: <u.kleine-koenig@baylibre.com>
Commit author: Cassio Neri<cassio.neri@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Found fixes commits:
8a904a3caa88 rtc: test: Fix invalid format specifier.

Note: The patch differs from the upstream commit:
---
1:  1d1bb12a8b180 ! 1:  b0856f15968b7 rtc: Improve performance of rtc_time64_to_tm(). Add tests.
    @@ Metadata
      ## Commit message ##
         rtc: Improve performance of rtc_time64_to_tm(). Add tests.
     
    +    commit 1d1bb12a8b1805ddeef9793ebeb920179fb0fa38 upstream.
    +
         The current implementation of rtc_time64_to_tm() contains unnecessary
         loops, branches and look-up tables. The new one uses an arithmetic-based
         algorithm appeared in [1] and is approximately 4.3 times faster (YMMV).
    @@ Commit message
         Reported-by: kernel test robot <lkp@intel.com>
         Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
         Link: https://lore.kernel.org/r/20210624201343.85441-1-cassio.neri@gmail.com
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/rtc/Kconfig ##
     @@ drivers/rtc/Kconfig: config RTC_MC146818_LIB
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


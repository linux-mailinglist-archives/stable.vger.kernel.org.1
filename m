Return-Path: <stable+bounces-100030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E009E7DFD
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024E01888717
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356917758;
	Sat,  7 Dec 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYMrXLvT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794E323D
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537248; cv=none; b=MG+4rVFrFBf5jc8w1eKKnjosfLT1go5+UsnQ9HLLeP0GyFRkI4GmeoVZKQZJdAC0q/RajvacFXVGnKFYiz3Pm2YPoiLBAOJk+IwV0jEkazU44+zbHcQq5on5g/kZZKCXQPhg6jGAA+GubLKIbmvT0NTx8B5jNoduCQU4nJp9PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537248; c=relaxed/simple;
	bh=9awEvojnuYi49o+x1q7pi2vOyloCTdQHzX59q6FCBBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZh8z8loPmBM0Sl4CB/AqOIXrM3nIe/2nm9+EzkTniYvY/mYgbWjgaJANOX7c+3czdv60c4mHbpAwvFgRP0+CfQolZg7+2JBA8ETkQMez3AYv/by3cNOO8tF1zPURND8U5OuoUg5RY/LpR+AWlCtA4fxoFMOsJvAMW9mklKM8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYMrXLvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9F4C4CEDC;
	Sat,  7 Dec 2024 02:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537247;
	bh=9awEvojnuYi49o+x1q7pi2vOyloCTdQHzX59q6FCBBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYMrXLvTnYBJy4/dqI15PtrubJYpxjdT/BqLh6oyLa54uEjY6hf9ofJ0eCznT56IT
	 zXgNtk5O9+7it8ELCk+fqWagWpVL4m4wwcyZxlugeGsa0P+7Zx3GyAJ2Ob2PkgZhGl
	 wxKaG+X0PBKrBVdvUT/93TNFNM/J2/TKayY3zyTvAmvzTn+JYoBbtN6lPjZVxfbqsx
	 drEwcB1TJz6Rj/Mq91QopbPVPCjwHs4XfHnHECeE+jv1LUaQXYxur2as96TNynv0Aa
	 zkyiviQhz36ch2gan/neg48TSN1mDE9rXd9Q4ZFFVCfRIqJwh9LoeNlr3mEfoNISfr
	 RGl7h0oXqmzzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 21:07:26 -0500
Message-ID: <20241206184511-fc7bc12b36f71321@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206173700.75357-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1

WARNING: Author mismatch between patch and found commit:
Backport author: SeongJae Park <sj@kernel.org>
Commit author: Zheng Yejian <zhengyejian@huaweicloud.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f3c7a1ede435e ! 1:  2989b63c0ad2c mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
    @@ Commit message
         And add 'nr_piece == 1' check in damon_va_evenly_split_region() for better
         code readability and add a corresponding kunit testcase.
     
    -
         This patch (of 2):
     
         According to the logic of damon_va_evenly_split_region(), currently
    @@ Commit message
         Cc: Ye Weihua <yeweihua4@huawei.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1)
     
    - ## mm/damon/tests/vaddr-kunit.h ##
    -@@ mm/damon/tests/vaddr-kunit.h: static void damon_test_split_evenly(struct kunit *test)
    + ## mm/damon/vaddr-test.h ##
    +@@ mm/damon/vaddr-test.h: static void damon_test_split_evenly(struct kunit *test)
      	damon_test_split_evenly_fail(test, 0, 100, 0);
      	damon_test_split_evenly_succ(test, 0, 100, 10);
      	damon_test_split_evenly_succ(test, 5, 59, 5);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


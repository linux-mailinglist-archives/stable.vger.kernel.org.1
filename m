Return-Path: <stable+bounces-166926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60FB1F740
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE87B0848
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAF27511F;
	Sat,  9 Aug 2025 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ+4GfCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921826E714
	for <stable@vger.kernel.org>; Sat,  9 Aug 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754782862; cv=none; b=dsjjUiy9GHBxNKsLLpqO3oz3OF7Ynta6Jz1xrruvYw2EVMB64ZbFoqhH85t6z+ASYoCGLfLEfLVQnRfFB1R0JIoqMRdOduREpJRfXqP0MuF5+lAJKyt/35Ca4kSo53jgcMEddu27HtqEi9GWvt8COaLhRdzIcgCUXIbzJosv9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754782862; c=relaxed/simple;
	bh=O3ME7VM/OfBzxZdwR/VG2iFojFLk4IolU1bZ1cCjHqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehsk4JOEWRYOom844C029UA68aDXo05Cjde1OYv3LnpBdvcDNs1lMLL8fT3H7gu/ukFU7D69xpIugprhZr/SOtE2R43oeJLJD9BwhTO4fx/aEb/XuBBVDhWy2Q5WG0nOw+ArRPC8PZbAJJCPQjtrhbDLiLAZkg5+nAK2/EMEVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ+4GfCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E8C4CEE7;
	Sat,  9 Aug 2025 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754782862;
	bh=O3ME7VM/OfBzxZdwR/VG2iFojFLk4IolU1bZ1cCjHqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQ+4GfCXEmGrSt8kUaXfAWiGoavKR0kVwc+8MNCH/m4CwUhifWQ6kxcxljpOIfHp2
	 ZfPBFvgE/67Cfx9oSjTlfuteKymLS+3q/IuS6dV8gbb7dyFGa+aOyl/XgXvz7It5vG
	 yo+Wu5Sh0TwxeGMyh97WmRqdHyD1BhmTLQcClujtnrTNuLtMd8wJiqSAjrI/wc1PBe
	 MEANF0gfEjIavHVFn79c4JdAS0mH1RpsFm3sYlmbUpuqCxIrRaFcRIP1hP7d3BStWC
	 MlvkuLmgswD7MC1u0HJ9VdecszTNSfytmIYE0EcGLTZubrr265Zt+b9ODHksatD1gD
	 eyAdadqrx/7iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] dma-buf: insert memory barrier before updating num_fences
Date: Sat,  9 Aug 2025 19:40:59 -0400
Message-Id: <1754749472-e511209e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808180537.26649-1-wanjay@amazon.com>
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

The upstream commit SHA1 provided is correct: 72c7d62583ebce7baeb61acce6057c361f73be4a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jay Wang <wanjay@amazon.com>
Commit author: Hyejeong Choi <hjeong.choi@samsung.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: fe1bebd0edb2)
6.6.y | Present (different SHA1: c9d2b9a80d06)
6.1.y | Present (different SHA1: 3becc659f9cb)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  72c7d62583eb < -:  ------------ dma-buf: insert memory barrier before updating num_fences
-:  ------------ > 1:  eb3b4ab80d5e dma-buf: insert memory barrier before updating num_fences

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |


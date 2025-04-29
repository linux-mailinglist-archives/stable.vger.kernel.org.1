Return-Path: <stable+bounces-137077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B17AA0C17
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6200F843C35
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA822C2585;
	Tue, 29 Apr 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz0OXaxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9D2701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931023; cv=none; b=ouVntXrAd/jUAJpAAlX7LsD+xIbfNA8NSmOmnPouk4OiNNFggIIbBdmH0LnZEpDQleUb1SJh8RkJhM7xgjQl/QJjZQePNhywdVXsGTpfvnTHzHMrJMwwJG2Bcy/ngRDde90gmhpZU1CDAwTlYdcnII0u/1i/TnMsiugx5cy8CxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931023; c=relaxed/simple;
	bh=lk0ofjGUiZGWHUhkXswOHW7yZJPnXM9FRMzrXoBYPQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJNFGRW2J1Xu19TNOpalO4TdyUvov/q9gdBpHE0b0hKOuAqPGMs072FC2/ojiOUBPSN7OzrPdpg3JEj2RhyQgEU0T8Oh6JE1pds3FvyRWywZXI5c8i8oeALCw/WdWyAPkIIlhPU+01C6Q2RMuiOp6h9Du8VBZfY7Rq7o1vOLHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz0OXaxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3711C4CEE3;
	Tue, 29 Apr 2025 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931023;
	bh=lk0ofjGUiZGWHUhkXswOHW7yZJPnXM9FRMzrXoBYPQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dz0OXaxX0Sxt5AXgAGfIGslf/Bl5BuyQ0DZrggpWUaaLmMBqY/KohQXGMncrLnIlc
	 r05oy6lB8YL+R0cE8c4iFxNkkpjyF/mAK7ci9hXhWf5jvpwmVEZJHQfypLiO2bXIEx
	 vmK72QGVhCVbDEW4Ey4Ozf7o0ZLWa3oWeQyT5Ndw2XfB8VOOBbKjXA7K17fNRf8E3i
	 W4T6KG7ids7rjrzoG7uEMiYkqbyIdNkYTBB2qj4wDRRHXLYCFB38Agvkg/IUN2tkuz
	 IPBPCFTaDiukEeYMi+yj1ubbDztavYmclukWaOmbVdCGsILEtN+V4pAvVuQOTXyLP9
	 aK2ssIEh2Fslw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y v2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 29 Apr 2025 08:50:19 -0400
Message-Id: <20250428215609-dca23f1e44d2f999@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428080741.4159918-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 28cdbbd38a44)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  9fc922291d44b net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


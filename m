Return-Path: <stable+bounces-132135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633CA848F2
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172229A7768
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72819004A;
	Thu, 10 Apr 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLxhA5x6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF61E8329
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300398; cv=none; b=Yz16F0trPC5jEte3ldUVSN+O68s+i/hM/dWTSxhZjB5HLwABUl/BAuwc77KS7bB6Ywc0rBNbXkX0XDwDMpGv7x7ZYzTj7lLJUq4O1Zh3216DMWAugtN32mrAewN3v0K2/pXTBlbBXURtDb7HxqXEH7jEkAt9UoDIrajABZCMY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300398; c=relaxed/simple;
	bh=Lw2+gnd8Pq+/xx8WnPVUXxh+LkfTrMnGeutSwa5FbBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM4wkdrmA8Jt3rSkBlugyppprdNeqCJZQAmHAafab3OvV+ere2JUcQTSLC0+8ClSQTxY8J7Gt18NiLaEVqdxoXmIfaXVtH/a/fVfwaN7BT8uKuxKhqxNnJ48f86w0wh92Ujz0AYdwhMIhgyqUGw41seBhFitE+Zxxta7ghrBR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLxhA5x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBBDC4CEE9;
	Thu, 10 Apr 2025 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300397;
	bh=Lw2+gnd8Pq+/xx8WnPVUXxh+LkfTrMnGeutSwa5FbBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLxhA5x6kscBNYKD1CbczFkfiLng31nXR8AeQr0/eUv/PD7yfTxy+rT/xb2hD/9zb
	 zB7sWTb7AdrWIOcYdFQ0XkMqcMuad0JdlpccsQ5tNSGkgBsdmpD/hUub8IyKPQ4qsR
	 2xutJIfvfZd6r8B3aLKsCoHPBzKL+rhULmlTgXNwt513Zq7u/3WqysiNZeJTmZlmad
	 5rF2c2PjpUTy4GfBGLksWkVYKkMCUkJ7yzVOhKEZfxKKWBYNIZgJRBBYKgMTnN2vzk
	 XrmF/JfOGQ6DqY4RqAeJrrNoeInjAF2NVUm+oWyT7UJUz7lKrmZvVy5hmHhLo9uCOG
	 e1Kr5WPdeblww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] nvme: avoid double free special payload
Date: Thu, 10 Apr 2025 11:53:15 -0400
Message-Id: <20250409225322-dc221329e4911d42@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408071807.1002129-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: e5d574ab37f5f2e7937405613d9b1a724811e5ad

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Chunguang Xu<chunguang.xu@shopee.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ae84383c96d6)
6.1.y | Present (different SHA1: f3ab45aacd25)
5.15.y | Present (different SHA1: c5942a14f795)

Note: The patch differs from the upstream commit:
---
1:  e5d574ab37f5f < -:  ------------- nvme: avoid double free special payload
-:  ------------- > 1:  2e6ab98f6f697 nvme: avoid double free special payload
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


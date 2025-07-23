Return-Path: <stable+bounces-164381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9851B0E9A9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B62818893D1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748A188CC9;
	Wed, 23 Jul 2025 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNhG3AK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1672AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245261; cv=none; b=oPx/rxLSUKRGOKZhVtHHWM0iaknwUMQ++PgWYbAG6CQC4OnJwq3v9pAhaM5wAcqkFH87h5MpaLXdbuEjHaIjlHzCD3ypWhwxhIczBWTYQuICPzw6wLlbOZ4WNeaO9SJ0ZzJxXMhVTtYDWsJf17YiSITuNPyhIKFH0/a8c2Nxuzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245261; c=relaxed/simple;
	bh=t8DiddCibPkXePf1sk1c3wgCwJJar0dJj7ZhOIVFduQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsaEddrney0SpHNJuiSoEnOgjv7kndT72hcvAipnZGN7SalojOGIDCyWIkMfevVqm38aGshjtzFhvMcOubFrW6dD4XaJ7BqVPxiynAsYx3S/XtA7U3dIT1UIwLg9A2wbtgni+gfCKX0DLU0lerZrkFNiqjNaLpMoHhe0EypBgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNhG3AK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B941C4CEE7;
	Wed, 23 Jul 2025 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245261;
	bh=t8DiddCibPkXePf1sk1c3wgCwJJar0dJj7ZhOIVFduQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNhG3AK0w1WKPNUIUQkznZ9WuOw0OvpCkSza24M9GnPa/68qy04kDWje0KvCF3a6S
	 e+uXXIO4x8jERVssd3obsFz+Hr0/1gvZX1Gi/U/hFwId8REXuwMAxT2vZyOOIUEmS1
	 fhaUTvgIBQoq3xkdTJu74Tgn0FDPOcrOISy4Dp7g+jxWTVgZjXnr5Nja568RQfI6c9
	 UOAbt2SUGanE2QYfnYNikXp1TdFYr+mdTbLRj2wXQVJjDIZCMyMtUyDsM6Ep3D3te+
	 73zpvNsm7VwtHSD2TBPNUor/x6UNYLtUVgEcBL07Wjp3HEWu7tkfyVXe2P/zOYRO2G
	 McVA7u/BX3zSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 4/4] x86: Pin task-stack in __get_wchan()
Date: Wed, 23 Jul 2025 00:34:19 -0400
Message-Id: <1753233443-f0065cbf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722062642.309842-5-siddhi.katage@oracle.com>
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

The upstream commit SHA1 provided is correct: 0dc636b3b757a6b747a156de613275f9d74a4a66

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddhi Katage <siddhi.katage@oracle.com>
Commit author: Peter Zijlstra <peterz@infradead.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |


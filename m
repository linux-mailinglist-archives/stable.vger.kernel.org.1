Return-Path: <stable+bounces-132353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14793A872B2
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9C16D740
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D691DDC12;
	Sun, 13 Apr 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlic6sUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EC14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562832; cv=none; b=p07s4temglMF74nM7O+HdlaHbCwV+mscGGE3QSyhN3+wfCXwD5DVdtm2JEArnXt/tmu57XFm0HokrGjXtKCtiq7xluU4nr63JlFlq57mtV3elelnmwOL75gInxld4MANl09EjhA2b89cQjfbJSCJU31y+rsAckc0ACCV98piBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562832; c=relaxed/simple;
	bh=WJ8hwpS9MyPCoiAbO1pGlG3PP3xhMytrwFHYwhWemr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+N4uUlcCbKz0m5cpLCIXm71NBwFKK96ZL2ctBwXW117C9o3zAaHWRi+weKVAPCwVYvugQv8jscrEyz/Qb6r23BLtVTVO9exYNUWE4fVCgwSWwzOYQEwhgDgm5CrX3VY8CNHYA0DGqY/ZcAa+fMKRPTndXN3Nscs6gpQGrc2Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlic6sUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F68C4CEDD;
	Sun, 13 Apr 2025 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562831;
	bh=WJ8hwpS9MyPCoiAbO1pGlG3PP3xhMytrwFHYwhWemr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlic6sUfskEA7r8oPRwZsYhIUODmtTi30TLMrxxApBVXSO3rEnJfFehbLJOufL/3U
	 i1lFm+/pQ/HvM3lVoOnG045aVy5Z3EA3QJcf1Y8Y0GLGG1qzWt5RSBMeB5ScklyzOa
	 NWarqSnZ4fKxPStEEf6mYH48kfcISK0boQHu988VXiVT16HJX6cfVbDeeRtclYSXVq
	 zIrtlt3ZSOGbYidkkXbSJgGo9pFD0kq1QBFYM+tVq1iyt4BqpQFGf2tDlGyWV0KN2B
	 sQatxnXqgysklJ5Dwc84cIu8EBUgy1/VFOKuBdUeH3PcBc9uAoQeSntHNduzJNxCXG
	 GkBvKS9R6tGzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] ext4: fix timer use-after-free on failed mount
Date: Sun, 13 Apr 2025 12:47:09 -0400
Message-Id: <20250412093559-a4db30332c9399a2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411081911.219016-2-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 0ce160c5bdb67081a62293028dc85758a8efb22a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Xiaxi Shen<shenxiaxi26@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9203817ba46e)
6.1.y | Present (different SHA1: cf3196e5e2f3)
5.15.y | Present (different SHA1: 2a4ae3bcdf05)

Note: The patch differs from the upstream commit:
---
1:  0ce160c5bdb67 < -:  ------------- ext4: fix timer use-after-free on failed mount
-:  ------------- > 1:  1c2c1669ad83f ext4: fix timer use-after-free on failed mount
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


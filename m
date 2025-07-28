Return-Path: <stable+bounces-164929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6DB13AB3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091CE3B59A5
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0055526563F;
	Mon, 28 Jul 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8/ylEDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311A26561C
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706749; cv=none; b=BqQhaQpIRMpMf7AZZGLpI8PvhMZ/QuHctP+b7ffYfNd4CY1LTS6/Ia31BvsH007Y0v9GILbs3/nR9myXyAN3g+qbNGVDLrnnv3jq64+9z8j0NxCv9SAy8V3120mk+9TcFHUIfeOmwE1hE7RB8Lwzcl2mbNOlyEbxOVi6zUHq+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706749; c=relaxed/simple;
	bh=lebmbu5JX0Q2mKGpyt6DeCCCoymYCJUwfRNM6Gfub50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTAGPaFndBVYZNfGhurq6HJq3Eq43sk0RWLM3Xp4/8czs5I3BmWdHmhMg3dFc+WZBNUJQo+mcgRCC5rKcHrcgzHEsRnQ3jGbO1Z9nkurUQB6lud1ESXERxZT3Hq3rep5ViARl6TQyu8ch6AZicQAD6/ImH7GwSTRXmhFKUU1T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8/ylEDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB165C4CEE7;
	Mon, 28 Jul 2025 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706749;
	bh=lebmbu5JX0Q2mKGpyt6DeCCCoymYCJUwfRNM6Gfub50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8/ylEDqPghSqaMWLF9DWIS9BTeVfyU7/NGGW7ZSMsiuV9zYlYTHYEctgOayCuqo1
	 tuXI15GV7zJ3cKsGI+7gv0bGuKPvKURR3655E9NxLPfJcqFfmwIBVxIeitbGu5VzBs
	 XdaAToZHK4rtBMRpwA42OBb5ie1WP6E+yDYgy3OIsivPWJtdOG3dTCvPtQsOhpBzOB
	 1z6oEJKF/Y4d7mDJCV2qqslXuKr+Z48pt2br5M2DBIYYbXkegRl2KK58zWveOZK7/V
	 irAmE1HUBDC93wYWXIdNVIGxcqaY8tKoi5OKJHQk8zgNFgT8e0eQmFjgs39xwehKrU
	 2TvwN3O+aeVSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenridong@huaweicloud.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/5] freezer,sched: Use saved_state to reduce some spurious wakeups
Date: Mon, 28 Jul 2025 08:45:47 -0400
Message-Id: <1753684448-d53f3b4f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728025444.34009-3-chenridong@huaweicloud.com>
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
ℹ️ This is part 2/5 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 8f0eed4a78a81668bc78923ea09f51a7a663c2b0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Ridong <chenridong@huaweicloud.com>
Commit author: Elliot Berman <quic_eberman@quicinc.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
23ab79e8e469 freezer,sched: Do not restore saved_state of a thawed task

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |


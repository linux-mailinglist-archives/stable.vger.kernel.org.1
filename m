Return-Path: <stable+bounces-126953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C46A74ECC
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BDE3A5777
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962C1A08B1;
	Fri, 28 Mar 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyYH6fuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B23C0C
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181387; cv=none; b=MGllO9yMLSvQQ483Cflq93e568CItnDXZCg9STv2Bq+l9TR0I9vfVpt4++cptm7ZOSsHrQoAxsUpN8Guahp6VDFTDczGiGnNBDu7bXHVarPQW81UxNpSKJfk1tn7YHTBUnUzahJ6XdYWv03p8l+C9jMpudYESQf+PqWekepf+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181387; c=relaxed/simple;
	bh=kdFXEWQBBxAgbOAGuN/tQdrjNAetGAany1Ey1VcZKHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDsjEiAB0BP81k6jo+tsrsNOm0lN5QALLTZ+kriGmQqWOiIBZix93IJ3CHl2d6IF7xdFgdPcZFPJlgxc8H3OLHVyT29N2tHhtTfGLfk2xOihVd4PbYOGaE+JgLb2ocYS3ldaRapd/8aoiNqYprnISyyH5fVWuVx8TjwaysPqOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyYH6fuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA0DC4CEE4;
	Fri, 28 Mar 2025 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181386;
	bh=kdFXEWQBBxAgbOAGuN/tQdrjNAetGAany1Ey1VcZKHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyYH6fuLPKGkDkq+jCxUtZB3WFY7KwOI5/PbrgWXVc89CAC4NkV2jRLOtSH//lVpl
	 sa799bEM75tzgC6R9s6h0u0C/y65oxkHnneiBNiCdo6F6kGRxlzmu9rxUc+mAV960p
	 n5SGEbs+f886ddyKwbZI6UD3ZAm8RiTt7lbKn9hyvHbkeX+U6IzdFtn4zCRyjR/aVw
	 vit+KcDoQAgSaNNQAm2kciQfQX6i4N2Lmb4GafqKr7V8ox0pB0l9rhnK/H0P+WQYz7
	 RMAAIfLKHplyuGl8YeqZqFHAuuzD7LZDZ/IX02Rp/oGN+mQzhdWOrrpFnKgThUcqFy
	 7uSU4e+cKbftQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] xfs: give xfs_extfree_intent its own perag reference
Date: Fri, 28 Mar 2025 13:03:05 -0400
Message-Id: <20250328115749-28b6a5ffec417878@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250327215925.3423507-1-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: f6b384631e1e3482c24e35b53adbd3da50e47e8f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f6b384631e1e3 < -:  ------------- xfs: give xfs_extfree_intent its own perag reference
-:  ------------- > 1:  344a09659766c Linux 6.1.131
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


Return-Path: <stable+bounces-158595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB26AE85C9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C02318942CB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468A266B6B;
	Wed, 25 Jun 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFw8DRhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D362652AC
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860547; cv=none; b=i+Sj/EkSpYkZmCKaWZmWOh8mCg5CtdZcc/+u0+JrTxRKGFxXQSJvW3LDxsbtfX+MAz4Z5kGLj9aYOYCBP3eKqqtY5mW4rXw4N+rlNq+DBUDdLmT0j3uVHB2mDjNW9LzD7LwzyKToZYyGAhpFUjf3LBCxAU0IBv/XEI7KIy0nlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860547; c=relaxed/simple;
	bh=q3Vy/aBowBi5MntFlJbsfoGFbv+2yFJ8d1Uyx98Tb3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQI+xPq3OwaC+/hLNfpIaayvnnHflMQpHij43hC9sZ4/GQ84YnNRoeuTlT80miI3cn3dHMJIUhHO7Y2h4cIKd8djbDlRrptB2ko4LJbGPSKwMLdaJFP66qhQI6PEfJkAxsPTidgRHYLpSaX5qM8R8EU4QokGD7JNcxy5JHwEOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFw8DRhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93CEC4CEEA;
	Wed, 25 Jun 2025 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860546;
	bh=q3Vy/aBowBi5MntFlJbsfoGFbv+2yFJ8d1Uyx98Tb3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFw8DRhSXJFqAymvM14m8dYPZHOVCHr1hLsFnlr4AXjHOqPERtm3ZJmFMjTnkk8tF
	 sngeW2pSg1LeDFlx/slzw6l2HWVmPZm5JVEhDZPgKfMzXSRzdDKtgVgkas7K3TSMlP
	 B7O+xdbmtAVqHEWBrwSlFbRRDgTQoUSquIC3sPksSbMCHBDfbZgOtBbYDNubXqLar/
	 lfTDIr5AjJgKDAtMuLjX4KtnIvLRi5+JD68G5NCla3TwqmRweUel3AKMDBkenqZ5aX
	 DzE35bylLjqH4I5GqfuBtrX6ZCLwLMwqDcY17RFfjtJvJLTNFCX8mM4YTGVUxFv8j1
	 phTTp5FdvkQwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] xfs: fix super block buf log item UAF during force shutdown
Date: Wed, 25 Jun 2025 10:09:06 -0400
Message-Id: <20250624191559-d8d1fb6d1407e834@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624134840.47853-1-pranav.tyagi03@gmail.com>
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

The upstream commit SHA1 provided is correct: 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
Commit author: Guo Xuenan<guoxuenan@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 0d889ae85fcf)

Note: The patch differs from the upstream commit:
---
1:  575689fc0ffa6 ! 1:  9876b048d8f68 xfs: fix super block buf log item UAF during force shutdown
    @@ Metadata
      ## Commit message ##
         xfs: fix super block buf log item UAF during force shutdown
     
    +    [ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]
    +
         xfs log io error will trigger xlog shut down, and end_io worker call
         xlog_state_shutdown_callbacks to unpin and release the buf log item.
         The race condition is that when there are some thread doing transaction
    @@ Commit message
         ==================================================================
         Disabling lock debugging due to kernel taint
     
    +    [ Backport to 5.15: context cleanly applied with no semantic changes.
    +    Build-tested. ]
    +
         Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
     
      ## fs/xfs/xfs_buf_item.c ##
     @@ fs/xfs/xfs_buf_item.c: xfs_buf_item_relse(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


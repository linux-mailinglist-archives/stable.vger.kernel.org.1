Return-Path: <stable+bounces-139380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C5AA6392
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7974C2E3F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470981E260A;
	Thu,  1 May 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6DIIxM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589B22539C
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126695; cv=none; b=maOOI3UGMhValtxFkyOz2BGuI6dP8KFVlDyRNqLthKSh6cFvtct7tm89q6n5N7LbVeanmnHxM/6hrSfX3sYztM3png8iwM/y7zwdlxqoZsw99j7AFQu3LVVuzPvAw/oRP0V135xfxUFcEi1cHA0UogKjbkWi4RK1BoDb4YbIozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126695; c=relaxed/simple;
	bh=8XCWGLJ8eG6iRkMfOOthmr2u00BuzMMJbL4rrNs2ANE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeGyhkIMQRim2f3pN4mqN98oJFmhUQ/N2HX6FxcO70XV4ssy3oEF5/hYwP8Mc9ypQlakjGLy5ZBnkVlo2mOdfxuXakU/XOoac9KP8OiViGM8XxM/R93MsuwbPHoYx7ja+pQ+kZ/dY3N/GWe2V85w3n2ciVUBNRH1h4desWLSOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6DIIxM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ECFC4CEE3;
	Thu,  1 May 2025 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126694;
	bh=8XCWGLJ8eG6iRkMfOOthmr2u00BuzMMJbL4rrNs2ANE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6DIIxM0NAhUIKaKugUueECVgXoCC76rHs9KFi9To1yIQaWktnDsYQ7WOgrTBhqxo
	 shNPg2YAjmMZSifPLuHqOLM8ylAS9b+VBp4BCV/CKZS74dNMDImFqvgnPI6lynzD1x
	 CLcv5pSqHSvnmf82F1WkjQOZAOl2v2FLCCEoJOShXajS/1TA2O2PT44wLXUWc83iCy
	 unwPf8C7YbFqn9SySlD8HycgFKJkPmidVdmCaz93GSaSt7GJSuhf9J8kakr0MrqrbS
	 uT+qrUKsKdLqFNsJOEaLG/3y8WNYwgghGYZ+rdhQvfi9S48roprcAObDLnnfFEmTOq
	 D7RiZ6k4BdZIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 08/16] xfs: match lock mode in xfs_buffered_write_iomap_begin()
Date: Thu,  1 May 2025 15:11:30 -0400
Message-Id: <20250501124915-665a8df3abdc6c81@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-9-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: bb712842a85d595525e72f0e378c143e620b3ea2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Zhang Yi<yi.zhang@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f24ba2183148)

Note: The patch differs from the upstream commit:
---
1:  bb712842a85d5 ! 1:  359664e60e303 xfs: match lock mode in xfs_buffered_write_iomap_begin()
    @@ Metadata
      ## Commit message ##
         xfs: match lock mode in xfs_buffered_write_iomap_begin()
     
    +    [ Upstream commit bb712842a85d595525e72f0e378c143e620b3ea2 ]
    +
         Commit 1aa91d9c9933 ("xfs: Add async buffered write support") replace
         xfs_ilock(XFS_ILOCK_EXCL) with xfs_ilock_for_iomap() when locking the
         writing inode, and a new variable lockmode is used to indicate the lock
    @@ Commit message
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_iomap.c ##
     @@ fs/xfs/xfs_iomap.c: xfs_buffered_write_iomap_begin(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


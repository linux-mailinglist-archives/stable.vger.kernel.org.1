Return-Path: <stable+bounces-139367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C189AA637F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176047A8EDA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46768224AE1;
	Thu,  1 May 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ombn5Gh8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872B215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126588; cv=none; b=bsLA6IZ1WHkg0elvPtqrpRWUTxcpbkVsfk9+V6MAVHWqleVyF5mxjn6vwzZzA1zLVqgFLQ2//Lf+DV8ZxVTJFQfdTCloEpV15eXFwxY74XU8UdYDUP8+R4H0rl64d/mu9UsLpvXWLVYgIb0+ldUiYn6fBy5/+ksAZ9zmBs09bLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126588; c=relaxed/simple;
	bh=HrAJMiZJCnnRmQloA2HqCg7gkW441WdUngKNVdeRb28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baP5WpSTGZBdC4G2/ihZBLK4HDEExrU/paFnWW+HQT+p1ofyKp/PLk91scBwoKCwKgMuoC1lMlCHS5+iy3NSy17jH16BrU++vpTdemOIF0O6LfV+PkZ56BCw5Q+L4QVkYy2zz/XCOJfXFBB6Y8ezFSUVMp7zkJ7ASI4uIWXo0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ombn5Gh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756ADC4CEE3;
	Thu,  1 May 2025 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126587;
	bh=HrAJMiZJCnnRmQloA2HqCg7gkW441WdUngKNVdeRb28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ombn5Gh89ofHTHwlQ0CGscfhGVawtvMzDrj+iHV0tf1CD49JWpvUbEYLLj3+jM8vm
	 PR4dfYWV7EoKln45imC/tK2pzrrlxcFKlSeeX5ARnYKtyM7GgVQ+qYXAT3WvxHSgJn
	 lwIqdHzx0zOz0G9VUwe3Jd/sPCJKmom7LVhV9O/VOSG7ZHxTKjtInbggked71Dygj/
	 HVOWv0EtFResYe/3OXEeghqe5P4WvfW9gN/Y95sKqaeafOZ04CxPxlzppMXnVdSlWc
	 NacF1bwMWJ9l5et7Mc6Ax17yZx+2XwvBy5EO/NqtmtGBXeqgZRWEDAmxteBTvXPtYY
	 WoXauH+lt1bAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 15/16] xfs: allow unlinked symlinks and dirs with zero size
Date: Thu,  1 May 2025 15:09:42 -0400
Message-Id: <20250501131726-984abae8fff3134a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-16-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 1ec9307fc066dd8a140d5430f8a7576aa9d78cd3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3eeac3311683)

Note: The patch differs from the upstream commit:
---
1:  1ec9307fc066d ! 1:  2121dc3036b86 xfs: allow unlinked symlinks and dirs with zero size
    @@ Metadata
      ## Commit message ##
         xfs: allow unlinked symlinks and dirs with zero size
     
    +    [ Upstream commit 1ec9307fc066dd8a140d5430f8a7576aa9d78cd3 ]
    +
         For a very very long time, inode inactivation has set the inode size to
         zero before unmapping the extents associated with the data fork.
         Unfortunately, commit 3c6f46eacd876 changed the inode verifier to
    @@ Commit message
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_inode_buf.c ##
     @@ fs/xfs/libxfs/xfs_inode_buf.c: xfs_dinode_verify_fork(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


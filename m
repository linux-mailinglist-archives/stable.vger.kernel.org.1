Return-Path: <stable+bounces-124481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37448A62146
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E58119C56AB
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEC1C6FE4;
	Fri, 14 Mar 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDrUNYbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF01F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993815; cv=none; b=eO0Owuf88HN4WEiSRZHuotbO63m5zTE8ZGik+ry5cuNUsGwUCQjAD8r96xpuxtHtEoy3mpzVLrvCxTw6/AO8HygsToKSIhMrl6Vf81oHBlP+zjqHvFctWhS6sW901Jrv33AL0X+xcLXopBzNySeLF278TcK8Yd/jgOvmhLcDcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993815; c=relaxed/simple;
	bh=MQ6IECuBQip9HEHpeyTopPQPjtJEUMgjn3FEXj1v59Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMo5XaM2wgReeIQPZQ+ll18bR+SpZHMe0azY51iCvoiKdA1m9ukxBw19esAo59igwiY9eGykgDak78J/Xlw6xEWjE5ixXtAaN0f0xnG685SRu+k8a3e1sdelsAZp+g+wVvlLdrXk/1wO752SjPBXTEEUGYkVh1751/7yRBqI7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDrUNYbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6096FC4CEE3;
	Fri, 14 Mar 2025 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993814;
	bh=MQ6IECuBQip9HEHpeyTopPQPjtJEUMgjn3FEXj1v59Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDrUNYbEw509yC6iClvO7VrLDId0yDqoJczye9OEx+6nqJYRfhkFB3FVlx16MAGXS
	 rHXpjAlatRbNgKrktMFhC3zyPMpHTD2pmpMaXdgWiTdkjuMa4S7WeLVqgfa5A4RUou
	 otUtP480c0Wmj08mELlubedql+4ehIkeShYxVT1UPJ/IY8TRIi9FDd+b35LsHRyd2h
	 R9LipVWTb0k7GmJIJjLoVPRfMsAIYYrK5o1vKq8ksFEJjt84ruPylNY4YmqlTJg9YY
	 tMOF1qiX9cRYHYv9LqgZep/Y6g5Hgbk1uBCfcAPsTDmyVhzlemYM7rxkI5fK9Ay0B+
	 kqCLy4yOCPypA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 03/29] xfs: fix confusing xfs_extent_item variable names
Date: Fri, 14 Mar 2025 19:10:13 -0400
Message-Id: <20250314111823-2e42f0aeec492f15@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-4-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 578c714b215d474c52949e65a914dae67924f0fe

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  578c714b215d4 ! 1:  48382d577161d xfs: fix confusing xfs_extent_item variable names
    @@ Metadata
      ## Commit message ##
         xfs: fix confusing xfs_extent_item variable names
     
    +    [ Upstream commit 578c714b215d474c52949e65a914dae67924f0fe ]
    +
         Change the name of all pointers to xfs_extent_item structures to "xefi"
         to make the name consistent and because the current selections ("new"
         and "free") mean other things in C.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_alloc.c ##
     @@ fs/xfs/libxfs/xfs_alloc.c: xfs_defer_agfl_block(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


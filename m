Return-Path: <stable+bounces-124485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC4BA6214C
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D738462547
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1151A23B7;
	Fri, 14 Mar 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWOX1Y2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4041F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993823; cv=none; b=c7+8OXDSMzAN8nxIDI3W0ZDXyHS8F0ibZX7fzpTmcAPlZx8+G5Hyi2j8LixzmLb0qq+xaafw95FqlSace6sa5801+LAE9i/PCGfqQJvK4srk0G3XLYVpxm5DvTly6UfG/WSDiKYYFVz3F9eOWlc1vPAEZyviiC0Jf252ZtnePHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993823; c=relaxed/simple;
	bh=NjFnh2TzN8v7IIMax+iV2DqOdPxmIKEH8WkQrF4q3aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKuPaHSw7Wt4Tkl37/SwBRACZQiQQqD0VaKDnZtnxQYOyJFkPoiKqap4nwRhxwfDj3jrLW5iUwqSTqM6zAWmU3TRrnFBMcBiPcWuPbqPfxUsfmdnihQwh9SaM1AmdvtlqCq4Ko8EgLp33d8Xrgw+5F25fPCgPYKXRFwSCiWtxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWOX1Y2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F85C4CEE3;
	Fri, 14 Mar 2025 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993823;
	bh=NjFnh2TzN8v7IIMax+iV2DqOdPxmIKEH8WkQrF4q3aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWOX1Y2zGxHzcegKGM1SE3RZgp6mY5BBN1L1LjbEKv/C285Mo+QJN16vvXsYHs2PM
	 qT97ah9M4a46K+8HoJ2TejOldkKQjrsToAsyQFjt5ZVskkK3BNkpIYnoTjc1eej4f8
	 lbmjxh5gZ8+lHcLBt/EsmwScf4YiJUCLAzKLNmOrNHOvsWW4I0nT1R0sa+humYky5N
	 v4x5XsV1DRLV2QFfIaunhCIC6TPKhGHOg65qPerAya9CSy6Qdte7TW+02DfYp6SsL9
	 sA+okEp2V1FLQHq82PIkjXn871u8E7mlz23odpVHZgcwRsGmN7O+jmOdB1NZUez244
	 +A0WmSmhQAKfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 04/29] xfs: pass the xfs_bmbt_irec directly through the log intent code
Date: Fri, 14 Mar 2025 19:10:21 -0400
Message-Id: <20250314112545-4933980ab130da74@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-5-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: ddccb81b26ec021ae1f3366aa996cc4c68dd75ce

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ddccb81b26ec0 ! 1:  f2c38698292e3 xfs: pass the xfs_bmbt_irec directly through the log intent code
    @@ Metadata
      ## Commit message ##
         xfs: pass the xfs_bmbt_irec directly through the log intent code
     
    +    [ Upstream commit ddccb81b26ec021ae1f3366aa996cc4c68dd75ce ]
    +
         Instead of repeatedly boxing and unboxing the incore extent mapping
         structure as it passes through the BUI code, pass the pointer directly
         through.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmap_unmap_extent(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


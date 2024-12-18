Return-Path: <stable+bounces-105237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CA9F6F21
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBC116E0CD
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC55516CD1D;
	Wed, 18 Dec 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrAAAP1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74E15697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555677; cv=none; b=Z93W5pWDsjoItVXEUiPXF/dIxB6a2SHe1uSfkvP7RWKOZlgrL2fIvIom9TC0FVI18Jf4RVSfhgagpvY/5yixruCFqjxSopyfh7EpjzjN27+xMxlTJcrDIiAKwsdFd0gKS8wviMXz6x+QV4epZjDa1AMcVsXtp6Bjzqmrf5wf98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555677; c=relaxed/simple;
	bh=RlDxuuCYiRpg11aehWm6xVGlLyiddrIZ7QAYqfaZK3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4oSpVWJ0TnQGXdbs72TiWLzBb2u3s8zhS/eOmB6x15MVjTfrO2kRnLM+Cf/7CXRIy1Ewl9RxgsqLjzvmnEYuK4Uwd4T+MMSJoMkehvId/0RQregXcYKnPxOvJvTUbwgl2MiHZAuHlLoRi6pcH12BnC+T/AnHpDLUZzmJupw1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrAAAP1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC06C4CEDF;
	Wed, 18 Dec 2024 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555677;
	bh=RlDxuuCYiRpg11aehWm6xVGlLyiddrIZ7QAYqfaZK3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrAAAP1l7Kr6GoLslFL7rdhdm/PGJvaFMvniKts4JcMpIs+zEzhIS0j/DYTslHh+t
	 3SUzt3EaRciCiy2km/mhVceZ7u/m/EDP0gP3a1XG64dX9tu0DeP5qzBnsX+k7O42pT
	 tATrMT2Dboznra+qzM9OJJBH8EYLsuY2lEQHrVqZMWsJW0PE2dZFoVAkwEqYzUsMPw
	 MAxspXz6+0j43Qy8jjN5IN3F6+xOZWnemnUGMPymyr49NrdoPGHoWYKyLg/3z4ku5P
	 lAKHXM9YCB1wcP7CNGi/OoE3T/GrM+mumxpXNsaxHAu6xxAMhgCjuds44ly5L4Mm3d
	 pqRTkc87nn55w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 07/17] xfs: Fix xfs_prepare_shift() range for RT
Date: Wed, 18 Dec 2024 16:01:15 -0500
Message-Id: <20241218153217-48a33690faf4edca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-8-catherine.hoang@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: f23660f059470ec7043748da7641e84183c23bc8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: John Garry <john.g.garry@oracle.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f23660f05947 ! 1:  7aa03646d5cc xfs: Fix xfs_prepare_shift() range for RT
    @@ Metadata
      ## Commit message ##
         xfs: Fix xfs_prepare_shift() range for RT
     
    +    commit f23660f059470ec7043748da7641e84183c23bc8 upstream.
    +
         The RT extent range must be considered in the xfs_flush_unmap_range() call
         to stabilize the boundary.
     
    @@ Commit message
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: John Garry <john.g.garry@oracle.com>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/xfs_bmap_util.c ##
     @@ fs/xfs/xfs_bmap_util.c: xfs_prepare_shift(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


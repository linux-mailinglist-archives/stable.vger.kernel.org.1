Return-Path: <stable+bounces-105231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BA9F6F1B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105B61890763
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E61FAC5F;
	Wed, 18 Dec 2024 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP4ocPoO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741916CD1D
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555665; cv=none; b=Ne6p/pfcROEQartyIu7HGe2kGkJz1fDTdI0BXq3kGypQJtmId4ZKC95VkUGwJ4vEj9w94uYqDKJtV2HhKJdKQBUYtyjCfi0jhpPdXZxNQ5TS0jKA8N/z8n2exom1LpbGQkMvigrpD313gV0x9cMIgmJn0wO8sn/aj/hvg2Ss1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555665; c=relaxed/simple;
	bh=PAZIctpKiPcN5FMAFqeBaHBcXjIZLLfEwfA8VQDX+hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEkr02/TDvbmnJCXdScwVq8u7D/t3IYIMl2AEgi/5EJB5QTRf0emDJmCDz+QCGETwe6jFNLia/LAasn8Xs9bNsTNG/JBWfYmIfUJXYdyRaWeI7vWOjC2NNVggIQFo8A6Jq/xGa5t/Go4c1LhaWK1Rt419MDtbviRgk/7cmioxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP4ocPoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3825EC4CECD;
	Wed, 18 Dec 2024 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555664;
	bh=PAZIctpKiPcN5FMAFqeBaHBcXjIZLLfEwfA8VQDX+hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iP4ocPoOPn3KILixRp0XpDxiTTtZlnsS+TULBcxUoVIFORKFHCiG4QV5AlJR8IZcD
	 2T6kFpqf1JlYcwnzjLjXWpju+gqs6v68QqPGAK84pWO1LdO5cZ+totXY2NXj8U46QE
	 agXqMaLPP0M1iE1IowFb+LsmfEs/I7GjnqnUW54iH+ecsLzMIGm8ThKZDvLg42v1me
	 gzSQiYMh6Dq90x5X1qEWqu4h5+uQPHeni3tc3QIyxyj+r5XAfRhhG3eI1JWF5BR9Lx
	 OkBQXSRsXGKZVMD8Jm6F+Jo2u3CLRGncZ5ouCoq2Yrt9kgQ2je8psctEDIaijN8Anv
	 2noOWPGFFZDSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 11/17] xfs: remove unused parameter in macro XFS_DQUOT_LOGRES
Date: Wed, 18 Dec 2024 16:01:02 -0500
Message-Id: <20241218154751-75317b74c2243ba7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-12-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: af5d92f2fad818663da2ce073b6fe15b9d56ffdc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Julian Sun <sunjunchao2870@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  af5d92f2fad8 ! 1:  9ba6eacedd6d xfs: remove unused parameter in macro XFS_DQUOT_LOGRES
    @@ Metadata
      ## Commit message ##
         xfs: remove unused parameter in macro XFS_DQUOT_LOGRES
     
    +    commit af5d92f2fad818663da2ce073b6fe15b9d56ffdc upstream.
    +
         In the macro definition of XFS_DQUOT_LOGRES, a parameter is accepted,
         but it is not used. Hence, it should be removed.
     
    @@ Commit message
         Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_quota_defs.h ##
     @@ fs/xfs/libxfs/xfs_quota_defs.h: typedef uint8_t		xfs_dqtype_t;
    @@ fs/xfs/libxfs/xfs_trans_resv.c: STATIC uint
      xfs_calc_rename_reservation(
      	struct xfs_mount	*mp)
      {
    --	unsigned int		overhead = XFS_DQUOT_LOGRES(mp);
    -+	unsigned int		overhead = XFS_DQUOT_LOGRES;
    - 	struct xfs_trans_resv	*resp = M_RES(mp);
    - 	unsigned int		t1, t2, t3 = 0;
    - 
    +-	return XFS_DQUOT_LOGRES(mp) +
    ++	return XFS_DQUOT_LOGRES +
    + 		max((xfs_calc_inode_res(mp, 5) +
    + 		     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
    + 				      XFS_FSB_TO_B(mp, 1))),
     @@ fs/xfs/libxfs/xfs_trans_resv.c: STATIC uint
      xfs_calc_link_reservation(
      	struct xfs_mount	*mp)
      {
    --	unsigned int		overhead = XFS_DQUOT_LOGRES(mp);
    -+	unsigned int		overhead = XFS_DQUOT_LOGRES;
    - 	struct xfs_trans_resv	*resp = M_RES(mp);
    - 	unsigned int		t1, t2, t3 = 0;
    - 
    +-	return XFS_DQUOT_LOGRES(mp) +
    ++	return XFS_DQUOT_LOGRES +
    + 		xfs_calc_iunlink_remove_reservation(mp) +
    + 		max((xfs_calc_inode_res(mp, 2) +
    + 		     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp),
     @@ fs/xfs/libxfs/xfs_trans_resv.c: STATIC uint
      xfs_calc_remove_reservation(
      	struct xfs_mount	*mp)
      {
    --	unsigned int            overhead = XFS_DQUOT_LOGRES(mp);
    -+	unsigned int            overhead = XFS_DQUOT_LOGRES;
    - 	struct xfs_trans_resv   *resp = M_RES(mp);
    - 	unsigned int            t1, t2, t3 = 0;
    - 
    -@@ fs/xfs/libxfs/xfs_trans_resv.c: xfs_calc_icreate_reservation(
    - 	struct xfs_mount	*mp)
    +-	return XFS_DQUOT_LOGRES(mp) +
    ++	return XFS_DQUOT_LOGRES +
    + 		xfs_calc_iunlink_add_reservation(mp) +
    + 		max((xfs_calc_inode_res(mp, 2) +
    + 		     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp),
    +@@ fs/xfs/libxfs/xfs_trans_resv.c: xfs_calc_icreate_resv_alloc(
    + STATIC uint
    + xfs_calc_icreate_reservation(xfs_mount_t *mp)
      {
    - 	struct xfs_trans_resv	*resp = M_RES(mp);
    --	unsigned int		overhead = XFS_DQUOT_LOGRES(mp);
    -+	unsigned int		overhead = XFS_DQUOT_LOGRES;
    - 	unsigned int		t1, t2, t3 = 0;
    - 
    - 	t1 = xfs_calc_icreate_resv_alloc(mp);
    +-	return XFS_DQUOT_LOGRES(mp) +
    ++	return XFS_DQUOT_LOGRES +
    + 		max(xfs_calc_icreate_resv_alloc(mp),
    + 		    xfs_calc_create_resv_modify(mp));
    + }
     @@ fs/xfs/libxfs/xfs_trans_resv.c: STATIC uint
      xfs_calc_create_tmpfile_reservation(
      	struct xfs_mount        *mp)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


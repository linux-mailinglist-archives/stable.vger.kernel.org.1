Return-Path: <stable+bounces-111927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDBBA24C3B
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74BA18852E7
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584AF1CC881;
	Sat,  1 Feb 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SczAK0/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939C126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454034; cv=none; b=KLMAY13zGWkSxNnCIpBRz9p1GxG+mMd2XlIZqJT6m0JZxzLkKDjU77GEMZ83X4vYVkb38aHCY+26Jw9Uu5fWa4Kr89na0cSkqYeSdXRqm4u2VwUuCNlYkQiukKY+GdhNxeBb7cy4oGLwZIlz0M/lFRyMlwa61y1bLuXNB3Id690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454034; c=relaxed/simple;
	bh=TLN17n8oZLaPH0U7vmLkI+pPMOkbMR+LuZauXZ9m+1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpewwSIlcwCWyyJkINMchn9ijTAyr1EMNAC4bORnW1VicHcYc6wKbC4qdQx/2mFa+E3X7AIujpzjwQaPXGyuhFbZywq9+MONgpf5JuvhPRyWuOQxXqyZHOQP6hB75wt6B5XSX0HZf8/KWe5UGwgh2ObVR5OcznQ3bPpQvECo4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SczAK0/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F6C4CED3;
	Sat,  1 Feb 2025 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454034;
	bh=TLN17n8oZLaPH0U7vmLkI+pPMOkbMR+LuZauXZ9m+1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SczAK0/+Gk1egkfuutXbo2yELge+NsGH1Rd1gaeVameqNZJNlqKg9g2t5c45UL7ZL
	 Jx5suXOtPU7NJcPrOvbZ++E1KL/T8daVnFxN4LgwwAU5la71d313CuNlLBnV44A/rz
	 gYke3HWN4xa0mR08mlsVn3vmObjDrDiQ5B0eViQwND5gLO3OoEuhawu2j15+BOF/vN
	 PIUkPtGflp0nLJN5AgRad3yYnTPplS8xXIPW4t0gqm01rm0AYPJuDwO8ovtJvYruED
	 UPrn8ajbtCcKHso0iD1LWAoU0R3XJC0iDeyRpeyEfQN8kJPwn662WqQYEdwzBNpm+T
	 mPaRsrsXLvxNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 16/19] xfs: clean up dqblk extraction
Date: Sat,  1 Feb 2025 18:53:52 -0500
Message-Id: <20250201145544-622a8b0b518925f1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-17-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: ed17f7da5f0c8b65b7b5f7c98beb0aadbc0546ee

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d744e578802a)
6.1.y | Present (different SHA1: 1fd830d98732)

Note: The patch differs from the upstream commit:
---
1:  ed17f7da5f0c8 ! 1:  ac9397950de5e xfs: clean up dqblk extraction
    @@ Metadata
      ## Commit message ##
         xfs: clean up dqblk extraction
     
    +    [ Upstream commit ed17f7da5f0c8b65b7b5f7c98beb0aadbc0546ee ]
    +
         Since the introduction of xfs_dqblk in V5, xfs really ought to find the
         dqblk pointer from the dquot buffer, then compute the xfs_disk_dquot
         pointer from the dqblk pointer.  Fix the open-coded xfs_buf_offset calls
    @@ Commit message
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_dquot.c ##
     @@ fs/xfs/xfs_dquot.c: xfs_dquot_from_disk(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


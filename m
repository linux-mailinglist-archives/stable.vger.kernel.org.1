Return-Path: <stable+bounces-105229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D49F6F1A
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF587189058F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DC515853A;
	Wed, 18 Dec 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKvRiZCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16237154BE2
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555661; cv=none; b=bgJZs4emE0kYDFmyiYy9hwMHu2YVkJXPMOAD6Ac1gYJDZI6gqoqGn1LfCDKr2bU1HQEa/qscahPb4OenI0nMUKB3DcvQ0vF7uba3fI5ElLPo/6WQS6KhxkYl3h6dx5z0LqEcNmREsTFlg2fF+SCjuv8piqRy87rorkM9GXY1k3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555661; c=relaxed/simple;
	bh=QjWbnGtF49j20HZ4x/U5W77atpkH4D4PS00ZO/oChGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdYTkCTIXblS4k2oEjtfuAoH+5rjSi7Gx+WPPH/oYqNpi64THFGPAqC7c6/Wz9/6UReRRKdtP4i6NljWj+/MO5mPQNNo93StogdmcRO1aqEIEVg5bexFKqIGunSAxUL8xWBtg2KQz98NA90ruKeRFoX3PffGGLZ546u8iKLTXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKvRiZCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23EEC4CED0;
	Wed, 18 Dec 2024 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555660;
	bh=QjWbnGtF49j20HZ4x/U5W77atpkH4D4PS00ZO/oChGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKvRiZCc8f6OsfO+/qlreFwd3lO2r5cuHgUXFFpu0894XYP384klxsHeuhvg6vvEr
	 BAfw8O36ENsNuHlVUEQSjaYcWnNzHyccl0fcaO7OdAvqjZ/dq6zFDykJTJdjk+b5bP
	 T1/BWX4bT73L2tUoqnnkKEvohb5hssaKFyQyrgc3yJl7jAGaihOuJ30kocNOFCde6G
	 CgQOL1f68i9v0OPOuD/msC4L10tVqmfdQM1bDefKn8jx1bYpXctMJCGSC6sZCVttgY
	 B1IxS6OBvT0U83rP+eGw7mkB8/gYiFMEQOiQouQb0/H1klq3gUIN2eW0Z/77HNlvuy
	 UA26Fp/kYsSyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 06/17] xfs: Fix xfs_flush_unmap_range() range for RT
Date: Wed, 18 Dec 2024 16:00:58 -0500
Message-Id: <20241218152815-b31a20f7f6f2fe5d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-7-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: d3b689d7c711a9f36d3e48db9eaa75784a892f4c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: John Garry <john.g.garry@oracle.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d3b689d7c711 ! 1:  d90eb08021a2 xfs: Fix xfs_flush_unmap_range() range for RT
    @@ Metadata
      ## Commit message ##
         xfs: Fix xfs_flush_unmap_range() range for RT
     
    +    commit d3b689d7c711a9f36d3e48db9eaa75784a892f4c upstream.
    +
         Currently xfs_flush_unmap_range() does unmap for a full RT extent range,
         which we also want to ensure is clean and idle.
     
    @@ Commit message
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: John Garry <john.g.garry@oracle.com>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/xfs_bmap_util.c ##
     @@ fs/xfs/xfs_bmap_util.c: xfs_flush_unmap_range(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


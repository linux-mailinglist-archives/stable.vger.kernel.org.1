Return-Path: <stable+bounces-111932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3928A24C40
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5C61885196
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F61CC881;
	Sat,  1 Feb 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulbw6wib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D378126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454044; cv=none; b=qgY+psH6UzH4GHLO+3GZLszAVUobHJQrxwdrzRlEn8N0Rhx4vLhB1PobOgmcCp7pKnL/ahKgPkVswLWf8xOLAXSF6spDHX6fmu/+T2uqpwJlUl94grke3snqQvSjw0rb1Uv+4AiYszYAHkgMtILnRz6uffInPeoI5dFH/5kGiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454044; c=relaxed/simple;
	bh=ydTO4mFVy7eL6K/0jxDQudgP7/rnT+HSU0+8LSM88Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjavFimKaTPxKqFt7mWKBbdnkJGBgLJAZla1r60GLUuiJzVOqZcziBrMxm8HvUYhxUm5TGRav1/5eMMJD9R+p41B+v1IocZaDEbA8Lhzcg4d07cN0oo2sbH/RGROX8gouOLkNUskmaVJV6eut9tDGwtYFCdCqiy6z1jZll6/eY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulbw6wib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A992BC4CED3;
	Sat,  1 Feb 2025 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454044;
	bh=ydTO4mFVy7eL6K/0jxDQudgP7/rnT+HSU0+8LSM88Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulbw6wibRmHuXLXSw/CUHVPONYNetA8rZ59/KQ/kaHMLQFGpn09moJhH3wOpMxG1J
	 Xqvk4POL6XpaI8yxESKcIACw3IU10W/1/Zo3DGbfL3t1WoeNtwCBhASFX5MGogkGtZ
	 5w59drhEWnzoWMaT1undoX0bmvzXPEP5O0lACNURGN/fc0nU2di2PHiyS6roi4/peG
	 iex/gYgu3TNMup9zKt4klV52IJdjsncKW/z/Bdri3De57NHGa6OwOLm8LCMX9p/FWt
	 HTmyhXYYzhD9Md7p3dSSwgZF+AUCWrdFcGu185J/maK4sLk14Sfq+W5yGQSU3GObl3
	 +GeYR8AXYe9Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 08/19] xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
Date: Sat,  1 Feb 2025 18:54:02 -0500
Message-Id: <20250201135907-e9503b516e0fb0a9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-9-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 35dc55b9e80cb9ec4bcb969302000b002b2ed850

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d4eba134c509)
6.1.y | Present (different SHA1: d2c306421d9c)

Note: The patch differs from the upstream commit:
---
1:  35dc55b9e80cb ! 1:  1dac0e648f50e xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
    @@ Metadata
      ## Commit message ##
         xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
     
    +    [ Upstream commit 35dc55b9e80cb9ec4bcb969302000b002b2ed850 ]
    +
         If xfs_bmapi_write finds a delalloc extent at the requested range, it
         tries to convert the entire delalloc extent to a real allocation.
     
    @@ Commit message
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_bmap_util.c ##
     @@ fs/xfs/xfs_bmap_util.c: xfs_alloc_file_space(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


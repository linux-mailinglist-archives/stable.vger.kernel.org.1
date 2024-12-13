Return-Path: <stable+bounces-104117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA569F109A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A11188381F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B71E1A28;
	Fri, 13 Dec 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7l4Fm0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2C1E00BF
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102799; cv=none; b=MknHBbWPxkSJfLlAKj9Q6wP1zL1EgeGSqF/p7KZ36Fs8xVMOnYIMTDI+PgHrEHRsiiFkdvCQykHL78XziZZ2LMVXmZucJdfHGW5NSZM9KWAeweus31n4xO/Jt15mgdsymFMoydg7scifOIJmK+KwgCpsNkMPu/Z6d+eWs7aDrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102799; c=relaxed/simple;
	bh=IbBu+KYFMTwWZhkmFsQdkxam4qOaiB3sNEouOFlI6rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKhLmRVUeyTpMDfibofAVDFuIOeQyDbxnRtg+NgG+xhk6azfXp1mVa2XJhQigQfrdxP0j30EO99xViiUq0IyDZUidSUS1xC1CqJIg5luQZYQBmB+TiMp1LQw271rKnrtcNFLvAxS5yq0Yv6CfPCQ1uHgoB48TBJHZBlTn8E67fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7l4Fm0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E649C4CED0;
	Fri, 13 Dec 2024 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102798;
	bh=IbBu+KYFMTwWZhkmFsQdkxam4qOaiB3sNEouOFlI6rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7l4Fm0PdRjReog97ntlhjJ4pSHgxt+p1Z7zKr8gKixz+1u+z4CMYDMWJHhLX1CCJ
	 sple9IlhVUdACkJIh5zqpx8iKXwX5ac/BzWsM2efPgapO6pXCSsNUNc9M0jyS8bXZN
	 Ic7AS/I4/eIy9bNLPGPNnsVBkvmGs5G3D3QAzHzU9a4nVWNjDdRhCJqhid6dtdiO+h
	 tP5T+mkOCZpxJurD5/SLabenZjyVVwKa0OlS4B5riKF4bUfQVVt/raeW85LWLZPlU3
	 7FX20NK0cYwQZKt2rg3kT8D/mwRyGNtVyZYuNkt7NysH9mRT1flbsXWbNzVLMi2lnb
	 MdTWwmKkmn78w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Fri, 13 Dec 2024 10:13:16 -0500
Message-ID: <20241213100358-ce596921e227a159@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213054350.3113655-1-guocai.he.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 7063b80268e2593e58bee8a8d709c2f3ff93e2f2

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Pei Li <peili.dev@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f650148b4394)
6.1.y | Present (different SHA1: bd04a149e3a2)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7063b80268e25 ! 1:  3d07377d81082 jfs: Fix shift-out-of-bounds in dbDiscardAG
    @@ Metadata
      ## Commit message ##
         jfs: Fix shift-out-of-bounds in dbDiscardAG
     
    +    [ Upstream commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 ]
    +
         When searching for the next smaller log2 block, BLKSTOL2() returned 0,
         causing shift exponent -1 to be negative.
     
    @@ Commit message
         Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
         Signed-off-by: Pei Li <peili.dev@gmail.com>
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
    +    Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
     
      ## fs/jfs/jfs_dmap.c ##
     @@ fs/jfs/jfs_dmap.c: s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


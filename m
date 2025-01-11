Return-Path: <stable+bounces-108294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EBA0A58A
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D0B7A14DE
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515281B4237;
	Sat, 11 Jan 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvPYU8m4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83422083
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622293; cv=none; b=KMzCffnIMU+MvN2gtVddpp87NLTabo5rVNytFMmKHiNIGnHk0j/N0BT2ybq6z3V95QUaLoUIzxDsrgfBbgEreOJ4lYVOlM5nnZAIs57w95/jt29n58dFsaP9UNoxbQkrSQRC2ONpx558jJDW3FilTLObd2ehYAr7XzkAdbo4yOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622293; c=relaxed/simple;
	bh=hkpGg9jswaJnn5yttYvcCYlPSNNTeRqZ/cLre5+BkaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsUAv1Jv5kuo06GqsPa2Q91uBvexhIvxmIHSAVOG4ZC4TOXLZfrSi/F1VpT0UG6rtMaO8AISNYOhinRYnFIlLHFaBWm5HaLMCK5pcgDJedRs1A0uBy2sVZ85nE9P4eRe/3SRWOYzAY3b59qagRuMMH7c5G8G4dKDL2FQHw7j4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvPYU8m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F9C4CED2;
	Sat, 11 Jan 2025 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622292;
	bh=hkpGg9jswaJnn5yttYvcCYlPSNNTeRqZ/cLre5+BkaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvPYU8m4syEWkWbcpDH62Pv5SRqyBIsokdSUpN46qgmcAjmZcW/IoOOOyAwLwUpI7
	 DOloJhTDeRmSiPlILK/sMmhllHBKIx99+m9mtnBoErWob2FRg5vqZhCh1vyEyZEN22
	 ebaAHw9/FDPAa9ggMP7q8ZqLgDt2NuK3rrqiBiA8Wlrku2AOYjoRz9GaF2pt0EIUwW
	 WEpkYz4vYghQr1LSpW6ZS88L95G3dp4U/jzmLduYbK/nNrR0A23ngHB4XpI4WFxV8J
	 iDRSSk/7Jo5zV6tIVUx5bXX/L/yEcIGYVY37ZwXyOkQ9iM63Qza2GTOUZ+GUsFS5o+
	 AJSelxPq4aNPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/3] drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset
Date: Sat, 11 Jan 2025 14:04:50 -0500
Message-Id: <20250111133306-ee0916fbaee0ad32@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110075844.1173719-2-dominique.martinet@atmark-techno.com>
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

The upstream commit SHA1 provided is correct: 6d2453c3dbc5f70eafc1c866289a90a1fc57ce18

WARNING: Author mismatch between patch and upstream commit:
Backport author: Dominique Martinet<dominique.martinet@atmark-techno.com>
Commit author: Sergey Senozhatsky<senozhatsky@chromium.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6d2453c3dbc5 ! 1:  70169b5d17a5 drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset
    @@ Metadata
      ## Commit message ##
         drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset
     
    +    [ Upstream commit 6d2453c3dbc5f70eafc1c866289a90a1fc57ce18 ]
    +
         We do all reset operations under write lock, so we don't need to save
         ->disksize and ->comp to stack variables.  Another thing is that ->comp is
         freed during zram reset, but comp pointer is not NULL-ed, so zram keeps
    @@ Commit message
         Cc: Minchan Kim <minchan@kernel.org>
         Cc: Nitin Gupta <ngupta@vflare.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
     
      ## drivers/block/zram/zram_drv.c ##
     @@ drivers/block/zram/zram_drv.c: static int zram_rw_page(struct block_device *bdev, sector_t sector,
    @@ drivers/block/zram/zram_drv.c: static void zram_reset_device(struct zram *zram)
      	set_capacity_and_notify(zram->disk, 0);
      	part_stat_set_all(zram->disk->part0, 0);
      
    + 	up_write(&zram->init_lock);
      	/* I/O operation under all of CPU are done so let's free */
     -	zram_meta_free(zram, disksize);
     +	zram_meta_free(zram, zram->disksize);
    @@ drivers/block/zram/zram_drv.c: static void zram_reset_device(struct zram *zram)
     +	zcomp_destroy(zram->comp);
     +	zram->comp = NULL;
      	reset_bdev(zram);
    + }
      
    - 	up_write(&zram->init_lock);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


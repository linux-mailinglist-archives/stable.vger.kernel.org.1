Return-Path: <stable+bounces-142944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839FAB079A
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DC04E82EA
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF21442F4;
	Fri,  9 May 2025 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIJ+GXGT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A691442E8
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755534; cv=none; b=XBByGLftx9bp9iH7J4hReOlZP558dzqqGDS2WgnymufyFLYZJr49OmYLRTXhCjNuM1S4jh1XOHZbVA7xwYqnaJ/Fd2xPvUjRcQb/EhiNCBvf2768/6wIAj3F2ZNKLepErt+TWA55tgSue8aUEBCdPVv3dq4T7pbHYAqouFjlCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755534; c=relaxed/simple;
	bh=VlYlVjJj1RorljuH4eNMTX2XpyATaWyXn5rBoEtxfTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USAa8/VeoX+Y73k33lcDL3RBa3dIFkgQVpjrjGT0ZInhihwg3kEjwhWPe157Rs7s6eVzzUw6UWdG8cNp3vcPwue0N3Dy0MqWqxN4r8RfJZzI1/8fmtgXujD1AYy3oG3hIyrTWVLYQx8ylJwGz3hIMZOaESN6bPgQHkB/4hJXfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIJ+GXGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF78C4CEE7;
	Fri,  9 May 2025 01:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755534;
	bh=VlYlVjJj1RorljuH4eNMTX2XpyATaWyXn5rBoEtxfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIJ+GXGTRtHBtJqDoQZ52GpmdMnkyKhksqzlUvFJwag2ZpNjNkJBH3iAz94aFTKED
	 J03xaEQLhHjVhvEWAC+BOD4wuq7kwhUPsiC9WJfofhvrgHA4xAj1l2qkI3fBObwfG5
	 loMO7guEYfXZeo42gwXmPs19Mt+e6sd2DX4Z066VyyrnWK+T7PrDfsr0zqKNKSTBkq
	 +9RSBglTjYsfz95q0OGI54IhPAg5l563LyOmnMaxVuI9SuJ8DmnoSKo5mVRbmkBK8e
	 AMP6LiCvrdahCv/t8VbbKwBHvlKI4NyeeCEm0EHtd5hBH/VJubgD0B2UPyOymBMY92
	 2saVYtsUsS46A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] btrfs: do not clean up repair bio if submit fails
Date: Thu,  8 May 2025 21:52:10 -0400
Message-Id: <20250508132012-dffd88be939cf54b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250508122355.99249-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 8cbc3001a3264d998d6b6db3e23f935c158abd4d

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Josef Bacik<josef@toxicpanda.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8cbc3001a3264 ! 1:  90c24cbc95555 btrfs: do not clean up repair bio if submit fails
    @@ Metadata
      ## Commit message ##
         btrfs: do not clean up repair bio if submit fails
     
    +    [ Upstream commit 8cbc3001a3264d998d6b6db3e23f935c158abd4d ]
    +
         The submit helper will always run bio_endio() on the bio if it fails to
         submit, so cleaning up the bio just leads to a variety of use-after-free
         and NULL pointer dereference bugs because we race with the endio
    @@ Commit message
         Reviewed-by: Boris Burkov <boris@bur.io>
         Signed-off-by: Josef Bacik <josef@toxicpanda.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/btrfs/extent_io.c ##
     @@ fs/btrfs/extent_io.c: int btrfs_repair_one_sector(struct inode *inode,
      	const int icsum = bio_offset >> fs_info->sectorsize_bits;
      	struct bio *repair_bio;
    - 	struct btrfs_bio *repair_bbio;
    + 	struct btrfs_io_bio *repair_io_bio;
     -	blk_status_t status;
      
      	btrfs_debug(fs_info,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


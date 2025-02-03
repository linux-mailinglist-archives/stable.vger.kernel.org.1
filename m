Return-Path: <stable+bounces-112044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EAA25FD5
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DDC3A8971
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7420A5FA;
	Mon,  3 Feb 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+1zQGhf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66EC139
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599901; cv=none; b=hkAFmiNAhPhlPIPhn8ugBkvU8hzJJBZN3Bk/FEaVbd5ko8uagEeaNmlAAWeodGWgi6HanaL9G5E1g3IOo2YR+7buAeDb+3+ewE7ODx7IRmkGXZlSWvjXrx6Ttmg1Ezyg8i6ns45nl+a4QhuLQyjN4yhmOkDrU0gtuqrupaQE+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599901; c=relaxed/simple;
	bh=RPnwHV/8nyCcMuW3mXRY833SVqXK/G33yDJJBB4ddQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kywr8tinXCX+2hqiTyUu2ZKkcJUf0eoMqo5DExbifyTJkAAC3FmSekBDO7wIOE0Rz2iu0T4lYp5NzAUIKLGZAC0vVF3Q5/whTcXVwXppKtPB6GOxQVwBhI34qhfenwUFsAhHRzzbr6uPw9yQEUZBmWlspzeSpb60fWE0pN7+2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+1zQGhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3461C4CED2;
	Mon,  3 Feb 2025 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738599901;
	bh=RPnwHV/8nyCcMuW3mXRY833SVqXK/G33yDJJBB4ddQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+1zQGhfukLRA1Uawfsn+MCSLKoXJ3ojKjUk6lYEAR15FigoFOahVoxZ4rA35V4ys
	 X4WxSxDd0qHGtmfYM4dP2oqGTlC5c57+ZNWNfVOOzB2+YpYcWN5WosIMa3/SjZYYU1
	 fddy48FMZg+6PaqEkg6/9dPzdYm/XTt3RwKiMkRhULzP768KxMBShLokjIzMAoXhqV
	 WG7qDBWIrUVBvQvu1xxJEhxdmFhpp7HJ2v4hM7PoYVnJTbC94sm6C4970BT6RsWncU
	 DXYLBDX9FUPaXtDT2/r/x5ZscReYJMwqroSvtS52xMzhMO1vepii8+dRQvwAiJkQuO
	 QOchdqjNcUcMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shubham Pushpkar <spushpka@cisco.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
Date: Mon,  3 Feb 2025 11:24:59 -0500
Message-Id: <20250203104935-39bd7456ad0b6156@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250203104254.4146544-1-spushpka@cisco.com>
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

Found matching upstream commit: aec8e6bf839101784f3ef037dcdb9432c3f32343

WARNING: Author mismatch between patch and found commit:
Backport author: Shubham Pushpkar<spushpka@cisco.com>
Commit author: Zhihao Cheng<chengzhihao1@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  aec8e6bf83910 ! 1:  387b408516f7c btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
    @@ Metadata
      ## Commit message ##
         btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
     
    +    commit aec8e6bf839101784f3ef037dcdb9432c3f32343 ("btrfs:
    +    fix use-after-free of block device file in __btrfs_free_extra_devids()")
    +
         Mounting btrfs from two images (which have the same one fsid and two
         different dev_uuids) in certain executing order may trigger an UAF for
         variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
    @@ Commit message
         Fix it by setting 'device->bdev_file' as 'NULL' after closing the
         btrfs_device in btrfs_close_one_device().
     
    +    Fixes: CVE-2024-50217
         Fixes: 142388194191 ("btrfs: do not background blkdev_put()")
         CC: stable@vger.kernel.org # 4.19+
         Link: https://bugzilla.kernel.org/show_bug.cgi?id=219408
         Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
         Reviewed-by: David Sterba <dsterba@suse.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    (cherry picked from commit aec8e6bf839101784f3ef037dcdb9432c3f32343)
    +    Signed-off-by: Shubham Pushpkar <spushpka@cisco.com>
     
      ## fs/btrfs/volumes.c ##
     @@ fs/btrfs/volumes.c: static void btrfs_close_one_device(struct btrfs_device *device)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    lib/test_dhry.o: warning: objtool: dhry() falls through to next function dhry_run_set.cold()
    fs/btrfs/volumes.c: In function 'btrfs_close_one_device':
    fs/btrfs/volumes.c:1179:23: error: 'struct btrfs_device' has no member named 'bdev_file'
     1179 |                 device->bdev_file = NULL;
          |                       ^~
    make[4]: *** [scripts/Makefile.build:243: fs/btrfs/volumes.o] Error 1
    make[4]: Target 'fs/btrfs/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:480: fs/btrfs] Error 2
    make[3]: Target 'fs/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:480: fs] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1921: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.


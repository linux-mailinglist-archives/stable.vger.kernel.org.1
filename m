Return-Path: <stable+bounces-108216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D59A098BA
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2FC3A3444
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B62139A8;
	Fri, 10 Jan 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pABdgmoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7529212B17
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530757; cv=none; b=I1lPXytRv/6l6VXMKuRPVaOli1B7biwVp2jlB00CoxnwVrE+oIjC4sAEvT09dCO59GE2Rhc011hwcc3mdF8Lxjbdm8uSJFuR04mawonra6NwqEAaC1Gg7M5LOz5B6EOljBQjhEVJAKQqJNEb48pQGmSgHJb7S1Eb/0r04t9Cc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530757; c=relaxed/simple;
	bh=cie0VSkXjWT6PI5GD1M33HD/GkdD8UxfA10nIaNSIHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnQrku0ys46TICWLlM/FrKtyLhUtuT5RqVQBlb47juu33dP+dt78waBNc1HTZX1e6Cyvg7Qj4A1R3ItjPpLboMt6K+bjrURL0/16YZSW1cfTEJTaSVCKsetzPkktyyi3Qs6Q8EuWyIhXyUULqkfTd0CMbIGuJJlLTvrFnV9T/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pABdgmoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BA2C4CED6;
	Fri, 10 Jan 2025 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530756;
	bh=cie0VSkXjWT6PI5GD1M33HD/GkdD8UxfA10nIaNSIHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pABdgmoCa/SLV1XBVdwrELuDH9LBeJOzF9uVvOXsSi/ZogYwZKoYmBf0rmADpiYC8
	 1SzGqMyM8zN2IBp70yxzqY1H+5Kjc4YAFSFZjS/Bf8382vJWgB3GCU1xPFO9LbpawY
	 31uZNxszIBm+jkrIBhQ4m2xwCSjAcffItJtmW4uulB8A0WR4ybvJ4E10R1xDm0+QLD
	 UAj+41cENOBiZoMqCGhmNWGj/+Ie8H5/r8td2pD+OJthzfaqnRsgg2K6teOWfTq/km
	 5XT/7kl3XAe3XInwBXRU0+2SpaenTnlHxb9VJyKCEFIsZWu9QAyWwQvAabVHbVBFKe
	 VNQ7iHVipcpQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
Date: Fri, 10 Jan 2025 12:39:14 -0500
Message-Id: <20250110103606-aaa23db4e384ba9c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_870C520322ED6ECDC9078DE499753B0E1506@qq.com>
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

The upstream commit SHA1 provided is correct: b7d0a97b28083084ebdd8e5c6bccd12e6ec18faa

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Ye Bin<yebin10@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 9e11b1d5fda9)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b7d0a97b2808 ! 1:  73a09904eb0d f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
    @@ Metadata
      ## Commit message ##
         f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
     
    +    [ Upstream commit b7d0a97b28083084ebdd8e5c6bccd12e6ec18faa ]
    +
         There's issue as follows when concurrently installing the f2fs.ko
         module and mounting the f2fs file system:
         KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
    @@ Commit message
         Signed-off-by: Ye Bin <yebin10@huawei.com>
         Reviewed-by: Chao Yu <chao@kernel.org>
         Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
      ## fs/f2fs/super.c ##
     @@ fs/f2fs/super.c: static int __init init_f2fs_fs(void)
    - 	err = f2fs_init_shrinker();
    + 	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
      	if (err)
      		goto free_sysfs;
     -	err = register_filesystem(&f2fs_fs_type);
    @@ fs/f2fs/super.c: static int __init init_f2fs_fs(void)
      	f2fs_destroy_root_stats();
     -	unregister_filesystem(&f2fs_fs_type);
     -free_shrinker:
    - 	f2fs_exit_shrinker();
    + 	unregister_shrinker(&f2fs_shrinker_info);
      free_sysfs:
      	f2fs_exit_sysfs();
     @@ fs/f2fs/super.c: static int __init init_f2fs_fs(void)
    @@ fs/f2fs/super.c: static void __exit exit_f2fs_fs(void)
      	f2fs_destroy_post_read_processing();
      	f2fs_destroy_root_stats();
     -	unregister_filesystem(&f2fs_fs_type);
    - 	f2fs_exit_shrinker();
    + 	unregister_shrinker(&f2fs_shrinker_info);
      	f2fs_exit_sysfs();
      	f2fs_destroy_garbage_collection_cache();
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


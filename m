Return-Path: <stable+bounces-104115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6699F108C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686CD163CB0
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40B1E1C1B;
	Fri, 13 Dec 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RReKA3ma"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D321E04BF
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102794; cv=none; b=JLDDXAjtYP2qopI030vHuNvQbofXMFHQ/4wklVX0hkNiteJ4CdQzV5aWQ/8CBqLJTf3jFxgci26NZxQxwIbovXsID0G+IeFd4FRSeN4d5dBhPu+dDB2nKva0kWdRsT8BtZXO6y8R3so2rChF2kb+s8wTV6N5YtKNyOvqkvgxuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102794; c=relaxed/simple;
	bh=S7qW+U8SVu37AEr8EmA6bf1UqHY+l24MZujz2rFV468=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umcxOQhp+nvXEl49D7iDsDoz8rUzxgmeTYgb7+mzSarJpfvyMHvpGJhOTiQ0DNKSSY/awHpgGl4B/hcGLRv8lNC2nwtvDS2KQFur/DzZUXxdboiH0Z9nhVK6qviGrU4qTSb2DcPPR8HwbCD1PZVNhRsG3HO0B8N26+QUP4EimlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RReKA3ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FA5C4CED0;
	Fri, 13 Dec 2024 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102794;
	bh=S7qW+U8SVu37AEr8EmA6bf1UqHY+l24MZujz2rFV468=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RReKA3maC/15rG5Amom80vFdKym3aUdJXZI3CKeE5LS1cFzDNJO4mOFaTZEXF6cRD
	 MPs/Y/cLvt/JH1jKFbfSDL5p/1QZ7+ydIAPudmzjQXiREY+TcY0TouHqILSLUZy4Ws
	 aFsWVfnkUSA3IjHj+EjDpmmlD1aUI28hj83Z9CzuUKWEbvTy07/jMnX3/KcErf/+Mc
	 hqmVbp/YuUgfXeS7jMl2qsmdHj020Ks4axWlbw4wnURmH+ZJZfXPBiJx8+mf5lEdss
	 d4muwXbWSrVJP1l3WyPpaoAR3wIF4MnnwLb8m05T7shWPFcTIW5EgN5ButseeBd1lb
	 hOV9h9C1hhuQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Fri, 13 Dec 2024 10:13:12 -0500
Message-ID: <20241213095854-2f81422cdd663754@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213071055.3601224-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: b4b4fda34e535756f9e774fb2d09c4537b7dfd1c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Baokun Li <libaokun1@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 23afcd52af06)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b4b4fda34e535 ! 1:  5f07a4e2bb575 ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
    @@ Metadata
      ## Commit message ##
         ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
     
    +    [ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]
    +
         In the following concurrency we will access the uninitialized rs->lock:
     
         ext4_fill_super
    @@ Commit message
         Reviewed-by: Jan Kara <jack@suse.cz>
         Link: https://lore.kernel.org/r/20240102133730.1098120-1-libaokun1@huawei.com
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    [ Resolve merge conflicts ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## fs/ext4/super.c ##
     @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
    @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct supe
      
     -failed_mount10:
     +failed_mount9:
    - 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
    + 	ext4_quota_off_umount(sb);
     -failed_mount9: __maybe_unused
     +failed_mount8: __maybe_unused
      	ext4_release_orphan_info(sb);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


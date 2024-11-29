Return-Path: <stable+bounces-95824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA599DE9D5
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F7162C20
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CA145324;
	Fri, 29 Nov 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALkpWT/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9923C145A17
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894880; cv=none; b=hRWQe1kQ9EqrXGgkrExvqTMMK8rsWTJSvcaoHJyp1gf9erxvOeBe0/awVz4FXp9zW1VPjgZt2HXaRYDJDDlKXtn+REjgiNUFsSIzse4aMM4zr8EbHWBj0HvAp8wcl8YbNrsTkGFVu/nStpGi3dn7qv0tbhZRZQNKLtUXmzTG2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894880; c=relaxed/simple;
	bh=reU66YkntxMzhGMiqCtkMCOmgLd52sSKQ/l8yIfpFFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCFSU85SMg6ZlS2cix+MmQn6kVluZN7grEqZR455ll7yKtL6anVgTOOFIjOAXaIyrErZoppIdnN6Osp4wmB/mkDVnD1KKsUSWyHBf6TRoLbE2e4Gk0OE/LSPNTw8Pu04w4f/52p5Vdvkr7wsJcNNKr/SfeLJ3v6OBahEtxiX+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALkpWT/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01B4C4CECF;
	Fri, 29 Nov 2024 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732894878;
	bh=reU66YkntxMzhGMiqCtkMCOmgLd52sSKQ/l8yIfpFFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALkpWT/hBSOfRiAJYaBKxgH/K4lQkDWlmGbRXnwBSWbKxB27g0mzKY3xmZeSF9DsQ
	 eNLDrZuTc5NfbDX9kbvoBSj0gGTonb91rnHlbRH+OcNbqhtV86ts5TM8L9LU2q0gyJ
	 VO9vlAA1JCcToqxNEvKxTu81EPD00PqtqTBPsLdcGEaVWv9Ha6TR/rq9+BdW1NHWqA
	 zTZLGb/3oFmi4np4AaxTW0OSqv2J1+tSd+dxDeB+HNcM6hLOAejiDSuG8ozsNzbaba
	 0fXkHUSM0Piu5TsHSIoqzrrbIncUjkgDQMfP19PRF40dBpeduWbMpzFztCec2iN7Jr
	 CLxU2Z+t6Qf3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] erofs: reliably distinguish block based and fscache mode
Date: Fri, 29 Nov 2024 10:41:14 -0500
Message-ID: <20241129103725-f5913823df104fcc@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129074059.925789-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Christian Brauner <brauner@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f9b877a7ee31)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7af2ae1b1531f ! 1:  bc9478262d424 erofs: reliably distinguish block based and fscache mode
    @@ Metadata
      ## Commit message ##
         erofs: reliably distinguish block based and fscache mode
     
    +    commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 upstream.
    +
         When erofs_kill_sb() is called in block dev based mode, s_bdev may not
         have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
         it will be mistaken for fscache mode, and then attempt to free an anon_dev
    @@ Commit message
         Reviewed-by: Chao Yu <chao@kernel.org>
         Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
         Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
     
      ## fs/erofs/super.c ##
     @@ fs/erofs/super.c: static int erofs_init_fs_context(struct fs_context *fc)
    - 
    +  */
      static void erofs_kill_sb(struct super_block *sb)
      {
     -	struct erofs_sb_info *sbi;
     +	struct erofs_sb_info *sbi = EROFS_SB(sb);
      
    + 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
    + 
    +@@ fs/erofs/super.c: static void erofs_kill_sb(struct super_block *sb)
    + 		return;
    + 	}
    + 
     -	if (erofs_is_fscache_mode(sb))
     +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
      		kill_anon_super(sb);
Using kernel version 6.1 as base for comparison
Comparing backport with upstream commit using range-diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


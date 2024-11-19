Return-Path: <stable+bounces-93906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC449D1F59
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB01F226A9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29279150994;
	Tue, 19 Nov 2024 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeGAwzJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA281459F6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990993; cv=none; b=k9u/PMDDkc7vAr1fKFSFMACSuD/847PBVzWpPl7v0ybbQCR/sAUs5DsGO+JXjM47rITN29HT17tfNF4qmckFqULEwXjZ3UFzoZUw2mr288EL2d2nK8e68jnW0F33ggI1dz9rlcB+/w2cRqvmr4QqAQfIWYUEA9q50FmWe8RSi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990993; c=relaxed/simple;
	bh=tKpjcykir+6ISqJT1uczCxoj48Ekr7FDn1bijRpl1eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdU58WtgGQdjS0J0nEnr4hdmwnKxwzpIEbm/FB9CLa8pxJXhcMsTysS6Q6xd0s5/U4RNDSllF+zut/j48oGFTgezUEysB247s8pJa/NOb1+kpBdHSbyQENagN0RAWFb9M15IYYowR5mvVgulx0mvTik9+bQ+e1TnvrDZgnvW9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeGAwzJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC27C4CECF;
	Tue, 19 Nov 2024 04:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990993;
	bh=tKpjcykir+6ISqJT1uczCxoj48Ekr7FDn1bijRpl1eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeGAwzJeFd/6jxOYmDoErlRb8qQyG8dx22h8Z47iRAr9w4f98pRewzEGS8XtrxAzd
	 Uge8gsoD/925/DR4DaQHLxm3y5GsfQnC9Tw+/WBxT0k08C7V8GPyU3L62Qb2U3vMVF
	 l6/nul+Pbk9zIzeccvooL4XSrZz9WhP4KOrhGQEz7L6/qWDx8aW3oth2fYW9NcVlL/
	 I7+ipYTgm0+tJqpm09aP3LJvjcS9sadm3M9n0mryOw3lw3RU62/fGCWQVfiJc1TTP3
	 vCnyRiMYgniXJjSHeuvlr+7wx3c6YkHHh4WyF45A4p9Tcn99ZJsJybP2Rif4KxMlWJ
	 nbCIOLj0RRPYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/3] ext4: factor out ext4_hash_info_init()
Date: Mon, 18 Nov 2024 23:36:31 -0500
Message-ID: <20241118102050.16077-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118102050.16077-2-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: db9345d9e6f075e1ec26afadf744078ead935fec

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Jason Yan <yanaijie@huawei.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:26:48.895059440 -0500
+++ /tmp/tmp.VjhMY5d2bY	2024-11-18 17:26:48.887055706 -0500
@@ -1,18 +1,21 @@
+[ Upstream commit db9345d9e6f075e1ec26afadf744078ead935fec ]
+
 Factor out ext4_hash_info_init() to simplify __ext4_fill_super(). No
 functional change.
 
 Signed-off-by: Jason Yan <yanaijie@huawei.com>
 Link: https://lore.kernel.org/r/20230323140517.1070239-2-yanaijie@huawei.com
 Signed-off-by: Theodore Ts'o <tytso@mit.edu>
+Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
 ---
  fs/ext4/super.c | 50 +++++++++++++++++++++++++++++--------------------
  1 file changed, 30 insertions(+), 20 deletions(-)
 
 diff --git a/fs/ext4/super.c b/fs/ext4/super.c
-index 690faf766d23a..13c0345c53873 100644
+index 3bf214d4afef5..cf2c8cf507780 100644
 --- a/fs/ext4/super.c
 +++ b/fs/ext4/super.c
-@@ -5024,6 +5024,35 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
+@@ -5042,6 +5042,35 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
  	return ret;
  }
  
@@ -48,7 +51,7 @@
  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
  {
  	struct ext4_super_block *es = NULL;
-@@ -5179,26 +5208,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
+@@ -5197,26 +5226,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
  	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
  	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
  
@@ -76,3 +79,6 @@
  
  	if (ext4_handle_clustersize(sb))
  		goto failed_mount;
+-- 
+2.33.8
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |


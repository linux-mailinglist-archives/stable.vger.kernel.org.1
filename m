Return-Path: <stable+bounces-111113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C609A21C0F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E33A37C3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788321B4153;
	Wed, 29 Jan 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqH7auFc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B931AD403
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149705; cv=none; b=T28PoKQsvk4ES7W7klG4jxW95Ju+f6dPoZhVRZcoQePqEVLNQEojgj7ofto8VqeH3jVZUktqvHgSbf2wCVzZ8gbVinpTpWlqDQg3QoylM5LlT4AiNpG8JCnqfCr0U3CRHckxFUypTh1j2odFPXEXiMG2QyOymc82FkBKU6ytLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149705; c=relaxed/simple;
	bh=G9B9ts9KDf4ggBzMb0EM33xgtXnEhwL+vAYPIR4Pa+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oa2K18+d/yGhjLkwiqtrccghop3wP34ZfwtgOhCdoMDOMxMQ/2+sxG9fajmCVrmFOogJsbxhI/CrN+wuoYaaan+IpqRVbNMYzuBSwZu62XYaIz9Pyjkke4pHDWkbaJ8VQBkDdbEKobnREiTRI1Zxu9ZtoWwvwHPe+49JXgfJsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqH7auFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F429C4CED3;
	Wed, 29 Jan 2025 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738149704;
	bh=G9B9ts9KDf4ggBzMb0EM33xgtXnEhwL+vAYPIR4Pa+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqH7auFcgRjhZmL5EwnU+vjx5VnD1u5TJ9XxIX0I6QfEE52Bq4J9P02UXnLt/QIrS
	 4nuY4LgLjpSakYrqR8+nv6WgtpLsz30k0EqbgCFPM7n1tPD8v/2d4Ya4qjKk7oyyuO
	 sFzwR1BwDv2XTsSA70RiGwFjl361lHvnGaManEaaqMAkWy5vfRpXLaaR5CfaJhRoe5
	 r8JLCSW4lbMvbNAGO3AZ7vePn2alvyc+Y8RzO/mscAx/USRh+TgT0QO9Jgo3roodBw
	 d9KbnJad0yC3HMcyNX03uMEDSolMXhT+f6GutNTWCL1EEJn7PsxCeImUpVbZJy7ffM
	 V7tkpocR4KXaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: vgiraud.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] ext4: fix access to uninitialised lock in fc replay path
Date: Wed, 29 Jan 2025 06:21:42 -0500
Message-Id: <20250129055448-06eddbf7ca29c76b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129101046.105471-1-vgiraud.opensource@witekio.com>
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

The upstream commit SHA1 provided is correct: 23dfdb56581ad92a9967bcd720c8c23356af74c1

WARNING: Author mismatch between patch and upstream commit:
Backport author: vgiraud.opensource@witekio.com
Commit author: Luis Henriques (SUSE)<luis.henriques@linux.dev>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  23dfdb56581ad ! 1:  366f73b541bff ext4: fix access to uninitialised lock in fc replay path
    @@ Metadata
      ## Commit message ##
         ext4: fix access to uninitialised lock in fc replay path
     
    +    commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream.
    +
         The following kernel trace can be triggered with fstest generic/629 when
         executed against a filesystem with fast-commit feature enabled:
     
    @@ Commit message
         Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
         Cc: stable@kernel.org
    +    Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
     
      ## fs/ext4/super.c ##
     @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
    @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct supe
      	 * used to detect the metadata async write error.
      	 */
     -	spin_lock_init(&sbi->s_bdev_wb_lock);
    - 	errseq_check_and_advance(&sb->s_bdev->bd_mapping->wb_err,
    + 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
      				 &sbi->s_bdev_wb_err);
    - 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
    + 	sb->s_bdev->bd_super = sb;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


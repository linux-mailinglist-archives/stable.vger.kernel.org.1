Return-Path: <stable+bounces-110811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BAA1CD53
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD951886AE6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F334155725;
	Sun, 26 Jan 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/crxhh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066B335BA
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737912175; cv=none; b=DzPHm+G9Ag/6/Cuiu/4cIKRS+DfSJnseHxRbXC4fs2aZYfIKdRAjN5GhGVA9MJYzxu6FkWMRhKzAnVj91TTp5umveah9z8eDXNz4+LaxKXJREcXr+WIqm8qiPLmWmvpj3vmwFIDJiArD6StpGU689BB0X3+RdV1V85aV2tEHYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737912175; c=relaxed/simple;
	bh=JrA6EYPrIab3pOwhAvvuSOl2nvKTtrpO2JkCQcP9QNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQJKqfsB5UYBRsv8cPBudnsl6twZ8yJstYBlxVBuslcVyyux6r3ZLk8QAY9SuD0iJBcwApJIh/IljyzRaUToL4E08VQculQOJOOZsKXYM316nyScpZpOaYJ419gTYoj2fTc7cMyjgJFRccmxF4DbeMJxdtMAzKlOVI/hXb0iqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/crxhh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36F1C4CED3;
	Sun, 26 Jan 2025 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737912175;
	bh=JrA6EYPrIab3pOwhAvvuSOl2nvKTtrpO2JkCQcP9QNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/crxhh0nSs9rMBBJhQ2nlWq0SfQ9l9u9TZCppoX48FnaNDsHjN0ntsMbR0iVnfZ9
	 LgGXInj+GhgPsPQpVqN/bZyZDpsUfCv3f78BmMrbVwM029nINyUUJj5WAl9HTkTdBn
	 80z0ynB+q/Ij/gfUSa13L65cjCQOh7YMRJge7Ixhm+WP0VXBKSW71PBbcKNpOzNwbu
	 WzH27LMIxP4ojYNax/QZ82N0DRDKtRWRVSVRdslsz/S/DFhY4XoQ0JEN/bSOENynhJ
	 qST8HANcP+1fTzoSZA0AYwscXU7bqC03jJhgipoW3FG5bgx4QPQXTlPiEO3dziL7pc
	 +CIDrm1vc+lZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] ext4: fix access to uninitialised lock in fc replay path
Date: Sun, 26 Jan 2025 12:22:53 -0500
Message-Id: <20250126115738-7c8380bbb2949cfb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250126072620.8474-1-imkanmodkhan@gmail.com>
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
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Luis Henriques (SUSE)<luis.henriques@linux.dev>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  23dfdb56581ad ! 1:  c5ee4ab8bc5ee ext4: fix access to uninitialised lock in fc replay path
    @@ Metadata
      ## Commit message ##
         ext4: fix access to uninitialised lock in fc replay path
     
    +    [ commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream ]
    +
         The following kernel trace can be triggered with fstest generic/629 when
         executed against a filesystem with fast-commit feature enabled:
     
    @@ Commit message
         Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
         Cc: stable@kernel.org
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
      ## fs/ext4/super.c ##
     @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
    @@ fs/ext4/super.c: static int __ext4_fill_super(struct fs_context *fc, struct supe
      	 * used to detect the metadata async write error.
      	 */
     -	spin_lock_init(&sbi->s_bdev_wb_lock);
    - 	errseq_check_and_advance(&sb->s_bdev->bd_mapping->wb_err,
    + 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
      				 &sbi->s_bdev_wb_err);
      	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


Return-Path: <stable+bounces-100644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741D9ED1D5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF11664D5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94451A707A;
	Wed, 11 Dec 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlcChbLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6C38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934728; cv=none; b=SN3grnMaKgYgO14IwVDOOvjeLhROB/ZeB/dlQ/xLi78kH1H6zWoIKPivyCP1Khs+0zIKiMXPw8cSwg9ORxwCAqJW4fUbQOHJNU0/BL4Ik0Fvc+ZYo7PtBZ92c/4ubj5Xrx0Q+Cb8xyFHW23iH60L0jzV5JLCX6PBXazzKHeI7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934728; c=relaxed/simple;
	bh=muHkcCIe3ZVIUuV6As6kJAYEiLYdqqGnWuIg5dx50G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnm2koD9VXZlREUUh7Lk0PzhXF3t2sA3cnJq1QD2NfeuppGyYoQTnGktL1xZGB9VuIwze1xsHrv1O/Qre41XKKE2M4UwFmRMhDpcpEGtsKTUnzTZkVRCHIHKWs43sRLEapPo5kMqT1GmWscSwdYnejRzaMOLj+538q2aLnWJRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlcChbLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CF4C4CED2;
	Wed, 11 Dec 2024 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934728;
	bh=muHkcCIe3ZVIUuV6As6kJAYEiLYdqqGnWuIg5dx50G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlcChbLPakEbaoqPBN7f2BKIi3lGBW9lwZ5OOcCr4b3xy6/5WEBiSM9iaMzpwYeB5
	 r71eW5mh+Y2i49FuueenyWrXoEm3MwLFwlszDO/4AXnOyn7tS4COwkwzIHMLQquwRO
	 J28ue53xYcPV25PRABn8Hra6xdgUJgdyWk2kktSWaYZN2sksXzn6eyzLdy7eT1EYo9
	 KLmtT1E8v+Vh+2WP4obmdtMsMLyYXeSk3W6gs9w+4L7vljWjVr8gfEIwNcDcGUFe/h
	 ZGVIUkkUvNVsoxurElezsvFDQ01VIFXEKDAQmPSsx/iYUbm3REBRV6UlTgfJy1wD55
	 PgM7Mefw2Ogzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ext4: fix access to uninitialised lock in fc replay path
Date: Wed, 11 Dec 2024 11:32:05 -0500
Message-ID: <20241211092049-6ab9bd02f0b06158@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211041310.3383060-1-jianqi.ren.cn@windriver.com>
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
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Luis Henriques (SUSE) <luis.henriques@linux.dev>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  23dfdb56581ad ! 1:  df7ded8c165b0 ext4: fix access to uninitialised lock in fc replay path
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
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
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


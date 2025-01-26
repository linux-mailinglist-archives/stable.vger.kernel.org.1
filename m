Return-Path: <stable+bounces-110812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE9A1CD54
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FEE3A121B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE3156C72;
	Sun, 26 Jan 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEoZsjMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E6335BA
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737912177; cv=none; b=CnaBSlNZNxbaVx79/hO+52gU1miEy1zniWYbss6kwiLqu2TJJlD2v3YOAVeF6NFaZstVV3+X1fcA6kzq1f2BHIIAmoTHt0LaA8lJyQNFEs9Xx0gaNMoXwAxc8gMuPcp+FLSB8ADNb/jmtPvWcOKu3Wop2MyaaODEq14i2xkIcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737912177; c=relaxed/simple;
	bh=yn5OdLIYC6fkapiybJaz6iaaRs4ufjBRmkcUKRbLdBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJJU9X7lE73SNzXOOls5sZMquBjHL7LnxudwUcmsqChXNs5wP+0CxAMZlcBU5YNDlUoej5jAeoTdnjhdSmUfTZKOLt70aDvwzSzb4KFeFIoAO71A8Z/l8YCO5ETnFb7Sci4SRJfMs6MgIaeqX5aUORWMk0atDKeZw6zFa5ZuBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEoZsjMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74FCC4CED3;
	Sun, 26 Jan 2025 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737912177;
	bh=yn5OdLIYC6fkapiybJaz6iaaRs4ufjBRmkcUKRbLdBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEoZsjMiuUFGW/jcfDX7cZM00w4GsOFoZ1Bn4hUiqPCE5PDEvcB9P5KiiU8ZeWPhV
	 Qlf5Y2gDk0trWen2N1Q7RW4aLGt9QPxaZPYKe424kMzMGIoMBmlPfEOYcwsKGd241F
	 nv0GLNjO0mI4F3Wtij+EuhumPosd+zgh2+g/1gGhIjaYtv8z0csy5YSzR/k7o87lgs
	 J8RI0YvEvqFGQYl3pmVBSlI97OidT2RrNv3/nbXdUhx9xsdWCRowHt8KDTX5I/FB6Q
	 WpAoflIqNM/qjQinYApdhcHR6rR6dBiHId9k51IndiGrTgqIz1iNzFO29RmsY87buK
	 BjxDYUKI1PYRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ext4: fix access to uninitialised lock in fc replay path
Date: Sun, 26 Jan 2025 12:22:55 -0500
Message-Id: <20250126121233-a58193a8a58e000a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250126070620.8071-1-imkanmodkhan@gmail.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  23dfdb56581ad ! 1:  d82aa31efc3cf ext4: fix access to uninitialised lock in fc replay path
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
    - 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
    + 	sb->s_bdev->bd_super = sb;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


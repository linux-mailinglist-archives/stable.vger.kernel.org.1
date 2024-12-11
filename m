Return-Path: <stable+bounces-100668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F029ED1F2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D2E1887DB4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5861DDC11;
	Wed, 11 Dec 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGr1TP7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51E1DDC09
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934783; cv=none; b=WLG5a6TmES8JwjUjM7KPvTUZYrsb9mGryJgZcuktKp8HJDHoQpJQe6im1N0eWaA5X/gNLQeVTuSBal1p66vGUhdUHENpUjJUwAVOvTLpcvU+8l9+Est5nPCljk4nd2WJs8ULlS9UeOawsxaxmRvDcPFrT0/730kKXoqSeWR8hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934783; c=relaxed/simple;
	bh=BtKFCRnkyD8bD13XloL/S5c9sPYd4ebF6K/EQDbpehI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvrzVh2zWTiUYL4IvM1A7UfxY3xQjppxLvmTY1RcERbrdqMAyG2eUGkzVz7r2RdtuwrASBoHrfWo8MpHU1E6lDvKcBHG2MdBluSKoFbEu74xrAKOn5/SWfEQvHFDhvLzs5ZN3oRXKscCz/va8trnGHdMzSSmYL95hXl74ndZ+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGr1TP7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2806CC4CED2;
	Wed, 11 Dec 2024 16:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934782;
	bh=BtKFCRnkyD8bD13XloL/S5c9sPYd4ebF6K/EQDbpehI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGr1TP7FWIFqFDE2J5Rv/G94y4m87Nv1W9TrcQcrc1kNFq2gvh3XxTucbgvkggj8z
	 am1OfZbh8pAmiugQjfg/uk65QpV+1cPn+eDwiEpqkcg4IC6aJItqLlnWsD5LbceC8o
	 Qihs2AijpB+BtIjYPPU2xc7WhZyjjKfSek9b5py8CJUl/saWos9Fc34dEN7OTLe+Db
	 Pn8RfFUmHD0tyZkjxMdQkAn9iwImbAslHlEwPGysPmjLz18CABIpSml4n1O7t5Hfzq
	 iiJOHeQyP6imJvI8/jRm5+EoUlFFUBuVZqceeUXy0MuJ4sJWtt4FyqNx2mZEuGkOjf
	 zD/SNA2GpBfNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ext4: fix access to uninitialised lock in fc replay path
Date: Wed, 11 Dec 2024 11:33:00 -0500
Message-ID: <20241211091132-c6bd258ba4891a23@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101304.2070456-1-jianqi.ren.cn@windriver.com>
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
1:  23dfdb56581ad ! 1:  a7dddfd22e8bc ext4: fix access to uninitialised lock in fc replay path
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


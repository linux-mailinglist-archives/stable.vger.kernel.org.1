Return-Path: <stable+bounces-145999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D4AC0238
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7871887258
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A651F2D7BF;
	Thu, 22 May 2025 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPL3kh6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A93539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879658; cv=none; b=qkq+oeWKPZfi5Bs829U+se2XC2NNf4SsY5lEU6w1BLudxttnx9nKlLLk+cXFSqu+oSsS/CQKWk9Ra6a8LBVIfQ0Mkw2Q80f4lR2FMHMUQ05oD5Kf2bxEv6MC/nUQ3yMxOFQmEcv2nuMjkxNxUJUEI8mV3sw5bEGLKU6cSE3TjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879658; c=relaxed/simple;
	bh=jEUQ0clIwxdIxapAJvKOaIXK2KMWsLXzaL6cmrPYmic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exaKNzl30Skp47qGlJqRrVIA73k8jPw1v7WM+JoAkYz280/V1uYsJGKG8yLiZy3GfaViqbTPwPXG60rIGVZ6bO/T9gYPYT4P1YhYi9nTMjs9LoCdc36WUarB+KWnwAIawDrYxFIYc/nS17tzg4XLrGet0ScPIhbxaKikq3/5Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPL3kh6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F8C4CEE4;
	Thu, 22 May 2025 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879658;
	bh=jEUQ0clIwxdIxapAJvKOaIXK2KMWsLXzaL6cmrPYmic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPL3kh6maJiEu/nW1PiU/X6h1Hzp+gxaSvkf7SAFrvG02tnnNEXdy5OOOZdtd4G6l
	 AY1vuMaTgSsBQRYS7bTgP97BxMjggVVX8RwA5cwpviorb3BefkjFL//gkzQAaYOU/R
	 Edl+V94vm3prJib7BzSJ4ruwRMFIDXA3gz2wI20PzVQKznGXWHyQdlHfHTSQEqT9J1
	 sf4Ybjn1pBBAR6PLHPFScnoTWv3IT+OTOTXRPJcH1poqRbKuKORv3MwHq/QJgeIYQz
	 CWq1+zIawp74hjz1PZKvWCalo6/0lMDfB7N1mtYsvH0Ws5R2gzOwycwVm20F4yzf4w
	 mw/eYVHAuKXqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 4/5] kernfs: use i_lock to protect concurrent inode updates
Date: Wed, 21 May 2025 22:07:35 -0400
Message-Id: <20250521154826-f1c70bd2e346436b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015336.3450911-5-dqfext@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 47b5c64d0ab5e7136db2b78c6ec710e0d8a5a36b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Qingfang Deng<dqfext@gmail.com>
Commit author: Ian Kent<raven@themaw.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  47b5c64d0ab5e ! 1:  3ab6e3573bab5 kernfs: use i_lock to protect concurrent inode updates
    @@ Metadata
      ## Commit message ##
         kernfs: use i_lock to protect concurrent inode updates
     
    +    Commit 47b5c64d0ab5e7136db2b78c6ec710e0d8a5a36b upstream.
    +
         The inode operations .permission() and .getattr() use the kernfs node
         write lock but all that's needed is the read lock to protect against
         partial updates of these kernfs node fields which are all done under
    @@ Commit message
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
      ## fs/kernfs/inode.c ##
    -@@ fs/kernfs/inode.c: int kernfs_iop_getattr(struct user_namespace *mnt_userns,
    +@@ fs/kernfs/inode.c: int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
      	struct inode *inode = d_inode(path->dentry);
      	struct kernfs_node *kn = inode->i_private;
      
    @@ fs/kernfs/inode.c: int kernfs_iop_getattr(struct user_namespace *mnt_userns,
      	kernfs_refresh_inode(kn, inode);
     -	up_write(&kernfs_rwsem);
     -
    - 	generic_fillattr(&init_user_ns, inode, stat);
    + 	generic_fillattr(inode, stat);
     +	spin_unlock(&inode->i_lock);
     +	up_read(&kernfs_rwsem);
     +
      	return 0;
      }
      
    -@@ fs/kernfs/inode.c: int kernfs_iop_permission(struct user_namespace *mnt_userns,
    - 			  struct inode *inode, int mask)
    +@@ fs/kernfs/inode.c: void kernfs_evict_inode(struct inode *inode)
    + int kernfs_iop_permission(struct inode *inode, int mask)
      {
      	struct kernfs_node *kn;
     +	int ret;
    @@ fs/kernfs/inode.c: int kernfs_iop_permission(struct user_namespace *mnt_userns,
     +	spin_lock(&inode->i_lock);
      	kernfs_refresh_inode(kn, inode);
     -	up_write(&kernfs_rwsem);
    -+	ret = generic_permission(&init_user_ns, inode, mask);
    ++	ret = generic_permission(inode, mask);
     +	spin_unlock(&inode->i_lock);
     +	up_read(&kernfs_rwsem);
      
    --	return generic_permission(&init_user_ns, inode, mask);
    +-	return generic_permission(inode, mask);
     +	return ret;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


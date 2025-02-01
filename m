Return-Path: <stable+bounces-111917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A30A24C31
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264F01884C20
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCE155393;
	Sat,  1 Feb 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YggKKsqj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06664126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454015; cv=none; b=jT9VAz/08h/v3CFYN67aCGLDBtQsB2IppruHJ0/k2pXADJfVEw5pVceOQG4VHxE7EJBPTyQrXBM3aR/2gykyOHkGQZvhhw8R9PZZwaGWP66jabX5U4/fnKlHQEU/fd4+KD46cogKE8V/JHsbScGX61OVYmmXNrTj6QYcuuurHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454015; c=relaxed/simple;
	bh=woqIwfYOj9w5zsoAsrtn6j3weAUTpXYBf37YSsZ/fMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ET7j01/yjzUyc3TnTm7XuK/yWOifAiKc9SEcjuN9Ds8UGO+OprOQYPjvhf3MJCuy1Y0qUlTE2hINLXTr17LZje7J39Fas+70VPlACmvdR2SBWKpO9svVz3iEtI+rFW9UTEQ18IfEsdkxkP0/+nX9O7cnC/D/NT0Nsu8s76wFMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YggKKsqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE80CC4CED3;
	Sat,  1 Feb 2025 23:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454013;
	bh=woqIwfYOj9w5zsoAsrtn6j3weAUTpXYBf37YSsZ/fMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YggKKsqjXsyYFWvamjw4ki42Oz2vCHpErSWHe3T452H77gwkZREDEohS6avTlhquo
	 pE+ScMSK+N5edZA7j/WNv8OcOfd0unSbtqsB7yeCEIawDVITxTCQ+tAq7Fi1iiJxgA
	 ffBXCNfXbF9IARaqMW4lMfKquyRaaeTgkeyxa2ptPD4jj48dCGnxv5GG33kc524+Yr
	 PMWjV5np5z6gBTmUdpzuR73Rur08+bqQEoxAXW6g5OrdhaUe+GEq0c9o0PwUHt5pzb
	 bz9Z9wMRNHVT6MvMPz8EbfGCxH8Hka7lOxS/YVOgqjWraqwj4NJQoLFFSGAgDywzEp
	 DCXtV32zPmmRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 09/19] xfs: allow read IO and FICLONE to run concurrently
Date: Sat,  1 Feb 2025 18:53:31 -0500
Message-Id: <20250201140700-c14215d740f61fce@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-10-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 14a537983b228cb050ceca3a5b743d01315dc4aa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Catherine Hoang<catherine.hoang@oracle.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d7d84772c3f0)
6.1.y | Present (different SHA1: 9e20b44a856b)

Note: The patch differs from the upstream commit:
---
1:  14a537983b228 ! 1:  a0286e9750934 xfs: allow read IO and FICLONE to run concurrently
    @@ Metadata
      ## Commit message ##
         xfs: allow read IO and FICLONE to run concurrently
     
    +    [ Upstream commit 14a537983b228cb050ceca3a5b743d01315dc4aa ]
    +
         One of our VM cluster management products needs to snapshot KVM image
         files so that they can be restored in case of failure. Snapshotting is
         done by redirecting VM disk writes to a sidecar file and using reflink
    @@ Commit message
         Reviewed-by: Dave Chinner <dchinner@redhat.com>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_file.c ##
     @@ fs/xfs/xfs_file.c: xfs_ilock_iocb(
    @@ fs/xfs/xfs_file.c: xfs_file_remap_range(
     +	xfs_iunlock2_remapping(src, dest);
      	if (ret)
      		trace_xfs_reflink_remap_range_error(dest, ret, _RET_IP_);
    - 	return remapped > 0 ? remapped : ret;
    + 	/*
     @@ fs/xfs/xfs_file.c: __xfs_filemap_fault(
      	struct inode		*inode = file_inode(vmf->vma->vm_file);
      	struct xfs_inode	*ip = XFS_I(inode);
      	vm_fault_t		ret;
     +	unsigned int		lock_mode = 0;
      
    - 	trace_xfs_filemap_fault(ip, order, write_fault);
    + 	trace_xfs_filemap_fault(ip, pe_size, write_fault);
      
     @@ fs/xfs/xfs_file.c: __xfs_filemap_fault(
      		file_update_time(vmf->vma->vm_file);
    @@ fs/xfs/xfs_file.c: __xfs_filemap_fault(
      		pfn_t pfn;
      
     -		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
    - 		ret = xfs_dax_fault(vmf, order, write_fault, &pfn);
    + 		ret = xfs_dax_fault(vmf, pe_size, write_fault, &pfn);
      		if (ret & VM_FAULT_NEEDDSYNC)
    - 			ret = dax_finish_sync_fault(vmf, order, pfn);
    + 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
     -		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
     +	} else if (write_fault) {
     +		ret = iomap_page_mkwrite(vmf, &xfs_page_mkwrite_iomap_ops);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


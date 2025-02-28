Return-Path: <stable+bounces-119883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173E3A490AB
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42C17A54BE
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 04:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF01AE00E;
	Fri, 28 Feb 2025 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/FErrjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3711A3140
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718799; cv=none; b=TFITVFxiUYvbDwqtouqyhvOJw9pILJhYcZkXGNTm5o/JrMoBqK0EyjaC+MBflm2XhjNx0wjI9jRdwIU/uCApje80Cym+l+2qPBr5ZtB14Y4L1hM3Aw6ujBOPfeSmxjkTDwybI8vPqarURc0Csh/JOoo6ClJ4aSqmySfWZj5m22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718799; c=relaxed/simple;
	bh=LjfHhtU+m6Dxjp5njuucafrlGUIsHlGho/cZjArWeLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDaUutZ3UYyOjGO7kG5fRV1C0v2j0FQL3MtT2AQYm7IZEi7hKT7Mu3EkZah5D1KM432ufokL+zKPj3ceom4WxUekdtnVd3EK/AiCrj4xbW2I/bPzTqYB3TYNN+yLEn4ZPzQ7RP3ecWTSG6n9ODbzImGz+mQmro0T/AfIxeOWYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/FErrjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C58AC4CED6;
	Fri, 28 Feb 2025 04:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718798;
	bh=LjfHhtU+m6Dxjp5njuucafrlGUIsHlGho/cZjArWeLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/FErrjDnL/FizEck5T8Oo8HqHbH1upH/qNTRlce9EO1eUeKG/QNn9/cdQrWwD3Cx
	 JhnNySUAM7t8dx2TfakeFp9lR5PQJ3hmnf3X2Boda1aMVGrtKxdC08eyVyKIf6/7YY
	 A4czneY8UJpXPASfJQe9BZ1suOz9kkcbftU5azY0dJTWU3y/tZJG6CvEltBSDHtmTW
	 PDs+TJhfqFJ4Qm0UbkrllD8yW3WqGEnGfv3Os86dJhpJJAN4A+CvUyacGyxS9Zj2LN
	 FolmmeZUDVuLDXKHBHeGBLcTb2vGBLVUn2GsGITxnj+cInPUlk2302+gwBto92L0Sm
	 zZmWhzI+or1zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 6.1 2/3] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Thu, 27 Feb 2025 23:56:13 -0500
Message-Id: <20250227203639-41229f317c9b3f60@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226180247.4950-3-konishi.ryusuke@gmail.com>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 8cf57c6df818f58fdad16a909506be213623a88e

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 35dcb8a3a70e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8cf57c6df818f ! 1:  125b899dd0a8e nilfs2: eliminate staggered calls to kunmap in nilfs_rename
    @@ Metadata
      ## Commit message ##
         nilfs2: eliminate staggered calls to kunmap in nilfs_rename
     
    +    commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.
    +
         In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
         with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
         path.
    @@ Commit message
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
         Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
     
      ## fs/nilfs2/namei.c ##
    -@@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    - 	inode_set_ctime_current(old_inode);
    +@@ fs/nilfs2/namei.c: static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
    + 	old_inode->i_ctime = current_time(old_inode);
      
      	nilfs_delete_entry(old_de, old_page);
     -	nilfs_put_page(old_page);
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |


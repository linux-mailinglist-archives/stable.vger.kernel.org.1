Return-Path: <stable+bounces-142951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A211AB07A1
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7184E86B6
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D013CF9C;
	Fri,  9 May 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aot2AGbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457928682
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755562; cv=none; b=PPrNjVijKHn3ADJKGzLQGVFVP04/9Nt/vkDO+GZac21wlMHMxORVMTn1AVyg3osUNYXUwgZ0Rxlm8ezhV7z0o8udVO2ThogPdBXkikLI0x1N15U5/oksECIbfe/4aMNM6Ko8fKLs14yFm2wrS8tQnZuJBjtNGjNRD3frjTuwPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755562; c=relaxed/simple;
	bh=O8O0/Teb0KJUFebcNrIxne10cTqYYF9zpCKbZaBJtx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9hOs3jwJJYXfF2Cq2SnwhmAnrnnLWDRanCr6M5wwkAJrIhfRrRrVFf/vMIN6NG7mYmEeXpDyRGaLqD6mVaw+HHaa1tB4J9KGVblyFxDHbWbCgpzV/E1jJrN7Kbt3zNtczr64k+3q6KLCRYaxlHneBoMjD+H4l+ArzENwaDod5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aot2AGbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE4BC4CEE7;
	Fri,  9 May 2025 01:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755562;
	bh=O8O0/Teb0KJUFebcNrIxne10cTqYYF9zpCKbZaBJtx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aot2AGbNUAsluJAKnj4cwDKQ4A3MUO+8uMjmM7FBqNEounke3BIQUIjytU+ZTAU2w
	 tUrqfUu5y4lyL3Tnfkqf6OtfLrbpaXSxE7oamG207LZCbDMDS5l9AfJxTgMRMIxTMv
	 rI6UvSUGLdEqpNkpsgqe/Wn1B/uiBb6h1E80o8x+9GrBPRwdHdU0cPUULW95nS/137
	 RwSzl0coGEH34SdqDLESYLMrCsWacjOBfj2ZvfegVDC2HHMbw+1waiZJX7mM/jrBQk
	 CSJMd3KasVErRZF+uWYHzKm4NzTIh8ifo/N0abIzY8ebC9Yx1trApHWb5PNTJGEQhd
	 pqvXpPuxl64cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: always fallback to buffered write if the inode requires checksum
Date: Thu,  8 May 2025 21:52:39 -0400
Message-Id: <20250508142104-cd77d6c00d4c73c6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <54c7002136a047b7140c36478200a89e39d6bd04.1746666535.git.wqu@suse.com>
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

The upstream commit SHA1 provided is correct: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  968f19c5b1b7d ! 1:  cf0081b3a1276 btrfs: always fallback to buffered write if the inode requires checksum
    @@ Metadata
      ## Commit message ##
         btrfs: always fallback to buffered write if the inode requires checksum
     
    +    commit 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 upstream.
    +
         [BUG]
         It is a long known bug that VM image on btrfs can lead to data csum
         mismatch, if the qemu is using direct-io for the image (this is commonly
    @@ Commit message
           to buffered IO.  At least by this, we avoid the more deadly false data
           checksum mismatch error.
     
    +    CC: stable@vger.kernel.org # 6.6
         Suggested-by: Christoph Hellwig <hch@infradead.org>
         Reviewed-by: Filipe Manana <fdmanana@suse.com>
         Signed-off-by: Qu Wenruo <wqu@suse.com>
         Reviewed-by: David Sterba <dsterba@suse.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    [ Fix a conflict due to the movement of the function. ]
     
    - ## fs/btrfs/direct-io.c ##
    -@@ fs/btrfs/direct-io.c: ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
    - 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
    + ## fs/btrfs/file.c ##
    +@@ fs/btrfs/file.c: static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
      		goto buffered;
      	}
    + 
     +	/*
     +	 * We can't control the folios being passed in, applications can write
     +	 * to them while a direct IO write is in progress.  This means the
    @@ fs/btrfs/direct-io.c: ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_
     +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
     +		goto buffered;
     +	}
    - 
    ++
      	/*
      	 * The iov_iter can be mapped to the same file range we are writing to.
    + 	 * If that's the case, then we will deadlock in the iomap code, because
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


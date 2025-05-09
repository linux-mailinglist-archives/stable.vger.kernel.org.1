Return-Path: <stable+bounces-143041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F045FAB1139
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 12:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DF07A54B5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D928F935;
	Fri,  9 May 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBrA6Clr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2D28F934
	for <stable@vger.kernel.org>; Fri,  9 May 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787866; cv=none; b=f2NnPSdJ0sPjNn62zZKYa2b8nB3P19SZ9u1ei+T6jcByadsnWHKRIxJ8c1rHYflDZ2jcfa7atzOirEB3TBjuM7hdIxw6thB6PniK4D+A4GNCjz+6+ctUBZg+st6llUk71FU7q250BJH2I/SMHU2l6R41Ransg/LIUxSHyJa/pYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787866; c=relaxed/simple;
	bh=oJ5Ioz2kr9QFDM7LS6WTL+LCq1hCqbqYm00kaYXszTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=powWk9r/flR0HrllRfs323csXMwjdGPOmwkwj/DQaNXAXe60ATHWCBBgztQNsaRsOD5jsiTN3b7So3aGYAuYdlYrVE6iPZAVRn/Ghqk4fWUMaxFCw8Dt90yist2yTm4cJ52PffQ2itcMtKX52Kdg/Z2HVoKezSq7cFJXaRU0Njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBrA6Clr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EB1C4CEE4;
	Fri,  9 May 2025 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787865;
	bh=oJ5Ioz2kr9QFDM7LS6WTL+LCq1hCqbqYm00kaYXszTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBrA6Clr4HtEsXok99grePX0E3p4+uUG0evMjHqcC1Tv+v7QGCGdyNLQ7OQCqrNyG
	 t+60trjiq8Y8pt12nz3IGMek3frDTJTW4vxjgKk4MhDyHf03z7WJUN77rmWIGMgzm8
	 ZFWQnzZtECRKO0bdPvhDQxERdbUuDrY6kGHndv2fUtNSGWqNo+EBLkHxPRVvnKwF0+
	 iKC5y2j/4zHnTZ/4z7BLe27GtXKwGzMdIFd6eYRyKWB2mmSvo3lFogz/W+f6CpyuWb
	 7hJ0Mr6PavVE32q2e/96RELQEyNv4x8J6Wv4qj1AuoD2u3Xc/KP9J5rQREIFn/wH6O
	 JT3s1HE1jEsqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y v2] btrfs: always fallback to buffered write if the inode requires checksum
Date: Fri,  9 May 2025 06:51:01 -0400
Message-Id: <20250508142620-05d880325aa36850@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <54c7002136a047b7140c36478200a89e39d6bd04.1746687932.git.wqu@suse.com>
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
1:  968f19c5b1b7d ! 1:  21bb3166ede2a btrfs: always fallback to buffered write if the inode requires checksum
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


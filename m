Return-Path: <stable+bounces-132795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD504A8AA48
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6492D1903277
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21981253357;
	Tue, 15 Apr 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScTqlCCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447C2580FB
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753412; cv=none; b=LZj4kush0Wp3Dk/+WxVc1LxU2ZkCXhiXb3um+dQ66kzfUAFTv/kqItWA9HIeB0nOoBWIVJkP2t4YWaH9mUFdzeNXbxV4frWXdN2ez/p5W8KaC/Q+C8aPCJzkVQO8we2W81B6xojpQvHqp3/ksv8DJfbjGFwSwHAYjwy8pboL0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753412; c=relaxed/simple;
	bh=RcBrXkj7egNii6EtjAyZxvwO/VtLJmDt/7kAt2nb98Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvLtQq8TDtQyB3bOAT3WoIqE99trHkqidLUED83wskfPUEFaDBYMUuuF3XUOu6y1Km40lYf3Xigr6DL90fgl1MIPHxbwamJRw/3rNz39ywdDDIT7hgK57ZGml/XicV1DGHgNltUGwg5EgZ8oMQwzMoonN41KFU0VSVrP+oSl5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScTqlCCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFACC4CEE7;
	Tue, 15 Apr 2025 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753412;
	bh=RcBrXkj7egNii6EtjAyZxvwO/VtLJmDt/7kAt2nb98Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScTqlCCKHjOCT4DOBw5JNchuxv89S/ACs+gsGHG5PX58NYbTnz3xZ7BHE0OxgWPVH
	 ZZZMRGI3Pr/nztyk6IO2gJmuaf9ZRpmPM5xndWiRTyqmXyLE50REShtLqRodjeQLHO
	 74lvgu+4d1RnsAtzD8IRq6t9EYm2iIoVLVSnq3uLe2aA2brdMPfnYZzg9HPDYwU60G
	 fG2NQNph8pNi0z8EIG5lzw/zfJ5SuF1k0Q5gh0vmOZ0ID5xp+dUQaYvSRvRY/hVYGO
	 +GuSPjFhUT/AhrImWNOgtCmawXRc9P+lWdofBN9Mj/dg4Ye8+eYCYfMXqUbbT+T0ow
	 RHgi08vPYGZ0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 5/6] filemap: Fix bounds checking in filemap_read()
Date: Tue, 15 Apr 2025 17:43:31 -0400
Message-Id: <20250415124359-107123315c9bc4b3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-6-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: ace149e0830c380ddfce7e466fe860ca502fe4ee

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Trond Myklebust<trond.myklebust@hammerspace.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a2746ab3bbc9)
6.1.y | Present (different SHA1: 26530b757c81)

Note: The patch differs from the upstream commit:
---
1:  ace149e0830c3 ! 1:  dea76eb0a8d6e filemap: Fix bounds checking in filemap_read()
    @@ Metadata
      ## Commit message ##
         filemap: Fix bounds checking in filemap_read()
     
    +    [ Upstream commit ace149e0830c380ddfce7e466fe860ca502fe4ee ]
    +
         If the caller supplies an iocb->ki_pos value that is close to the
         filesystem upper limit, and an iterator with a count that causes us to
         overflow that limit, then filemap_read() enters an infinite loop.
    @@ Commit message
         Tested-by: Mike Snitzer <snitzer@kernel.org>
         Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    (cherry picked from commit ace149e0830c380ddfce7e466fe860ca502fe4ee)
    +    [Harshit: Minor conflict resolved due to missing commit: 25d6a23e8d28
    +    ("filemap: Convert filemap_get_read_batch() to use a folio_batch") in
    +    5.15.y]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
      ## mm/filemap.c ##
     @@ mm/filemap.c: ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
    @@ mm/filemap.c: ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
      
     -	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
     +	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
    - 	folio_batch_init(&fbatch);
    + 	pagevec_init(&pvec);
      
      	do {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


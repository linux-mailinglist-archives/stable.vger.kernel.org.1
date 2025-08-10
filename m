Return-Path: <stable+bounces-166942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B50B1F771
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C65F17BA87
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385AFC0B;
	Sun, 10 Aug 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0u8Hin9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F27EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786526; cv=none; b=p+/HeJc3mNSpxgSUjCGhgKp7CxY8s20cQg0tBfN+Kx9cJiwams4B/nryZZuEpHLdm/B2Z+Q/emSGQzV4jjXNbDSmFcWYf3gzlxxLKa86SRK6bZym8QjxCugg+MUckHcFdFgGPwbY4CT+b1XEFQMi6KRsJonZM/poULYQYKHe0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786526; c=relaxed/simple;
	bh=CZ4jUjl2hdc0ZqRrQHEkgvULzWtiJhFLCEve2vkABb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGtR/zoRNz6tZW6wPBJoC82QK81A9/XwotJLA3oFbKlRUJUoQJMGescrS0mAQ3Ln4bgn073H8NS7n45PbB84qT4RNsWH8VB0BJRRQKDiepukcxl8G6BsxW7WXamE0eMX7fAtBAVEN7PhToonl91QYhO8njGpnNVOu8B0biy03tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0u8Hin9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617F0C4CEE7;
	Sun, 10 Aug 2025 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786525;
	bh=CZ4jUjl2hdc0ZqRrQHEkgvULzWtiJhFLCEve2vkABb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0u8Hin9MHzZ6595JjGSSYy292WE021SWgdw6ria3g1MznMDna447RA8OFICDSoji
	 7NxXzonu7DiNjnf65sVtN+MxPPSHUQS7HNPsHqLzy0sP1Kr8p2w6dE0CV05ae/5Ugn
	 fS8Eh5LbYJMgcqjOuvRUT39e2/TtIz8vx/Z0i7ak7NP2gPCD2sf7Yl4OA1IUxKAq7F
	 huVKM/yrdoX1V8FTyZXaTyCHnrp2S+y13ryAICzDDl4gqX07w1hqi+5Kd9MhW5Ejnq
	 5PUsOj3A7g+lARvlEKz6KQoCD4uQs7Rxr+gZa4KdqUECIfyj/40G+J+89P2oieWtjX
	 bZ3rXpKlpVmqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6] io_uring/rw: ensure reissue path is correctly handled for IOPOLL
Date: Sat,  9 Aug 2025 20:42:03 -0400
Message-Id: <1754783337-cf640bd2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809205420.214099-1-sumanth.gavini@yahoo.com>
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

The upstream commit SHA1 provided is correct: bcb0fda3c2da9fe4721d3e73d80e778c038e7d27

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Jens Axboe <axboe@kernel.dk>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bcb0fda3c2da ! 1:  941165821178 io_uring/rw: ensure reissue path is correctly handled for IOPOLL
    @@
      ## Metadata ##
    -Author: Jens Axboe <axboe@kernel.dk>
    +Author: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## Commit message ##
         io_uring/rw: ensure reissue path is correctly handled for IOPOLL
     
    +    commit bcb0fda3c2da9fe4721d3e73d80e778c038e7d27 upstream.
    +
         The IOPOLL path posts CQEs when the io_kiocb is marked as completed,
         so it cannot rely on the usual retry that non-IOPOLL requests do for
         read/write requests.
    @@ Commit message
         Reported-by: John Garry <john.g.garry@oracle.com>
         Link: https://lore.kernel.org/io-uring/2b43ccfa-644d-4a09-8f8f-39ad71810f41@oracle.com/
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## io_uring/rw.c ##
     @@ io_uring/rw.c: static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
    @@ io_uring/rw.c: static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
      	if (unlikely(res != req->cqe.res)) {
     -		if (res == -EAGAIN && io_rw_should_reissue(req)) {
     +		if (res == -EAGAIN && io_rw_should_reissue(req))
    - 			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
    + 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
     -			return;
     -		}
     -		req->cqe.res = res;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.6.y        | Success     | Success    |


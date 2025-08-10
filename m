Return-Path: <stable+bounces-166947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D9B1F776
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72F17BBF2
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40455FC0B;
	Sun, 10 Aug 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqpUePYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098FEC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786540; cv=none; b=QFbym811zTNrlbrCjqcThXl6FbGPz+KlMy+Ahk4VoAvHMJog4tyGoiv4y2+8e94N1cp+K1PrDx3TFgR5Ob8AmfRP/xt4zdnF+73Y/vKR4VyQSTx/wuDfJp6HjlX8k5ysZ5RDLPgg1U6bhrwR+rpqj5btqqiyJ+IRt3WiC6JgndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786540; c=relaxed/simple;
	bh=wBe6t8JWdOQb8+80/Q6j1O1K8lmE9bajqbxgDCNGV1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG5du6L5hsRTbqWoh93RpN48812MalMEQtVm5cAgIxM3KPqiou/8gH5AJo3cwQ3WlnBIIxYto6Gq4NLjoWOf5IpoTOfOm5cCRGstu9QCFh4UwF0qlVdP/CNrAS7eENWHTF+gugScS00Yu1pRFzxQn1AlboH6QmNZ4CoIOVSrTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqpUePYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB86C4CEE7;
	Sun, 10 Aug 2025 00:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786539;
	bh=wBe6t8JWdOQb8+80/Q6j1O1K8lmE9bajqbxgDCNGV1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqpUePYtAvilhWsLqL4BSA++buT2q4DZSawiDjTpmJEptPdqVie/t8UcTpEnNLDNN
	 uQ+GhvAVOgezXuP/0qrwyJHdfrG/pkbINLBu9gn1BzgojKlbcXw3eYAeXom0MviVf4
	 Y3Nyc0Baqm/jsVozkzBXnYree19FDdwz4MdXlsa6t6TyU0t8+r28l1HgFrh+COVXnr
	 bgLOzwd9b1+tgh58FzjuiCwuOr5qFm9ZSCfSSJrxiV0kvTu67b/hGV8/AZU/bC9ozv
	 6ZNLTGGS2BBRVpVkg/JSoqHpo5fWuZRgjlzS3xITyIBTY26/OsLL+9NtuXak5nj1X/
	 SjKyfUnzYIYAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] io_uring/rw: ensure reissue path is correctly handled for IOPOLL
Date: Sat,  9 Aug 2025 20:42:17 -0400
Message-Id: <1754783538-5c8b45e3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809182636.209767-1-sumanth.gavini@yahoo.com>
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

Found matching upstream commit: bcb0fda3c2da9fe4721d3e73d80e778c038e7d27

WARNING: Author mismatch between patch and found commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Jens Axboe <axboe@kernel.dk>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bcb0fda3c2da ! 1:  9067ba27246b io_uring/rw: ensure reissue path is correctly handled for IOPOLL
    @@
      ## Metadata ##
    -Author: Jens Axboe <axboe@kernel.dk>
    +Author: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## Commit message ##
         io_uring/rw: ensure reissue path is correctly handled for IOPOLL
     
    +    commit  bcb0fda3c2da9fe4721d3e73d80e778c038e7d27 upstream.
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


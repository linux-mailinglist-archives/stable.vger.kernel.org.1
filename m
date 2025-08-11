Return-Path: <stable+bounces-167077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05D8B21861
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 00:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8074C68035A
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2C21C9F1;
	Mon, 11 Aug 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOMmzEmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FA1F948
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951433; cv=none; b=ikzXJpgViAuPoZKqNzCDamX4TRPBjfgWkIjnhp1e4jSsbuiub2mdffJwb9DseWftWfBGDuPvKFR3psPgRQk23xzDIQy3/FyPohlNay+xtaFZLMIcstDLwLMHdbnOP36+WtjKuA22EeqcjffavGQvXXSfx5jhKgK1dbuapD8arNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951433; c=relaxed/simple;
	bh=v6vNdLwZ84s8iZFUZso/qs50zK2bkeaHX8LgqyBs7pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7R+uHw9jYpyZfZgjzv90F3zNS523dOxFd2R2t8+88O6MdWtrwNEkNTZ9eyOwl2vYSeA5CZEI+m1qdzgEtmL8ygEUGdpPOKsceMogaXqR/sbfbKTHGIHykeQX55kQjZShAWxCHeiD31T+JG9L35sF/FeMXobIaK2X9DxQC6p4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOMmzEmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CE6C4CEED;
	Mon, 11 Aug 2025 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754951433;
	bh=v6vNdLwZ84s8iZFUZso/qs50zK2bkeaHX8LgqyBs7pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOMmzEmPZojAvvl9RE/4k/VXeeDMswV+D+vF8h6HW9eKAv/ov0Hzy6Ri9mpg7TeoM
	 JjYmB6iTLCebtggb8hY/0wgGpz7pwxii6ECfKGSdxR5J55x9Y7kp1FRfdq91LQ/OGX
	 GSzGF0VCRs0QI4t0XUuzqeX/rZnv6NrdYL4mpCFgSQwZOyKBjz2VUI6x4k3bSWs9LW
	 Aq9uWUSnuTzFsEHxqIifNDcCXxLhF1wHGqatkdoZFgqdOAgAmC2IhSrWDJAZN8g13D
	 ZivujKH8ZLzLzAqy+KMa7j4sx86EBwbfz2rbc/Rgdut7jisugLFIqt7fTGmvgy3jP6
	 ApP7ehClswA9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shivani.agarwal@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2 v5.10] dm rq: don't queue request to blk-mq during DM suspend
Date: Mon, 11 Aug 2025 18:30:30 -0400
Message-Id: <1754925507-8563750b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811052702.145189-3-shivani.agarwal@broadcom.com>
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
❌ Build failures detected

The upstream commit SHA1 provided is correct: b4459b11e84092658fa195a2587aff3b9637f0e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Ming Lei <ming.lei@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  b4459b11e840 ! 1:  d0cf570e337e dm rq: don't queue request to blk-mq during DM suspend
    @@ Metadata
      ## Commit message ##
         dm rq: don't queue request to blk-mq during DM suspend
     
    +    commit b4459b11e84092658fa195a2587aff3b9637f0e7 upstream.
    +
         DM uses blk-mq's quiesce/unquiesce to stop/start device mapper queue.
     
         But blk-mq's unquiesce may come from outside events, such as elevator
    @@ Commit message
         Cc: stable@vger.kernel.org
         Signed-off-by: Ming Lei <ming.lei@redhat.com>
         Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Shivani: Modified to apply on 5.10.y]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
     
      ## drivers/md/dm-rq.c ##
     @@ drivers/md/dm-rq.c: static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
    @@ drivers/md/dm-rq.c: static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hct
     +
      	if (unlikely(!ti)) {
      		int srcu_idx;
    - 		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
    + 		struct dm_table *map;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Failed     |

Build Errors:
origin/linux-5.10.y:
    Build error: Building current HEAD with log output
    Build x86: exited with code 2
    Cleaning up worktrees...
    Cleaning up worktrees...
    Cleaning up worktrees...
    Cleaning up worktrees...



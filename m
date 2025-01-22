Return-Path: <stable+bounces-110181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A062A193A7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821363ACE82
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7B214235;
	Wed, 22 Jan 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7FsEJvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48F21422F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555393; cv=none; b=itQkvXWH9Z48kFlsrDlT1AnlUzp/ls/8nrRtAr9L7BDylD037+C+AFJr4cNpEHijicPveADwRwJ/KphXh4mLxpgrRKh/itvOJ1xLuurhw1FDDb5ookcKkb3Gwyv+W6U/u/Wvq1SJiBoCQSawcFbuQc0mUTTxTxHJP5FonADRsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555393; c=relaxed/simple;
	bh=HBcLnM9Uh8ckbWcx3E7Tng6eL6b7j3YyNkNZ5jd7T7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LU1ZalJeDnqJ9tPWSRpLfTVyh21uD3Lh9Q6wREOut6+MQzXCU+lJtq6MVkTRXD504et59xOXTvDbuFPzkhvyHTyuwPVUU5faEFeVcZeZYhKJNFP2gl0+6B3B6Elm/c3GQHyGihXsZNhhGT4qTrqsqacACag3Hizr5Wagvmfyr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7FsEJvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B95EC4CEE3;
	Wed, 22 Jan 2025 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555392;
	bh=HBcLnM9Uh8ckbWcx3E7Tng6eL6b7j3YyNkNZ5jd7T7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7FsEJvrmJfhAyalRlUOQfLxOd4UsAIObA0ogvSY5vg8DuLzUFOAM6lUlfDQJo2/t
	 E06QOBx5ax3r0M/48wbRWtFnT+FKQdZlNWQ70oimuhyrRA+gUvJecMazQ8lWPHsQ3/
	 /z2OjazwNUuR0NNR0vECPXv1xeEIgQQlkT6p/QKrws1M4gbZ4XJlCJHyB+G2iB+dCo
	 4CE0t2MhMBRmuai1ariiUnLN8y8yr59zWgDyInRfkOP4N5GbF2I+baCfrmMoRvjCXT
	 NsnBJnVjqH5Qkni3qDstGN3QiJhyeKVL1elJ6yoJlJ8vUIfzK2i9daHLQ0iDiU706K
	 K/jpKAjejPVPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop
Date: Wed, 22 Jan 2025 09:16:30 -0500
Message-Id: <20250122090206-42a50ceed708cf59@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_ABAD564DE407BF249EF53E0E184C5CC30006@qq.com>
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

The upstream commit SHA1 provided is correct: 8be3e5b0c96beeefe9d5486b96575d104d3e7d17

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Selvin Xavier<selvin.xavier@broadcom.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8be3e5b0c96be ! 1:  ee8c4af490b25 RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop
    @@ Metadata
      ## Commit message ##
         RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop
     
    +    [ Upstream commit 8be3e5b0c96beeefe9d5486b96575d104d3e7d17 ]
    +
         Driver waits indefinitely for the fifo occupancy to go below a threshold
         as soon as the pacing interrupt is received. This can cause soft lockup on
         one of the processors, if the rate of DB is very high.
    @@ Commit message
         Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
         Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
         Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
    +    [ Add the declaration of variable pacing_data to make it work on 6.6.y ]
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## drivers/infiniband/hw/bnxt_re/main.c ##
    -@@ drivers/infiniband/hw/bnxt_re/main.c: static bool is_dbr_fifo_full(struct bnxt_re_dev *rdev)
    +@@ drivers/infiniband/hw/bnxt_re/main.c: static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
      static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
      {
    - 	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
    + 	u32 read_val, fifo_occup;
    ++	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
     +	u32 retry_fifo_check = 1000;
    - 	u32 fifo_occup;
      
      	/* loop shouldn't run infintely as the occupancy usually goes
    + 	 * below pacing algo threshold as soon as pacing kicks in.
     @@ drivers/infiniband/hw/bnxt_re/main.c: static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
      
    - 		if (fifo_occup < pacing_data->pacing_th)
    + 		if (fifo_occup < rdev->qplib_res.pacing_data->pacing_th)
      			break;
     +		if (!retry_fifo_check--) {
     +			dev_info_once(rdev_to_dev(rdev),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


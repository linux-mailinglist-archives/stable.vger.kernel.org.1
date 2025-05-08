Return-Path: <stable+bounces-142899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65892AB002E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D474E746E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAC27A103;
	Thu,  8 May 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0RZ6dEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620722422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721174; cv=none; b=GbDJ1T6yXwuJoFC+Aj1zhhuKRGkGQZ+6XVYZ0csclMm2/kh9xmSFTFCXoKYP2WoKbMdLLAvYlRKk5yXqRqcESk7hMVxWPLNyV+v5MbcR/klDJNwf9qhVDeUaej8vKodAK0L64VJi42i/Bi38BmzJv4Lc38bO0pDbNfkYUAVxNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721174; c=relaxed/simple;
	bh=EPcC4eLIaaufL1rjdD1V6NseJsLFJ/t96g4kR22ksn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5aamarI9azCJOxMHo6G9EwnrcDyI6SSIgDRlqGnSBiEKMit+56/ighRWrlSCm11vB2o7hRereKkHyH/QU2pDABSRbH2RWoNKGqbA7XqWl4nTLgMoUdGGh3j+k2rMjUSt7avY+hZaoPOAmaMd0rbAaV6DTIskqpUByrmBRJyn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0RZ6dEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FECC4CEE7;
	Thu,  8 May 2025 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721174;
	bh=EPcC4eLIaaufL1rjdD1V6NseJsLFJ/t96g4kR22ksn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0RZ6dEjM0fYZxmQiq7r14nWxfwuo/oeDQHBBet52YVEH2rx6HOr+1+FfCizgPIeo
	 /ACYWDQiXMvct/gaHVLM/EYkIwkzPaiwtmalPmqaMCAhIz7Jxn/L5TEzsjgN7mmKrM
	 d7kWsIPfa1NqSXG/iL0YTU0UMUQVIaODnyJcvhHFlm8JwRNqrtASSv6AA8uJn5Nlq5
	 BtMkVtMYNBJUtcu4QhY3sDYfPpRX8zv6E4RDwirCOgGCMAhB5fLc1nUpT7XlWbBQJT
	 sYmv6VEHC/mHh4yAZ1/CHgvJ2NIS7V4rrGsEQAciRaydIF56rX4yxsdS6Qd+HEe6r9
	 USKQ5LEqb0Vgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 4/7] ublk: improve detection and handling of ublk server exit
Date: Thu,  8 May 2025 12:19:30 -0400
Message-Id: <20250507084419-9650541528a84a25@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-5-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: 82a8a30c581bbbe653d33c6ce2ef67e3072c7f12

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Uday Shankar<ushankar@purestorage.com>

Note: The patch differs from the upstream commit:
---
1:  82a8a30c581bb ! 1:  7602c3e23b631 ublk: improve detection and handling of ublk server exit
    @@ Metadata
      ## Commit message ##
         ublk: improve detection and handling of ublk server exit
     
    +    [ Upstream commit 82a8a30c581bbbe653d33c6ce2ef67e3072c7f12 ]
    +
         There are currently two ways in which ublk server exit is detected by
         ublk_drv:
     
    @@ drivers/block/ublk_drv.c: struct ublk_params_header {
      };
      
     -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
    --
    ++
     +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
     +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
     +static void __ublk_quiesce_dev(struct ublk_device *ub);
    - static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
    - 		struct ublk_queue *ubq, int tag, size_t offset);
    + 
      static inline unsigned int ublk_req_build_flags(struct request *req);
    + static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
     @@ drivers/block/ublk_drv.c: static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
      static enum blk_eh_timer_return ublk_timeout(struct request *rq)
      {
    @@ drivers/block/ublk_drv.c: static struct gendisk *ublk_detach_disk(struct ublk_de
      	mutex_unlock(&ub->mutex);
      	ublk_cancel_dev(ub);
      }
    -@@ drivers/block/ublk_drv.c: static void ublk_remove(struct ublk_device *ub)
    - 	bool unprivileged;
    - 
    +@@ drivers/block/ublk_drv.c: static int ublk_add_tag_set(struct ublk_device *ub)
    + static void ublk_remove(struct ublk_device *ub)
    + {
      	ublk_stop_dev(ub);
     -	cancel_work_sync(&ub->nosrv_work);
      	cdev_device_del(&ub->cdev, &ub->cdev_dev);
    - 	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
      	ublk_put_device(ub);
    -@@ drivers/block/ublk_drv.c: static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
    + 	ublks_added--;
    +@@ drivers/block/ublk_drv.c: static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
      		goto out_unlock;
      	mutex_init(&ub->mutex);
      	spin_lock_init(&ub->lock);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |


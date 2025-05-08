Return-Path: <stable+bounces-142900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E360AAB002F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6227C4E75F5
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB1280325;
	Thu,  8 May 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvrgXHnH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345B22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721179; cv=none; b=ObVgPANBtMT/B8WB3MnPQJYGFsH2VrBOuzFO9/QwDJTxjx5d2mQm5vErdEeWnd0rxJt/TljsyUx95Sx2p1MGSJMle2twYwtinMm27jcxouA7IyUwwkF9+bLq3KrmubYHXSSoHDL4hSpFk+ogdfVNLoRvjVKK8ie5c+vA0RL7PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721179; c=relaxed/simple;
	bh=oUzyZwnUdUoWj7jYoyyHqyB8eioAwCteMfm0YmoROwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ipi6dRFvt+utu+VCs4yFVWkNRtVQuwxnMWswLRpeE+PzgAqVaIYc8wlTLKzCz+0xGBDndSuD5BrkQcnJcvuOReD7m417h90OjIgt621KP2dc6Z1027iYYE8E0WZDrKwXdFCLzRSbbjfoSEmpG2Qwel9BFUJxOpkoFFHsTS/lFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvrgXHnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D0DC4CEE7;
	Thu,  8 May 2025 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721178;
	bh=oUzyZwnUdUoWj7jYoyyHqyB8eioAwCteMfm0YmoROwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvrgXHnH8q5GpqKChukOCZ43hfaQsMzvbU82rCgsRw9CG96YLDPA/7D0ASkJgIzzW
	 tepktqXwS+rSef2v2hp4QExBbim+w8QrLNZnfOSvFS0aHF04RGH5oMUhW4XzDqTbse
	 w7kd9RL2wGyonersalePFU93z3DzZY4G+AHE4rpBYJrRgwcY2yuseYCcYU6FxXTZXt
	 ybs6SkJflbfuKk1V8mwLlchFbYXyhGMOuaRgyD9EKOKDgm5fBtweGmPWBfu/wH6b9g
	 EbSDUzmpxpjGDyHnP92BA+Dlxehis2kp9wVWwQbu9k9K61yrWF1dKdwKt6d/m5eOE3
	 fgyBnB8P/N1Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 3/7] ublk: move device reset into ublk_ch_release()
Date: Thu,  8 May 2025 12:19:34 -0400
Message-Id: <20250507084139-5291449c12f8b77e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-4-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: 728cbac5fe219d3b8a21a0688a08f2b7f8aeda2b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Ming Lei<ming.lei@redhat.com>

Note: The patch differs from the upstream commit:
---
1:  728cbac5fe219 ! 1:  24577a96fbb85 ublk: move device reset into ublk_ch_release()
    @@ Metadata
      ## Commit message ##
         ublk: move device reset into ublk_ch_release()
     
    +    [ Upstream commit 728cbac5fe219d3b8a21a0688a08f2b7f8aeda2b ]
    +
         ublk_ch_release() is called after ublk char device is closed, when all
         uring_cmd are done, so it is perfect fine to move ublk device reset to
         ublk_ch_release() from ublk_ctrl_start_recovery().
    @@ drivers/block/ublk_drv.c: static void ublk_mark_io_ready(struct ublk_device *ub,
     +	}
      }
      
    - static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
    + static inline int ublk_check_cmd_op(u32 cmd_op)
     @@ drivers/block/ublk_drv.c: static int ublk_ctrl_set_params(struct ublk_device *ub,
      	return ret;
      }
    @@ drivers/block/ublk_drv.c: static int ublk_ctrl_set_params(struct ublk_device *ub
     -}
     -
      static int ublk_ctrl_start_recovery(struct ublk_device *ub,
    - 		const struct ublksrv_ctrl_cmd *header)
    + 		struct io_uring_cmd *cmd)
      {
    + 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
      	int ret = -EINVAL;
     -	int i;
      
    @@ drivers/block/ublk_drv.c: static int ublk_ctrl_start_recovery(struct ublk_device
      	ret = 0;
       out_unlock:
     @@ drivers/block/ublk_drv.c: static int ublk_ctrl_end_recovery(struct ublk_device *ub,
    - {
    + 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
      	int ublksrv_pid = (int)header->data[0];
      	int ret = -EINVAL;
     -	int i;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |


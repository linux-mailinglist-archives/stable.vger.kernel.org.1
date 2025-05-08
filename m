Return-Path: <stable+bounces-142889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B537AB001F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DA81C077D7
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBD280A52;
	Thu,  8 May 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooR6+xel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595C28032C
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721094; cv=none; b=KTtIMZq14LnnBFTqNWzevQ+zRphau4ftznNULrrPyJLyUIMnLAC3z+paXlgjo0D0RWmBxVDf1Y8RCP0+lIGfy0cFpSM/m8VtdE4JmNgspYNB8V7ZcoU/3U0FSdWFivqbMM1sBw4NCV/Q2OlbBJcjNahgCeZFuJIKofLz1cE9uAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721094; c=relaxed/simple;
	bh=O+XqLLk8ouasLJRkVx/7Oj92x4lDoX09sViOXW/xPX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICzs0uscpxvfzn5Qn4obhpY/phA5nYaEugNcd3mG6NF5wf1wxfBHWRZCHPrzH2gEDPQqa/YNCDlisH00kyXiGNsM/84sKhlEN1G47yDz1LQgi3T0UpBMAFok3mHPVwAaD3Lj6/boHYdMIDTkmjAW/rAuGhViXXseag89wBsJ75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooR6+xel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5862DC4CEEB;
	Thu,  8 May 2025 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721093;
	bh=O+XqLLk8ouasLJRkVx/7Oj92x4lDoX09sViOXW/xPX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooR6+xelagn1swJHYABZNqrRHi9SUagU5O64phHZtEj5D5xd/FENr73UrW9eIL+e+
	 22fTTbav6WHGsiY7D3pPnMGDzzWILJ20jBNo5gy6P/2omL43ghAJ9CXDx2s2YyFkGT
	 9iFcGWzVZZQy4fknsfxbwHfmo9skG1M5BHPHp5tNedzemefDybsq+b2j/27gR8gRh+
	 rfNWCzmIKvgh6GafgrWIXIAPxjOrrirwqzVHmMADWfxEOWRJTVpn1O+GORmt0/WbBZ
	 Yb8TcTqoYsKWzGCfP05/w+Int+GeRYKFFX7b165vhuGHJlRJUZJGTHwiuklJ2Xj92M
	 Vg0OkzE9Q9wTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 2/7] ublk: properly serialize all FETCH_REQs
Date: Thu,  8 May 2025 12:18:10 -0400
Message-Id: <20250507083857-64fffb6941388e98@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-3-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: b69b8edfb27dfa563cd53f590ec42b481f9eb174

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Uday Shankar<ushankar@purestorage.com>

Note: The patch differs from the upstream commit:
---
1:  b69b8edfb27df ! 1:  632ba3dbe853d ublk: properly serialize all FETCH_REQs
    @@ Metadata
      ## Commit message ##
         ublk: properly serialize all FETCH_REQs
     
    +    [ Upstream commit b69b8edfb27dfa563cd53f590ec42b481f9eb174 ]
    +
         Most uring_cmds issued against ublk character devices are serialized
         because each command affects only one queue, and there is an early check
         which only allows a single task (the queue's ubq_daemon) to issue
    @@ drivers/block/ublk_drv.c: static void ublk_mark_io_ready(struct ublk_device *ub,
     -	mutex_unlock(&ub->mutex);
      }
      
    - static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
    -@@ drivers/block/ublk_drv.c: static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
    - 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
    + static inline int ublk_check_cmd_op(u32 cmd_op)
    +@@ drivers/block/ublk_drv.c: static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
    + 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
      }
      
     +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
    @@ drivers/block/ublk_drv.c: static int ublk_unregister_io_buf(struct io_uring_cmd
      			       unsigned int issue_flags,
      			       const struct ublksrv_io_cmd *ub_cmd)
     @@ drivers/block/ublk_drv.c: static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
    - 	case UBLK_IO_UNREGISTER_IO_BUF:
    - 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
    + 	ret = -EINVAL;
    + 	switch (_IOC_NR(cmd_op)) {
      	case UBLK_IO_FETCH_REQ:
     -		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
     -		if (ublk_queue_ready(ubq)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |


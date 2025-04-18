Return-Path: <stable+bounces-134614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B531A93A33
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF4A1B676DC
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E792144D2;
	Fri, 18 Apr 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHKzG+jZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF515624B
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991869; cv=none; b=KjZSXyNPwk+HvW87izeJS6sPOb/srChtkqMwQw7UFOk3u/dZbOSuIPUfx9q5gqDdPtf5rHJGY/ueb4UZF4PKNx1SlX8hsTPMcjin08ufXD/kcTgwax1BSFj/HTfvzMiTFOfY90EJgs8vndoVapxuL0fGewCAotg9DBapZaTzyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991869; c=relaxed/simple;
	bh=6CgIa235sR39lRgrpfRnLM3E/+F0+uJ136bEoha4eos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6+i5vWLxvu6srKGwW6tSWQbN+5/Bf3ynja8UedPjDlkZ05TWeK4nRvRQtBRXqtcnTOtwUe/PfTVTC4mFmPemCmQzRuIHtESCkqRnE/HVtaJGGXyT3QJ7UuWTNwsYReXUeoXw7HKYtIHiyQcPjN9hUUpG3Fg6Z221hRcZdqRnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHKzG+jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A585C4CEE2;
	Fri, 18 Apr 2025 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991868;
	bh=6CgIa235sR39lRgrpfRnLM3E/+F0+uJ136bEoha4eos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHKzG+jZEAGg5CkAojS8mcYe/BzD/YKrUcYsenmvoRn+5/cLuH+T+4bR8EXpZczEe
	 zwk9ftR1b9hGQDs7uqJP4zKxPFaPV/3TbWOYAxmpUf82vhKXuFNSglcP4QVakgSYpG
	 6EXTTu70nTuD6NvXZHiCx6X51yxaI7jpxkmmufjYJo0BTsKvrSP0JQOHddIx5QIme+
	 EnBGUDZcHPmXSe1GV1fnSK0r+a9Bm3vnlA061sHoQKTT6Z/eLYm5oHOHvkHIe0Rcmy
	 ftUGBm7MjdnX5bIzlkLAdRLdzh6J/E24Hy+aLVXG0tytkzfzyH4O5cIv9mYJfV4y0y
	 UCtqmd+HtcQGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15/5.10 2/2] blk-iocost: do not WARN if iocg was already offlined
Date: Fri, 18 Apr 2025 11:57:47 -0400
Message-Id: <20250418102133-e97be29654583e48@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417073352.2675645-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 01bc4fda9ea0a6b52f12326486f07a4910666cf6

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Li Nan<linan122@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1c172ac7afe4)
6.1.y | Present (different SHA1: 2e962785b508)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  01bc4fda9ea0a ! 1:  62b4e00c59eb3 blk-iocost: do not WARN if iocg was already offlined
    @@ Metadata
      ## Commit message ##
         blk-iocost: do not WARN if iocg was already offlined
     
    +    [ Upstream commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6 ]
    +
         In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
         is intended to confirm iocg is active when it has debt. However, warn
         can be triggered during a blkcg or disk removal, if iocg_waitq_timer_fn()
    @@ Commit message
         Acked-by: Tejun Heo <tj@kernel.org>
         Link: https://lore.kernel.org/r/20240419093257.3004211-1-linan666@huaweicloud.com
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## block/blk-iocost.c ##
     @@ block/blk-iocost.c: static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


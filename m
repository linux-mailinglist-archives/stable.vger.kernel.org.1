Return-Path: <stable+bounces-134605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B0A93A06
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F38D16B50D
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626C214232;
	Fri, 18 Apr 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhKazIru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6203213E89
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990965; cv=none; b=Bheq3Z6DyAphmGmZU3FMGWwELQtOUzqNlijg0Qf5Gz3kUbsnKUN+IG/xvAO1SX6d3jIFuEA1X60cX873kZXN+RKN5w5ygxgwUGPYW9IRkbWzXT0d2G89fNay8xBmFYG5Z3wxCd+M2l523cwS8i6KPrOdBuoH5V2WFfDSwPfqTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990965; c=relaxed/simple;
	bh=gD43GxgtfM4JJ3CnuqTqKDTTJps8/k+UNmhI9bqnEkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skjs2UtC+WZedPaclG9bXjQHgSgRidVzGAXyqI0NRw4LqtO09414iVuq0F3QIWq1z3k+gDLcuwiIbthzw9u5z2ZVGWN9pBU8tisnGwKudFe8wayFv7L+DVXydsLrz6JeVXTrBfy6nGASHn4YN42z+6R+5MkfqBukHd3A5jTSOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhKazIru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1630EC4CEE2;
	Fri, 18 Apr 2025 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990965;
	bh=gD43GxgtfM4JJ3CnuqTqKDTTJps8/k+UNmhI9bqnEkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhKazIruXZapAflu40QfRfLGd+emVFPMUiAi0h0H22QjsRLlAdI1PPGdYy8B83/qt
	 7rgZ3K2FIUt2kxMpKIpmu/80bXOwEW5XINpznIDHXpg++yopjH4+iT/1fT8jSbwWZJ
	 wC3wUncWfLrExP2YsYwoEBDNBrgLY6JLF6S1gbysZ8Nd65DIhBbYzk7ee52AcVzUH9
	 IwpF5+QFNO6GXj55fzJcO9nQg9um9DcGy7Q9GlnUtHuplcH6TEQbO+0DpnmLC/9umM
	 mSf2IkDrfqO3H3LcJpHTDe3CcvsgEFOUo7lF5+k3xp0vdkg1CQqN/tDVYoVZCfwGTM
	 p5aWGoJa3yMGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] blk-iocost: do not WARN if iocg was already offlined
Date: Fri, 18 Apr 2025 11:42:43 -0400
Message-Id: <20250418093947-cb32c875128f0652@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417073041.2670459-2-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  01bc4fda9ea0a ! 1:  f8c69d65cdd96 blk-iocost: do not WARN if iocg was already offlined
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
| stable/linux-6.6.y        |  Success    |  Success   |


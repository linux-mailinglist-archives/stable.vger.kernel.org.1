Return-Path: <stable+bounces-125669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A030A6AAA8
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327424870F9
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368141EDA18;
	Thu, 20 Mar 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kucE7pW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959E1EDA05
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486614; cv=none; b=avqhJPTjEzi2vvvJi/+YHeRMSIXeNUGEUsM3bw66SMP0F/PhD644nVDfgduPgG2qaN0YXV/Tj1Iht9YvoRMEzk7If+9HCnUwvnd6LkIz51SpAwEwhQv6Cxc7/XUQu+td+ZPFjbBV7rBwJu4zvZqQ0wOU3hf5WVmyoAXWaZrS+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486614; c=relaxed/simple;
	bh=LV7rwrmodQ4U6u1JO4NZ5hLGx+kHI9F3A5tCpnHzvuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo98rA0F6w4efbYCn++jCCK3+9nwoG3QVGhYz5Ko9lm42fCNLjpJf8jD0psqxH9T0O8LfpE8//L2lswQ55f60pninwi8E0UHevmRaMnTizxc2yS+R4x0Skc9YXfVJ051dqsNjfHGCfV1fh9arQMkJKZ581MF+HupJ2RbCIDmQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kucE7pW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF79C4CEE7;
	Thu, 20 Mar 2025 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486613;
	bh=LV7rwrmodQ4U6u1JO4NZ5hLGx+kHI9F3A5tCpnHzvuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kucE7pW2xv+l4PGFvb8faIE2rugIW9C1y6JF1xdTdZo832ALQvJ3Ii4kQxbTeYBET
	 l+fmA1Cc144BCzZU8ByY7RBuELQcnwrwHGHZ1GqTlIZ4BQkBrk8Yq/FNyBjXxMDDi3
	 ZsjUGiQ3bHJ37opKOgokdga2xaqfWi5Om9HPWWP6b9hdQqJrS4TKdlMNWekfuJp34o
	 UTqV7EPin6cXUjtLMXemSiqvUQbkK5bJqwgyRHy8NcOKjBeoMHlLB9wiBjIDUraY3N
	 6E3H3bcgTR4dDKMit2xNuS2xQp1KQD3kCqHs3Hs7Esz7ALw1gEjl4JX1DHqPgiLM3R
	 tmeEIRKvwXOWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Thu, 20 Mar 2025 12:03:21 -0400
Message-Id: <20250320113401-5371335b6c570924@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_A61660721BA068D56A023F1625A5ACED7009@qq.com>
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

The upstream commit SHA1 provided is correct: 95c38953cb1ecf40399a676a1f85dfe2b5780a9a

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Kang Yang<quic_kangyang@quicinc.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 543c0924d446)
6.6.y | Present (different SHA1: b35de9e01fc7)
6.1.y | Present (different SHA1: 6e5dbd1c04ab)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  95c38953cb1ec ! 1:  d70f5cd84923c wifi: ath10k: avoid NULL pointer error during sdio remove
    @@ Metadata
      ## Commit message ##
         wifi: ath10k: avoid NULL pointer error during sdio remove
     
    +    [ Upstream commit 95c38953cb1ecf40399a676a1f85dfe2b5780a9a ]
    +
         When running 'rmmod ath10k', ath10k_sdio_remove() will free sdio
         workqueue by destroy_workqueue(). But if CONFIG_INIT_ON_FREE_DEFAULT_ON
         is set to yes, kernel panic will happen:
    @@ Commit message
         Reviewed-by: David Ruth <druth@chromium.org>
         Link: https://patch.msgid.link/20241008022246.1010-1-quic_kangyang@quicinc.com
         Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## drivers/net/wireless/ath/ath10k/sdio.c ##
     @@
       * Copyright (c) 2004-2011 Atheros Communications Inc.
       * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
       * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
    -- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
     + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
       */
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


Return-Path: <stable+bounces-106243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590599FE226
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 04:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A6F18821FF
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E988126C17;
	Mon, 30 Dec 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7z6NpbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4412594B3
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735527888; cv=none; b=F+1H0g8xCVgeqJsQLROW/bhe0EpwTMpfjW4SVOIWxUHETcPLtqevzukzosd2F5J3M9Gp57CcjdjeF+deoLihlBmFm9e7X2GNlgjuXk/2QPE1V/SZ3TCjbhKBt8dqSVorf6I3gVtN2Pf4XhtbbHvt9xo7gMvjbIin5dVSYRuL0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735527888; c=relaxed/simple;
	bh=3ditnXEIKd3+95Tf8xMAQ7z/TQW3Y9tTUF516FklZlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bThj5MIGeaM6NmXFsDPEHgu+V87rkGZM7KUAoIs1qzuHYj90qLiIzZua4fXCIhNycJ2Ccry5PzecUOUmPvlxXQsU7rXTSfHVb9WaNeSG6rroJUOb6QjElUdpGSXi/x+b+0DjBhvEpI6X8/upKJ/X23wg2KnMV6GxxT/03IkR2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7z6NpbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABCDC4CED1;
	Mon, 30 Dec 2024 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735527887;
	bh=3ditnXEIKd3+95Tf8xMAQ7z/TQW3Y9tTUF516FklZlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7z6NpbYEmuqFsbP4W0zhaGZnpdBBrx5Lp86dGCy6wbRVgmtI5+rldC4y87aI51hJ
	 Gz1l9kHQkukY3QNad/bFKDQCo41Pr/EuT1o+8VfOs3A7VAC7QjO3RNVcv4j8Kk6O5e
	 /2XBsMrnzgA/EzPB2jsDG7LIMLajfPrJu4PjIWYv3axlF2GBgBRCUFic0AkeeH1Y2X
	 IAYly7uDWeJYcfLQMrFoa7v066hBu7U6abn42batthrsPo3LptZne0N8XuyEUjnrr9
	 cSv/sROMLE9ckzVIWeubd5+MwLJR1QZ7wwzdl3J0+ex6AC8+iI2EZd8E2kp1V87ju6
	 7SqrRhahNHBTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL
Date: Sun, 29 Dec 2024 22:04:45 -0500
Message-Id: <20241229220412-6f37633cf7400e2f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241230013919.1086511-1-zhoubinbin@loongson.cn>
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

Found matching upstream commit: 4b65d5322e1d8994acfdb9b867aa00bdb30d177b


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4b65d5322e1d ! 1:  c2210939eb07 dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL
    @@ Commit message
         Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
         Link: https://lore.kernel.org/r/20241028093413.1145820-1-zhoubinbin@loongson.cn
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    (cherry picked from commit 4b65d5322e1d8994acfdb9b867aa00bdb30d177b)
     
    - ## drivers/dma/loongson2-apb-dma.c ##
    + ## drivers/dma/ls2x-apb-dma.c ##
     @@
      #define LDMA_ASK_VALID		BIT(2)
      #define LDMA_START		BIT(3) /* DMA start operation */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |


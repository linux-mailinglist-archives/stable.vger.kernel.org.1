Return-Path: <stable+bounces-125825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF74A6CCE3
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 22:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95703B1A04
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7B1E51EB;
	Sat, 22 Mar 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxyK9siH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C386338
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680288; cv=none; b=qMZhBaJGQw/RuyNencfehotN7URHMSPbwzWYxNQt8LD+czOJ2Zh6k2VmlOVEGWBJ79eGbW3LcB5xqcIUlrmRykhbIwgE8kyETVq6sn/711pXP/LkqI1Ui4FTlr83g17ScX6Jk6BpdyrubzQznZ6Uosmb2mE1ye+AX+3FeZ1dfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680288; c=relaxed/simple;
	bh=UfgD8yy9P6ujfflpSqYVKfxkgxb8oYvOd6tv1HDV2Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IusylWd9je1hjl0s784RoCn5lAHg4/oRtmWxQjENaORU+NbaRjBiEmyWhmbEJkYhrrbzWytNLedtEwluddopkSepsijqG98I6Rf1LEqZ6/CMyKOgvlYp6ZLsBmKqQsgBg+ITsvZ3WIxKEW8/dCQ7E1nsJumkTssM49ZPPSaREyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxyK9siH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288C2C4CEDD;
	Sat, 22 Mar 2025 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680287;
	bh=UfgD8yy9P6ujfflpSqYVKfxkgxb8oYvOd6tv1HDV2Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxyK9siH68ir0G5R+USV3Ye0Zwy43X2EDpRVW1yC9sSanKo6yneosV4u5wdnPZG2f
	 mIUIEg2ZX4WPRC+BrxbHLFF4HIZYO12JKhBA4yhbCFPgl3DTDrD2r4cPpjhnKVz74g
	 D3yQsdudUnza4sdNsdiFUwqZNiBAAr7qPIupTt8A52hRBbsl2+JlfUhL8hB3e4JhVi
	 XrGDXeNyuDkbkkluadb9cV1DWwPHrA28fzo8o+TBpTSL7tJtXHtLGG8jQgAibMsQKx
	 nB5JwuAP13lrLxfPxa+qhPyIN2fgdEIb4N4vEKlbUC8XP6Mz7UO15m44St2S8PdQSt
	 6rWBs2mYgEZGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
Date: Sat, 22 Mar 2025 17:51:15 -0400
Message-Id: <20250322095705-c65e6f9e30278385@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_E426386D30240DE4B48C35371F2E921AD608@qq.com>
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

The upstream commit SHA1 provided is correct: 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Miaoqian Lin<linmq006@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  045a31b95509c ! 1:  2a4b98a5147c0 phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
    @@ Metadata
      ## Commit message ##
         phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
     
    +    [ Upstream commit 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f ]
    +
         callers of tegra_xusb_find_port_node() function only do NULL checking for
         the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
         consistent.
    @@ Commit message
         Acked-by: Thierry Reding <treding@nvidia.com>
         Link: https://lore.kernel.org/r/20211213020507.1458-1-linmq006@gmail.com
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## drivers/phy/tegra/xusb.c ##
     @@ drivers/phy/tegra/xusb.c: tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


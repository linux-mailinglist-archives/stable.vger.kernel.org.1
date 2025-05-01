Return-Path: <stable+bounces-139344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E0AA631D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CD41BC3071
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548611EDA2B;
	Thu,  1 May 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAaA0acz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C511C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125453; cv=none; b=fcJ2fOWfOca/pyoy++qS/iqZKgwLi1c0etlvUPRqarjLUs+WUzLKjaAsNrO21ZPIoKBRtmruoU5PHJLZe5EQEQBBwsUADJlQhCqOpxiWHkg9ZEfTipusib93mub3FS83bawD0wTjafzcLALlx0YQg+cYMWsjtwXDKwBeAnCzAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125453; c=relaxed/simple;
	bh=eT93La1TZ3RSttng92Gt7G/VM23x19yvZo9h9yOQRQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1cpFhzk0xK4WMwaxLGogPg0zcUTwQd30A+xoGRaR1jjQsE741XI5NFoVmYBTpmqzs/+xbJ4hzrr6FOIeQ0lMt20xbGnnELtPwg/IRNQABDQmMzyHlsreo/xZcur/JcmiZw6/r0Skb1O8888JidsWaS6J2byuddPWPkK/Dvd2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAaA0acz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC5C4CEE3;
	Thu,  1 May 2025 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125452;
	bh=eT93La1TZ3RSttng92Gt7G/VM23x19yvZo9h9yOQRQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAaA0aczLuvb8oyCQvwTb9zlnzQ86kdZYSt5puqIT7eLJzKAtOL+h3G14BiwjzOHz
	 oM98LJPH/MyL3dAKpqxQHufJg2lHMVgbEET0Br56z7YobOD5kd/FrEW598uiiYCTZT
	 2J4tV/OkHvROqxbLIpThXrD+5eJBaTfFdkxvQNVG48xlXAurBvWfZFXL9nRdER3k6w
	 dLRzId0gj2YGtu+lYXoDSn/KwvWkW9kvek89+gkjJqB5P1TiEbgjn88U1UHSvHwFI0
	 cndj+61WUYCR6e7MakezaB3SeS7JUVKyPYoV2Kl4SvizeHyYazy2u4X/1RmY+773UR
	 46tcuRMAJsQew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 13/16] xfs: make sure sb_fdblocks is non-negative
Date: Thu,  1 May 2025 14:50:49 -0400
Message-Id: <20250501130919-15c9ae15571a8247@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-14-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 58f880711f2ba53fd5e959875aff5b3bf6d5c32e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Wengang Wang<wen.gang.wang@oracle.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0e52b98bf041)

Note: The patch differs from the upstream commit:
---
1:  58f880711f2ba ! 1:  621457ef92ee7 xfs: make sure sb_fdblocks is non-negative
    @@ Metadata
      ## Commit message ##
         xfs: make sure sb_fdblocks is non-negative
     
    +    [ Upstream commit 58f880711f2ba53fd5e959875aff5b3bf6d5c32e ]
    +
         A user with a completely full filesystem experienced an unexpected
         shutdown when the filesystem tried to write the superblock during
         runtime.
    @@ Commit message
         Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_sb.c ##
     @@ fs/xfs/libxfs/xfs_sb.c: xfs_log_sb(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


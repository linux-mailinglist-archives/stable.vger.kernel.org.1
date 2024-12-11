Return-Path: <stable+bounces-100649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F89ED1DA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B631665FC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5E1A707A;
	Wed, 11 Dec 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI6XMF0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5838DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934739; cv=none; b=lwJy02duVTl4qiGH19lADiGr3R/Kd+wG15eT2khQnbmNMH+YcIygCeO4as9eUeWGpreg/g80gM/8INLFZJNsMWH69h3Y31rmCc5NawdK0WMXqMUgZPNqzGxmKWmH3+sM4ZOXLkO57dqmtafG72QwFtVoQzzVyG+dWz9n0r0RVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934739; c=relaxed/simple;
	bh=wsltIYYQuPvxXDNGIOz67tJswcURnICUAfAVQBNFKR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pusRKwoC52qKoWfQjxVvdh72Xp1pQCfdS29x+g2OIffX7tkPDTP+LFUiEybkXrhl+PWtSkglm7uOfxw2vGnq9OG8s4h8ZXI70YWdHjvU/A3VF5xv/AlKThMHgDf5L33CQ/OCiuYVt83MHaviiN4umP26FywmIpJtasQeKGRg93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI6XMF0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96849C4CED2;
	Wed, 11 Dec 2024 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934739;
	bh=wsltIYYQuPvxXDNGIOz67tJswcURnICUAfAVQBNFKR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tI6XMF0ZWbx5q6M0Tv2B1C6XT9O9IMXZEEiqBL3+Mz8nGItAMzz+IiYTbjOCsaluy
	 2qhNaA991ZaHkW391nsrBZVT09rQH3QRLbB3vLVrGuKqWpspOEiPP4L/zSBKG7U0tT
	 QqleozWXyOOuAcRoUpWcLwVbAgN83DqKToZxjr68fMgAwW1U7QHKqtLiG397elSdNQ
	 KNOPg768pSSwOW6FVAUsXyyLRNb60iGPEA7Z50bBIpYTV6I4QV0LBR0RtZx2tX8ZZO
	 ePQ/rYZ8JlB269Bwz2cFjPxurT+gRQZQXqjzb7qc9AUdwnfHnRsOglkHH+yXiHeMaH
	 /oLiVZILYivAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Wed, 11 Dec 2024 11:32:17 -0500
Message-ID: <20241211094551-5b4e8d3a48ec7b0a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211095825.2069491-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 789c17185fb0f39560496c2beab9b57ce1d0cbe7

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Rand Deeb <rand.sec96@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c5dc2d8eb398)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  789c17185fb0f ! 1:  c1a673cbf296f ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
    @@ Metadata
      ## Commit message ##
         ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
     
    +    [ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]
    +
         The ssb_device_uevent() function first attempts to convert the 'dev' pointer
         to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
         performing the NULL check, potentially leading to a NULL pointer
    @@ Commit message
         Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
         Signed-off-by: Kalle Valo <kvalo@kernel.org>
         Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/ssb/main.c ##
     @@ drivers/ssb/main.c: static int ssb_bus_match(struct device *dev, struct device_driver *drv)
      
    - static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
    + static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
      {
    --	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
    -+	const struct ssb_device *ssb_dev;
    +-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
    ++	struct ssb_device *ssb_dev;
      
      	if (!dev)
      		return -ENODEV;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


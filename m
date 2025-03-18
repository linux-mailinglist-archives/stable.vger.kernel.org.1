Return-Path: <stable+bounces-124816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A98A6775B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526273AF890
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58120CCE7;
	Tue, 18 Mar 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvcOVbFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E934C13D
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310762; cv=none; b=AGxi1MwHmZv43rEClw/DQlhnJHpKZQgQcrJZHFp5JfVu7MdU7vgupCMLN6wRPmLb3+7/zqNGjEWJ0QHUdUg8Wu2KBNZFKTf+1nue5Oim6uIskELKQyz9W+jw6ViQDda1tuMOS4Rmiv0iofKLVkvah2k/ZqgXoIfLdA2c9QSd+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310762; c=relaxed/simple;
	bh=5P4xBrMDbpmJ7lyWdXEw7fSYCfTp+UWRX97Uoxb9zJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsDXIWkoh9rLQKwu/KD8YFh2neFkWatMgVP/SnMDdQK+3T1ROk+ARef/t3Oi2ajeS1bgmapjGdMcbFPHcVR+owANUwr4dcG+8Vbuw+2eOnGdGGl8GwwvbzWV5IlmkLlKPOyLaFJTD4eKpXg54GuqMl5S0Ahl2F0NeY8vnZdPOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvcOVbFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2B9C4CEDD;
	Tue, 18 Mar 2025 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310762;
	bh=5P4xBrMDbpmJ7lyWdXEw7fSYCfTp+UWRX97Uoxb9zJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvcOVbFfcNpxflhNX5bCU+oZ8e0UT7whbj+luGlPDq5R8IiyRoc12CDjdg/YCZLxO
	 9QjuleMlOikoAm2W21LTUOKjzA8KO4U3b6r9xjP6LsaFxMb+XS5av6S/9LkmO/73nn
	 loQ40FJ8cyXG8GU2ZGgYQ2Mv6gZTNTeWSTOzHRbyjH8utBQxJEZtR7MIaN/B4vOvfL
	 wTaSlWkYYy+s8uwOxVd1QGR1tA+fb6oQVTCPuLE0eDD6ItnBbrIXpsdrh+BdzumX+H
	 sMEma+H9FgW8k4u7MOaWDOuO+JuFMZrxkfeTQw77tuGGqUWu6zbxC2TMPxUHjAA7Er
	 JTg210V2FFuHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Tue, 18 Mar 2025 11:12:40 -0400
Message-Id: <20250318080925-32aa4e1bb5cc535a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_891A70685F6B183EE224B3AC4F70FC60DC09@qq.com>
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

Note: The patch differs from the upstream commit:
---
1:  95c38953cb1ec ! 1:  4bc5b99f1591d wifi: ath10k: avoid NULL pointer error during sdio remove
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
| stable/linux-5.15.y       |  Success    |  Success   |


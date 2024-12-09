Return-Path: <stable+bounces-100195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522D9E98FA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8159281315
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30D1B0426;
	Mon,  9 Dec 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byvxCfuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37A15575F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754913; cv=none; b=BwEwHl3fDuaE9pVsv/OgToCbU+wCANeNO0fNj7TkF4oC4/mP2EG8aCytA39X1YthrTDsEdEj8OpGg25fUkgOgQ5ysx0818pAIyIytT0kW0hb0QCN9DMEAWqfDhOAhRTy5B5Z9JHqUkbCWwoVjlWecvhghJVWccVR/8izIGiuifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754913; c=relaxed/simple;
	bh=a9QcQiM00M1Zv3FgNaWygJVoKtz0iSwWXLqF6/mAJPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAxOUoUDBTFnVO6G4qN+h46UpeBnyj2TdtbWUR2Hbch/C/UiOyeVCG99IvVrt32pZ51we25/R/mKlP90RV32XVZ9fChI/BRQtWOs+96wL5c+oO314RHt/ImV/RlxqNQFadX7FtgKkOx0urTCjVUxHxNBF8CySPZjy6ILVFHTEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byvxCfuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42CEC4CEDE;
	Mon,  9 Dec 2024 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754913;
	bh=a9QcQiM00M1Zv3FgNaWygJVoKtz0iSwWXLqF6/mAJPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byvxCfuWDbpKKooPF9rV+CMTapcz5KYRkJD69dgNGB2k7l1rsimqS9jvPH4K3yddL
	 RL+utlHctIzI0PTtxUlKmgG07brmzVFb5uhJGiOVLkinvQnudB7Z4KdGQX6AX4jQpy
	 HsPRmR5/0PrykMp9pCqtQB75DEB/0WqSJLdExLjMPNOSbV4RaLVZ2A7iZDJd2hMZxi
	 hzPYSllSFpA2AxcIkw5jpS/jpZFiaXm5jvyGY9AdwHTrNme9pobZY8JaQKpMoQwsKl
	 d7jKept0Zx13P8SzXxaPQLab9QWOw/9YANtZhYHnA0qdwnEwdpXvj2nxHVRBlsOrVb
	 sHy/MXu2gLhYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon,  9 Dec 2024 09:35:11 -0500
Message-ID: <20241209075536-d21beeee13dd6299@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209063333.3426999-1-jianqi.ren.cn@windriver.com>
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
1:  789c17185fb0f ! 1:  eabfe79daed2a ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
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


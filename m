Return-Path: <stable+bounces-100658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A229ED1E7
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C345E1665C2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF531B6CF3;
	Wed, 11 Dec 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILhssqge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7B38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934759; cv=none; b=B12+0cfaLkDtZCeFT+5xiJPGw3QpgLAz7Rn6VrRZqN5jCbQyV1pEN/cMXO6VXSwWl01CCV0tj2OSHewjR3HtX8BvdQYHgglY9I9ulZmy398WZeEZ9vC4pvgHxsxh2yLTTXHoPix+zPgmY4nblDL4DCL7/ruj5CBrC1Ju/wSnZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934759; c=relaxed/simple;
	bh=ymIjbqTprlofUv1jGQqFzsXU8cEjkk+nl+A173C12Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiYBtd38/FqQa1tM25Vp1f90lGWTieI1D62dOwjFjPJqe9MBlj9VfS7a8ZCnZPF3Dd7Cnh3wBdVWbN/sJOH3mvJmp8Wv+7k69b486ZgDcZJgtaHs5ynoLRUfux1pAuJwZKKLXks72rjGf1gbuGNEeRPKhZdUJxqxHw1RCpXrNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILhssqge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D45AC4CED2;
	Wed, 11 Dec 2024 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934758;
	bh=ymIjbqTprlofUv1jGQqFzsXU8cEjkk+nl+A173C12Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILhssqgezb9AuPzGt9L4VBPqa5JUs33d0zM5mZwn0PtgXkz5ypRfVXIc3cN8t4j9S
	 6C3wugJCwIVPY+MEXktmYcSWXtqvdRJgp+Z0DToB7iS/v7VTUTsFUD6QOB/BvUCN1J
	 RT9K/i70fBbPIKdwM2GSyIKjX73ys/dyV7aEf4S/0YIZp6ZsseE/EJYrKvfm8KH75h
	 OGfWcXcfeRWnrF1PKn9bjyCczKIBDyRgbWVZWPwW7+O8oJsjvh8ZRRlvy1SlbNVro3
	 6mqG62lXhHfNfpZTAgeEzmi8YVU1QtJXbZubc81CTjehCQPGfe1xVg+Jshs+woTPFz
	 8FHVDQvQT14Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Wed, 11 Dec 2024 11:32:37 -0500
Message-ID: <20241211104650-cb8f31d950f9a684@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101533.2111952-1-jianqi.ren.cn@windriver.com>
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
1:  789c17185fb0f ! 1:  4a4a333f41731 ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
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


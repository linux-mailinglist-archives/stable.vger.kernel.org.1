Return-Path: <stable+bounces-118920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F81A41F45
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ACF188BF95
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06889221F15;
	Mon, 24 Feb 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDu+Vch4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A233705
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400712; cv=none; b=ZHOrifrARcZnVwqn6Wlt2sFcXKqnJv14K6SVwIv7i+odgrrupZ0SsCvigbN1Nr073zEpRKnWpL3R+rB3jtB1gUsZQi997bDr24hWOY3LhZE9feSbj95etQO8+2st2nAwC6fVUwql0Hdds1ApuwBlLiTCj/DU7FwX6aQ/V7613sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400712; c=relaxed/simple;
	bh=gE+NOI2TDLbfn6dcZhlj+dpHfTfIsECxCijbcLPY8A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG8ntf60MTzMtfQQGDM35X1gZPI74O+1s5jjVKmB4I5jHqdcdRCHfBT8aiJSt43PU8bkJSgiz+9O0fJ8bEDXqOdO7lUMYT0SDZ4ooPecXYs7WbIpxRGQB9OLqJwysuXupZ4lESSkJijzLmDEXQMicKyrDKFTZ3dxkftzCDtqvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDu+Vch4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95B4C4CED6;
	Mon, 24 Feb 2025 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400712;
	bh=gE+NOI2TDLbfn6dcZhlj+dpHfTfIsECxCijbcLPY8A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDu+Vch4JMRD5nuPI7pHeWqppHjc35lfQqBjuXxk0AVfrFYwZc9EY2G6gMaVzNNMy
	 g/KdqWrXq/8QMORtIN/SVnoLlEOkIJd8Bnrx6QqQy4WFEPiTJyG7DdDud/ffnZJP23
	 k7LbNJF+/Ras2o/ug7AeYDjAbcnwWC3+NPurBykxndLSIBq5X9uBBf6P33NtB2VNrF
	 EUvN7auW/+D1dlg5gl4Cghme4b8vwdW/wYx6lX4p+uCZpVnEkRP0MOiyC80WRdPyTp
	 7r3zlTzYbsfDupkQkiu0sbKgiTSW55S//9QY71ZB/7feLKXivy/n1s9CsD+5lmEHeu
	 6aZmNNjEmrq8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon, 24 Feb 2025 07:38:30 -0500
Message-Id: <20250224072824-f5c9903e96cceacd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224083707.2532381-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 789c17185fb0f39560496c2beab9b57ce1d0cbe7

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Rand Deeb<rand.sec96@gmail.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c5dc2d8eb398)

Note: The patch differs from the upstream commit:
---
1:  789c17185fb0f ! 1:  d56063aab85ca ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
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
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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


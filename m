Return-Path: <stable+bounces-99972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0D9E76C9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F3D16544F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB11F63F0;
	Fri,  6 Dec 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvBmZmFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769D206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505108; cv=none; b=Q3HJPPUW5HlLR88lARN1FM2bruf1b2YQBx/BwAYNsp0+4uH0NcdzdEtTBQVitHfuvRiQTlftCQgxx+EBthqLBkXxLvBelT6+/Y1sTZowqXEJJNlGJ7teCUPvv+n29eDyWsdjl5b0lj9FcAYRSNI2GFMEvKNP+Ay7PAbnUjhDnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505108; c=relaxed/simple;
	bh=b+BaGKPDUZfPCAdlqWNJGxfEHIR0oqCGIRiGrVxMVoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4C/R567zmlAN4Ho4Z373FRa6UctFGXbOt8pD151ZvVRQZLRdEEJ9B1YPhdc/ICEnLuLFpq34RtkAJQ52HyyCnkD+OOYFyPX0r2dZE+7TBq9GidfPGsxmvnMeAAsb05XVXpjaOp5/tsFUZ13YR67TVvL43d6xUQHC2VuWGuivAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvBmZmFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7FEC4CEDC;
	Fri,  6 Dec 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505108;
	bh=b+BaGKPDUZfPCAdlqWNJGxfEHIR0oqCGIRiGrVxMVoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvBmZmFxisNe4fXuy8mJhwwLmplB05/sF1bPRVpuJuYeh3LTxAH1T5vEzcBPDMgpe
	 nPTdWfFnL7DSzjhFMINePUNbSDxu2iEYZ2Twf8RF69Ji01Bty4YnOp96Ti6blIw4M1
	 a5oYkAKZeSnOOsYrFlprbJkd0d/eZJam949MEVRN1gLdRoMRC5ibutY4PpAf2nwUsN
	 5/6Pgg+fZ86pEaSNZhdUhwBOi1Nm3TKWla987aZ9P5rbXuqShZr7Rob7le7ql9Z+D2
	 OEevOg4/ujifQhONws+4GnZxUnD3hfV+XGR+JIN2VGbdPhmGgwyESDno2djsQSKDsn
	 6WVVHeQRdZ3dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Fri,  6 Dec 2024 12:11:47 -0500
Message-ID: <20241206094659-1454e387e24e03d7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206093256.939765-1-jianqi.ren.cn@windriver.com>
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
1:  789c17185fb0f ! 1:  66fa3cdc05708 ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
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


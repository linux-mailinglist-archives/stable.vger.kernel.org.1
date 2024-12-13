Return-Path: <stable+bounces-104118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5869F1089
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A58280C90
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB91E2312;
	Fri, 13 Dec 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKsldLDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A861E22FD
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102801; cv=none; b=fPVVO01P2SYI7N+aQzbl6X/aYo9WivmLw1kFbS60Ty/PkUGrFNjjSW2qLFFL2/JvVo0ci/tSHfuNX2ZTii/3om0wlXEUMECw253m1JeUhRSsDkpd7tViGFP3yWhcabGIkpNxgROa7GTST3D4oSse2/BYM4gPGgpRcO/HKND4oIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102801; c=relaxed/simple;
	bh=8jAWLIJY787pftTIbX/XuLRmWIqRpPxIfs9tWl3MKFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTLhuf2lEM67Mtsasvty1hi155zPWrXwBTHvmKLgKxn+C837Iq7foONFPFQbKZMRbmkvPstnPz+iUcV5VtZ4u2QRv1zp8TVZflWDJZ60xaFoVoKA58i79H5STFAdLpk1KOc2NNPDcTK+hyJZf2rBKN7mc5GpS4TcFFYEJvoR/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKsldLDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E741C4CED0;
	Fri, 13 Dec 2024 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102800;
	bh=8jAWLIJY787pftTIbX/XuLRmWIqRpPxIfs9tWl3MKFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKsldLDd1FYhEfsv7n9Ed0AcgLY7i/wBHvHQ6gVV2TDVKjKx1YURsxwcaGX4uD+dA
	 mCL1BSJWVIotdshFpKq4bLUD2M35RbFYmEH0V7jMj1gE/Vw3bkZlCgv74PZpbLsUui
	 3SwEKrMEgDf3CuQbAtZg4aP2Z2DkIH9MFa6zDaVInzajpfYTl1obA+cfNwdanyqmGm
	 0JUfTyv4LmQt+sK7XOZ4B4MxOL7t3kqn4Qv7dM3rkK8iAtdHNwC6FCFRuQmXF/jeWc
	 1nMFP9g1b8ipP56jnfL2ulM05J8njZaHJARmTB+QdV5HRHo97+PYeYtReWyMwp0iAI
	 sOK2dxtGbuPDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH][5.15.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock race
Date: Fri, 13 Dec 2024 10:13:19 -0500
Message-ID: <20241213090047-1bc638bb649e26a8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213103122.3593674-1-guocai.he.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: bfc6444b57dc7186b6acc964705d7516cbaf3904

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Ian Ray <ian.ray@gehealthcare.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e2ecdddca80d)
6.1.y | Present (different SHA1: 58a5c93bd1a6)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bfc6444b57dc7 ! 1:  3812c0bc93e5e gpio: pca953x: fix pca953x_irq_bus_sync_unlock race
    @@ Metadata
      ## Commit message ##
         gpio: pca953x: fix pca953x_irq_bus_sync_unlock race
     
    +    [ Upstream commit bfc6444b57dc7186b6acc964705d7516cbaf3904 ]
    +
         Ensure that `i2c_lock' is held when setting interrupt latch and mask in
         pca953x_irq_bus_sync_unlock() in order to avoid races.
     
    @@ Commit message
         Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
         Link: https://lore.kernel.org/r/20240620042915.2173-1-ian.ray@gehealthcare.com
         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    +    Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
     
      ## drivers/gpio/gpio-pca953x.c ##
     @@ drivers/gpio/gpio-pca953x.c: static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    drivers/gpio/gpio-pca953x.c: In function 'pca953x_irq_bus_sync_unlock':
    drivers/gpio/gpio-pca953x.c:675:17: error: implicit declaration of function 'guard' [-Werror=implicit-function-declaration]
      675 |                 guard(mutex)(&chip->i2c_lock);
          |                 ^~~~~
    drivers/gpio/gpio-pca953x.c:675:23: error: 'mutex' undeclared (first use in this function)
      675 |                 guard(mutex)(&chip->i2c_lock);
          |                       ^~~~~
    drivers/gpio/gpio-pca953x.c:675:23: note: each undeclared identifier is reported only once for each function it appears in
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:289: drivers/gpio/gpio-pca953x.o] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: drivers/gpio] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1906: drivers] Error 2
    make: Target '__all' not remade because of errors.


Return-Path: <stable+bounces-135277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB62A98983
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD264436DE
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5981F4167;
	Wed, 23 Apr 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT2ojxcO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3391E86E
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410629; cv=none; b=u0uuy78oK/tEjrnuP9OaUXHl8mmjiir32aAJPYaE9pbpqlMA1nloO/7x9AFhAaCJxxbRbKPfnvEKxTimdnyWE9Mb0Z/m/kwDt5jqUbwmTVC2KMUOMYKsFRORmwOgg1MZcdQTTz7IFllzz/OqF+5RBbXtve0taXiqKMphuDv1Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410629; c=relaxed/simple;
	bh=3YLs/50fJEMHQ8vF8CeQrPbnMcuWOnQB/j5zu2Y5UTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlMkGhD2g0jCu32kqbg/jLop4cOY2cGSCZtbTt3ceq+bqXrvELXT8Pd/rOfHpUQVdpUQhgR+4Pqu/B0OFzk4hy+J4x9B2rjBduYSsYE5WnXk1j8OT3ODU4MCOk0N/0z8wpuadU6lbFuHhDygMNa3xKFTd7zwadvW5NcyloY62P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT2ojxcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E11C4CEEC;
	Wed, 23 Apr 2025 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410629;
	bh=3YLs/50fJEMHQ8vF8CeQrPbnMcuWOnQB/j5zu2Y5UTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT2ojxcOO+SN1HKcxE0CcAGUUieQbggKUxIJQF0U04aCgdVCAdrcX0Ssgo9fTm8rX
	 HfF/y1CpsX8WLrTP64C0hBMDvz9X+IIz7dd3p4I6lDBzAiCbC6895ngIs+/RKRB1ZZ
	 hVsWzN/gVMFVg8y3n0zI4Ds3FD5VfaZZOtHEUYsUGi7YeGIlt6rZshYZA+vlaBj4jn
	 gKuwECfJGCgw6z/QGBakESjIWdJ+HKUlZtAFModaU+d64W0Ot7VJycf7YKhsdiSQZK
	 JUJ+5bvHFZ8yxkCvWvFgBikX8iqh8lOrbtRvePKg1mQIXbECCH5EdZqr8xGckVrkyG
	 7Psaox5VoxGog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y/5.15.y] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Wed, 23 Apr 2025 08:17:07 -0400
Message-Id: <20250423072444-db6b4ce79d040e68@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423010410.2131206-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 5d7f58ee08434a33340f75ac7ac5071eea9673b3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Kunwu Chan<chentao@kylinos.cn>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ce666cecc09c)
6.1.y | Present (different SHA1: bc08f5ab11b1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5d7f58ee08434 ! 1:  cbad465802664 pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
    @@ Metadata
      ## Commit message ##
         pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
     
    +    [ Upstream commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 ]
    +
         devm_kasprintf() returns a pointer to dynamically allocated memory
         which can be NULL upon failure. Ensure the allocation was successful
         by checking the pointer validity.
    @@ Commit message
         Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
         Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
         Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
    - ## drivers/pmdomain/ti/omap_prm.c ##
    -@@ drivers/pmdomain/ti/omap_prm.c: static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
    + ## drivers/soc/ti/omap_prm.c ##
    +@@ drivers/soc/ti/omap_prm.c: static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
      	data = prm->data;
      	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
      			      data->name);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |


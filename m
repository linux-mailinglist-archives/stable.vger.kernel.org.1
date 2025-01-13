Return-Path: <stable+bounces-108546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B09A0C539
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFDD165D3B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCECC1D63D1;
	Mon, 13 Jan 2025 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYRA95/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2261CDFA9
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809757; cv=none; b=VH2EeIuwZbC3C4mK+QCKUQBMLoI99qJgtZeN+Nxmttl/9sAIJiZBrWTl+TmQsKMIfolhldLNt+AIZlFE8DOAxKGbLt7lPehGu9Eqm5MFiLiBbIAV4fxYGhqfyim8yaM5aEcLaLC3D6EXnqyx0CY9PSWb1sB6CK2oiTzJk47Fqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809757; c=relaxed/simple;
	bh=HvwlpckBDiwoHpoH9G48+IhD7UXPG6AWICt1f9pRvgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmS5oXWtRozEwP1tWROT63UWF5anWJUUlxVmwMODZFoYHofTm6Rda7/l6OuFC9LCqWrLAFcxX8QmQa3cYgTfdIwiln7u3nMZIF37agI4MvXbYwYOg8okFy4IY35Ost1zjoMCbJ46kjFMPlyETd59FlunexLCJLChfMjmK6ZG/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYRA95/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D4C4CED6;
	Mon, 13 Jan 2025 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809757;
	bh=HvwlpckBDiwoHpoH9G48+IhD7UXPG6AWICt1f9pRvgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYRA95/XeJuSF1FFCTGP9RnJU+37+jiQWZf94SXyVojL7RHASBRgsQ4+zNKko7AsZ
	 PnXKPCPjCSYns05nIDPwNBT/3DNaCVPqddCzs4u7640B71qkWDySvk1fSl434wtmCv
	 nPcXc1X+8gLA+CZaWtFu7Musr046ksxh13MZe0D6SlrXFQcDYxHJCS2LEDVn0OiFHW
	 iaBaXL1CKQTuAlebCkUK/qIw9VaEK2AkqfdUpG/DvFdb7H2QwfyzwDGGpTWqOXjygL
	 1PDUA8NMEBQmJBu8gJmCl/9pC0VwsDGeI3CynuDUozwfWdhBnQO3O4BhlVg/jXYNs3
	 J4x4MN7u4qVSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:15 -0500
Message-Id: <20250113162203-1249370fd9d67547@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113140325.505120-1-inv.git-commit@tdk.com>
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

Found matching upstream commit: c0f866de4ce447bca3191b9cefac60c4b36a7922

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol<jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c0f866de4ce4 ! 1:  02d3f9beabec iio: imu: inv_icm42600: fix spi burst write not supported
    @@ Commit message
         Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
         Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
     
      ## drivers/iio/imu/inv_icm42600/inv_icm42600.h ##
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600.h: struct inv_icm42600_sensor_state {
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600.h: struct inv_icm42600_sensor_state {
      ## drivers/iio/imu/inv_icm42600/inv_icm42600_core.c ##
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: const struct regmap_config inv_icm42600_regmap_config = {
      };
    - EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, "IIO_ICM42600");
    + EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
      
     +/* define specific regmap for SPI not supporting burst write */
     +const struct regmap_config inv_icm42600_spi_regmap_config = {
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: const struct regmap_config inv
     +	.cache_type = REGCACHE_RBTREE,
     +	.use_single_write = true,
     +};
    -+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
    ++EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
     +
      struct inv_icm42600_hw {
      	uint8_t whoami;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |


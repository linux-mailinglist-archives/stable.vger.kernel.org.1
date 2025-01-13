Return-Path: <stable+bounces-108540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C526BA0C532
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8083A7B12
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAFD1F9F52;
	Mon, 13 Jan 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tymJWQit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F71F9F6E
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809746; cv=none; b=cCF1Bd6VCg803oE6OOGxL58gDp14iy5AJtFRg1lzCpqHcy1wYXEXxCR7x6vi2/NYh9XAWSKU9qPJjmmO/jGlaIMRLdYm4ZdO3pxpKDL7YXWOmZHZI8EtIWICLMMSrkzS2oWrjERml5Jdj+r9PPvpLPtzTe8Cq8UU1ZadH1LmlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809746; c=relaxed/simple;
	bh=CnmaErVt3r4BWFDyKuTnWXAMKxCvyFCdUf8DtBeHBME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoFn3eNbECgFYmP9pKCJKS/7trdVqONcMT1jdyerK8AdqOxuVGOspQfZF7qOmoq1L7fbYFbauVUnx5ozUNE6YooZZdO4Gfu4+pVwsAyeLGHTl1XUfWsLmSplaUzaX+RN3ZxE7E44MRxcE66eWvYuO/Dykgcp/p1S4jFQVwjdhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tymJWQit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F72C4CED6;
	Mon, 13 Jan 2025 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809744;
	bh=CnmaErVt3r4BWFDyKuTnWXAMKxCvyFCdUf8DtBeHBME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tymJWQitAm/Fd80E4hZa50qhJ9FtZdE/MJqHasrRvTf2x11qhCQwLFmFPdg2meWHk
	 bGX96tA8JPgf/qkKgQ7QgEJidHWxu5ZbGfvzTag27OZEtDO3up2F5wcn1X73XvbtXA
	 P/ZXTWVsciFnfbzY5twYAR0SzIZdZoRdJpwWnWMYu7JNlHTY5wD8bvLy7ryrKwVpEz
	 MeLEjab/QDlQTRsn2LdwU1aa7MWC4B4/S5J6DPE5lNDwiFcRMiTL5KW0Xtz+gPWckn
	 l5Fh5Q8Xx0hBcClgJu/qeGyjMeN0dhW/Smrujb7Zh361nCutXyBdlYJ76hva9DrsY4
	 1R/6sPG/OiXKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:03 -0500
Message-Id: <20250113155551-c9f1e346a492da37@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113133316.236077-1-inv.git-commit@tdk.com>
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
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c0f866de4ce4 ! 1:  64636852bc5b iio: imu: inv_icm42600: fix spi burst write not supported
    @@ Commit message
         Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
         Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
     
      ## drivers/iio/imu/inv_icm42600/inv_icm42600.h ##
    -@@ drivers/iio/imu/inv_icm42600/inv_icm42600.h: struct inv_icm42600_sensor_state {
    +@@ drivers/iio/imu/inv_icm42600/inv_icm42600.h: struct inv_icm42600_state {
      typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
      
      extern const struct regmap_config inv_icm42600_regmap_config;
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600.h: struct inv_icm42600_sensor_state {
      ## drivers/iio/imu/inv_icm42600/inv_icm42600_core.c ##
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: const struct regmap_config inv_icm42600_regmap_config = {
      };
    - EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, "IIO_ICM42600");
    + EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
      
     +/* define specific regmap for SPI not supporting burst write */
     +const struct regmap_config inv_icm42600_spi_regmap_config = {
    -+	.name = "inv_icm42600",
     +	.reg_bits = 8,
     +	.val_bits = 8,
     +	.max_register = 0x4FFF,
     +	.ranges = inv_icm42600_regmap_ranges,
     +	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
    -+	.volatile_table = inv_icm42600_regmap_volatile_accesses,
    -+	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
    -+	.cache_type = REGCACHE_RBTREE,
     +	.use_single_write = true,
     +};
    -+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
    ++EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);
     +
      struct inv_icm42600_hw {
      	uint8_t whoami;
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: const struct regmap_config inv
      ## drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c ##
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c: static int inv_icm42600_probe(struct spi_device *spi)
      		return -EINVAL;
    - 	chip = (uintptr_t)match;
    + 	chip = (enum inv_icm42600_chip)match;
      
     -	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
     +	/* use SPI specific regmap */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


Return-Path: <stable+bounces-108547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F7AA0C53A
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D096165C22
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABA1D63D1;
	Mon, 13 Jan 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnvLmC35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7A1CACF6
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809760; cv=none; b=Wh3DLVERP7CI2gn1EQlY2oSfO0SL5fWrG9RjTFfvHWoYEw1q4ACiXz4p2szzT8lneiADDRcxGBAHGRPmvLJnzvaH9Qgr64JCYXMHO2bT01EHEH7US1HDoDzkWbUGdFxRRmEQU0SS+7mA9w0G7md421FNpYL6eVuxCXHu4Eh/IeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809760; c=relaxed/simple;
	bh=qUYG58vM4ftrO3ZsoT+OS8NFzsdyjgKtgHDtSUAyih8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEstoi8mZtl7Ccpe7HxyFXEgMXvw+2EgwuzBYNA7gskzIeaoNclSPnDdmQdFw14H7R6i530cd6o0xM0eqYEYB5nSkGUjaCwV5sCUjeWJ9iXor37O7CkVPngtMBTAjLK97WZO8aVUH+qt3WSPr4FKukFv/6l4x8c17fwCCnGodVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnvLmC35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C639C4CED6;
	Mon, 13 Jan 2025 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809759;
	bh=qUYG58vM4ftrO3ZsoT+OS8NFzsdyjgKtgHDtSUAyih8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnvLmC350TTwLxPN+vB1iUECDSlE4RVAbqTla6fQ0ASNc7YAn684dhhlW4ZLitHlq
	 51RJUDSS2GUMsDu3ITy4jt+Js5m/3sufYDoOkUrH3iQBWNeeBN+xGxjhCbHkcOhpQd
	 cMSYT4ESGSOv31bOZO/xnVllrE55oPgKHf0Ff+pQp4olrRe6r4geqBn0I7+bI14ZAy
	 3tw1RvM9RW/phlHbBTcrkAUD7ey6y5vwXPOScufKMrdyF02uIsFK54w5MMhAPDI24e
	 B0yNK46ZoCtZ3S4sUuAnqUOCwtdLSz3mZc1LvIEdfCHkxlfmPriMCJ6wObe4D5fxfY
	 xCzrE1HVSlrOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:17 -0500
Message-Id: <20250113163538-a004035c4a8194c3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113131918.128606-1-inv.git-commit@tdk.com>
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

Note: The patch differs from the upstream commit:
---
1:  c0f866de4ce4 ! 1:  5f7ac79ffe7e iio: imu: inv_icm42600: fix spi burst write not supported
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
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: const struct regmap_config inv
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
| stable/linux-5.15.y       |  Success    |  Success   |


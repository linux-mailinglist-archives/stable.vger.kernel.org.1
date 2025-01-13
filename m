Return-Path: <stable+bounces-108544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC6A0C536
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB69F3A7BB0
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E01F9AB9;
	Mon, 13 Jan 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag6rtsPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAE1F9F50
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809753; cv=none; b=PC9k2t4dJ1faKK1XUIdviG/r9Dd6LVuy51G0k1jmOnNefGC3b8FUKhpcF4MtPHwl5CLfxqO4+QkQvXKMbXtJ0jarvYOZGycmPsixMoS7BI4TcfDFhqimhH+npaa2yESR6urRQQ2SfQYNSWpuRJTbicXRYDl0Mw955bMx1dUNdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809753; c=relaxed/simple;
	bh=8+IP44pm7r1eW31ak5Tmz96NqQnjFisFRlz2HpYVi/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUBs39Tcq1sKUqvdVSvkHuuZWC4rEQ5+tOU2x49iQVu/jF1YkT8y97NVvCafv5AePbpRD1fYmIh1amlTy1qkDW5rgG/zOzou0XBa0su8gGCyNMWrPWbuPyL+MXRWuMHaqoDXbhYi53iuXAxUsmRsJZRo6x5IBv8tVBwFZq7utCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag6rtsPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D80C4CED6;
	Mon, 13 Jan 2025 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809753;
	bh=8+IP44pm7r1eW31ak5Tmz96NqQnjFisFRlz2HpYVi/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ag6rtsPESCfCsF7mMWG3PFzSYH6uAbJFjoadDrV2V01XESCn6VfKbHZsyxVjiqBiH
	 aG6+hMR5HMckTUl+ZarjZ9tdRnrZPEn7c+cy6ZA+/9CavZWlcB2YVWROJV6zfdTXXK
	 dZkm/SRvL+Xkd93BV7XHOPBqCzrYuBTCoDb2ZOsI6BCBzigETmY44riaPD3KuOPxrr
	 wlH6oQMg6hgTnlbKAfOm8+pKGO5CN40NgipS8gcog0EZ9f4A9LNkFGfbceIBKbFUVQ
	 A3SLd0zQobl/mKZ54OcP8RT7xbbV7WiYn3UgWTQnBOicQFYoVQHnIyiFR+A36i0DaJ
	 9lB63W29MMtEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:11 -0500
Message-Id: <20250113161954-e5776fa8c7e72b5d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113135307.442870-1-inv.git-commit@tdk.com>
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

Note: The patch differs from the upstream commit:
---
1:  c0f866de4ce4 ! 1:  c7c357270b7a iio: imu: inv_icm42600: fix spi burst write not supported
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
    + EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
      
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
    ++EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
     +
      struct inv_icm42600_hw {
      	uint8_t whoami;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


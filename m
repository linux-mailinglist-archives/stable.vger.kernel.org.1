Return-Path: <stable+bounces-108538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F1A0C535
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91861886148
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602A1FA15D;
	Mon, 13 Jan 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH9NIKrh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF11F9F50
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809741; cv=none; b=Iy1ZeOcj84HXAUdVvfl7QC72moS4BoT+Iosme1/I71YAU3yn9AnrIHZ8X6/HN8UP1i9YLCq9d+xJPpUDqiUQSxqA3B67rCnqFJd1RGT0Yh1DzOZ5QNRNpjxDOQ1pks+43IstbwS0ENpBseaQaZn+AN49mcPRW/IzK2gUB0MG1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809741; c=relaxed/simple;
	bh=5NsW0Qze5uL8M04ft4IwPBHk19aZ0ctccCl4uGlKdzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3kQFU+lPhLgGawvUfJ5KDdXzeA77JIP7t58JXzd8P3KuOna7daZb9ec4ztK9WPA0RscNObI9UwPOd4cURGZcWtklQaJJEWN7nOKNSD5BI8+6R6IMJKEg0GD/H4A5et2j12KSKOlenAesK7Q4KZ6WbcuM/IodBqfhdlGaqJmIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH9NIKrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBCC4CED6;
	Mon, 13 Jan 2025 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809740;
	bh=5NsW0Qze5uL8M04ft4IwPBHk19aZ0ctccCl4uGlKdzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jH9NIKrhHpaM2heM+CnmEc3ZdiWgR5aFYqEVq0uSjY2Q0pt83YDlOLgmakwy+IRf9
	 ha68YT02onzaq2fdDDiY9xDl1mqZw32Ic1roqVPA0kWiyNpMzGmPLkmRnuIKUj+iXE
	 d6zlPleHNJ4oysy4uk3Tqo1b7pPjzJEQ7WfWWCoNAVAHY+007OfuUxG+ncikEGywKi
	 V/1hQHAmgVL732NC3sm36SpglkuVKU+tcnxd6dagfGhYwAHoaQch4TPCmi55bGGhLf
	 XAvMnv4IKu7ye06g8zwlRXqJSnztJLayU+qv5ZFGmkd1o/t+G5UUv3UOpEC9K0vSMU
	 C36H07pvUR0Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:08:58 -0500
Message-Id: <20250113160218-5fada1e1b69a8ede@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113134351.378484-1-inv.git-commit@tdk.com>
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

Note: The patch differs from the upstream commit:
---
1:  c0f866de4ce4 ! 1:  a497cfdda85c iio: imu: inv_icm42600: fix spi burst write not supported
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


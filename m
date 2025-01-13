Return-Path: <stable+bounces-108541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18546A0C533
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327F8165C8C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5771F9F6E;
	Mon, 13 Jan 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp6p1E9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565671F9AB9
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809748; cv=none; b=QiXjLfEWWG4iWfIukLGQgZ0zB6rnRYJDMbBcSGtADwD/fD7SwkmhtkuRsXJpw4CosVvozbUrfJFJeDmyp8/1MbFzjBs8urMa1l0FUSpwlpD4d9KhnxuqLS0Fl6clBqpkP+XAPwY7FjA5vHjW9n4rUsVoQ/e03zDx6azXifpwJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809748; c=relaxed/simple;
	bh=QLzOnAjUmYyhz5Bbtcmz4gLNC/S+ldcXhDqqOXCTB5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMk5omkXSClSUOPo9d8wYa0kwDgtGZzDfKWqiqvRvUVYjqwgb0EDt6FCi5DBvssmkTMQ9caP+V8FBjr9meZQ4E/onsDMqkQ/Y0I/XZmr5KmU2I8We3OOyVSLMrT6XyTzgNcrSZsK8jaIH6hrHebJtuh/efo3FL7QloA1PtjdklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp6p1E9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5104CC4CEE2;
	Mon, 13 Jan 2025 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809746;
	bh=QLzOnAjUmYyhz5Bbtcmz4gLNC/S+ldcXhDqqOXCTB5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp6p1E9hCy1IYHeqlmEbT0uOAWKDamkb5caNiNFgHU9sXOYQ0rBg9sR7wxJ8kU+dh
	 ZPFokuXS4MJ+u6mCqIUAFG37DNjpE/nZWuFW/gbBkQGj4ZE0k2xy/YWSFT9nLej56D
	 K8LWLmxAaGVhShSJ0XhcFnYDraiHye62aWy9y8OxCz9PwhUrrjAgxpzdt5JaFdXYCe
	 l3gDcO5KjCJKDMrDetJUU0wM00vOe/tllmM9fx9wfWnfwa3u7gJSVwHhFvsIQpTlvc
	 SabF7KGjqPMt/Pz/300uoErIqLXJmEWV0vzJ8gOY8S//+I4snWhify39VqgcpCNHmh
	 PVwCXeJuNo7cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:05 -0500
Message-Id: <20250113155106-6c39bed60813cfbf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113130609.1797-1-inv.git-commit@tdk.com>
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
1:  c0f866de4ce4 ! 1:  c63aa97f9604 iio: imu: inv_icm42600: fix spi burst write not supported
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:54:27: error: 'inv_icm42600_regmap_volatile_accesses' undeclared here (not in a function)
       54 |         .volatile_table = inv_icm42600_regmap_volatile_accesses,
          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:55:27: error: 'inv_icm42600_regmap_rd_noinc_accesses' undeclared here (not in a function); did you mean 'inv_icm42600_regmap_ranges'?
       55 |         .rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                           inv_icm42600_regmap_ranges
    make[5]: *** [scripts/Makefile.build:250: drivers/iio/imu/inv_icm42600/inv_icm42600_core.o] Error 1
    make[5]: Target 'drivers/iio/imu/inv_icm42600/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:503: drivers/iio/imu/inv_icm42600] Error 2
    make[4]: Target 'drivers/iio/imu/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/iio/imu] Error 2
    make[3]: Target 'drivers/iio/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/iio] Error 2
    make[2]: Target 'drivers/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.


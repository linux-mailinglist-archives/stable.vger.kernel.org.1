Return-Path: <stable+bounces-108548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F081A0C53C
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6881B3A79C6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A761F942D;
	Mon, 13 Jan 2025 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1tG+t0h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC821CACF6
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809761; cv=none; b=enfUj1bkEVDcQdqb9ieHAs+Z3V6qEcZhNBwk0sp79eDQK4BVU+AcrOKUFq6rATdflkZEU26DnoL3DxSgyrrLrnwXT5kqppwGxKUyblR4QPY1u4BZR17ztSpg0d8QLICtlD3olRGh/QR5oygcCAG58yWo6SqpJq0I3hqmDYEgWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809761; c=relaxed/simple;
	bh=RDrUI8In14nePRVEilwE1jU9cyjYyGr3ZPcEkFx9xzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lM6JQVxWUtp1MrKFIuBYmH6mYd+Kwk38FKNw8hzmnFxaVBJWXWmdcUwPXWjBwZhHfomSrFEqVTQgLp3yDL409Q2F8nx38ILG1DWdeaeJKSx7ZeYldHLF9hJttAA0+7HHUAHDTpAmp3+fqXN6qkUZamv5kmKHuSeoc4/LOgXrezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1tG+t0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D4C4CED6;
	Mon, 13 Jan 2025 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809761;
	bh=RDrUI8In14nePRVEilwE1jU9cyjYyGr3ZPcEkFx9xzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1tG+t0hfwW23PDYNdn/7/bG8PqGrb0F2aqOGNqAvdqBdUS7e9nEEAjAv3x4RUGny
	 t5wP+zIbfY8SAHb/YAFjXEin+EXVSX5iJeZzbm+ALKYLE7iOS2hn72h+FFq2AVuWek
	 PMSARwWTV5mQshG+mGeMcj7ZIuUA4rPxnBBayCqm8UvBpO7tacoh+tGBrvmapxB69n
	 8cT0DH8evk20z6OV+ht6Oho4nW8rOmGkjH8WvyriiaMY5AOlAzlnFKFlIhTyWz8Frw
	 Riys+4yDikP6xm0GJmpHFMvk5MXkNmRruUykuou9kJKt6mb5V25/qPI5FZ4hcs/ASQ
	 QnxoGxLBkuBkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:19 -0500
Message-Id: <20250113155232-abf8b1ad2f025d24@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113130802.1930-1-inv.git-commit@tdk.com>
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
1:  c0f866de4ce4 ! 1:  d020d9ff9b6c iio: imu: inv_icm42600: fix spi burst write not supported
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.12.y:
    WARNING: modpost: module inv-icm42600-spi uses symbol inv_icm42600_spi_regmap_config from namespace "IIO_ICM42600", but does not import it.
    In file included from drivers/iio/imu/inv_icm42600/inv-icm42600.mod.c:2:
    drivers/iio/imu/inv_icm42600/inv-icm42600.mod.c:16:56: error: expected ')' before 'IIO_ICM42600'
       16 | KSYMTAB_DATA(inv_icm42600_spi_regmap_config, "_gpl", ""IIO_ICM42600"");
          |                                                        ^~~~~~~~~~~~
    ./include/linux/export-internal.h:45:28: note: in definition of macro '__KSYMTAB'
       45 |             "   .asciz \"" ns "\""                                      "\n"    \
          |                            ^~
    drivers/iio/imu/inv_icm42600/inv-icm42600.mod.c:16:1: note: in expansion of macro 'KSYMTAB_DATA'
       16 | KSYMTAB_DATA(inv_icm42600_spi_regmap_config, "_gpl", ""IIO_ICM42600"");
          | ^~~~~~~~~~~~
    ./include/linux/export-internal.h:41:12: note: to match this '('
       41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
          |            ^
    ./include/linux/export-internal.h:63:41: note: in expansion of macro '__KSYMTAB'
       63 | #define KSYMTAB_DATA(name, sec, ns)     __KSYMTAB(name, name, sec, ns)
          |                                         ^~~~~~~~~
    drivers/iio/imu/inv_icm42600/inv-icm42600.mod.c:16:1: note: in expansion of macro 'KSYMTAB_DATA'
       16 | KSYMTAB_DATA(inv_icm42600_spi_regmap_config, "_gpl", ""IIO_ICM42600"");
          | ^~~~~~~~~~~~
    make[2]: *** [scripts/Makefile.modfinal:31: drivers/iio/imu/inv_icm42600/inv-icm42600.mod.o] Error 1
    make[2]: Target '__modfinal' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1870: modules] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:224: __sub-make] Error 2
    make: Target '__all' not remade because of errors.


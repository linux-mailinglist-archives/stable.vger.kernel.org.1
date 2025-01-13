Return-Path: <stable+bounces-108539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E30A0C537
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F0D188247D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AC1FA171;
	Mon, 13 Jan 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFQjnA9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD91F9EDA
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809743; cv=none; b=EH0iwReZD2NzPNackXeK5rzSyjmndMMMsWKqTXqJE5ib9+nLTbrLdoHX8exmkdS1fnnntxRBdVYVbUHf+pJ9jHRqGfdopB3W8v8MEysYp8Jb6l9w6QKHFfMYpsRT5iCruVpZcyQR3QFAi3+W+uMO071wl8OTLy9kRMUAIyRIe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809743; c=relaxed/simple;
	bh=ux+1yumZdakKoGRxTYbhrJT229r9+qIqsHfoI4k5RwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vp7A76ksPGnDUE9eG1Fh/ttR26h66Br4AfjFXZFKcvt9MFcNX3HpnY73nNmqUjnRWA2xta/2s7goH0FzkkcGiuCwGU+KEfpGf2r4A428cktzC7BCPbjN9ryS1+o/9fWFp4YwL1+PrRGOBHWNfR4wKxEDluvm1yS7UQx9QgJpT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFQjnA9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF7AC4CED6;
	Mon, 13 Jan 2025 23:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809742;
	bh=ux+1yumZdakKoGRxTYbhrJT229r9+qIqsHfoI4k5RwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFQjnA9ZDFE7fgFjEmwbUDT8Q9kSEbUnZbJJkC37XunsoW6FJvmUZcCPGW2GGq93/
	 5sA+DgUtbSSMGBeyCUe+cUXequ0aAAhDsEx6o71D3c9cCZxppGAy/gyvg2F43//Dz4
	 gQioMz6DMG4JLCTZdEQLHcabfnB71IvfZBN55/KGKJQ7t30YT0UL5fusUsDxeRE465
	 /MZEw2CcpBzPINzbeM4+pwa9w3oXgavhhQR9O9sCd8fMIltipDZap40D5k2IA/d26n
	 tRDGLDnWJTfOLwUJF7Msa30wyU+IVFPR5C/TOl26g3ZJmhhtoLoZtozNKUKU8MqmYF
	 mvuiZneo6mJpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 18:09:01 -0500
Message-Id: <20250113161511-1c617734b337df70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113124638.252974-1-inv.git-commit@tdk.com>
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
1:  c0f866de4ce4 ! 1:  ab66552ae37a iio: imu: inv_icm42600: fix spi burst write not supported
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    lib/test_dhry.o: warning: objtool: dhry() falls through to next function dhry_run_set.cold()
    drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:54:27: error: 'inv_icm42600_regmap_volatile_accesses' undeclared here (not in a function)
       54 |         .volatile_table = inv_icm42600_regmap_volatile_accesses,
          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:55:27: error: 'inv_icm42600_regmap_rd_noinc_accesses' undeclared here (not in a function); did you mean 'inv_icm42600_regmap_ranges'?
       55 |         .rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                           inv_icm42600_regmap_ranges
    make[6]: *** [scripts/Makefile.build:243: drivers/iio/imu/inv_icm42600/inv_icm42600_core.o] Error 1
    make[6]: Target 'drivers/iio/imu/inv_icm42600/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:480: drivers/iio/imu/inv_icm42600] Error 2
    make[5]: Target 'drivers/iio/imu/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:480: drivers/iio/imu] Error 2
    make[4]: Target 'drivers/iio/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:480: drivers/iio] Error 2
    make[3]: Target 'drivers/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1921: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.


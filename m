Return-Path: <stable+bounces-110762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9DA1CC2E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF351880980
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489F235BF0;
	Sun, 26 Jan 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcb33tnT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1118BC2F;
	Sun, 26 Jan 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904113; cv=none; b=o9d+ZeXYS0tEZtRmbwCop4fzua559Xim8uZs0HHbhGDfbwQBdSGgRsj6lLGzb0/y4eOwxIuGjFZgDmwsXb34kx2ZDB5ZPpzX7RBzcqdipgksU6A2o2pksW80wLrD4G3Ld6/GkgBxANNgxFK8Comb7sYi5st90NBJ+yqf4Xsaza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904113; c=relaxed/simple;
	bh=Zb845kRKbXoO7eghh28NgtlnjkEgrqKhhNPTPtzq2kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq57S6h8MDB65IAzEYitI6a8Go0pAavRNal5uVHGzq3dvjsU/NwSuBhz/9zoDBFHqwDoFULSOI7ajz1m7siIDGqZw3vuYVuoVN6m5YsuWy4KIF1vgoBFo4BkUH6EpXh9c/jiifx4IRIP58O/nURiar9+UK/iPYMCBZevtiE03yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcb33tnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD08C4CED3;
	Sun, 26 Jan 2025 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904112;
	bh=Zb845kRKbXoO7eghh28NgtlnjkEgrqKhhNPTPtzq2kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcb33tnTEImy39PGHUWpw2ZESkmSQshogEpM6z7QQejp0NrSBLuYwHT8VyRMRwM+4
	 Lq32BnbB9jprCVckOijG3zw+UnvJUmat4hvrAYPan92yivNRmvuFBC8JZcr/9yG6Bh
	 cQqzB67iiJChAWKc0X1VzK9Bx8Aey9FAoV6A6ZwXEwnDHoRFH68ZSjBc0j1acgsD+L
	 3QThZV1PcwG2ooqmb2HA7cCkakVKHkt7pgGHON+R/CjZrRxlue1kUOEftAvgk61Aby
	 xLNmM7i9Xhx5JhAaU806BHn8MLLjEnWkj28qiAnXMf4q10hbsWSpzFzG15NOqNU1sX
	 mM/xIHbeZeQVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vijendar.Mukunda@amd.com,
	mario.limonciello@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/14] ASoC: amd: Add ACPI dependency to fix build error
Date: Sun, 26 Jan 2025 10:07:58 -0500
Message-Id: <20250126150803.962459-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Yu-Chun Lin <eleanor15x@gmail.com>

[ Upstream commit 7e24ec93aecd12e33d31e38e5af4625553bbc727 ]

As reported by the kernel test robot, the following error occurs:

   sound/soc/amd/yc/acp6x-mach.c: In function 'acp6x_probe':
>> sound/soc/amd/yc/acp6x-mach.c:573:15: error: implicit declaration of function 'acpi_evaluate_integer'; did you mean 'acpi_evaluate_object'? [-Werror=implicit-function-declaration]
     573 |         ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               acpi_evaluate_object
   cc1: some warnings being treated as errors

The function 'acpi_evaluate_integer' and its prototype in 'acpi_bus.h'
are only available when 'CONFIG_ACPI' is enabled. Add a 'depends on ACPI'
directive in Kconfig to ensure proper compilation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501090345.pBIDRTym-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Link: https://patch.msgid.link/20250109171547.362412-1-eleanor15x@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6dec44f516c13..c2a5671ba96b0 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -105,7 +105,7 @@ config SND_SOC_AMD_ACP6x
 config SND_SOC_AMD_YC_MACH
 	tristate "AMD YC support for DMIC"
 	select SND_SOC_DMIC
-	depends on SND_SOC_AMD_ACP6x
+	depends on SND_SOC_AMD_ACP6x && ACPI
 	help
 	  This option enables machine driver for Yellow Carp platform
 	  using dmic. ACP IP has PDM Decoder block with DMA controller.
-- 
2.39.5



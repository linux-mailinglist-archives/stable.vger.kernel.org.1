Return-Path: <stable+bounces-110748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0869EA1CC47
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4F3AFDE8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F80230D09;
	Sun, 26 Jan 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRCENFgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3192309BE;
	Sun, 26 Jan 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904077; cv=none; b=DYk8WDlmgG7c5isKKRL8ZIXtDl4fPqxPPYrHISNg6Wi27pFXbr8N1G0gQoQiBP3XqHEsDvaQaMX1AiXW8nwjgeak3l8eqi9+W8CESCP87xTu6oM3R6Keibm8epoR6a0twtzstAdBVNX1/72HdjeGMHGBS4coutGMkK6cohrGxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904077; c=relaxed/simple;
	bh=pN2iyG/2GmLvrGkkKnRyGODW++r0bTYI+cOvghZDqok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfYAtdDkyxOF2CegMALe7pn3XXbyoilM4wVxLpvuNm3ZorICFbyIai+SmGL7ztL6ZwKFYiMoseAyhSgLU1nSk4nQAA0PGAoNDHMliWxjoW5ywhek/5oplL4/wyVLVkqgCDv2MyNKgG6dNTrLUgh8zMO9HGq56H/ew27t3UpaqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRCENFgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12B7C4CED3;
	Sun, 26 Jan 2025 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904076;
	bh=pN2iyG/2GmLvrGkkKnRyGODW++r0bTYI+cOvghZDqok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRCENFgWTZB3KzpZDiiNWlQDDnKRYJwVhMpI6w+0dhqkPYdJiK0DEo3KqpV03xYzJ
	 m6cfJ+IQ9duqeHQeSO7UvIqg5B8kKe5TWwsTpyE/Ju8vRTOzw54uws8u2Al577iC4J
	 oR1RQtcWv/q246bFtoP+LgUR+dHazOeRYywDzh6vw3wuK9MhnfnQYIf1fNsirYqnAF
	 udgfewpGy4RO73SqK8jzhchiz4fEGyNxmLfG+UQurUhawy0qgvllst0kXK5Ho7Gs/c
	 5Cw28WCvcGhW3ZRw5hwgs748IHDGDwhpe6rzwb7sZgXTjiSKRg33SKQb/WMcTCAYTV
	 gAEqLq7tAmUug==
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
Subject: [PATCH AUTOSEL 6.13 13/16] ASoC: amd: Add ACPI dependency to fix build error
Date: Sun, 26 Jan 2025 10:07:15 -0500
Message-Id: <20250126150720.961959-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index c7590d4989bba..8035211782791 100644
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



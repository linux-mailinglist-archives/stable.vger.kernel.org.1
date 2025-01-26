Return-Path: <stable+bounces-110772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CCA1CC8A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E843A9D96
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82823ED52;
	Sun, 26 Jan 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmho/G78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7C23A59C;
	Sun, 26 Jan 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904137; cv=none; b=DhxeXrDzgx6r4HbURL6OZf6xoGm4BFNZSNuzQ5lLE5vaK0Ybp8cwZmFXrsv7TE4oRF+WBZaP21xo8HvFgMHAn2KoRrlS1PPbXAPnfXhYRP2LJe9YQfXs19B9mDmI8MOnjvFTDeVp7/5fVh0lUehRS/kiA6cFYMrStYobghM8dWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904137; c=relaxed/simple;
	bh=I+zlLs+oP8McyI0D9rdLCj5WIug2bCsI2Wop9WzSO10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8vmI47ksGKhQbNU/VEIaSKPrmvJH/1Kl49nmXQcMNeCJ9JDuZXoECdGHZOBug8ZQ9s4jeDhOLuV2nTc2Vmz95oTmL+TBw4cPVOIV/VMzqDaf/qnQwHAYXRelh1DSbX0oR6hWR9gfxUngrMhOdDV2s5JAfbGmp9tz1/JaipBoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmho/G78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B562C4CED3;
	Sun, 26 Jan 2025 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904137;
	bh=I+zlLs+oP8McyI0D9rdLCj5WIug2bCsI2Wop9WzSO10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmho/G7895hjAng8KAL3siNdPVREJXb9r8YF2CeLBsbPgCe4DwnRM4JIT+dQk1/IM
	 k6yVgzIwSKEOnu7RFOxRgdmy+2av0qEEsmvqGm37C2mbrbjjBx5olqTynxzIMMmYMa
	 kmYxOa6tpkbXBnSiMFRHDJS08TWkc7u/eCtTIqBtFDmjUHEx17xuKRAmOo/ia24uR4
	 QPyGvQi2VDegF3v1t6zwQDW2BtYhJb5Da8W9chTw+YLxfT7sH8hdSBzEToCo/Bx+L+
	 yA5aNhlEdpo80xsCS0kSe58lW2SRMkvLH/K8sgTkC13MVdeaJXbCqOSTXj0jTWRtA3
	 lBFGI95MxQb4g==
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
Subject: [PATCH AUTOSEL 6.6 7/9] ASoC: amd: Add ACPI dependency to fix build error
Date: Sun, 26 Jan 2025 10:08:35 -0500
Message-Id: <20250126150839.962669-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150839.962669-1-sashal@kernel.org>
References: <20250126150839.962669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 273688c053172..0b6a01c6bbb1b 100644
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



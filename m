Return-Path: <stable+bounces-110780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A1A1CC95
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1003A924E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37BA246341;
	Sun, 26 Jan 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/TVEy5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B3246339;
	Sun, 26 Jan 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904159; cv=none; b=cwbqKMwsplPx9wZ4JHtj/Xz9I4ANaf+l40qIheXSWAVvYTtDJmYfVhTEQ3iK+ut5QLPl1W+VC9JlXQAvdxCIZEpXTN+rblhVJEIQfSdKemomG6H1+EqZ17nxGVvVSngVYjvQNbb2afqoqIxqAx6K388HW1i5Tsy9n7ZMwH7d2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904159; c=relaxed/simple;
	bh=AQfu0qWpc3NLfGzRRW2+nrxqhUYx32R6CWe09wKCLA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0wPLqknVIFucTeLupRkkbmAusqo9UuQ3JuxeTzp8SDjcuc536DRSm3WKHDwSpweaGuYMhERuGFw0VJaQ51OWQhRbd0QBwP7j1fcq1buPQpcKwBDx2eVxVFvhhGfBTEohWD22u6u2Argr+S/nwzHJMYaJGDkY40M66WApPwlDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/TVEy5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBA9C4CED3;
	Sun, 26 Jan 2025 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904159;
	bh=AQfu0qWpc3NLfGzRRW2+nrxqhUYx32R6CWe09wKCLA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/TVEy5o68S0KVrB58ptk49JgsyHjwzO8ClkuDCOsKc5T+5Ho26hOodGreYlZm6S8
	 O8C3Ab8hstmIyHWKoAgZE5ZHjS/4M92ajpQKOitzNjiY9LjJUOantM8Nq9eIBlY8sb
	 htvAJCAwa9OctnUCq1mKSt0f92kROpciaDHI8KxLgOcoxy/XumRns/3Fo/UMylPgDl
	 9sqh9LRdbWyTFLd5twXULoYgvCDV6EZDowOAeksQpKVZCXnA0Nkp0wt/f0deRV23kD
	 MmL+QEPmWjHqnghNo+sT4RpL9wv4m6MIbTmBhl1uy481bGBnBdj0Sbw/Css6jyQATI
	 XxWT3YmtJn38g==
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
Subject: [PATCH AUTOSEL 6.1 6/8] ASoC: amd: Add ACPI dependency to fix build error
Date: Sun, 26 Jan 2025 10:08:58 -0500
Message-Id: <20250126150902.962837-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150902.962837-1-sashal@kernel.org>
References: <20250126150902.962837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 44d4e6e51a358..6e358909bc5e3 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -103,7 +103,7 @@ config SND_SOC_AMD_ACP6x
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



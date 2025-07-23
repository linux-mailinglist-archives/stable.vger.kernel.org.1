Return-Path: <stable+bounces-164335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B145B0E7C4
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235461C86833
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A213C816;
	Wed, 23 Jul 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgixXZNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD615B0EF;
	Wed, 23 Jul 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232277; cv=none; b=qBnJyoWsGEM8xE+1krGerE7e6y/wy2xGAa9bh5Yxl9qPX5Xo1YDWakU+20OmhhRtyNl1i4U1CstSCb3xJq1zFuOPv4L6RgUrN5s2+5FcUlp23GQJ1D6UeeTiGucpnV9ZzyJv+UCjRInykQ8zsQMQhIZqA4bhSn5tkROBGRdsb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232277; c=relaxed/simple;
	bh=l+n1R8HMKYVFbbZ2Cv2bsnSKQw7/cJ5qIg1y4Ef0NnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxFZbHQ6lNg5tei2FrCihC9P5ZxEc+D8u3W1509XcfKVkSGFxC/NRMDhMXd+a2uzzMlm4pRFTY0oCQlSJ4IEDXFWS41XxKCgt61oJwVV7Ut4AO8aKY4Cw6tIojTzO+Z/hbVldtHBt3wkHvBXFau+QHdk2KcPFAGP4Z9PGt6BRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgixXZNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CFC4CEF1;
	Wed, 23 Jul 2025 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232276;
	bh=l+n1R8HMKYVFbbZ2Cv2bsnSKQw7/cJ5qIg1y4Ef0NnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgixXZNMM5MKjOpgjZyblf6qQXRTFvzTvd6abSpTv66rzZj6UWZo/5ZbQSCHz0qvD
	 PKkVphWa+kVdBeAaJKHk7y+HSEuo76o/3lfGNyG5nzYZ2jVztUFYl4m+QzVeEND6zQ
	 +wsPYlZNc3jjpLIsrQlPe0R2gkENwjsGlmdy9kCQM7gGYtF4ZsO3Ixo+rcJjq1ArUL
	 lDgM8UH2Pu2jhXAu6aVgqh/+K/KCtQ2V+mwTrvaJw2yo14w2UP30cxnAN9st0nq5Is
	 xFl6Tu8TPuDVR6JyDlH/ymdq3nxd6dmrNs6bKDI+voAWBOD+lGgl6towgiCPPe9wDx
	 r649oUNaOnZlw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	cezary.rojewski@intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	brent.lu@intel.com,
	jack.yu@realtek.com,
	koike@igalia.com,
	lachlan.hodges@morsemicro.com
Subject: [PATCH AUTOSEL 6.15 7/8] ASoC: Intel: fix SND_SOC_SOF dependencies
Date: Tue, 22 Jul 2025 20:57:20 -0400
Message-Id: <20250723005722.1022962-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723005722.1022962-1-sashal@kernel.org>
References: <20250723005722.1022962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.7
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e837b59f8b411b5baf5e3de7a5aea10b1c545a63 ]

It is currently possible to configure a kernel with all Intel SoC
configs as loadable modules, but the board config as built-in. This
causes a link failure in the reference to the snd_soc_sof.ko module:

x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_hw_params':
sof_rt5682.c:(.text+0x1f9): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sof_rt5682.c:(.text+0x234): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_codec_init':
sof_rt5682.c:(.text+0x3e0): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_cs42l42.o: in function `sof_cs42l42_hw_params':
sof_cs42l42.c:(.text+0x2a): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_nau8825.o: in function `sof_nau8825_hw_params':
sof_nau8825.c:(.text+0x7f): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_da7219.o: in function `da7219_codec_init':
sof_da7219.c:(.text+0xbf): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_maxim_common.o: in function `max_98373_hw_params':
sof_maxim_common.c:(.text+0x6f9): undefined reference to `sof_dai_get_tdm_slots'
x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1015_hw_params':
sof_realtek_common.c:(.text+0x54c): undefined reference to `sof_dai_get_bclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1308_hw_params':
sof_realtek_common.c:(.text+0x702): undefined reference to `sof_dai_get_mclk'
x86_64-linux-ld: sound/soc/intel/boards/sof_cirrus_common.o: in function `cs35l41_hw_params':
sof_cirrus_common.c:(.text+0x2f): undefined reference to `sof_dai_get_bclk'

Add an optional dependency on SND_SOC_SOF_INTEL_COMMON, to ensure that whenever
the SOF support is in a loadable module, none of the board code can be built-in.

This may be be a little heavy-handed, but I also don't see a reason why one would
want the boards to be built-in but not the SoC, so it shouldn't actually cause
any usability problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20250709145626.64125-1-arnd@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and its context, here is my
assessment:

**YES** - This commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **The commit fixes a critical build failure**
The commit addresses link errors that occur when Intel ASoC board
drivers are built-in (=y) while the SOF core module is built as a
loadable module (=m). The error messages show undefined references to
SOF DAI functions:
- `sof_dai_get_mclk`
- `sof_dai_get_bclk`
- `sof_dai_get_tdm_slots`

These functions are exported from the `snd-sof` module (defined in
`sound/soc/sof/sof-audio.c`), but when board drivers are built-in, they
cannot reference symbols from loadable modules.

### 2. **The fix is minimal and contained**
The change is a single-line modification to the Kconfig dependency:
```diff
-if SND_SOC_INTEL_MACH
+if SND_SOC_INTEL_MACH && (SND_SOC_SOF_INTEL_COMMON ||
!SND_SOC_SOF_INTEL_COMMON)
```

This clever dependency ensures that when `SND_SOC_SOF_INTEL_COMMON` is
built as a module (=m), the Intel machine drivers cannot be built-in
(=y). The `|| !SND_SOC_SOF_INTEL_COMMON` part allows the machine drivers
to be enabled when SOF support is completely disabled.

### 3. **Similar to previous backported fixes**
Looking at the historical commits:
- Commit `8d0872f6239f` (Similar Commit #1) fixed a similar link failure
  for `sof-nau8825` and was backported (YES)
- Commit `f4df4e4042b0` (Similar Commit #4) fixed a similar dependency
  issue with SOF IMX and was backported (YES)

Both of these commits addressed build/link failures caused by incorrect
Kconfig dependencies, just like this commit.

### 4. **No risk of regression**
The change only affects build configuration and doesn't modify any
runtime code. It prevents invalid configurations that would fail to
build anyway. As the commit message states: "it shouldn't actually cause
any usability problems" because there's no practical reason to have
board drivers built-in while the SOF core is a module.

### 5. **Meets stable tree criteria**
- Fixes a real bug (build failure)
- Small and contained change
- No new features or architectural changes
- Similar fixes have been backported before
- Low risk of introducing new issues

The commit follows the pattern of other Kconfig dependency fixes in the
Intel ASoC subsystem that have been successfully backported to stable
trees.

 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 4db7931ba561e..4a93242329362 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -11,7 +11,7 @@ menuconfig SND_SOC_INTEL_MACH
 	 kernel: saying N will just cause the configurator to skip all
 	 the questions about Intel ASoC machine drivers.
 
-if SND_SOC_INTEL_MACH
+if SND_SOC_INTEL_MACH && (SND_SOC_SOF_INTEL_COMMON || !SND_SOC_SOF_INTEL_COMMON)
 
 config SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES
 	bool "Use more user friendly long card names"
-- 
2.39.5



Return-Path: <stable+bounces-112089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E152CA26999
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BFD3A528B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63593213E75;
	Tue,  4 Feb 2025 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT7wt/Q8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE2213E6F;
	Tue,  4 Feb 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631872; cv=none; b=W6RkCiV29AjuwUlgv7ge1x7DbHtkbNLOwypJrMz+hDqvc71UtePakWHLjKqbIEVQKlPWo47UUdHbqNO5NAJplzCjdjVV+kizkyzP7mDYCg+JOb6pNrrMXsetKe26Iyjg2/2GiL7DiA3VvLTryeD4JHRjUCXaSPfQsC3wNflHyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631872; c=relaxed/simple;
	bh=ZzyTehzqwTJGj+rCkkPkOkHYdNKzAV+y6E1BnCDUc7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFSM/t6jp7TNhwCTObzYjW8kblP6dUhmcXQ/PUWcAOEA36zj2kou2AjGf/TCaCZROnj6SFtvIKtDph4H15Kp6hKgqry2UlJuNuJqSkrUgZs5Jyar5Y9jLfLqAPMAg9dSRKM5bFNYlbOgkqhlsPNui1S/MJNtPHh+3Qo40au95xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT7wt/Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4A0C4CEE0;
	Tue,  4 Feb 2025 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631871;
	bh=ZzyTehzqwTJGj+rCkkPkOkHYdNKzAV+y6E1BnCDUc7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT7wt/Q8MJ6g3v4AN+FLfq1We3nCfr5WuNPxB5ckBVzmAAOsrYmC89XjMCS1v8zRB
	 TnmKaFtGAPC9aHM2sHfUCJpaZHlTfqohRqAQasyV3yrwN2alX38/oDutVxwljHiY89
	 zynEzwkURLsgK/0E3doNKCWhmXjCpeoFD/2/sifdpvSoZfv3Lm3qw3axCchHm2Wonb
	 xeoTMj73JPkO4GlaMC7MptJ7Ritau92/jiZ40ly2pI0cbRN/C7eUFRhDJBUc7/sQAC
	 br0VnB7sanAINtT/ZHH+pGbE1BzLSOTOV593e2uiznYpwxG+r89cpMEIf2DHAZP+2N
	 BWc7SR2CHOvjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 5/6] ASoC: renesas: SND_SIU_MIGOR should depend on DMADEVICES
Date: Mon,  3 Feb 2025 20:17:32 -0500
Message-Id: <20250204011736.2206691-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011736.2206691-1-sashal@kernel.org>
References: <20250204011736.2206691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.1
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2e3c688ddaf2bb8e3696a773b5278711a90ea080 ]

If CONFIG_DMADEVICES=n:

    WARNING: unmet direct dependencies detected for SND_SOC_SH4_SIU
      Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && ARCH_SHMOBILE [=y] && HAVE_CLK [=y] && DMADEVICES [=n]
      Selected by [y]:
      - SND_SIU_MIGOR [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && SH_MIGOR [=y] && I2C [=y]

SND_SIU_MIGOR selects SND_SOC_SH4_SIU.  As the latter depends on
DMADEVICES, the former should depend on DMADEVICES, too.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501241032.oOmsmzvk-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/8c17ff52584ce824b8b42d08ea1b942ebeb7f4d9.1737708688.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/renesas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index 426632996a0a3..cb01fb36355f0 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -67,7 +67,7 @@ config SND_SH7760_AC97
 
 config SND_SIU_MIGOR
 	tristate "SIU sound support on Migo-R"
-	depends on SH_MIGOR && I2C
+	depends on SH_MIGOR && I2C && DMADEVICES
 	select SND_SOC_SH4_SIU
 	select SND_SOC_WM8978
 	help
-- 
2.39.5



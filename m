Return-Path: <stable+bounces-12199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB72831DFD
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2272C28172F
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC272CCB2;
	Thu, 18 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwI2G4Ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15712C6AB;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597106; cv=none; b=sN5KMbQ7AuKgzEUpQubfKWCmUiHhaObDVWmj67gOus2TOS6nM/n/JyJSEbDfrUUA5t7VyshvTsWynMaEiAqgiaFcGG4WIVphUyEjvW9l+2X5On+zLtpW65VmydqngtZmAl3ijEbiHuMMX9Ro438IbkkUYn1EtMSzSpQonj+U7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597106; c=relaxed/simple;
	bh=Khc6okNYonivQKkrXDtCP9RflkoszTHGolHQDW410oI=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=uyFmnGHW76LhQ3ZHEGtIjTJhnBtaFUnf7zaK/49U/DTrIUYDY9z6T8XKpGEz3ziOVnWPVfRgGi5boZF2kAejAYz46HHWOm3STGyCzfK6oSKcvOQqT2+/2ULMqT633YeBN4rmxDzirCp5gJT0rx7zLmZqhh0+R6lsF8P8rvr3llo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwI2G4Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1BEC433F1;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597105;
	bh=Khc6okNYonivQKkrXDtCP9RflkoszTHGolHQDW410oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwI2G4Ac0q+adLKeZDRND0ELSZSYkr4695P1BsUaED08JEU/WUFI/hIAv0RlqRE+4
	 RIEV9YWns7dy2v8f2DARuK1sfC/jM7wY/94WdIkuuMp6XWfsBLiewShKii0bc+I2k+
	 fgQ6puoW1ZxdHvK2sRWURd3XCAWE6v7/RnB1Mlop8rVj+704L6NwJiz1tP857vPtgj
	 UgFFNJ34WP4ASZL50RjMY2j8/fbSLG8Om6Z85hfhLvFuSGjiP4UQL2mupu3hAhMzP1
	 LrbsjZ+cbFRW0Acx/xqq+8By/4oO0pidYVS5oR3Hp1Y9VIzU1gzZ5humi8rixjHK5a
	 XhhVmkfYz6/zg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQVir-0003Z0-29;
	Thu, 18 Jan 2024 17:58:33 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Date: Thu, 18 Jan 2024 17:58:08 +0100
Message-ID: <20240118165811.13672-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118165811.13672-1-johan+linaro@kernel.org>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default PA gain is set to a pretty high level of 15 dB. Initialise
the register to the minimum -3 dB level instead.

This is specifically needed to allow machine drivers to use the lowest
level as a volume limit.

Cc: stable@vger.kernel.org      # 6.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 32983ca9afba..8942c88dee09 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] = {
 	{ WSA883X_WAVG_PER_6_7, 0x88 },
 	{ WSA883X_WAVG_STA, 0x00 },
 	{ WSA883X_DRE_CTL_0, 0x70 },
-	{ WSA883X_DRE_CTL_1, 0x08 },
+	{ WSA883X_DRE_CTL_1, 0x1e },
 	{ WSA883X_DRE_IDLE_DET_CTL, 0x1F },
 	{ WSA883X_CLSH_CTL_0, 0x37 },
 	{ WSA883X_CLSH_CTL_1, 0x81 },
-- 
2.41.0



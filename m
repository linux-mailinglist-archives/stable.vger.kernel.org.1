Return-Path: <stable+bounces-181047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD2CB92CE0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A022F1905A8D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F681FDA89;
	Mon, 22 Sep 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D47O8Hh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61117A2EA;
	Mon, 22 Sep 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569556; cv=none; b=e5/yUkTO69GTRV4ONlpS+SXjGFOdhM5sJu1QsVstsHMKaLh1fJG5Gl0e97pLi/7g2kcNwvlxtckeCQjTyyEV7kUwO78Dhwjj7g1sq0+BiwCFp7GfDzn8S161wHrw4wwoVvoZYzF9scy7Sqb7uGbU747B0u9zQ62dgKxQShajPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569556; c=relaxed/simple;
	bh=rlKIa+fJIWQNRVEoJLp+aIwlO9oxH5zeio9SeotJIXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNJDdfOX4MqSSOPSKPd7//hRdEpjpwlZjq6NZn95Q0PuWZwJ1Mba73mzQkjSOeHx67XeRfCdv+b1ysoAGBcW2kJLqSOWo+e0dKQR6zeMAGVV1Nrm50qjt0Z0SYKi/dK6dDOXG/NGayXtaLZkeyTsOo9GT0qnl9lAPinI7JFieVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D47O8Hh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25356C4CEF0;
	Mon, 22 Sep 2025 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569556;
	bh=rlKIa+fJIWQNRVEoJLp+aIwlO9oxH5zeio9SeotJIXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D47O8Hh9OfLgWF3kGMkeApu4/XOEa79Rvi3kRhm6Tvd7VyuESFuk6h8Qsxv5Mqii1
	 hlePb801q3bYvb6RdbNXGYIy6cZ6C2Eo4CnLv4aYDrzn8HYX6+Y45WRbrut+Tcy5Ks
	 1MAHeu9praiGaJ16Uz3juKm3lwqqqT1x/BeZ1pyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 39/61] ASoC: wm8974: Correct PLL rate rounding
Date: Mon, 22 Sep 2025 21:29:32 +0200
Message-ID: <20250922192404.646759674@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
References: <20250922192403.524848428@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 9b17d3724df55ecc2bc67978822585f2b023be48 ]

Using a single value of 22500000 for both 48000Hz and 44100Hz audio
will sometimes result in returning wrong dividers due to rounding.
Update the code to use the actual value for both.

Fixes: 51b2bb3f2568 ("ASoC: wm8974: configure pll and mclk divider automatically")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250821082639.1301453-4-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8974.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 1becbf2c6ffad..587e200913767 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -419,10 +419,14 @@ static int wm8974_update_clocks(struct snd_soc_dai *dai)
 	fs256 = 256 * priv->fs;
 
 	f = wm8974_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
-
 	if (f != priv->mclk) {
 		/* The PLL performs best around 90MHz */
-		fpll = wm8974_get_mclkdiv(22500000, fs256, &mclkdiv);
+		if (fs256 % 8000)
+			f = 22579200;
+		else
+			f = 24576000;
+
+		fpll = wm8974_get_mclkdiv(f, fs256, &mclkdiv);
 	}
 
 	wm8974_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
-- 
2.51.0





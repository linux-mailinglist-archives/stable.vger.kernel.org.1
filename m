Return-Path: <stable+bounces-181131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D185AB92E0F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0498447213
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080472F0C5E;
	Mon, 22 Sep 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwJt+9//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45902F0C45;
	Mon, 22 Sep 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569767; cv=none; b=sH7qycYHvgNSOUuYJ9zrT5cHcGf+lgyKGU8cs99wa6MuG2utWpBiyV0H0cFSDArjLUr9Obc+Q10qp2Z3ASDSkFELQX5BmKeZTBCZlT80SpNIwFPLtd4vf87pXQdwXnNJ14dskWTilmKNpvuQ3dmdAtr/2tCKulZnPp24SzhoOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569767; c=relaxed/simple;
	bh=nJNuJQW34AfxCMw8IU7RuEwZkOxxuuy+owKJ8/KTHqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQUedwu67vGMCHdCcW87wqiR85MaGWc97q6RwYwUlIvMl74dIFtWqCzISP7/DVz2MojwlhRqnX+j5TZO/3NlRvWBRrV3FMhNRmif3zTjZ7BFqrM24YvHyITc4KiDWKBY+4QbPQ9/vPT995ktQRRcKS6pc0s8loH1fzwr+mTwx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwJt+9//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6EFC4CEF0;
	Mon, 22 Sep 2025 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569767;
	bh=nJNuJQW34AfxCMw8IU7RuEwZkOxxuuy+owKJ8/KTHqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwJt+9//670asZFFCP3v2JOpQ5heklrVSij/ZS56wlvlbJzu3H/bH4m7gnYqusIAi
	 4u/hsCynmkv3/6F9wXtmNKzs0A3lZxdSzJHA5IDs+waDVSyMWeeGyJF96Mb2g+4lxH
	 ZgCHQYcwRLM/6G60Swoe/3Qxx8WkmujQgwCfW+qM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ankur Tyagi <ankur.tyagi85@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 49/70] ASoC: wm8940: Correct PLL rate rounding
Date: Mon, 22 Sep 2025 21:29:49 +0200
Message-ID: <20250922192405.925738630@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit d05afb53c683ef7ed1228b593c3360f4d3126c58 ]

Using a single value of 22500000 for both 48000Hz and 44100Hz audio
will sometimes result in returning wrong dividers due to rounding.
Update the code to use the actual value for both.

Fixes: 294833fc9eb4 ("ASoC: wm8940: Rewrite code to set proper clocks")
Reported-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
Link: https://patch.msgid.link/20250821082639.1301453-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8940.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index b9432f8b64e5b..eff7d1369d01a 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -693,7 +693,12 @@ static int wm8940_update_clocks(struct snd_soc_dai *dai)
 	f = wm8940_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
 	if (f != priv->mclk) {
 		/* The PLL performs best around 90MHz */
-		fpll = wm8940_get_mclkdiv(22500000, fs256, &mclkdiv);
+		if (fs256 % 8000)
+			f = 22579200;
+		else
+			f = 24576000;
+
+		fpll = wm8940_get_mclkdiv(f, fs256, &mclkdiv);
 	}
 
 	wm8940_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
-- 
2.51.0





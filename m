Return-Path: <stable+bounces-96448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1E9E2862
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AFB82231
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E041F667E;
	Tue,  3 Dec 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HAve1XmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553871F6664;
	Tue,  3 Dec 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236849; cv=none; b=paYZ6ot7b9cDLH5ZKhx6becnKlrWSBx9HoOqghKoX9YfFHqEv9QWmMN/r9FTNaLbDT91mANpM7W3etdVO7LfspZRZMlYzr3uYPUGc8t9LwuEIL30ziscZc3gO8IFMX6e14y0W0hm5OM9rM6hY44HMcxON7RP1WQgfunCACgOr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236849; c=relaxed/simple;
	bh=T4ogs0pIt26j/fagzUsHEqsoG/coqQYedfl94RGlCeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgtjHVU52RWAtlpoD7FCcxnd722croNa7UfHmqsIo5ib4LnajLoSLvPajk8vuMJ9Z1MLDnk/LV9a9n1XShNRHyP2UB3FeQGO+aiDizf8KLp1YQPT6400FM1YMU3shpp6gY4gWzJ9I7rmLdG+S8jPRNMgNu5sJEkCuWG0YrGlrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HAve1XmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB502C4CED6;
	Tue,  3 Dec 2024 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733236849;
	bh=T4ogs0pIt26j/fagzUsHEqsoG/coqQYedfl94RGlCeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAve1XmVIuBM22pvrCrPhXy66BR4aTCH1BfxSd3NB3IpY22baxpJZ25LytUe4jukh
	 IJwUMSNlf0OHhAZljORYYr45nNiIgLvHjVx+6KNO7s1ZOmPaaHYnB/Ard0CyWGuULB
	 uKDCseuBFfWLCef47X/4NSbpAq2rgK6O1Zo5DBMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 103/138] ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
Date: Tue,  3 Dec 2024 15:32:12 +0100
Message-ID: <20241203141927.504644768@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiu-ji Chen <chenqiuji666@gmail.com>

commit 1157733344651ca505e259d6554591ff156922fa upstream.

An atomicity violation occurs when the validity of the variables
da7219->clk_src and da7219->mclk_rate is being assessed. Since the entire
assessment is not protected by a lock, the da7219 variable might still be
in flux during the assessment, rendering this check invalid.

To fix this issue, we recommend adding a lock before the block
if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) so that
the legitimacy check for da7219->clk_src and da7219->mclk_rate is
protected by the lock, ensuring the validity of the check.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Link: https://patch.msgid.link/20240930101216.23723-1-chenqiuji666@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/da7219.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1164,17 +1164,20 @@ static int da7219_set_dai_sysclk(struct
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
-	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq))
+	mutex_lock(&da7219->pll_lock);
+
+	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) {
+		mutex_unlock(&da7219->pll_lock);
 		return 0;
+	}
 
 	if ((freq < 2000000) || (freq > 54000000)) {
+		mutex_unlock(&da7219->pll_lock);
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
 	}
 
-	mutex_lock(&da7219->pll_lock);
-
 	switch (clk_id) {
 	case DA7219_CLKSRC_MCLK_SQR:
 		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,




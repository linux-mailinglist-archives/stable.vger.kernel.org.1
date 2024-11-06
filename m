Return-Path: <stable+bounces-91609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE989BEEC6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EAFB24298
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293191DF75A;
	Wed,  6 Nov 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwW7JMS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF98646;
	Wed,  6 Nov 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899236; cv=none; b=MFLFmginzuvfWx8I8vl1Nkq0cPqAJiA1rbZ1GMPxebexB+kPQ9gC61Po8mS6IkHgrJOze/fvbIX+v+Trrqhr2+yS9H869mRLXBge4yRH9CEPIMZ+ER/s60IT05LD7Yid+L6LKkZ4JkOoZ5tu9bbm/8oOmSpD2xVtRGNuwPllrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899236; c=relaxed/simple;
	bh=1KqoN8rZ+nLU5sf8j1igiaTmUJpeKA1dfcYdG6HaPmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO2Vpy3pvlthszVDG7Txuv6qmCal/rRq3C+Vy52aSKnEPWsufUADKLQEdYiXThweQXPsaJzKujZuhMId0eb7lppvKz5Gqqfn3iOuEwBt7+G9G98/g2i62eXpKgfOOdFhZZzjNG8kHSL8oL3SPPsbX3ji2RVxXg9/C1Dodd97aaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwW7JMS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AB9C4CECD;
	Wed,  6 Nov 2024 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899236;
	bh=1KqoN8rZ+nLU5sf8j1igiaTmUJpeKA1dfcYdG6HaPmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwW7JMS67Gy5On6EFktcsLCUix8SHmc889j1NnOcdFccm+iAK97ArkcSllDFxS5QR
	 fPalz+PwmPbXGmqmw17QF9sQgB7TyGC17VbMCCnPKqi9J9WcfdAmmNGQFaS3fl4Fze
	 O7yRPRRNxQzU9Pqo/9dXAm0xFqYL4PNR4meU4VnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/73] ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()
Date: Wed,  6 Nov 2024 13:05:21 +0100
Message-ID: <20241106120300.478055882@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d221b844ee79823ffc29b7badc4010bdb0960224 ]

If devm_gpiod_get_optional() fails, we need to disable previously enabled
regulators, as done in the other error handling path of the function.

Also, gpiod_set_value_cansleep(, 1) needs to be called to undo a
potential gpiod_set_value_cansleep(, 0).
If the "reset" gpio is not defined, this additional call is just a no-op.

This behavior is the same as the one already in the .remove() function.

Fixes: 11b9cd748e31 ("ASoC: cs42l51: add reset management")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 4b026e1c3fe3e..09445db29aa1f 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -754,8 +754,10 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l51->reset_gpio))
-		return PTR_ERR(cs42l51->reset_gpio);
+	if (IS_ERR(cs42l51->reset_gpio)) {
+		ret = PTR_ERR(cs42l51->reset_gpio);
+		goto error;
+	}
 
 	if (cs42l51->reset_gpio) {
 		dev_dbg(dev, "Release reset gpio\n");
@@ -787,6 +789,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	return 0;
 
 error:
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 			       cs42l51->supplies);
 	return ret;
-- 
2.43.0





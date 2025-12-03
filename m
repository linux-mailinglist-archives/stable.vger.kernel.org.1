Return-Path: <stable+bounces-198421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82AC9F8F3
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0733D3000792
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01880DDAB;
	Wed,  3 Dec 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jbl9sghh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A230B520;
	Wed,  3 Dec 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776487; cv=none; b=gRGJCeeZ2RqK+BBYOZTm4ytBElJDJA9UW2ecDDJZWjOqgos87WgCVu/SR5zla8c596rD9yVjqpINhBYuVJxjK2JMshi0GTmkzvo1QP5L+ZD7t6VTA369aPrAezBsYi1HMRxmXQselfb5RQzDoXzkDHcJS6/CthRxBfAwRwgBVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776487; c=relaxed/simple;
	bh=YKV1BEDA6nU28eo047jmkSqolqcn9IT9+YcnyvGZyZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkLO93NrN/6JNbbREIGgNFnDwFPy0C68yLo0QIc4cECov1wgiTbzkab9VRhXvr+TWVEdS/g0My6J8JzyZkjmoai6O3jIC7Ofe/qXMO1NkSG5B8gg27EHr34cWjyb2wEwiry3Xxrl9lgiYFe5REhWnmI6Hn1uQ48SGXhbABq/AnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jbl9sghh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886DC4CEF5;
	Wed,  3 Dec 2025 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776487;
	bh=YKV1BEDA6nU28eo047jmkSqolqcn9IT9+YcnyvGZyZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jbl9sghhSXWmKmi4ayP3eYKvSv+au9+ffIj6NCx6mXEb2k/YaWgoX0WncM4c9dU07
	 zZwKpQYugXyQfPSZFdZfKXQE4aqzqBfBBMXBR10ou2XAdmgB9YCitpsjgIBF27OLOQ
	 UuEal2eyCqLAFNgS+sPXW7mBA/AbF6zWNiDEtgUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 197/300] ASoC: cs4271: Fix regulator leak on probe failure
Date: Wed,  3 Dec 2025 16:26:41 +0100
Message-ID: <20251203152407.923649915@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 6b6eddc63ce871897d3a5bc4f8f593e698aef104 ]

The probe function enables regulators at the beginning
but fails to disable them in its error handling path.
If any operation after enabling the regulators fails,
the probe will exit with an error, leaving the regulators
permanently enabled, which could lead to a resource leak.

Add a proper error handling path to call regulator_bulk_disable()
before returning an error.

Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20251105062246.1955-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4271.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index d43762ae8f3da..6d997ea772ec0 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -594,17 +594,17 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulator;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
@@ -614,6 +614,10 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 				   CS4271_MODE2_MUTECAEQUB);
 
 	return 0;
+
+err_disable_regulator:
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	return ret;
 }
 
 static void cs4271_component_remove(struct snd_soc_component *component)
-- 
2.51.0





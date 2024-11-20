Return-Path: <stable+bounces-94396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9A9D3D0F
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A51B266F3
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38631BCA01;
	Wed, 20 Nov 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxmp+UEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E281A4F1B;
	Wed, 20 Nov 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111580; cv=none; b=WMZSQckB2bprDaXH/9Ja0ONOCJggj54tiOLBU1ezL1QJw8fUZtI4xUhT7W28PiiDuTiM+dEFg9+HogUtL5Rb5et+5TNHPMheUhyEPZJRl0r/unj9JqyFF5Fyv7UJ8LumRZKj21abmKzHziFzr7NpRbZhuFX+tWUVHLdHoNWAUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111580; c=relaxed/simple;
	bh=q1jZB0Y3D3QaQ6qJhaPFxFesXLoLz4odukHwSav9Imw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSD4mhBGlNDAsSvN3nEgNh5RfEMna6Aogis0S2QyTSgXu3aZa8dubnlGhD4ZkhnXxk7EKupvYHNErVRuNF6G1Itw1UcbMS4QJMv5PllFqOQ+Ux/w7A1KykgX0Q4Sv5xNbcG4PSwiwDPQGv7X32mvuE8gFU1FZQ9HGMyWih6NJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxmp+UEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98161C4CECD;
	Wed, 20 Nov 2024 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111577;
	bh=q1jZB0Y3D3QaQ6qJhaPFxFesXLoLz4odukHwSav9Imw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nxmp+UEld1aimjR0eSLdpdeincNpWmbmUVwIvI/9I7VboFaHrZdHFoPvIb2Y7TC54
	 8pZtDuVx3nayn5RRfColFBWFXxLT39E0VXySYaJ2ivNmXR0qzjbG4YsdIqtWoH/2/T
	 45p7LLtGifLjav+ycuWYOu0wPXL4aKA3EKqSqkYCn8UL/DMTZk+L1b16ipM4n1cYdd
	 eQ1IspiAE3DHyLpUjRfcTFdPFri+M7SxwBZwlQhhgYIlrzdsdUy/Jp07XvBqXONLuC
	 /OJXbojt8/5/9TM5lFkG3yU+qahOJkgz2BZ3Myn9TnEio2S9KuM9xl30c85YZJG9Hs
	 j1CTH94fVkxDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 05/10] ASoC: max9768: Fix event generation for playback mute
Date: Wed, 20 Nov 2024 09:05:30 -0500
Message-ID: <20241120140556.1768511-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 2ae6da569e34e1d26c5275442d17ffd75fd343b3 ]

The max9768 has a custom control for playback mute which unconditionally
returns 0 from the put() operation, rather than returning 1 on change to
ensure notifications are generated to userspace. Check to see if the value
has changed and return appropriately.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20241112-asoc-max9768-event-v1-1-ba5d50599787@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max9768.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index e4793a5d179ef..8af3c7e5317fb 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -54,10 +54,17 @@ static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
 	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
+	bool val = !ucontrol->value.integer.value[0];
+	int ret;
 
-	gpiod_set_value_cansleep(max9768->mute, !ucontrol->value.integer.value[0]);
+	if (val != gpiod_get_value_cansleep(max9768->mute))
+		ret = 1;
+	else
+		ret = 0;
 
-	return 0;
+	gpiod_set_value_cansleep(max9768->mute, val);
+
+	return ret;
 }
 
 static const DECLARE_TLV_DB_RANGE(volume_tlv,
-- 
2.43.0



Return-Path: <stable+bounces-120116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB7A4C773
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A88A18836E5
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E8219A90;
	Mon,  3 Mar 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBnZRU0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396823C8DE;
	Mon,  3 Mar 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019436; cv=none; b=bWSka9482Li5yEFC2ElbMj15z61Jf89EF9bnUQpoNX3mXQ+YhfZANWXeUfKnCbYnwJo/D2z0w9Xx1tZwjt5jz8NDLeLR4XCh8YtwhLYOxtlPHQSu+vX3/iyZoxfw7dSdoQ1IPWqgViKtsr4Vypuhc/08CQX4pR+Yk6y1pulsLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019436; c=relaxed/simple;
	bh=4M7qw2BCNap/yj1lp7E2M6gYvaxv2EvIQCTCMGBcr1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noNb9qpJ0gx91lqye8ry2PxOAmfQGBgJa4ZEq6MWtw3PPm5l1XMSKfUT7ShX72aNemiPKfMD4pNckPBeQ09zgtRlSLsQMqrWPCTtuKjw5ronV3rddMH1XxJAbioYSkr9VvsMy/NBCVvFf3vd/4XhtaEE5TvHl3Ax53M5CYaMFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBnZRU0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3954AC4CEEF;
	Mon,  3 Mar 2025 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019435;
	bh=4M7qw2BCNap/yj1lp7E2M6gYvaxv2EvIQCTCMGBcr1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBnZRU0relCv6+ExKWA83h6t4qBCnbettrKZCKoETcE1EBNtV5FA7LvhaTHA8PgQi
	 rqN0kWxEDPRYu46RhqfLBUPVq69osNf6SnItBMRNZGiYEVU9HfzTCf8HHkJFO9eOHW
	 +y1VwKtwsSRdCrSPexgEF85z/10xpwZ4X4Q7yQhwSBOifPmcis9QkPwT7XW/vHDMhN
	 OQrFpE3m2GyfyASrNtxryAxAZPjuirpOc1SSXduzpJy7devl2ukvqFN4UaKgUo0hUc
	 3bivlyygXoaKFr1TVS4EYpgJ3yxNsL5Hu2UN7K+zq8C+do18eohyrvm9VyUVppSsLv
	 I1+/5/3dAlr7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/17] ASoC: tas2770: Fix volume scale
Date: Mon,  3 Mar 2025 11:30:14 -0500
Message-Id: <20250303163031.3763651-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 579cd64b9df8a60284ec3422be919c362de40e41 ]

The scale starts at -100dB, not -128dB.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9f93b230652a5..863c3f672ba98 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -506,7 +506,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
-- 
2.39.5



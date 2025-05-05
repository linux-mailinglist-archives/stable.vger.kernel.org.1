Return-Path: <stable+bounces-140163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E236EAAA5C5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B9A188CBDC
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10888316DE8;
	Mon,  5 May 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G21qvV6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC4316DC1;
	Mon,  5 May 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484257; cv=none; b=PG78acNi36aRQQBkasgY5/s4rcTwSIf34Tc5VAL6/uquvM1pSIpCHH3eU7+439GXHEw4X5oMz+25hsJsLsTx1UabSfTxtaCMNvKmKzhCQfC/5l3cyF+HC2DCVpJ4wtIN53c0jroDwrY+1U9/R3A7kFR/tw/DJqU/9X3XhbX2QA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484257; c=relaxed/simple;
	bh=0p6a0dm0WZpDnUSrzP1TWMURgSuCGh+2SAPykeJYoGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE1xr2Q8GjDw8GAxk/ltOmojYeO1g+yCNr6NtHvZi1NrmQDjfzxybP22bbO41axKLJG6Vi4/w9qOSsqcfqh+ydEOhH+xtZP+xqTa0+AWrXdp9oCYfvuQb0Ghr9RgqAroKBX/xYO8LiVT6Wh0ouX/2URlDgiGgbX8srxEcJ4SL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G21qvV6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B9AC4CEE4;
	Mon,  5 May 2025 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484257;
	bh=0p6a0dm0WZpDnUSrzP1TWMURgSuCGh+2SAPykeJYoGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G21qvV6L8xxmKsZJaw0WecHwgnMWe7GpmmiV2now+zZjcVtlFLlk2v9db51r+MIZS
	 rOGP2f7umBBDufcLdO6z2HK0TxHyLMnGVMLq+UIGOH3C4EtGp5HaZiGqndWPf4eWgc
	 ItIDJfe5SEg8MEGLSDoh9HiWiS3vxtqEIRf19UC3zXRFrrcNQSEhZ3Gs26zeEgScD7
	 UEi7RfFS85VAknOXdxWnCWLGo08i5RrW+ZbuI4WZM6HHbFRk2VWL1nAwwHH7DJvEkW
	 oNCEBB4j+zLJC3AGhUBdbOV3yK261QVylr9tzBVLFoEbq7a6zXbLoWjD3npTsTC6UX
	 A8Ee2mV/1pPdg==
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
Subject: [PATCH AUTOSEL 6.14 416/642] ASoC: tas2764: Mark SW_RESET as volatile
Date: Mon,  5 May 2025 18:10:32 -0400
Message-Id: <20250505221419.2672473-416-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f37f1748564ac51d32f7588bd7bfc99913ccab8e ]

Since the bit is self-clearing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-3-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index bc0a73fc7ab41..31f94c8cf2844 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -652,6 +652,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
-- 
2.39.5



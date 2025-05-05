Return-Path: <stable+bounces-139783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE14AA9F90
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD847A81F9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E9283CBD;
	Mon,  5 May 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irTdjp1Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435AE283CB1;
	Mon,  5 May 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483329; cv=none; b=aCXkZqE5hkiJF/awjh1AY66kcUuZuh/mfhRh8nSRlceQD1Dau0DyNHHkR5x49T46o76OTl3w3STjdLLAZCyup5Z6HkUUYhw4MkthIuIW6YrW0k3F0Tgsj5tNEt7yBJNDfkNEgb9fNlIYZ3XEYSA2gGXflmNIu2k9YgPKixchK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483329; c=relaxed/simple;
	bh=hbBPPF/t8qD5NAM+L3aWD5RMjQP1XWlyvcE97YNQk/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKH5h1zPieajkMU3Fk20B22bC4zqHnw0LPpMBq9pzKCOjNSXRvvrdSuBPxt9g8IitHvQo+BpxaoVNI5r1ZAVM+j3ySLHGHkPtsTdZHtnGiNUcUdA2l00NY7UVXUVL5re8P5j8nD/mW4VDMTUK/HTDmn/vgMekNnXKklD23iga/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irTdjp1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741BEC4CEEE;
	Mon,  5 May 2025 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483328;
	bh=hbBPPF/t8qD5NAM+L3aWD5RMjQP1XWlyvcE97YNQk/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irTdjp1QZ31FXsv4nIfswvMPxfpiAVzHcPk7l1R7BGv0+EP56W4k4ZdbXfpPQ8BpP
	 rd2lDiC3SEnagxie4H/wpBq5b60qKx/NnIbDZFj4qp8SYClO3AvUilLsvn6wn+JJmI
	 ecsI/toP/GmWK1Og4Mu6XgX5YqwzXVAXWouoYg+BNVAKGYkiaJHq+qSPJNx6/WMqJi
	 2E4UUJ4Kr1ZfQ0Cw4/aqix4Hd275uxQTISzr9oSxqhAFBdtyHociiNkah1/jfuON1U
	 vnZ+jECxqFRee15OYNH/gh/DXn+0YxzMZFLTfNoymYXSUGlJ+MpxtekdnV7SEktY6f
	 A/fIfVaD/3PwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 036/642] ASoC: codecs: wsa884x: Correct VI sense channel mask
Date: Mon,  5 May 2025 18:04:12 -0400
Message-Id: <20250505221419.2672473-36-sashal@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 060fac202eb8e5c83961f0e0bf6dad8ab6e46643 ]

VI sense port on WSA883x speaker takes only one channel, so use 0x1 as
channel mask.  This fixes garbage being recorded by the speaker when
testing the VI sense feedback path.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250312-asoc-wsa88xx-visense-v1-2-9ca705881122@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa884x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 560a2c04b6955..18b0ee8f15a55 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -891,7 +891,7 @@ static const struct sdw_port_config wsa884x_pconfig[WSA884X_MAX_SWR_PORTS] = {
 	},
 	[WSA884X_PORT_VISENSE] = {
 		.num = WSA884X_PORT_VISENSE + 1,
-		.ch_mask = 0x3,
+		.ch_mask = 0x1,
 	},
 	[WSA884X_PORT_CPS] = {
 		.num = WSA884X_PORT_CPS + 1,
-- 
2.39.5



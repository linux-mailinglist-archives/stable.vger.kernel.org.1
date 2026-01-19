Return-Path: <stable+bounces-210379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9221D3B37B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 18:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70DA5311FFF9
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43136C5A5;
	Mon, 19 Jan 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fen4HPZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086E2C158F
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840958; cv=none; b=VdNiHVaEO5VQuf8g5iD0Ntbouh6dTKr+xkD4HlyOFy0t26+jVqrHpghw5KA+GTovwSS67yg1zd3scZXuY5U9+8XRJHdbDCFPnT05h9U1hVVDLBGFNdXbl3p+klS1vleMnHA/OV6gHKDRneni/csQfIPB6+zotSXEm/EOpBZnD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840958; c=relaxed/simple;
	bh=UjjEHRAu9+yYAF1Q64dkhQD4EmJaSb6CQjI+XuooEBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npvTJirQzvCG4i2wNjy3F0Tna3IU9Mzrd5yhucctmtZQoAhGLkr3efcFNAsq+7/ui8CQ/vJJoqmkHSAjKexGzLW9nO8QKRaf62yCjQEtTJqeXcb2cFh2V5kA6G2np+6dT/pF6jaf/upPJU13Vurj2HBPQWzIu5it/4LZ6/zhTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fen4HPZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9DC116C6;
	Mon, 19 Jan 2026 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840958;
	bh=UjjEHRAu9+yYAF1Q64dkhQD4EmJaSb6CQjI+XuooEBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fen4HPZ0rRugM2WGPG2TLpHYs8Qfi+Q6ZvT5xlIXe0U/jhMPzO9paD1TahRVi7SdC
	 cSiknD692AHyiGkHR6ixcpMQvdhcLqafg9wWj3hlz5hdbr4v3YHKB+I3YLJjNv5tp/
	 wY83g30pZSKKLOldcC9Bce8+u15mSBgsnDRIIKfP00XvgDMG17xAnhtgiNf4VM2y2X
	 opYuDZilhqU71faN60OfgCYMGtjukx96cIFy4U+4ew90w0Y7Xm5Mw9/mURlQROEDVK
	 5P3fE/ws92cVla1M7bIaWoz5U7ewa8PCgskXmovTP//4cwqe9KGKbFFbBz69USremq
	 LVFn3sUGwTu/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: codecs: wsa883x: fix unnecessary initialisation
Date: Mon, 19 Jan 2026 11:42:34 -0500
Message-ID: <20260119164234.3142419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011909-dastardly-spiral-ae7e@gregkh>
References: <2026011909-dastardly-spiral-ae7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 49aadf830eb048134d33ad7329d92ecff45d8dbb ]

The soundwire update_status() callback may be called multiple times with
the same ATTACHED status but initialisation should only be done when
transitioning from UNATTACHED to ATTACHED.

This avoids repeated initialisation of the codecs during boot of
machines like the Lenovo ThinkPad X13s:

[   11.614523] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.618022] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.621377] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.624065] wsa883x-codec sdw:1:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.631382] wsa883x-codec sdw:1:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.634424] wsa883x-codec sdw:1:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Cc: stable@vger.kernel.org	# 6.0
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260102111413.9605-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index e31b7fb104e6c..8d1393041de48 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -441,6 +441,7 @@ struct wsa883x_priv {
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
+	bool hw_init;
 };
 
 enum {
@@ -1002,6 +1003,9 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	struct regmap *regmap = wsa883x->regmap;
 	int variant, version, ret;
 
+	if (wsa883x->hw_init)
+		return 0;
+
 	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
 	if (ret)
 		return ret;
@@ -1044,6 +1048,8 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 				   wsa883x->comp_offset);
 	}
 
+	wsa883x->hw_init = true;
+
 	return 0;
 }
 
@@ -1052,6 +1058,9 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 {
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa883x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		return wsa883x_init(wsa883x);
 
-- 
2.51.0



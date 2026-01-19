Return-Path: <stable+bounces-210384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC94D3B3FE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 533D83120436
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80231281C;
	Mon, 19 Jan 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO1jKPSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36642ECEA3
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841931; cv=none; b=seH661GD82TQziSczWNrPnmaDT3Rcsm+O6nf/2p38nOoCZRkA+XOvWWtJAOyC8iAwtz7rz4EMc8j8Oh6B6cojeky3zb6hnFNZ3yVGQFCIwfodd2Qmww3OnzLgXKK90Aqixp2GmDVM4lZL+8GUUXM4wH6HseW8RxLkwImR+mrIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841931; c=relaxed/simple;
	bh=sxxF4mEu1/xp4hN65Z5XaCYU7BvgZz6fAkmhUsjMmzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVovrJlPDC1EskhDn01ajyCBjCGsKTORVDfDy8XOoSQ1itQSf0jTutmbePYkUBMl/t73ip/HymRfgUewvUhIrom6XlLLN26YI2o+VoOI/41lKAvER+qxTSbMSdgR5JVAaIDUiEWom586gEb10afPRn7lMugOeGhmQBp1tKbczXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO1jKPSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60274C2BC86;
	Mon, 19 Jan 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841930;
	bh=sxxF4mEu1/xp4hN65Z5XaCYU7BvgZz6fAkmhUsjMmzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TO1jKPSaq81Dw2CF0CJWF4DkjDtU/J2bd4nSVXWZHt/Zwz/f6zUGBVOEScjlGQmjE
	 GnXBBKjoGteO+6n6L/rcnm0WinoYe8F4n4jIPu2R0u4vK7Jbx9AEqnwRSwU+VhQcHp
	 AoB2D/UKreITAhRQu+peSj9fK4m8vv11ce2VJnh54ts3hW5XL+mdhEJfz7om0I3yzl
	 rMjeEsABFLcbEgjBHA+uE9/bMHiuororUlno1N+ZOwiQsKi82M/qmkrmHkHW1fdonn
	 aK749JbUK6eJGdxdDD4l5LxETSAQrqgSm0N6UFLVcqwNbPBZufzEvsLV9eSDW9Didt
	 zunPpUeTY+apg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: codecs: wsa883x: fix unnecessary initialisation
Date: Mon, 19 Jan 2026 11:58:47 -0500
Message-ID: <20260119165847.3262757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011910-hazy-tubular-e9ab@gregkh>
References: <2026011910-hazy-tubular-e9ab@gregkh>
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
index 1831d4487ba9d..8d712781018a2 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -444,6 +444,7 @@ struct wsa883x_priv {
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
+	bool hw_init;
 };
 
 enum {
@@ -1003,6 +1004,9 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	struct regmap *regmap = wsa883x->regmap;
 	int variant, version, ret;
 
+	if (wsa883x->hw_init)
+		return 0;
+
 	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
 	if (ret)
 		return ret;
@@ -1046,6 +1050,8 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 				   wsa883x->comp_offset);
 	}
 
+	wsa883x->hw_init = true;
+
 	return 0;
 }
 
@@ -1054,6 +1060,9 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 {
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa883x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		return wsa883x_init(wsa883x);
 
-- 
2.51.0



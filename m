Return-Path: <stable+bounces-210386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB92D3B457
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90FC3308D526
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD86329E49;
	Mon, 19 Jan 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHgHtiZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD832939A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843225; cv=none; b=ja3SWFn2eXimFRLWRQkUj2upNmnJJoKaVZ2YT/dA7hE16wZ+H/k49pvN7c3IOCCgtwXi9HqJzzs2MNqog+GiHZCaDM0mKM9G0DWx4KZdMiTJObeoYPAEPZVWLuih542Wup8GUIjk/IYLsg59AdDeA4aYT652oALlfRWapfR0er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843225; c=relaxed/simple;
	bh=ZLiMD/hg6FuDvZPzK2S/oNhqueNagyDqAVOQLYFbbDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZRL3fE4JhEES3DxQ2uQROH4j/SNrm/wrI8PkmW8Kw4kghay6CcD/BeW2nXK5oDxjs1AVJf580+tnuH2kZbzDy3NcJUJY6cKbTqgQoVpmINeTjMQ2izzHB40rVwnMXc6o7Sy3Z8VCelonLA/m8qPEV0gF2iKSE+GyfaurlQnmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHgHtiZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C0C116C6;
	Mon, 19 Jan 2026 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843224;
	bh=ZLiMD/hg6FuDvZPzK2S/oNhqueNagyDqAVOQLYFbbDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHgHtiZuoBMr/YDiWluzctV6E8Z0VkJVp23uvfrhND3O47LowR5fKsZjE3Lx0VwSY
	 YaHFlAuERaJqHZjHQhz/Ef3/20yCqHN/Ola80yPM6rVABbxERVgovmPJweF4NvgAmq
	 yNf6UrX8FMOi4fEJsoCa6siVzPebI0X5eB/Nq374KJ8PtnMkopiUyeQxcfYMi9Zm/3
	 GYo/3+EPzbTlJ7LDgXkLlnA0wO4my7qqBVowo+uAcF2abGSpL4lWdZn/WUYJ/QlP2D
	 uqGSGIgVt6FqocQrN5j87Msx/0uxdqhl0Ak9DSk4tk/vlGtB5foynvKVWrJm11gjcq
	 BOKxchCf6dg/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: codecs: wsa883x: fix unnecessary initialisation
Date: Mon, 19 Jan 2026 12:20:22 -0500
Message-ID: <20260119172022.3580065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011910-psychic-unsaid-88e5@gregkh>
References: <2026011910-psychic-unsaid-88e5@gregkh>
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
index 639fb77170ac8..94ac6729cb016 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -448,6 +448,7 @@ struct wsa883x_priv {
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
+	bool hw_init;
 };
 
 enum {
@@ -1007,6 +1008,9 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 	struct regmap *regmap = wsa883x->regmap;
 	int variant, version, ret;
 
+	if (wsa883x->hw_init)
+		return 0;
+
 	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
 	if (ret)
 		return ret;
@@ -1050,6 +1054,8 @@ static int wsa883x_init(struct wsa883x_priv *wsa883x)
 				   wsa883x->comp_offset);
 	}
 
+	wsa883x->hw_init = true;
+
 	return 0;
 }
 
@@ -1058,6 +1064,9 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 {
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa883x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		return wsa883x_init(wsa883x);
 
-- 
2.51.0



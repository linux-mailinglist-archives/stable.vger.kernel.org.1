Return-Path: <stable+bounces-197108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE09C8E997
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 371B5351426
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8A3271FD;
	Thu, 27 Nov 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgktAKkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA93195FB;
	Thu, 27 Nov 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251496; cv=none; b=NYro3Ew69vzGQbJCtPOMqHLYYbL0PKFjpYmQz/6z5pQ+ROv3N22QB322W9IZ8gZP5H6GQQMMyUt+ALFQvdBlLYdwzE+Swr6aI+sDA/ODbtuCAsqMxFPgoeyknYFsLM8Qe3RFaThmGZCLYIxNvE7y3OfZZuUns6OhC8NJvqiaDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251496; c=relaxed/simple;
	bh=2grttM2+b+FCcMtYfwJ2Au6peSQXsKGtdcjJJ8wLerY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPmRbWNjnFHiWXP++BKtwOk/VwLre6J2nEKxyGRAv5n6YFylBNhOhwjijGSNX0UcuIhgUWIDKcEb58phK72ChuvbNQYF9MGDNzASaYJBoJ+Aa7bv9MzYGXUOvBXDRmraKInGOgOqVZtBcxbGI12pVQem4rKEj40xgew3HqxUIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgktAKkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F4AC4CEF8;
	Thu, 27 Nov 2025 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251496;
	bh=2grttM2+b+FCcMtYfwJ2Au6peSQXsKGtdcjJJ8wLerY=;
	h=From:To:Cc:Subject:Date:From;
	b=EgktAKkDuxcpkbB99CLHNNUJNo8Vmpw7zG3ropuSNDZR59ai6mcEAZ7Hbx0lOO10t
	 l2WVLsPKGCAns5OWaDmToHF8xcPke6Vay3hoIChQwfXSghn8+h2pGoHgOQE1qfUy0t
	 mglyH7wviDGquIsjSHzW5hIP8cNpZasu7N+3BYBqHY6dWv1eRSvuG292veTRSFV/6s
	 bpQxpysSbtQxWf12qxEha8c+XxCRmaOeWQ2cG3o1dcOj9CikEuSnWbzL37xWO31/br
	 dyT66xbjlqsBTzXlUPpoZcxN/WO0vVKOIczpQ8iq0q9tn919h52vy/STq+VTyiyRIC
	 A62jFEaY8dyhg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcPK-000000000aT-3sWa;
	Thu, 27 Nov 2025 14:51:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd939x: fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:50:57 +0100
Message-ID: <20251127135057.2216-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The soundwire regmap that may be allocated during probe is not freed on
late probe failures.

Add the missing error handling.

Fixes: be2af391cea0 ("ASoC: codecs: Add WCD939x Soundwire devices driver")
Cc: stable@vger.kernel.org	# 6.9
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/wcd939x-sdw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index d369100a2457..da342a0c95a5 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -1400,12 +1400,18 @@ static int wcd9390_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
 
 	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
-		return ret;
+		goto err_free_regmap;
 
 	/* Set suspended until aggregate device is bind */
 	pm_runtime_set_suspended(dev);
 
 	return 0;
+
+err_free_regmap:
+	if (wcd->regmap)
+		regmap_exit(wcd->regmap);
+
+	return ret;
 }
 
 static int wcd9390_remove(struct sdw_slave *pdev)
-- 
2.51.2



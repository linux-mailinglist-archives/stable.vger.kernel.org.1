Return-Path: <stable+bounces-210642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMXVJk00cGkSXAAAu9opvQ
	(envelope-from <stable+bounces-210642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:05:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB714F798
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B6B6E0DC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81250311960;
	Wed, 21 Jan 2026 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmpmrJPx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC17319614
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961068; cv=none; b=sujXqeWOjqgewh9hQapmSYezVDCZjvaB35C4B0WVq97tM/BMiJfVSCfzNbhWJkkzLZ8k+1mxUwsAsGOP3H0+5F0y3jqva/keRnLRW/CvBke8Asg4fgoLufHlxC+FyDGVe1NvMW0kJaUTXsbGLk4po65MS8II9holewSKCfBeu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961068; c=relaxed/simple;
	bh=4U9IFc5wxnHv0P1+UhXIYebw0QdgMQACdgETn3cURcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHeqpowDYWUm56MULPw+ZWBcQDBXhqrglvnyzg+Bz1Hv89EDTGYbwplF78qsIZONeSquug9krym857hrckWzCO5ChJS/F0KqLYx0OPM7XsMUCz5Cg9RB58W6Bfc/guuNz4c87HzztlPxiDjyU3ZkP5XuRePl6VTWvI21kZyKs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmpmrJPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D106C2BC86;
	Wed, 21 Jan 2026 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961067;
	bh=4U9IFc5wxnHv0P1+UhXIYebw0QdgMQACdgETn3cURcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmpmrJPxVnKE1kgB2iVvzLmmkQa3Mn+h/fHIRqS5sKbt2Q78M06itSngUVfX48hJb
	 0Z5McjCcV9saEiv+l9Fj8d9pmIgUNr27RbvEIs6r9SJ6m2x8wEbgmXOTp5lU3kRKV/
	 i45ApTEMCF7mf5mQ9ReC2QFlIos4dJOljAJ11TVnH23DoYDM+XpOHzWCGrH5tZySLp
	 TuGJJpBsE+JSN0X02FELYo8cB1RG2k6ts0pA8m5OE3LeQSF2eyWPxnRi/zU9NxS3po
	 QWpX9evxpNmXoAZTtOQQfPY7pEtxvQc/e6ImqSuDyqOsDHrChLcwYHvRnstvj5hXhF
	 R7ae9lHKhTVyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
Date: Tue, 20 Jan 2026 21:04:22 -0500
Message-ID: <20260121020424.1123218-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121020424.1123218-1-sashal@kernel.org>
References: <2026012029-aflutter-entrap-629f@gregkh>
 <20260121020424.1123218-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 2CB714F798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 738455858a2d21b769f673892546cf8300c9fd78 ]

The shutdown GPIO is active low (SD_N), but this depends on actual board
layout.  Linux drivers should only care about logical state, where high
(1) means shutdown and low (0) means do not shutdown.

Invert the GPIO to match logical value while preserving backwards DTB
compatibility.  It is not possible to detect whether ACTIVE_HIGH flag in
DTB is because it is an old DTB (using incorrect flag) or it is a new
DTB with a correct hardware pin polarity description.  Therefore the
solution prioritizes backwards compatibility while relying on relevant
DTS being upstreamed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230102114152.297305-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 29d71b8a5a40 ("ASoC: codecs: wsa881x: fix unnecessary initialisation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa881x.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 4ff53ab127467..d12615746721e 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -678,6 +678,11 @@ struct wsa881x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA881X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	/*
+	 * Logical state for SD_N GPIO: high for shutdown, low for enable.
+	 * For backwards compatibility.
+	 */
+	unsigned int sd_n_val;
 	int version;
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
@@ -1123,6 +1128,26 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return PTR_ERR(wsa881x->sd_n);
 	}
 
+	/*
+	 * Backwards compatibility work-around.
+	 *
+	 * The SD_N GPIO is active low, however upstream DTS used always active
+	 * high.  Changing the flag in driver and DTS will break backwards
+	 * compatibility, so add a simple value inversion to work with both old
+	 * and new DTS.
+	 *
+	 * This won't work properly with DTS using the flags properly in cases:
+	 * 1. Old DTS with proper ACTIVE_LOW, however such case was broken
+	 *    before as the driver required the active high.
+	 * 2. New DTS with proper ACTIVE_HIGH (intended), which is rare case
+	 *    (not existing upstream) but possible. This is the price of
+	 *    backwards compatibility, therefore this hack should be removed at
+	 *    some point.
+	 */
+	wsa881x->sd_n_val = gpiod_is_active_low(wsa881x->sd_n);
+	if (!wsa881x->sd_n_val)
+		dev_warn(dev, "Using ACTIVE_HIGH for shutdown GPIO. Your DTB might be outdated or you use unsupported configuration for the GPIO.");
+
 	dev_set_drvdata(dev, wsa881x);
 	wsa881x->slave = pdev;
 	wsa881x->dev = dev;
@@ -1134,7 +1159,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap)) {
@@ -1159,7 +1184,7 @@ static int __maybe_unused wsa881x_runtime_suspend(struct device *dev)
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
 
-	gpiod_direction_output(wsa881x->sd_n, 0);
+	gpiod_direction_output(wsa881x->sd_n, wsa881x->sd_n_val);
 
 	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
@@ -1174,13 +1199,13 @@ static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
 	unsigned long time;
 
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 					   msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(dev, "Initialization not complete, timed out\n");
-		gpiod_direction_output(wsa881x->sd_n, 0);
+		gpiod_direction_output(wsa881x->sd_n, wsa881x->sd_n_val);
 		return -ETIMEDOUT;
 	}
 
-- 
2.51.0



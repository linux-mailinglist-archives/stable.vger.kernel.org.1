Return-Path: <stable+bounces-210655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLTFNFA/cGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:52:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C489500B6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37C95EFF72
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E634CFC9;
	Wed, 21 Jan 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5gISg+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC434B1A9
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963664; cv=none; b=ZEO9wk8U8NtJ3tsnxhleLf83TPSdP8/+lk6ghppxu7FamTn90Zx1FySaJjT1VsvAL7lsr/QJd0Wsxq8ByCN6/wk6JNqbB7KpZinZfCK/eQ3GWgNomI3JQ9BzsXw2LVg4rkOt+67TQKhhSWEbR1v8piZUbLqHxaRd1A498QtvybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963664; c=relaxed/simple;
	bh=uQwek6isLVACBwkOdx5BF6+0ZxlEYwd6RuEygmn9qnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIeiNTz777VZX/4B9PCdoxUsEAv9+2kdUkqgejDbK4q421/ePQRnrcHGnQH7hjtMBoeWq5MAcKAWiR6cfQX+1EmS3lUsrt2AoaDUbtH5OW1WOKSXqfz+3WKtbvjUsv9bZJk13Dm+7io3qUp1+xLJjOV29xKiaatALgstWfagKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5gISg+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CAC16AAE;
	Wed, 21 Jan 2026 02:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963664;
	bh=uQwek6isLVACBwkOdx5BF6+0ZxlEYwd6RuEygmn9qnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5gISg+emEuWgKKSQOrTz+mQFp98w9U93N2PoZf+9Yd6liCjfemEzmAMz76QY3qrW
	 lPFumq+5uQijcx8YuRU5LdKWJh86dXtpu15KJnRsL4HKKgCqP4G6pGJpy8dHsflW/+
	 9rhJQ5Qsyv/KkOPgYf2RxQnrSLA8AY9DPmnPe1hdatHDXbcAfejMTUEOcWv6XRdFOB
	 KTi02sgXYkZM76mWhwM/VDOeR1mYZ9VXwgHWAku0r8hb6n2oBmv71lZdOiWSZwf7Z4
	 koCmuV6TdMTuGUH32EH3aHO9HKcvH4DuF/ghrmtJNgxszqvBKIgag5Dlet7GX8AeAp
	 FMqcLigyw0srg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
Date: Tue, 20 Jan 2026 21:47:38 -0500
Message-ID: <20260121024740.1145743-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121024740.1145743-1-sashal@kernel.org>
References: <2026012029-possibly-cornhusk-03c3@gregkh>
 <20260121024740.1145743-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-210655-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6C489500B6
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
 sound/soc/codecs/wsa881x.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index f4fef94bdf989..24f3a92037d4c 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -676,6 +676,11 @@ struct wsa881x_priv {
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
@@ -1112,6 +1117,26 @@ static int wsa881x_probe(struct sdw_slave *pdev,
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
@@ -1123,7 +1148,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap)) {
-- 
2.51.0



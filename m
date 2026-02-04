Return-Path: <stable+bounces-213996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEonAFZlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80119E896D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D240315E26B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB5421887;
	Wed,  4 Feb 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Q3hHOGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834003D994;
	Wed,  4 Feb 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218210; cv=none; b=fuM9KbnCJ8bVmPTLnU4NgZYvJ+mweAUlgnP14x6S/tc8T+34j+E7t/4ip+FWSYAwZAR0Kqmc7jjYfLBD/hwfeNsAREqwJEFfmXx5wqBBnAsOBfzbkzTqY8+NCsNiq8Q1of64DUJx7yGIgYrdMCCjlYScuXE4tWFTJCZs0CyunJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218210; c=relaxed/simple;
	bh=o7tWqKS7MALIm8C+J1SMYXG5SS9ps42gj3scoJLqpmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrahkNxPUW8jUe5c90F7010FMEcs8Cv/W6Y/p8446lu9BopxjEj3YQ2Lq1RNr6YXU35lqv733VNuz4sV2co6hQFH/RrUuq9HwZoXX3zFjnpHPGYyLWzRGqo8ZqkJ3DtM3+7+uBi6Jnw6BiC2ClKZ3GSLUSOZD4pqx6INNETDAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Q3hHOGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3FC4CEF7;
	Wed,  4 Feb 2026 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218210;
	bh=o7tWqKS7MALIm8C+J1SMYXG5SS9ps42gj3scoJLqpmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Q3hHOGyC0Nt7osmha0h2T1laoiJ2T3fcT42VukLkKjgB8A/GQosiUd4xd4WPU3/H
	 ZPvonlQhYvpeejkreCApeMemM11t/Y+nHeGHDqKb51s/R1Im/YInZad/I/+6jl4gPT
	 DloxyF48cjdV/Zk6AX0lPAJYRs37w4MD7/G452lA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 245/280] ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
Date: Wed,  4 Feb 2026 15:40:19 +0100
Message-ID: <20260204143918.453738663@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213996-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 80119E896D
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wsa881x.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

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
@@ -1123,6 +1128,26 @@ static int wsa881x_probe(struct sdw_slav
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
@@ -1134,7 +1159,7 @@ static int wsa881x_probe(struct sdw_slav
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap)) {
@@ -1159,7 +1184,7 @@ static int __maybe_unused wsa881x_runtim
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
 
-	gpiod_direction_output(wsa881x->sd_n, 0);
+	gpiod_direction_output(wsa881x->sd_n, wsa881x->sd_n_val);
 
 	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
@@ -1174,13 +1199,13 @@ static int __maybe_unused wsa881x_runtim
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
 




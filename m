Return-Path: <stable+bounces-210654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA34Iw0/cGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:50:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52E50090
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0B47A40318
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D934B42C;
	Wed, 21 Jan 2026 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHXW+u4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42996347BCC
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963663; cv=none; b=Ch1FuPURqelHVFbh1FgCvQRFjjOMrVTDAfjZRGU/pzEz6olM1lWZo1M+nxO3LKDZvJHxRoXIF1PvHFpf1YWnuwHLY5S1b+q6RQZ/43u6fvm7pAPyaopwHjabwNnzaRJRqioLyAsUGPgtIFpS/F2D+FsV0AzlB3x/agLQsZMFgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963663; c=relaxed/simple;
	bh=MjjYhkZ1VQ+stOfowXE/bd795o4gflB2z2x1exktUW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyp5vqxCh80hVdMKI6NGspgsvCdG+d9z2J0QDdwkvx9rm+uWfM/Mj6D+0+G9nUcj4VOnfVSHW3kyj018ydD3cSTjja3dZQgS5C4oCnp4rSLTxY6qZ4DC2hJmp9iWCzwE/ZDABH2RnI9cZi9Gg+Xxuw+MolDISYYgOWb2qbGN8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHXW+u4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F82C16AAE;
	Wed, 21 Jan 2026 02:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963662;
	bh=MjjYhkZ1VQ+stOfowXE/bd795o4gflB2z2x1exktUW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHXW+u4wqQYbuHW7XFIZSEInhxOMr4iXcKbOYmChPaV5ts+SLMi0D0q/nXe0uMNDE
	 WboH8/MZHDPGaHrQHlrOILi2XqA2QQJnBH+xjIuXDfqMS7tmA4jF1PrHkPqkzSCsL7
	 /alo9rAT8aB3Z403e8Ox2M4oCdzDFPbmDAiYEwY95Ofcdv/VNYgyXasHpOYOAKAR5n
	 LSRnpOMxQDW8H8bIAXdor4YN+6dElqPodv+9AWRAIbWrQX1hI7dTiQcfOHxXGAIgXc
	 /pIPxu0/ANYvImMqePf7jR0vZB/fITpA9nv6GlCoRXltxUJ/VHCt9A3YhJPNJthQjx
	 FY33b0aeBPSUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] ASoC: codecs: wsa881x: Simplify &pdev->dev in probe
Date: Tue, 20 Jan 2026 21:47:37 -0500
Message-ID: <20260121024740.1145743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012029-possibly-cornhusk-03c3@gregkh>
References: <2026012029-possibly-cornhusk-03c3@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210654-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3A52E50090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c617c9e7024d152426acf9f1aaf01070b6852f13 ]

The probe already stores pointer to &pdev->dev, so use it to make the
code a bit easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230102114152.297305-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 29d71b8a5a40 ("ASoC: codecs: wsa881x: fix unnecessary initialisation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa881x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index c8d3dc6341037..f4fef94bdf989 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1101,20 +1101,20 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 {
 	struct wsa881x_priv *wsa881x;
 
-	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
+	wsa881x = devm_kzalloc(dev, sizeof(*wsa881x), GFP_KERNEL);
 	if (!wsa881x)
 		return -ENOMEM;
 
-	wsa881x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
+	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
 						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(wsa881x->sd_n)) {
 		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
 		return PTR_ERR(wsa881x->sd_n);
 	}
 
-	dev_set_drvdata(&pdev->dev, wsa881x);
+	dev_set_drvdata(dev, wsa881x);
 	wsa881x->slave = pdev;
-	wsa881x->dev = &pdev->dev;
+	wsa881x->dev = dev;
 	wsa881x->sconfig.ch_count = 1;
 	wsa881x->sconfig.bps = 1;
 	wsa881x->sconfig.frame_rate = 48000;
@@ -1131,7 +1131,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return PTR_ERR(wsa881x->regmap);
 	}
 
-	return devm_snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(dev,
 					       &wsa881x_component_drv,
 					       wsa881x_dais,
 					       ARRAY_SIZE(wsa881x_dais));
-- 
2.51.0



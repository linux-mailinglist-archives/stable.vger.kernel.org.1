Return-Path: <stable+bounces-210641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KwNFsk0cGlzXAAAu9opvQ
	(envelope-from <stable+bounces-210641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:07:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 023944F802
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D16E24EFBC2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D327CB35;
	Wed, 21 Jan 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIStVMyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DA2C11C4
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961067; cv=none; b=bYiGa/qR78OdX+3LOxo7GeJvvF3Fio+k15MezrvV6kWNns19GFUA+HkY2md7y+SdBCQFuW1FCiY/9wMtHKIeQVo+wnssYhq9EPowz91XK4Z7b+77Mpxm5nHeDOTByzvenuxXyEBI3w7rSQ0xsPy6QpRnMYFv0nquqmeqG76AwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961067; c=relaxed/simple;
	bh=MfT/OP/m4yrcHdcB/A41UBosRfDQMgvlcosCcSyjFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7k49MI1bOx3ht28yORmXCZ6St8ipL2PrIMxMwP3acibO1iu0n7pOcGcCOPnWeOqzwjaKIszkJBHZDAmIhvgtoTuRLLeUw1aMuAW60vOmtJXH750dq0IXHLEiyewr6GJ4/g6QR2gNutC52BI46yruYMjR1jlZYKUSxDz9kUDz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIStVMyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875B3C19423;
	Wed, 21 Jan 2026 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961067;
	bh=MfT/OP/m4yrcHdcB/A41UBosRfDQMgvlcosCcSyjFDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIStVMyTOGBNqa1Ueh4Ss8/kci279+YyZL8W3eO/34h7mFdHT8ORlvbw/e0aa0ZyD
	 Qea3RwE0PEmVIaU4PNiCycqsOqD2bZrlcL5ExcH7mF/Vaiv9O9HDBk/bxkouyYwn6j
	 LCMPWFme7jDWL/hJ2RFJkm7RHVaII0dPNMhi7Wl7zWeVTjn92EWAfoujiAFtWvMsKN
	 vqhvTGTIgqZTBS12jHvq/P8I32m7o/SXgsHRR4Xa+dpu+tSIpm+tfXrfpDGwfk+9EO
	 4cyJQnXWGpPaR6PeKPG847V4VG/7WnCSklOzuVvvVCrvqMCl5DRi2l55TR7e/QGnuo
	 yX6IWlAXPK10Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] ASoC: codecs: wsa881x: Simplify &pdev->dev in probe
Date: Tue, 20 Jan 2026 21:04:21 -0500
Message-ID: <20260121020424.1123218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012029-aflutter-entrap-629f@gregkh>
References: <2026012029-aflutter-entrap-629f@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 023944F802
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
index 054da9d2776cd..4ff53ab127467 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1112,20 +1112,20 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	struct wsa881x_priv *wsa881x;
 	struct device *dev = &pdev->dev;
 
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
@@ -1148,7 +1148,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	return devm_snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(dev,
 					       &wsa881x_component_drv,
 					       wsa881x_dais,
 					       ARRAY_SIZE(wsa881x_dais));
-- 
2.51.0



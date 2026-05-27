Return-Path: <stable+bounces-254588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDTfOIT3FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:54:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF15E55E7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 680023028259
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96C403158;
	Wed, 27 May 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so8ndgTR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750B413244
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889338; cv=none; b=fXWPQfTEDVs9ehbXCRlp7O+w4s//ZJhNSjevNfowL6GZA/fELj0zrsgUgWbCCQdKoAKGda77smBD8MaeV3sIvw/uAofqCM6Oe6BKQrRbs8imog2fjtLiXsg+DpnRCzpxWtYka3QAMcYXSjo8T8yBwNhnZi0qc2h1hyTxgU7oUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889338; c=relaxed/simple;
	bh=InHqJ2PNAaclYU6DB/4BCMiDFr1sW1hmcux0hzUPPiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FK2pNAi9oKHliLbp7CdUcJaK9zdWbdQeEkAdgjkN1WkjUYNkRrLYSbk9cRIURV4DGzJJBzhMK7VNDZzUkP1padlFg3/MmCkYJsRhJLOntrQFzBqVHDqSb5U0I5AA6xTrb6zpv6NyWTSmp1/wBkqAp4OkNHvyzCCnRc46ouhRcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=so8ndgTR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3044857f09aso7329307eec.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779889336; x=1780494136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPQMUeKZPxsEa24h/tMGbugrrlbgcKdXRN5CjzvNfg0=;
        b=so8ndgTRV6zGfnA3zRCb15rFM7brydNusYaTRlXwOKsnXN9a1GzOgTnJK3A3+v3qen
         ico02iMeoSh5piHA5MKQ1TBDZc7CO4yZqrSOSNqZptqqy4DPMwI1sNNKQOXmHU7DcCH1
         ri7vftJwG85+pW0fV3xHZ13f+FThghEr/9ON4mzFCyhXwGX5sZQ2Xtt9/mjAihYdE/X+
         rLzHCsjfjl9ETDpSCga25x0EMMbEfLbLYDLgBNnyBmJzG7MJcP4ljIN4ZQOYLmTRkGAw
         kIpjFHNzZUmfQPs6UiUv5RKWI10wJlvi/uKfEUZr5nVSux/5PBMZXKpTzozJgFhRqilj
         MjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889336; x=1780494136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPQMUeKZPxsEa24h/tMGbugrrlbgcKdXRN5CjzvNfg0=;
        b=Nrd4JeSzO8KFIqA9aVfgcgGH253BUq39HAlPX2pMiRzQDJ/P2GnnjpUpEm/MQyFklq
         LuQmvCI11NAFoU7VPGrXJ+ecnaCOfwEwo7K6+evz4lEk7UvRDfu6jm5/KnLVxeIwLq5x
         FOIZUDxRvq9tsP/pvNMUr76YKrq+PxnxEagKJOqMAO6MBunwAwKm1VMgNadbTtcwHjZR
         biVrUKauuBbK/wRkTg5m9MqBa5uLwoUoL6CD1XQY8WhuoB/gHXeRKt6gskFwt5S7RZfc
         r+vKf/aEiwkScmGVOOcSVcx1u+edYDPoUa+xvK8oX39lJPwHnEIpM4BJpmx9Tthp5kAA
         JE9g==
X-Forwarded-Encrypted: i=1; AFNElJ+HATB5Up6UYnlMBXoSU3TavZiu4sjexh15wOTp5HpZTDOjjjdJvMNCny+cR8fydQ24p6eWhkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5TFB+8cl+H5gdO/xiMG+SxDYxl5AUEqJCZV0c0w6j+GHPtmZ
	1sL1wX8sVSHCXoytmbTeueOlZxmyfr38zvtIJ5mcZf1Pud8H96Qg/m4X
X-Gm-Gg: Acq92OFBznXJGY8TZAsV56G+SIyR8FGeBpT7QIQGEJqUkiBsyM9iP087w1YSwcg2uVe
	uq8KXey+oWX4lUpOLKvK73V1rs9ZhDI/8pDdc9lFE1DKJFTpekT3K7LSiVLh7spTlE0MrW6V6py
	m3D70kgh5V35MTS1oTOGSHih92+dCoiGv3JDEpU/7y69iwdMGSUEq4mjchZv8oc6tq50qTJskzy
	XvBNjw6naBiVXSE3bC9UJqvWdMjXf/UlKbA/desI2Ofpsi9nouzhNspSL7OeX5ChEQE6oe+imBU
	mrZQD9XRwsxy+WZUqj8uptje9vY8kh4jUdXhaYDACI/ijMtXHpt66cg08h7+4xKTp/2anpf0s1G
	C9Xs0LHrcISv0bXOjAUbeTRQWyYZdsBK7XGWS0TPm7HTW4KoKTOgJmHOoZRGwo74QkPyOQP0KZe
	toEbhenYlR3Xzm8we11w69KNwcTe9qUy3c8gGeY0gP8jhg8wcSD3fj0KimUAx4PbdnqRAuE1MdE
	HGXpeQEBzkQ
X-Received: by 2002:a05:7301:a84:b0:303:f2fc:c483 with SMTP id 5a478bee46e88-30448f30872mr10369074eec.1.1779889336443;
        Wed, 27 May 2026 06:42:16 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ccdaa124sm311702eec.11.2026.05.27.06.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:42:16 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:41:49 -0300
Subject: [PATCH 2/2] ASoC: mediatek: mt8183: Check runtime resume during
 probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-asoc-mt8183-probe-cleanup-v1-2-4f4f5593c8d1@gmail.com>
References: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
In-Reply-To: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Shunli Wang <shunli.wang@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=InHqJ2PNAaclYU6DB/4BCMiDFr1sW1hmcux0hzUPPiE=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliX1YZNC5ZftYw1+3/caOwl8IefBtEl/fymm+WYIh0t
 VtzMUaso5SFQYyLQVZMkWV10iLLPV0PrtbHrfCAmcPKBDKEgYtTACaS/oiRYaI35zZxrdy1CmEm
 DqssLOu3sKvesLk43WZ6wGIT1fwCe4afjEW/dq9n3H5PYsbpJ0KVHS++HFYIfaoRmLz5eE3/+xk
 2/AA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254588-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,suse.com,perex.cz,collabora.com,chromium.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7DF15E55E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MT8183 AFE probe uses pm_runtime_get_sync() before reading hardware
defaults into the regmap cache, but does not check whether runtime resume
failed. If regmap_reinit_cache() then fails, the temporary runtime PM
usage count is also not released.

Use pm_runtime_resume_and_get() so resume failures abort probe without
leaking a usage count, and release the temporary reference before
handling the regmap cache result.

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 49a69728fd72..2634699534db 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -844,17 +844,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
-
-	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
 		goto err_pm_disable;
 	}
 
+	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
 	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
+	if (ret) {
+		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
+		goto err_pm_disable;
+	}
+
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 

-- 
2.54.0



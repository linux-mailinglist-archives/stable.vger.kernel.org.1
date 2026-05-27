Return-Path: <stable+bounces-254595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBHxBnb5FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:02:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34E5E57E3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53287308F2B3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89174218A1;
	Wed, 27 May 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqzJfGpG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1E423164
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890308; cv=none; b=GE59xCWp7XtLvT1SDQiendjm2ncwLckiytf6ssSYI1XjVa+3GzxMaswjturUuFImzva6HraWJVx1bW7j3ECoDnuH5IEjYKqDNkOCMUAnLM2q7Jfv0ezoQgZaDxjl3V7jJ0tQFzNksIhQrxbsha0+dVIOkP6cLw6jyQsay9Jy59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890308; c=relaxed/simple;
	bh=AiWKUJ6pcaS+s2EMRR0lpjZ6dv0VklPnVPvbjxXu/dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOmhzPcUaaN8acaKo7UiHneCOyPwExrH6luqfYjCG1k83ZO0tbawopBwafw/UA1U3MrzbIOCqlCG0JWhCaXc6pjojt5IzMJD+PTpSPcJS6SY79S/i5vd2LpUvliJbHPGU8hrh/B4PB7Dh3DVmeSUy/nPsDk+Dz8q2OUjUgm73YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqzJfGpG; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-134fe980658so13407143c88.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890306; x=1780495106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqn/GhtdZ2zHm2dhsjmzQoC4+5EN3BPsb9xc1JJYgSU=;
        b=BqzJfGpGBT2ZD8QCUeCJxpZoohRCpO3AtLvwHujSgB8IFg8wJmO1oln8C0LQBG1w5R
         wulZhe8lIFSISr+c70OQMZP2vkOEZOMWJieebZ1s2RcghL205pp1EX+EIN9gXrgBqe+y
         YQkJwokEyGkFZjSZRuFYiNTdts9xdKMwfo4whn2D8GZr/keSMND293VlEZmeIbMnQfVs
         Csueft557jAgqaJbDAbyrxsw55pD9LNUIiIZ09IBJoOEiK0lb1WJOb1xFHshxNNaLEyT
         iV1VAOaJx6CajGXHIfumi4L9G3bIinv65csgwOi6Yy3xsDxPLTAANZWRcNCGLngj5fof
         knug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890306; x=1780495106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qqn/GhtdZ2zHm2dhsjmzQoC4+5EN3BPsb9xc1JJYgSU=;
        b=ANZEt3SrqewW+5G7wRtgxcZk/zpwWmM9oDsMQSAusbtpjsmG2lIcRM7Sf/n1pqUGAq
         nJNecE+vYgC+Nfqr5X7Uolofb8mdjZIZj1+r09qzuHkqRYxM2okobky2QP8o/Uuo5lBD
         RcClSzaC4FmwZ0rrp4TL7xEfdfB4tbC1nFirg9/q6ZZfhQI8s0rssR3fRCMNE8qvzy5m
         m2JGMqdbpp77byfRK9NY03LDkKBFt4+L4X9S50Eyveppu+AjmhxLpgRXpx4H8+0jQC0N
         tLy9y3hWVE19kaIt3y+GRwo5sdMii7jM7jQAQSNBagk8g7rrUc6yVVnEeZJAGg3sCMO3
         Jmqg==
X-Forwarded-Encrypted: i=1; AFNElJ8x3Nt8nHygmzzSOZWQnS/OVbC2amw2yfHm9zwPD4kZOFHNKsrCvwjhcdd/XhTeTFZ+yUYhHc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw17drkzbZBAPJxMXSKLiAcf3t4VV9qPlJSkcOiNAR3fNS/ES7
	95hKp5xd/Vj4qQG2MoAeXEc27KHhSulgrg3jlEs7pLO8UZA+w2cHzleo
X-Gm-Gg: Acq92OEjg2Mg2TF763LBdusyI889vO0O0lrWBWFKyAuwcdCKNjLNoFIjL1/84dageAd
	Zqki/OtasbhVCYTDDUfB+KgEKzFJorPvlbauakEEBPVUS6iT92TyJXRy+G0JYua89IiY+ludBoM
	jdzWSWHszU1o6ZAXLWeW22sZs5zB5YAv66pWg5C1V0T6WmbWmDJwFHlNF6ROK/Fob0F6ZCIsAlp
	SZl8mQxZtpd3bK/pvz5YZ7n3yq06gskSDgnBxDzoBxe8MSwu8QMq9yINWbfWs0UHOK8z3ZYJV27
	P+Ni/ld0SMgAHi/phjhDSTFzoC5Lj+FZIOf7fZPO43plkAu4OsdcnjzQqrN9MJck/HD/QGuiE4t
	hEFrJl0IruuG9Mt7OZxiiBQ0uu+lKY5Dnbk3HFjKMi+yScy+t7E3L24itDyWAwEnmV5PzTOVM3j
	g/Sp7lDKqaJYkPd3NXCP50d6LMvbIxLtq2lEu/aaXK8Ud5dXlH56bxijJFFrHR9Z9KNWw9CeR7/
	2xYhbUpcZvX
X-Received: by 2002:a05:7022:62a6:b0:12d:de3e:86b9 with SMTP id a92af1059eb24-1365fc6932bmr8295204c88.41.1779890306165;
        Wed, 27 May 2026 06:58:26 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm13013788c88.15.2026.05.27.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:58:25 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:55:47 -0300
Subject: [PATCH 2/2] ASoC: mediatek: mt8192: Check runtime resume during
 probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-asoc-mt8192-probe-cleanup-v1-2-1bb834d05b72@gmail.com>
References: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
In-Reply-To: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=AiWKUJ6pcaS+s2EMRR0lpjZ6dv0VklPnVPvbjxXu/dY=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliP4pklll4m/lM4s7ZEHO7aHXznfQp56/39sv0p7Ap3
 3zr9uJQRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzkyDZGhqXrhb+oauy39J/t
 8NiuduspzslHDBLFfp62j3380CxR4xbDXyHxP0ruxx7puPtlON8wPb8vSjhoa8qtDba7ZzC/XBL
 rwQAA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254595-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D34E5E57E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MT8192 AFE probe enables runtime PM temporarily while reinitializing
the regmap cache from hardware, but it uses pm_runtime_get_sync()
without checking the return value. If runtime resume fails, probe keeps
going without the device necessarily being accessible, and
pm_runtime_get_sync() may leave the PM usage count incremented.

The regmap_reinit_cache() failure path also returns before dropping the
temporary PM reference and before clearing pm_runtime_bypass_reg_ctl.

Use pm_runtime_resume_and_get() so resume failures do not leak a usage
count, and clear the temporary bypass flag after dropping the probe PM
reference on all regmap_reinit_cache() outcomes.

Fixes: 125ab5d588b0 ("ASoC: mediatek: mt8192: add platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 9f5057eeeff9..db0ae44a86af 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2227,15 +2227,19 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		return dev_err_probe(dev, ret, "failed to resume device\n");
+	}
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
-	if (ret)
-		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
-
 	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
+
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 

-- 
2.54.0



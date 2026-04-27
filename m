Return-Path: <stable+bounces-241344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHzXBPR672kmBwEAu9opvQ
	(envelope-from <stable+bounces-241344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CB3474D8D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74F2430078B3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F566321F5F;
	Mon, 27 Apr 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afgIxeEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915713233E8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302256; cv=none; b=sY1u6H+ZgMZ1CKuPU8gvNVVdZ3TNmg1ofzttcgsBVKp1crlMBmfT4rGtvXIuVdIo+u+wwLrniDYhx8pDmKWbmtOlrSZLuH3s0mr/ncTCyB6XFIbngGb4iaoWz6gZeE+N0/V2Bg79p5sVeSb/NNrEJmUPCvG0YdxFdYdUHQGKmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302256; c=relaxed/simple;
	bh=Ba+dTVUBhKnEfFMyTWML1d2ClIcN7W0bbbcIFyIYV0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuTS14MyngNUjRlmBkjCk8QEdmm3a5vTr4njjAlbfvczVL/1JL7RPw2mkgXRHhPdP29co/rTqe3sgvEkrelsgh2g8fLDyQsf8bMhcNB8tONyef/UIp33LbVIuMEJEwlLWqOB429B2MVEtNE5ptMD/OlCwEDKdtWsgyp79dvrqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afgIxeEs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so6440892f8f.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777302253; x=1777907053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th+fTKGfuo6huv0uM66BibBdeXURX3Gjx4cjUN6LP74=;
        b=afgIxeEstITQJMJ6gENwrk3sK6SxAbqZawE65ujqjjxYitWrkP6igePZ6I8x3BdUDm
         8ZExyyPOq5m5WxZ2FhPqO3gxIEEVJnIfOUbBDS5WgSPdo0rD07uBJNS5oi4Ci9nI0nRL
         RpAuTf68Af8YksvnXUpU7ziDKBg7gurNonTGAnlr1xtClQnhEuRQqRYtkZ/AJkbBPOw8
         7iMyEBuW4QxK0qnDvgF9jLy/VGNUJpNu57TyPSFKVTU0ZRK97JRCHJIucDnjPIRFy4UR
         3823vF2fOesV/875scsUHhl5b063JMCkTrrEcOYx7kU3JUcknznExK4gU7zEi3HokidP
         l+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302253; x=1777907053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=th+fTKGfuo6huv0uM66BibBdeXURX3Gjx4cjUN6LP74=;
        b=BQLLkqtlGiibFhuKbSgCkRrmlMRLMK1BXNcdsS5tpm2u3A7Cw5yxbpxQyceaHGbpL3
         pOqB5ncxkcBImf92Ycz7nIdV8pG744YcYiJR6c6G9VuPP4zBVuEf2KV/43v8u+nGLNbv
         onxh2YM/N5bmFhY6BpmRqBaZDKRIpvjAmPX96xauXvHhxH1QpaJh5Lo4QD4XA6C6lfJM
         nx9E+tBKS3X0c3Dc8GYHyCk9bGSoQgyBLrh/Wz1NEFl7BDnfjUWN/zCHkKwElrqbmS63
         XRXYIRQo8eoxWR5A/qWwKeZwncgawxURBHDfOIi3MZKXttKuFow5tPQ2M6v33HkzcbFM
         ncqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gY7PUl9joeFNSSj/cgU6QzS1IVezKJTWBx9Ln/u67Lm2JLO73uTWXb3zxycPKTfsbwRe/yKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvI1O2eI0ufhSez2zK3mpN9lbJ8XpFPOHSIfhYZ4NAUTcfbI1z
	vakV0fH0G67lt2hEHt1pnWuxt5IApf6okW1npXYoq8uD+C9t3JAn/9FO3FFi15OyglQ5QkT5hc5
	kH8ryEnY=
X-Gm-Gg: AeBDietyq+PGygkKz3gyZEKZ7n/jRRfNLDDrvi8ji0bO1tkPN7brdrdRJoYC9va+TwM
	9s2VWhZodnlb2laFqJHQ1N0cKyzkU5DvU9m9BBZpx+jyH/8w5PHyAyDpjnK/SB3ROyCUcsguqAI
	HazthNULCDmMW9DkNKcD/7Yb2z2jaQvr/o1tSRBRcBcgPlvd+kBCpzlbNIASHvoTrGpq+RD4O1O
	sohoqs2Nmr7UkSQ/7wWRT4PUnrZ8DeMxrUwXUr5VpY/9e8AdgqLG9MSOtgoi7d9oXP791OIuPcn
	M+N45Y9Bv0t2NmGt7Yh8ceT8thY2lhRylzsfHOhUe+09mpcU+wtsFZrBMtjyq/RT0ON27bNpw/o
	ungW7OEW/haHAuofHJV+tvTi0jlIJuIWbfsvtpv9nNtXsbQipsGrPcEXDi1sL72Yj/KJ+NB3Zq7
	mEmUcUqgzb6bV/G2vUVLNKz25/Rj3LcWntz/L7UgAKQps2tdpzIzDQSg7/LIXgdh8S0Ic9a1z1K
	4yxKQIgU/6MUSLXTQ==
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488fb780463mr598840525e9.22.1777302252912;
        Mon, 27 Apr 2026 08:04:12 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm235370215e9.26.2026.04.27.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:04:11 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 27 Apr 2026 15:04:07 +0000
Subject: [PATCH v2 2/6] firmware: samsung: acpm: Fix mailbox channel leak
 on probe error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpm-fixes-sashiko-reports-v2-2-1ff8de94a997@linaro.org>
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
In-Reply-To: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777302249; l=2357;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Ba+dTVUBhKnEfFMyTWML1d2ClIcN7W0bbbcIFyIYV0Y=;
 b=+4DHqrrOrGVH6m6Wr5Ur7SY6SyVl3EwK2I9IlGtYy5oHdPr9Pl50/6Hc5kvjbRc6gNH+qLFVB
 ynehG37WZSHCZr4+uQEBK/+nnABGuiJG/bdVGw9ezePZ9tunC9qr/lM
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: D1CB3474D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241344-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Sashiko identified the leak at [1].

The ACPM driver allocates hardware mailbox channels using
`mbox_request_channel()` during `acpm_channels_init()`. However, the
driver lacked a `.remove` callback and did not free these channels on
subsequent error paths inside `acpm_probe()`.

Additionally, if `acpm_achan_alloc_cmds()` failed during the channel
initialization loop, the function returned immediately, bypassing the
manual cleanup and permanently leaking any channels successfully
requested in previous loop iterations.

Fix this by modifying `acpm_free_mbox_chans()` to match the `devres`
action signature and registering it via `devm_add_action_or_reset()`.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e95edc350efa..bd0d48e9d157 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -529,8 +529,9 @@ static int acpm_achan_alloc_cmds(struct acpm_chan *achan)
  * acpm_free_mbox_chans() - free mailbox channels.
  * @acpm:	pointer to driver data.
  */
-static void acpm_free_mbox_chans(struct acpm_info *acpm)
+static void acpm_free_mbox_chans(void *data)
 {
+	struct acpm_info *acpm = data;
 	int i;
 
 	for (i = 0; i < acpm->num_chans; i++)
@@ -558,6 +559,10 @@ static int acpm_channels_init(struct acpm_info *acpm)
 	if (!acpm->chans)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(dev, acpm_free_mbox_chans, acpm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add mbox free action.\n");
+
 	chans_shmem = acpm->sram_base + readl(&shmem->chans);
 
 	for (i = 0; i < acpm->num_chans; i++) {
@@ -579,10 +584,8 @@ static int acpm_channels_init(struct acpm_info *acpm)
 		cl->dev = dev;
 
 		achan->chan = mbox_request_channel(cl, 0);
-		if (IS_ERR(achan->chan)) {
-			acpm_free_mbox_chans(acpm);
+		if (IS_ERR(achan->chan))
 			return PTR_ERR(achan->chan);
-		}
 	}
 
 	return 0;

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog



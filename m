Return-Path: <stable+bounces-241885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFWzBskE8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB17494A54
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694CE30AD4E8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A33FCB0F;
	Wed, 29 Apr 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RObhQBHZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CD3F9F40
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468316; cv=none; b=FFQtxXgfu739PS1mp8CzRMTHiK2aLFZnV/Q8UcpwjEmjJN+SN3PAn98kFB8g7c6PnBzFfQu2l81YbD8J41MX/4C0JIOFCJY/gS1S9U6Y6e3rgPse+vqkhMnaJxzJEMZA0VrLLGoOAxrOgTTxHFHIQHpg/2MGjhZnqdq9/WSRmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468316; c=relaxed/simple;
	bh=VKO+y19Pmg/NLq4w9DyMkKEZ4ajWvhIqJpQfNSp1fww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHUqwUumQ3gEKblLPND3mghJ9UL4YNbTazTn+YvCwRxiqVQnFXpspXEfo78DgEF7qt7cE+ZnuEMtHIDwRkL6JupK0TosdE/LasUKJdwo7lS5KIa1yIubxfY13Bi2fdy0iCwxn165QHaF3q1xGawL0E1cVM5iSJ/B2cJRkR2Ectk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RObhQBHZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d64313c39so9637840f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468313; x=1778073113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGTs6AF8YA/dsJ5X6YrGeOvqR7qYdbsvIoXjGXSTGR4=;
        b=RObhQBHZKGH/M3SfrnL+5KN1fiDASD2bNJ2dZTqUF2mro5nOrbvB0w1EdPeYui4QTW
         42egfXcTEHnpAxQ+R2JJ+nJD/gGVAoYhz8w3BDgLO+R8RqQwjASzQ7iWvZcwtc/G9yUz
         aVReWfn3cmHokNK+fC6aDUZ6ggF2m/jqd94Gvm0vfLt/wxjKS/XnV2kurxHkF75+kPug
         q172prNG1v/RaRVkiofS44GnyPVj04wZLUElkAO72VVvTHljgMg3/8ErS6TkD2fp+XCw
         wTZFmQ15AkSj+/5KvJonRMNL/CzI5xHtHGV+gZ4DPzhWEIegaayYKn11sh/W8pLTd2j0
         yodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468313; x=1778073113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGTs6AF8YA/dsJ5X6YrGeOvqR7qYdbsvIoXjGXSTGR4=;
        b=lpK+F2uPehgLYS258BcT634mjeV0wNgTV5dWHNDngM2n4DcWJ4hoA/QzQkzcm62MaQ
         8oDqFFu8PAriWNhThXwVkSacHpk90GZxLqFgRJeqoejEx+0+3l/BMVM90S52FCGKZHnF
         zcW1PgDpjP/Jp09xnJhSguH9mFEm0rrXs2R9blFUfm5OMwnrWmS5ei3khn4dHSjYya6y
         Q1sdZv2AOesVR8fgGUvxJ9aSn7RZ3oTYsHgOxrqEpjC7oAWsh04i6Fg87ISUbpF20XrX
         UYijkxmx+tYhLByojP7YreZ6f2tP/m6FyOU3Zf7wiPzoBegGA0YXRxSW0lN4ZhcrW1hG
         +I3w==
X-Forwarded-Encrypted: i=1; AFNElJ9ysXcxuX2/xW8PA/ol2G9wqop+7xzm7NJE0hQGhVU0kZvvZ0KF3RkidiKglTR10BSed4nuRPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHGAlu0/jLU6f8SYRjSODmqXQTlEn8vONZI70cbWpCYoX8HGM
	yaI/+N/gSUA9UHc5RHrhnmF2pzdxHSCHgD7aKRSqZf4bmr9wj8ubZprDiFhbK+Ofw/k=
X-Gm-Gg: AeBDietp1X6CIjVAUth7mH8EU9l3e7clwaPeqXBi6fP2BpHkCaSU8F3WbP+dL9NKHim
	rUGUo6bgl6uP2XILdW0YkuYgbbfuCcgSEn8GNtl+PFgsDX4ZeXBFd2XYbNPyaLJEBE0ER4vIqyw
	BimABvBKDdN+fZGTD5nVq4ARkLDLhgxCYSFyn/SsB6MIUor5R6KcvBwBluHbVd0XBhPJIdIxAAQ
	oR9x3QTND8mSXoZ4x0tc8R+cjDrCnHrujzwtD+bA8d6zZmgh/cUFFrKC+/z+oUzLFdpF/z7pscT
	3d0FKCSWsNnrH6Ua7vRFDl7TJ+ZxNLBMoCsoaZ9e2ZzHudYeWKt8SM2Q7H2HLuwS9j3uSbJ7fuo
	7KY2H8kbR+ULw2Pydjw65W5CTu4oMvAzieFyvcfo++ygGFCT/9N9kbM5sXH50Ac63psT80iN4dk
	eejTw8hOilj4q82w+IpvjHp8X6qUPD9zA6HiGlCxyGeUY2Kr3/3LnLBr+HEPSuQ59SLz4a6VsFk
	voiE5yjo0zXugJzNQ==
X-Received: by 2002:a05:6000:2681:b0:441:1ca1:6404 with SMTP id ffacd0b85a97d-4478ee6236amr6849560f8f.18.1777468312985;
        Wed, 29 Apr 2026 06:11:52 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:51 +0000
Subject: [PATCH v3 2/6] firmware: samsung: acpm: Fix mailbox channel leak
 on probe error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-2-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=2353;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=VKO+y19Pmg/NLq4w9DyMkKEZ4ajWvhIqJpQfNSp1fww=;
 b=1gWFaMA3Cd6Dw7QDwhBQgAQ8DdYnx8S5TmxRBEoW9KCayFmX+XpOy0oYB12RXbvUT0DJgo2Xk
 TeJmSkes8lZCIccs94W3mYrZcqMBIsK/nC7MMT+GLZDKIUgxFTnzRhv
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 8CB17494A54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241885-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

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
2.54.0.545.g6539524ca2-goog



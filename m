Return-Path: <stable+bounces-242984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP5AI/9y+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:20:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0974BBA00
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB210303C00B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B338D69D;
	Mon,  4 May 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDs8mYqo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87F3976A0
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889751; cv=none; b=pNpsveVbyjY86+x4Et9bEqAdSAln+W089m0WESceVSE8G93jRRBeS1QhQuXZlxNY7riP9u25FnabPubaqwfhQS6Puqh8fdSJenoHo9mKDPg0HOsWZHYMUO/Kes5zdD3Hvm0hGjtPDNm2VqZ1/iLP2urwO0/7b52OVp5G58Caht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889751; c=relaxed/simple;
	bh=d7vm0U9qdAXbH4NbIyamvNnVpjWmz6WguBCwDQ3CBjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYq3FSZlMD6auRslwfZTPbrM8EvcUOx07NblNm82J9EeN+IKA9IXQV7X+3sO5aNthRpUohsgux4sJfiy8c2Q3sj7P3ZlZluwhbOu0cGOAvgUgjx0mUmiGuhdBj9tg13rBqis1cokYYk/wZ6J78dFNRtjD5wvu2EhjWQD6uiMI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDs8mYqo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449de065cb3so1461571f8f.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889749; x=1778494549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zXNbcb1r2bmykw+LmN/b7BGBlvkjjNT8szr48jA7Sk=;
        b=uDs8mYqoVfAfiUt5oTZH1g887cUggCLw5tQiBMKpDBcP8aM7kWPVuMv0bqv5k6VagF
         ItbPiMgZjKK3DZ4KKjGEtciqpIVcVVEnkHT/u96SMnn0wwRiBKLvGXn5UXh3iKGhCQB4
         uSqSrpTV7jRCKaxCcdV+7iSVuDbSowtPXdYIoxnnSlNFcGnPqdH5UGOaty5ZIW5QBpkd
         F4m+PVQYO1K3f4PrY3xLyGgCtX3in+zxySdlC04vwDwLIWw6RhIUxJ4naK3tzdeqnFz4
         gXah22So9897tHjSrrwxUGq1RG8BaS3XUWGXzvq1jJKEnvEcE76GQzZx4N0oKkOrspot
         b8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889749; x=1778494549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zXNbcb1r2bmykw+LmN/b7BGBlvkjjNT8szr48jA7Sk=;
        b=aud2Za4F9Ol37GRy5RD3mXnGTCAyYnBPY+BresJcVtmFiOflv24VMoLcNhLZqFAn9P
         tV46Hx5mtvO88G8bHUb1KafoKZ2hmoiBF7XspFbhoF+6hAOQUbF/gIt1sYkI8Ecrehut
         i81jXPqHZ8mABET/MgCCy7bsCOl0emmGjeyHEpFfZhqZxhWxkcxXwKfSozZYmvdSAu6U
         71eUIURy4lZIkvVdWrgRuCWBzZm3Ky3L0dKnS6YE36HyJxw7aVWpiix//Xw2Hzu40R4w
         rbqzuBamp9K9dIlTlK1INFuuvuMyi0Vs5WQqYN2NwNiO37Xe6eVEYl0xldp5NErbXjQt
         06Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8vss0biifHORi9zmByxQMY1SYZeVor1iX+b+dau4e1QyajlAeXJHRHHGKEVf1uuseuhoYsdko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZjrxyZ66Mb4fX728DawetKYh26nnHaUapUX8Fj1RlyRZVOnu
	7SMZ7mZjMS0SNTM5tGU4UgiAO36PqK4XeaJ1YjNR/txBlUcpkcufqQ+RcnvRVhF5eIg=
X-Gm-Gg: AeBDietP5pwVhBzesqQm/ttv7bzX2hVuzP+S5tSA45bTk9grwg5bRCZFoHqyF7pfOyh
	b+A64Aej5OefkrBG5+fyBdasCesB4FuuplpOL6Q6lhbCW9pm6nHTtbZXU84u5ZWQDsuIuK3xu4/
	z/ysjkJKrEFN63ZvMySIF3MMd2SgkMTm+/5X0/dXxJyQAtaLvyAhl5ugqtYehio0BDQSJm//Whx
	l3uqCmTNnVkKuj6601YGQ38T4xln9PYcrjifj+OD2On9RZVIKGEhZy4jX0i3skcfWcdOXRGAZ1u
	I9Wz+JaPTzknq29pizYs0Tzt9UouYMc8cnE+SVtnf0tgmsvH5/74APAS1q1iEHmJmjwuQHIKUS8
	wXq9WtuSyjnvrEcp0grHShAjggo/qRQb28xg6XaxXVpyzp8dQCkOC8+HTlUSkyuhWfGDgrJir4i
	x/nACSXDH/+pp+dxsnLM4fmR4JBZ8fV2RHmyvCuLaJRs8xTLwRBZq+o66YoOVqZOKIHwNmLPAD7
	IZMzw/klzjg4WWVsg==
X-Received: by 2002:a05:6000:1a8a:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-44bb6ab21e9mr15653154f8f.31.1777889748670;
        Mon, 04 May 2026 03:15:48 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:48 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 04 May 2026 10:15:45 +0000
Subject: [PATCH v4 2/7] firmware: samsung: acpm: Fix mailbox channel leak
 on probe error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-2-529246be6b2b@linaro.org>
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=2402;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=d7vm0U9qdAXbH4NbIyamvNnVpjWmz6WguBCwDQ3CBjQ=;
 b=0rNQ8Y4iQCyOFXljmUsK4qxlKqz8T5lsKjJdTaI1xueZa/M4bjprLdfeJPxcebI5j9oy37Z3F
 lHwd2yowtI2AHXEbLPaxKxhmQ4iqTdhtr+bGVHVA1ymMWJdqABBvTvX
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: DE0974BBA00
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
	TAGGED_FROM(0.00)[bounces-242984-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 drivers/firmware/samsung/exynos-acpm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e95edc350efa..9766425a44ab 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -527,10 +527,11 @@ static int acpm_achan_alloc_cmds(struct acpm_chan *achan)
 
 /**
  * acpm_free_mbox_chans() - free mailbox channels.
- * @acpm:	pointer to driver data.
+ * @data:	pointer to driver data.
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



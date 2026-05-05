Return-Path: <stable+bounces-244146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBISKKnt+WkLFQMAu9opvQ
	(envelope-from <stable+bounces-244146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204154CE462
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5A7302F72F
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818C478E59;
	Tue,  5 May 2026 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXkWU+aW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FC478E5B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986837; cv=none; b=f+7xLbJ1xN76lG4QRuLfVaD9pp/NTNi1WuE67sKslHKs17PQaFF+F7Xu+ONL+E2fob7Uj0oDzyE3iRfPYBbrNH+FUW/eWgF31ZZ0PSnWnOR4O+VZuJ9ctEETr89BSKuwUvyVvvSgLcz+iUlSHlSQ62QzSzfB5GCNCpn9VGOklS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986837; c=relaxed/simple;
	bh=wZGIg1WvrcZuYhDQpreZS8xozMJIsonW/o4iqtdaJ6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiAwf1NbbSIkOhyNWrg7INJaFvD44FzzKDEnSo6XLTSV50Ak7aoTBuju955AB1miBpJQRxr8hyBHLxqfnrvNcRUCfwTeHqpAyLn65KgmYSIiT0oix8ISjUxt+llFkHCot5XwH9DJhjYbzmuDYmbPcW+DUocUJHULKA1Qq5g3X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXkWU+aW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so50751525e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986834; x=1778591634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AFkvwk1yHFeeDLYag5Oi8EMMsCVOXTu0Co6nMK2/h4=;
        b=XXkWU+aW+daHNNqDIsHjJ3uyxbDzWRwtswENztA6dDymG4WzW+n/ZifxLiG+3t7Qh+
         rIOVZoexAMo2HhZNouA5f8Nn3F+d1gnPzgn3qbEAXkbY4ilKIVjoyWWE32SxVcTualRT
         oRPxQlLKyutDpHkLb8fQBTvG1WDdZi1wyDvBsfwPTNra2XrWK+dilMqBUOU77nZM4XEn
         acBBvoLuIl7uPLkjCnLYX3cy4wEtWHl5xfFr1oWShWsCtXQ4aYStAHI7EPxc6EeFurnA
         0A8PjfiAkyhNRJeIsBfzmhjiGr6bV1dVv9cZkHJ4FDw72bB78gKAUzmCGg2duAvMoYb+
         yY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986834; x=1778591634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AFkvwk1yHFeeDLYag5Oi8EMMsCVOXTu0Co6nMK2/h4=;
        b=qCHAOLLEuIZxdGsoAo9ZjfOO5+ylX41AfcvO6HADqt+gOv8aUOl8MDrPgx0RpHh/f3
         67vvZYl6H16ypF6OLMw9AEuTvnLqxbxEkwzcmbWx4JzBYpeN41iV3R2eUuzqHeOXtn/B
         2W5D8WlprdPxqYTvXoVNu/ueyWU5yZy3HoOCGPYj9qyJ9PIhl7eQISgKuePWdUEcqSAU
         iwYhwfFr0NkWOJanFuZ1EZmkUSMPXArqwbHeSIX5HVCrKF/ZmuDmuGYJ0FeKPo5yHWCS
         koTQBMADJmaBq/jZ+9JirvTJfXmkeqm8hb4HZ6uRAdLn984yN78S8QSxBnyyYtzIWbkO
         2JTA==
X-Forwarded-Encrypted: i=1; AFNElJ+smIOF9sKyumSg+tc3lgPgxx95xPKkpA+wwMVXIYnF85TWC7Lb4yBgkHkUi9j+r6mmTVeO08Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjwRcWjlkNG1MOpdKQKVpGCWarBy/U1/pcFStoTfY4P0fEpEd
	7avyKEYEs3DdKKlRJpQxZE9n9LOWUTcvrH4m4pdOs6HMn/Z21yEWU0jzXzxBn4rLRUg=
X-Gm-Gg: AeBDievDp4S7bNZ1wolATWzr5AkN8KhTScSFBqksGMC0iuBiwysx2U/DwoVxWuSayG6
	KpFz8RwS5c4cOw7Rub1P0nzsRNyWPIKCaWWPMOD7WpLuoWIktHjC8br/NrHSBuDlY+oGyhPEr20
	OiKUsmjKLivDlchpMHsKWGJ0jy2b9TIM3yvzcgWZE1Awp/9ycrjqOXjLoaCbaYxR/n0FoH7PxQM
	mw0NidVzq9E4ylwVpFIwuDdKJeNC+Tlpwn6G2zOvUzY+Hdi8ZDdMT/Ei9CzknYciggZd+5zvtdq
	Yy181XvYNJQtcpmsJj1I/BSbwxwsNoZph1Bsj9FDUao0uvfj6XlAQwOr3R4cwFybD6rnANnfh3V
	MqvLwL/NTpWFbey+cmMGDl+IlbCWbC4pp/UA5rr5lcFgd+AnzgZNPenvaA3PqzG8aZFPB0C0Gld
	npJxw56AAte09XGB3r5p3S0Ww1Nhk0XLRdxHriLJE3La2PYdcYBh3Yw7hKQh76bzEK5zQyudFdb
	svozjBzZjq+oHmfTBrPSeP7efWU
X-Received: by 2002:a05:600c:5296:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-48d17fe008emr47062135e9.0.1777986833570;
        Tue, 05 May 2026 06:13:53 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:53 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:13:01 +0000
Subject: [PATCH v5 4/7] firmware: samsung: acpm: Add memory barrier before
 advancing RX pointer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-4-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=2113;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=wZGIg1WvrcZuYhDQpreZS8xozMJIsonW/o4iqtdaJ6c=;
 b=vzW22Fo9gyaBKn9uKemzB9qhAaJduQL/9Ushx5qlHjwMWCJOJHUz+8hJn8xmalmTzQus8kfYn
 MCGqMwi9nOYByz3EpsQutQNfFuol5X6gMNNK0rl0Glzn7AHBpqYO299
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 204154CE462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244146-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

Sashiko identified a silent data corruption in [1].

In acpm_get_rx(), the driver reads the response payload from SRAM using
__ioread32_copy() and subsequently updates the hardware RX rear pointer
via writel().

On weakly ordered architectures like ARM64, writel() provides a write
memory barrier (wmb()), which strictly orders prior writes against
subsequent writes. However, it does not order prior reads against
subsequent writes. Consequently, the CPU is permitted to reorder the
writel() store to become globally visible before the payload reads
have completed.

If this reordering occurs, the firmware may observe the updated rear
pointer, assume the queue slot is available, and overwrite the SRAM
payload while the kernel is still actively reading from it, leading
to silent data corruption.

Fix this by inserting a full memory barrier (mb()) before the writel()
to guarantee that all payload reads have completed before the hardware
queue pointer is advanced.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad%40linaro.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 9766425a44ab..a9449bc33bd0 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -5,6 +5,7 @@
  * Copyright 2024 Linaro Ltd.
  */
 
+#include <asm/barrier.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bits.h>
@@ -278,6 +279,9 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		i = (i + 1) % achan->qlen;
 	} while (i != rx_front);
 
+	/* Ensure all payload reads complete before advancing the rear pointer */
+	mb();
+
 	/* We saved all responses, mark RX empty. */
 	writel(rx_front, achan->rx.rear);
 

-- 
2.54.0.545.g6539524ca2-goog



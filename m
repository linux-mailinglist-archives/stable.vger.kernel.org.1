Return-Path: <stable+bounces-241888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABjvFhcF8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172E494AC1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0826430DE923
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A33FCB11;
	Wed, 29 Apr 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k374Qs6F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11253FBED9
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468319; cv=none; b=uHXmL+HmZYPosCcaOQ7BS9P0SpUaAYgayEij/UQu4ofuACySn7MI7FhfJA+YktQDGrO1+rXUwC3v/iKBW3KSpuxn+I9gajoiUyEvMoDchhnc1wtRokpi57xgS2VY1OjC+aXJQSidfiFHfZ/74WpNRjvDYws0+eAc3jxV9tFjLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468319; c=relaxed/simple;
	bh=icbMfRdCY++qMwHt3NVqCYtxBBVHdcrDPMwKwp8NvrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0x/bOt7Uez9v7uYy2qV02ff7IoG/I3Baby5180/biN5IY5N/YTX2xybbjCGCzI6X68ATm4L3iE6E6QV+Rx6qgkX5nT19jUQqLwsgaNYqIjlLT+VeypA1Mte6oQk3EIhj0Ws2kLFpXTTL37WrwTNk/1miIaud6L/3zhKY5JdF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k374Qs6F; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-448528f4e69so307375f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468315; x=1778073115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHZhPl6Ww9luKOTLTqFrUaU4l6PHixrZT0EheMjlh0M=;
        b=k374Qs6FEGM9zmGAzuRFjS+liWljA2doi0MFqkp34y5WtHnTWC1Lo5VJbZ4XdLmRgY
         QDm0h2PUuccnc6qiBJ191TtjUjMZNoz4p6S0/jTtYA6E0okbt9EyBl/WgSpbYKHQUUU7
         +ac7OO+rDGa3iWqL4p+xe638mOpL6gPJr9uwgfrhW0Sd57AvF6QhTBUtIoysWtoW7OVv
         GA/HAf2udXZDDtcwaMAK++rvYv1BdLHGhb93UgZIr73N3OvpPr9SD+KihF4FLxzh/W1+
         LHfX35tb1pwp4rGNKVBbzurWHn+WTykK1zNYbvFp1tjcCUd/N3vxhs7rYxRJUuHbKqzn
         blMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468315; x=1778073115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHZhPl6Ww9luKOTLTqFrUaU4l6PHixrZT0EheMjlh0M=;
        b=bQz/Ak0aSdvD/27Bz80sPw4iQ3T8fJHqWuILxaX3OoFCT7Pomv1mwvvhdlCmi1/pew
         nE+x1F/idHSrR4DJ4XJxQpVmeCSy61V9/At3OtUlD1R+ztFAy+fqsRLwGgaBmmmHzVih
         r31QGFY67T2GjJ3rGww5uKM98Q0azClNJFlwVPZImS+i+hhaJ8HKAj+fqMKWj3ghxCYY
         7pdbUPRKyilyZSI0gbyAfTG5nmINXelyEb8EoBsSjpH7OFYN8OTg5s3/8CO5KL2Wndwv
         fMmYw2zbNZ9t4qobxH9AYwB9X/tZYrzHH1vnP3cMX0YrBmN9qNY/HEenCVFR3qwY2p7h
         HIww==
X-Forwarded-Encrypted: i=1; AFNElJ+UW76nfkyhzJOKDUkkDHmvbDvnez8j+I2pDscfeEyT2Wmp6ICLnz/3FUClVm8HbcGnPPwyTd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQWKATy8A05/c6LzMCt/nWw3eT/fVyH8fXAgCQ5HU48RP0tZl
	vUaOzPHnONtsvc1bsF2bUUN647m1oTb6hwsHrYeQ9f8S7wMvIcn5RGv5USz/TFIbmWI=
X-Gm-Gg: AeBDiesyZMQT8FWU38x0hYdPfbMcLcTMfJs5Glg8WFC8t1+phvDhL7xKB/D4jQWdvnV
	E4JBfIssjYCDTwVAaLYGmadOioq+LvgIhX8E8qVi/xxMwCdj1NJI5LivcxfbhC3qZ8CpEsYHtBW
	kcIcV2JGUlB1lJEw9jVb3A+6EcUPugKefqHhN/e8DRaqFDx4QPrr2uxoPmueeK6dWxG1XUwXm2T
	d5OQdRbbTX02T0Rn+Nxr28ZQOsFANyNttggKVYsOOpgOI3ZSIxcnN5rMfTiaLYeqXHxIJS37+XS
	CidNLnet9jF40UYIB+w53zQivYQOCdPPC0EPqFW02mEcoJtwiLfEuKBybOpTneC8CD1jNb0f54I
	DAxpdXjvLmaDV3Q2UxIxaHL8ruTE5KKyN08pfe0n8AZIgjrFB7OtPuoddyHANPZhR9hpNPLH3PV
	646Aubu69wYcha2MaIXP4EenE3t2VOOp4cBoDUsIJSpPwDADB7rkHM4yn/2WdcnplKJXN5K9I5l
	4AdVFwSWG7o7XpK5A==
X-Received: by 2002:a05:6000:40cb:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-44647dcf63fmr14140392f8f.13.1777468315079;
        Wed, 29 Apr 2026 06:11:55 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:54 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:54 +0000
Subject: [PATCH v3 5/6] firmware: samsung: acpm: Fix infinite loop on
 sequence number exhaustion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-5-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=3628;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=icbMfRdCY++qMwHt3NVqCYtxBBVHdcrDPMwKwp8NvrY=;
 b=UCDCLiY5Dim90lCTsvySxGERU+EK7a5cZdW8VdrNdJKi6eaVx8FFW563ZHPo2gPXZsudXtv5X
 pxkQW8MG2VsDOsA1JB+fwd9hF3nzSSKENx8TQukhXM5W9K2e0mMwZbQ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 7172E494AC1
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
	TAGGED_FROM(0.00)[bounces-241888-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]

Sashiko identified a possible infinite loop [1].

ACPM IPC sequence numbers are tracked via a 64-bit bitmap. Previously,
acpm_prepare_xfer() used a do...while loop to search for a free
sequence number.

If all 63 available sequence numbers are leaked due to transient
hardware timeouts or mailbox failures, the bitmap becomes full.
The next call to acpm_prepare_xfer() would enter an infinite loop.

Fix this by utilizing the kernel's optimized bitmap search functions
(find_next_zero_bit / find_first_zero_bit). If the pool is completely
exhausted, log the failure and return -EBUSY to allow the kernel to
fail gracefully instead of hanging.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e4d8d1120192..b8a4978b091b 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -12,6 +12,7 @@
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/find.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -370,29 +371,40 @@ static int acpm_wait_for_queue_slots(struct acpm_chan *achan, u32 next_tx_front)
  * TX queue.
  * @achan:	ACPM channel info.
  * @xfer:	reference to the transfer being prepared.
+ *
+ * Return: 0 on success, -EBUSY if the sequence number pool is exhausted.
  */
-static void acpm_prepare_xfer(struct acpm_chan *achan,
-			      const struct acpm_xfer *xfer)
+static int acpm_prepare_xfer(struct acpm_chan *achan,
+			     const struct acpm_xfer *xfer)
 {
 	struct acpm_rx_data *rx_data;
 	u32 *txd = (u32 *)xfer->txd;
+	unsigned long size = ACPM_SEQNUM_MAX - 1;
+	unsigned long bit;
+
+	bit = find_next_zero_bit(achan->bitmap_seqnum, size, achan->seqnum);
+	if (bit >= size) {
+		bit = find_first_zero_bit(achan->bitmap_seqnum, size);
+		if (bit >= size) {
+			dev_err_ratelimited(achan->acpm->dev,
+					    "ACPM sequence number pool exhausted\n");
+			return -EBUSY;
+		}
+	}
 
-	/* Prevent chan->seqnum from being re-used */
-	do {
-		if (++achan->seqnum == ACPM_SEQNUM_MAX)
-			achan->seqnum = 1;
-	} while (test_bit(achan->seqnum - 1, achan->bitmap_seqnum));
+	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	achan->seqnum = bit + 1;
+	set_bit(bit, achan->bitmap_seqnum);
 
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
 	/* Clear data for upcoming responses */
-	rx_data = &achan->rx_data[achan->seqnum - 1];
+	rx_data = &achan->rx_data[bit];
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
 
-	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
-	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);
+	return 0;
 }
 
 /**
@@ -460,7 +472,9 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 		if (ret)
 			return ret;
 
-		acpm_prepare_xfer(achan, xfer);
+		ret = acpm_prepare_xfer(achan, xfer);
+		if (ret)
+			return ret;
 
 		/* Write TX command. */
 		__iowrite32_copy(achan->tx.base + achan->mlen * tx_front,

-- 
2.54.0.545.g6539524ca2-goog



Return-Path: <stable+bounces-244150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLjECAXu+WlqFQMAu9opvQ
	(envelope-from <stable+bounces-244150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:17:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900094CE50A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9BF308B782
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE747DD60;
	Tue,  5 May 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0Yf3+hw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5347CC9B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986842; cv=none; b=JXnMEk0WRh/eqrVrXEaJaAQH2XIkJjn8VXYeen5b0KsRh3LwqaDCLoCLVa2ezG/kZJeFg2d8xT6pVCHaSRi61BPYSmxirtrswATxNVWawcG7zMO2B9Uq1O1nNhFubWgybgpT+8Yqda+eIMj8hpFO5bRIngPFQC22r14QwMmVBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986842; c=relaxed/simple;
	bh=EiurrGkcahcx7sI65l5a7ioyNgZJtrM8vsswXoseAMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6TAeYW0DajlGKA9Wacbz0lglnFzSgFIw8Bnw7ntVXjJ7heN4f+1rhuatLzziAYLcfkBJyY3TFGOanXuWfnteWjWnC64aL3/vRRk/Yx6hvDUK8gs1CTyZ5EgIzkmwUPC/PmVO9mYE/sODrM48tZPViB0m9dM/9CffxOSYP3d6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0Yf3+hw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso44323235e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986835; x=1778591635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q59EG8r8mRnPm4MFGBHxIdCjMVDqVdWUq04J9T41SAY=;
        b=q0Yf3+hwWa6y0jOO57CFZ2Mz7J9hOJmUHQR6qoz+3LhofbrEaO4f9GiVxghIXrscGq
         fd7HU2P68kzb/g5gM9jKrpC6qEoM4oSDT7yTE+70PGn+2HpOKfn38IOqC4/qZXn0eGZa
         BdV5io+z6hpvT5QtDdamVjC3ZDDxwiAy7yGw1rBJe/RWbJ717Upk11HJvBIkxz5IMAF5
         mTMdYrFsRpM044K7tMszeeNV7oh84dCROlfaT4W4R7EI75vBk6R1Qlv7ntASjm8Atlpp
         urC+EIXLSuq3lsCjKn5lqyvrwRZiY8jcPYVDGwyHw9NvGoPWOGDeHZhdqipMBzZd90Bj
         8Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986835; x=1778591635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q59EG8r8mRnPm4MFGBHxIdCjMVDqVdWUq04J9T41SAY=;
        b=ej7XX/OGa7pxRVEs8oGgXBYawce1fzG1dNrAzkWuYLRrj8NWiHq6BIEBpW0kYX+TdC
         TWJmAyZJVDKJAFXeuZFuFqAviLwlLs9JvLULs1v6XLx+z6G5pNF+yU3Op6vi2JCeUAyU
         ar8YsDGf8yhImKUbllazEvtYX2oFL4wxsnVQi2BcRjuaVJahP+J0hZCNQnn8U00MDmdM
         uc01EJZ2+SML8CbySd2/ZjURB5lSYqM3byxrF0V8gJkIGgRby7Q2m9/42WjV5XnEtVxa
         8Gt9XgCu2yMYUGBUMKt9HeMhxeYpZ9+B2ulic3k1hXmL7nYam1lSuXA3V6d/U0ihvRII
         ZqeA==
X-Forwarded-Encrypted: i=1; AFNElJ8vcHwa2AEhR3aFiMIgwinqfBuUFiQObj7n1URQZiOHYCs1Y0fJ/9m81+h993pmURsSHb68L34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/BJRA4veYqaUG+IIBRg80koOdwxSnPbznTIEmZvL0icjBpaP
	6qCIK0QQpxpQuAbwL7mIevM7rN7pIVUTsbfpEXQ3v0KonKOm/Zoi12lmbeZCYwcSFk0=
X-Gm-Gg: AeBDietQVM1bZweCAiTTi4fuAcDiNKuLWK9+oRj7FrnVxQRU4Kgde0x+H+Yz5k4vxeB
	KinGlJ02o/3DUYopeZB9JQIJPwyuo34tuZTsbfcXwSP+kBa6XiGYdK9skhhIMjjTIhAmhUd7SdM
	H1HKRYtka4DZyDec92CnRzc+sn1mRTqDlFqiNVBAHeYe0WR4pPpFdhHFTPk1Y68Gf1sMKQC5Bn2
	7E3aqfSFiqv6fHImGGqVz4QZS0pdXo44LtKgVdD87rcOee8iEC5dCA1YFOcs0nYqXH8ypkUatRC
	FLjDGck3sxXf1nD9snf6EhuLw6Mkr80pF5EBy24KQqq3MLRi57MRvc6YORQNM/3wy7aR0wndhbE
	I0/W/EzylNhZZE23zQobmU4e+LCSKjsrzSF5f3dHBeO3Sxz7KqV9/ePxFA8FqRO7CY0tfog8OGi
	B3r9HTl4+J4+T+XExSpfemP2bTuRD0XPw3Y+v3oHGP/unbpnkYNI/Lfg7pNpFJsozl0amvDX6O4
	MSX7cdasWBENEtr+Q==
X-Received: by 2002:a05:600c:859a:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48d188d4786mr36585875e9.11.1777986835218;
        Tue, 05 May 2026 06:13:55 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:54 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:13:04 +0000
Subject: [PATCH v5 7/7] firmware: samsung: acpm: Fix infinite loop on
 sequence number exhaustion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-7-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=4772;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=EiurrGkcahcx7sI65l5a7ioyNgZJtrM8vsswXoseAMM=;
 b=sGgiYQ0Fj7h0fIetimStE6LYB8Eka6DrbBPLMswMbcYUjNNUFgRR3HOJv91qVm6vem/Uz2Haf
 s2y+X1fAmfYAg6+Az1ciaJJlGHJlRB+5Ax/53p9VNTk8SnnbcnIuAmF
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 900094CE50A
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
	TAGGED_FROM(0.00)[bounces-244150-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

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

Furthermore, drop the allocation loop entirely. Because
acpm_prepare_xfer() is strictly called under the 'tx_lock' mutex,
sequence number allocations are perfectly serialized. If
find_next_zero_bit() locates a free bit, a single
test_and_set_bit_lock() is mathematically guaranteed to succeed.

To enforce this locking invariant, wrap the allocation in a
WARN_ON_ONCE. If the atomic set fails, it indicates the driver's
mutex serialization is fundamentally broken. The warning generates a
stack trace for debugging, while returning -EIO immediately aborts the
transfer to prevent silent payload corruption.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 45 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index fd2e46e9f7e9..a2cac913b2bd 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -13,6 +13,7 @@
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/find.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -394,34 +395,48 @@ static int acpm_wait_for_queue_slots(struct acpm_chan *achan, u32 next_tx_front)
  * TX queue.
  * @achan:	ACPM channel info.
  * @xfer:	reference to the transfer being prepared.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static void acpm_prepare_xfer(struct acpm_chan *achan,
-			      const struct acpm_xfer *xfer)
+static int acpm_prepare_xfer(struct acpm_chan *achan,
+			     const struct acpm_xfer *xfer)
 {
 	struct acpm_rx_data *rx_data;
 	u32 *txd = (u32 *)xfer->txd;
+	unsigned long size = ACPM_SEQNUM_MAX - 1;
+	unsigned long bit = achan->seqnum;
+
+	bit = find_next_zero_bit(achan->bitmap_seqnum, size, bit);
+	if (bit >= size) {
+		bit = find_first_zero_bit(achan->bitmap_seqnum, size);
+		if (bit >= size) {
+			dev_err_ratelimited(achan->acpm->dev,
+					    "ACPM sequence number pool exhausted\n");
+			return -EBUSY;
+		}
+	}
 
 	/*
-	 * Prevent chan->seqnum from being re-used.
-	 * test_and_set_bit_lock() provides formal LKMM Acquire semantics.
-	 * It pairs with the RX thread's clear_bit_unlock() to ensure the CPU
-	 * does not speculatively execute the rx_data buffer wipe (memset)
-	 * before the sequence number is safely claimed.
+	 * Execute the atomic set to formally claim the bit and establish
+	 * LKMM Acquire semantics against the RX thread's clear_bit_unlock().
+	 * A loop is unnecessary because allocations are strictly serialized
+	 * by tx_lock.
 	 */
-	do {
-		if (++achan->seqnum == ACPM_SEQNUM_MAX)
-			achan->seqnum = 1;
-		/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
-	} while (test_and_set_bit_lock(achan->seqnum - 1, achan->bitmap_seqnum));
+	if (WARN_ON_ONCE(test_and_set_bit_lock(bit, achan->bitmap_seqnum)))
+		return -EIO;
 
+	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	achan->seqnum = bit + 1;
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
 	/* Clear data for upcoming responses */
-	rx_data = &achan->rx_data[achan->seqnum - 1];
+	rx_data = &achan->rx_data[bit];
 	rx_data->completed = false;
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
+
+	return 0;
 }
 
 /**
@@ -481,7 +496,9 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
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



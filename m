Return-Path: <stable+bounces-244148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NolL8vt+WlqFQMAu9opvQ
	(envelope-from <stable+bounces-244148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB224CE496
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E7630607DD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5DC47CC84;
	Tue,  5 May 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOvstt5I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC16423A62
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986840; cv=none; b=H99F745bO4xEnCQ0B7DZe2erMnfOTH2kmLNDh/cn8Wi8TFanyiIKhv8+dO83eHGGdM0OE4/2GxLkT0Ip1OjgleZe3BOKgWnIOgAiwOUz+GMbn/lPB9ZWuwHSzY5MSNUo9sDKWee/4vAq3hntPOZ/PRa9+3Qvl9h9PbU5BXuaen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986840; c=relaxed/simple;
	bh=y3CzFzYBC79FHo60Bgq3OAMyWY2i8lL9XzUZoMqVK/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQicfCHRCz8EWLdOJ/x8wyR879CSEBaWnLbqJunPm6htRsvWFSVP9b2UQiqYo/8NJPADTKyzrbebn7nQG8KggLLc8s8ITtiuZjSckzOyBo/i9zdoAZsM7+rQukI9PGPJieC0J+EGgxtkyB38eIISdaZ1R0Mf6bmruowMF/IP22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOvstt5I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48909558b3aso57361175e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986834; x=1778591634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+MxyFx7bMkGaeeMjkJNvF3dfsBwvJKWr4lu6sjRpo=;
        b=OOvstt5I++shryBnY4nSxXOj668i27YIEMsAPeKjy4AlhSzIUQDJ1XJy+MD84hyMUM
         w4Sn5VySnZbibX0bbinj5xdXaBQqD+BCgIXp1nx9olNY3cV46HbR/CCA+g6l1xsoZYEX
         F1D5aErWk/WqsNKMe9QcNDYNhqVkXuPKnR/3fW69GfPhl8hVAMBHYPLWI4cmiBZMHWE1
         HMzzrUGncHxCnnK+KRxHhYqXzV8YBTi4AIoJfPJwCe6zoXuwXDbYAXpuvl13MebMhOzK
         yu58Zx7clIF0MHQxZSxBbRWWGK4KABxZhe7zJmSjz7iMuylC6V9EfVyNmR1ThTP0hJMz
         +qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986834; x=1778591634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pr+MxyFx7bMkGaeeMjkJNvF3dfsBwvJKWr4lu6sjRpo=;
        b=p7rnbXVDhRV/8MHyhWI/EZ5eyjo9p9fiMto7nv+ggNjlj8ZX0A7LypJUR4b9BoStis
         W1mtNJECW5O5r6q3w401xTyUfv33IkQ7Msmm8Q4DM5yUaQbKjhYDd22+pyoJfiir511O
         Uj2MOFvvyuDXHvSgZAaCE4gjTFLJbMveK/vB6bbDm6RTwU6IKjIHEVEIjS2V9kN2QC2n
         UZCKNbw2nm70rodkzoMDuWRfv5CZjTU+VMOFFiTpC5S8thc+G8URoIBCGpIyPkcLIfDV
         rtMQB6tobL5A1b1YtsPWY+5k9uux4rBzUZA/TDz5KhygLQQqOwI919YJTG3mf8kmM/dj
         ReDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8A6qY72pEHzrESWlJ21IHc1eVf7fYGUNKM+otxJzdlipoUvXk9/sB5GsvlDZ97OXeMYVPkrvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Pd4qgHse0LpfoTyh0DPqKPr4XN/cOLyDX1q+eA0WiZANghpI
	Ood4SNdfBcvLBNtWReUbSP/fQYwA6IO0nakYQ1193jU8ZQHwmp9NInlnh2ChY65WB9E=
X-Gm-Gg: AeBDiet/lu3P2bYxEEyMeGOXv+LOfzelxkXzXeQfGpuMmnBLD9F8DMshf7qybRJbV7A
	PxS53K8vAJG3jtWg8uVG93F9erWqlYWw5pExG3xLhED3gkLEmgYs9u5TxI+Fv/aVrlwUWZUar6t
	WY7WIeDJDZeylNKItDGR9VQxW4sqob3ZnL+R3ZJWKv/pRsde5TmTzv2ZOMZV/GNpxfMAo7QZpPv
	34qIAAEK+ija37Gu+ita55teST9B0lkplV48lQqt3HZ7PUbiZa1r6hnkhZgBtDaYbDZMPy1l9K+
	wnaybZ5/wbg1pxr9uFlNUTe6JM2AXQRyXY1JMAwPXlS3plS+NzaXyQUiXI+noWMcQuieGRAGr+R
	pM/AeBN/eL69uMSfMWmHqPf7w3hykBEIOOABhjmMuCmMBp4mVTjIyxwOKLVraZNUlFoiCggtWq4
	lfXhR8vylFjJuE3LzN+n16afmZhZRvT9tYoSd6h/WnJt3VsFXScVtdNW27zHLFjQ79WV0dXkt1V
	HeAsfAa2VY37ZeGIRPXtz5I/TLo
X-Received: by 2002:a05:600c:42d5:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48d0c0a38e7mr74267125e9.3.1777986834145;
        Tue, 05 May 2026 06:13:54 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:53 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:13:02 +0000
Subject: [PATCH v5 5/7] firmware: samsung: acpm: Fix false timeouts and
 Use-After-Free in polling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-5-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=8240;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=y3CzFzYBC79FHo60Bgq3OAMyWY2i8lL9XzUZoMqVK/U=;
 b=PEYKzv2ZhBQp/FxhrFEHzZLE4K2AoV5DdiBbO1toNYl3zeHv+9j10qVqVimuouZYidiSb6fz9
 t8l+thgFTWRAD4tryh4vFbkUaSH2Mq7ngIppD+z3HyTjP0ZT+2U/JPM
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 3AB224CE496
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
	TAGGED_FROM(0.00)[bounces-244148-lists,stable=lfdr.de];
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

Sashiko identified severe races in the polling state machine [1].

In the ACPM driver's polling mode, threads waited for responses by
monitoring the globally shared 'bitmap_seqnum'. This caused false
timeouts because if a thread processed its response and freed the
sequence number, a concurrent TX thread could immediately reallocate
it before the polling thread woke up.

Additionally, the driver suffered from a cross-thread Use-After-Free
(UAF) preemption race. Previously, acpm_get_rx() cleared the sequence
number of whichever RX message it drained from the hardware queue. This
meant Thread A could globally free Thread B's sequence slot while
Thread B was asleep. A new Thread C could then steal the slot,
overwrite the buffer, and leave Thread B to wake up to corrupted state
or a timeout.

Fix this by rewriting the polling state machine:
1. Decouple polling from the global allocator by introducing a per-slot
   'completed' flag, synchronized via smp_store_release() and
   smp_load_acquire().
2. Strip acpm_get_saved_rx() out of acpm_get_rx() to make it a pure
   queue-draining function. Introduce a 'native_match' boolean argument
   which evaluates to true only if the thread natively processed its
   own sequence number during the call. This explicitly informs the
   polling loop whether it must retrieve its payload from the
   cross-thread cache.
3. Centralize the cache fallback and sequence number free (clear_bit)
   inside the polling loop. Crucially, the free operation now strictly
   targets the thread's own TX sequence number (xfer->txd[0]), rather
   than the drained RX sequence number. This enforces strict ownership:
   a thread only ever frees its own allocated sequence slot, and only
   at the exact moment it completes its poll, eliminating the UAF
   window.

Furthermore, explicitly guard the 'native_match' assignment with an
if (rx_seqnum == tx_seqnum) check, even for zero-length (no payload)
responses. While an unguarded assignment wouldn't crash (because the
cache fallback acpm_get_saved_rx() safely returns early on zero-length
transfers) doing so would "lie" to the state machine. If a thread
drained the queue and found another thread's zero-length message,
setting native_match = true would falsely convince the polling loop
that it natively handled its own response. Maintaining a rigorous state
machine requires that native_match is only set when a thread explicitly
processes its own sequence number.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 68 ++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a9449bc33bd0..2dea9b7bfe91 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -106,11 +106,14 @@ struct acpm_queue {
  * @cmd:	pointer to where the data shall be saved.
  * @n_cmd:	number of 32-bit commands.
  * @rxcnt:	expected length of the response in 32-bit words.
+ * @completed:	flag indicating if the firmware response has been fully
+ *		processed.
  */
 struct acpm_rx_data {
 	u32 *cmd;
 	size_t n_cmd;
 	size_t rxcnt;
+	bool completed;
 };
 
 #define ACPM_SEQNUM_MAX    64
@@ -205,26 +208,28 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
 
-	if (rx_seqnum == tx_seqnum) {
+	if (rx_seqnum == tx_seqnum)
 		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
-		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
-	}
 }
 
 /**
  * acpm_get_rx() - get response from RX queue.
  * @achan:	ACPM channel info.
  * @xfer:	reference to the transfer to get response for.
+ * @native_match: pointer to a boolean set to true if the thread natively
+ *                processed its own sequence number during this call.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
+static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer,
+		       bool *native_match)
 {
 	u32 rx_front, rx_seqnum, tx_seqnum, seqnum;
 	const void __iomem *base, *addr;
 	struct acpm_rx_data *rx_data;
 	u32 i, val, mlen;
-	bool rx_set = false;
+
+	*native_match = false;
 
 	guard(mutex)(&achan->rx_lock);
 
@@ -233,10 +238,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 
 	tx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
 
-	if (i == rx_front) {
-		acpm_get_saved_rx(achan, xfer, tx_seqnum);
+	if (i == rx_front)
 		return 0;
-	}
 
 	base = achan->rx.base;
 	mlen = achan->mlen;
@@ -260,8 +263,13 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		if (rx_data->rxcnt) {
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
-				rx_set = true;
-				clear_bit(seqnum, achan->bitmap_seqnum);
+				/*
+				 * Signal completion to the polling thread.
+				 * Pairs with smp_load_acquire() in polling
+				 * loop.
+				 */
+				smp_store_release(&rx_data->completed, true);
+				*native_match = true;
 			} else {
 				/*
 				 * The RX data corresponds to another request.
@@ -271,9 +279,21 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 */
 				__ioread32_copy(rx_data->cmd, addr,
 						rx_data->rxcnt);
+				/*
+				 * Signal completion to the polling thread.
+				 * Pairs with smp_load_acquire() in polling
+				 * loop.
+				 */
+				smp_store_release(&rx_data->completed, true);
 			}
 		} else {
-			clear_bit(seqnum, achan->bitmap_seqnum);
+			/*
+			 * Signal completion to the polling thread.
+			 * Pairs with smp_load_acquire() in polling loop.
+			 */
+			smp_store_release(&rx_data->completed, true);
+			if (rx_seqnum == tx_seqnum)
+				*native_match = true;
 		}
 
 		i = (i + 1) % achan->qlen;
@@ -285,13 +305,6 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	/* We saved all responses, mark RX empty. */
 	writel(rx_front, achan->rx.rear);
 
-	/*
-	 * If the response was not in this iteration of the queue, check if the
-	 * RX data was previously saved.
-	 */
-	if (!rx_set)
-		acpm_get_saved_rx(achan, xfer, tx_seqnum);
-
 	return 0;
 }
 
@@ -306,6 +319,7 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 				   const struct acpm_xfer *xfer)
 {
 	struct device *dev = achan->acpm->dev;
+	bool native_match;
 	ktime_t timeout;
 	u32 seqnum;
 	int ret;
@@ -314,12 +328,25 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 
 	timeout = ktime_add_us(ktime_get(), ACPM_POLL_TIMEOUT_US);
 	do {
-		ret = acpm_get_rx(achan, xfer);
+		ret = acpm_get_rx(achan, xfer, &native_match);
 		if (ret)
 			return ret;
 
-		if (!test_bit(seqnum - 1, achan->bitmap_seqnum))
+		/*
+		 * Safely check if our specific transaction has been processed.
+		 * smp_load_acquire prevents the CPU from speculatively
+		 * executing subsequent instructions before the transaction is
+		 * synchronized.
+		 */
+		if (smp_load_acquire(&achan->rx_data[seqnum - 1].completed)) {
+			/* Retrieve payload if another thread cached it for us */
+			if (!native_match)
+				acpm_get_saved_rx(achan, xfer, seqnum);
+
+			/* Relinquish ownership of the sequence slot */
+			clear_bit(seqnum - 1, achan->bitmap_seqnum);
 			return 0;
+		}
 
 		/* Determined experimentally. */
 		udelay(20);
@@ -384,6 +411,7 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
+	rx_data->completed = false;
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;

-- 
2.54.0.545.g6539524ca2-goog



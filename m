Return-Path: <stable+bounces-242988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIP5Fwhy+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A524BB93A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216D1301F498
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E739E171;
	Mon,  4 May 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4nCdkCH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4939A809
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889754; cv=none; b=fmoZyGoP5olaSbhxDfla1nyqDZeIag5D4ZfLuNS77BsaOqXm+CUeM3L4u3OJd2TbXM4EhdFdRFCmDfQmB+dCv/A7bQHKsVs2PBt9u6lX5LJWC3Csc8PVTQoOw3J2wt3aoTWML+SGkUhsj6UXgd2uHZ1EAPSA81noDIXdZMuhxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889754; c=relaxed/simple;
	bh=tcFrmEcYu2tzuwg42FiZIub27Jmrw6YPYJg6B/kafic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1yIFSvYTQmJJ41NORVa+7NE67eZhVKdZt9ptOcsqBl6Fk6TeFuyUBfOLw9cehJgKT2yaCdNvTBXqlNHTWWnuLb5dVmpz7VZ5ud5s9h99ua3TiP7xgDoZoJm5sZbGCwa2xU1lYyODpjxZAxoa3QjSkhhhgcCt1fb4Ew1WOTUAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4nCdkCH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso28253325e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889750; x=1778494550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeMW31xh2IrRZGJdOFJPgh5TF/3iY7D9q0BMKHUqLFA=;
        b=L4nCdkCHEkKnnSoaNFynUCHf8bKZgoyV5BGM50zZV1uRdyJNP1kCsQqaoXoXISyzaO
         GKcmdpGcydYeiIWJcceoSCJjv6tvs/0Uel8QK/ZJk2PoaFhFwW1o3H2pP2mEI8GogqkG
         pPdus302M1aqCLfN2aJ2hkkPAg4j4KV30oXi1uCjACiSZQNgx9TqfTniMHcIf+9+KpEg
         TfMw7zUoBya6PgX762QH56ta43VPXVjBOFzun1YjB8xFLLJVlOpYOzlgdmLT9iKaXojl
         dRBu1DwusTe7/D/LWPr8xD19R5l09mtiaigespV1KnGNgykwCHg9BNv2zlcQB9htHTXt
         GYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889750; x=1778494550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yeMW31xh2IrRZGJdOFJPgh5TF/3iY7D9q0BMKHUqLFA=;
        b=C1St17hAu2w0ndRvQUrUxRfTxZifhZIiQeX3XJes0oHLqJA0UpfICq2N4j9Gmpy3NA
         uRqvz8ZKieEOyTHlqifftR8HIUn/dxnfcJIRbBY8iKd3bHjw84DvThi9V9DsCJp3ahKC
         IBKVlY7oiVZIxatSxvnoPVDWFJbzGaHNmAs7I6r2ray0S/9YlEkW2HJhCgne6lHGdil5
         77lZw/a6VkHZMYvjWQvkbVswSZOWYr4Ko1EC/gxcqcaFj+9z56+q/AUziD2Uu9Kc5K3f
         gQbldnBxHG8ywp5yXnSoANZlIFgNVy8ulv+TXpLY9DolNFXYWeFabaevUQsH+FGmodt/
         u12g==
X-Forwarded-Encrypted: i=1; AFNElJ/gH53fR4+6Ojw5bdZQ02Erk0n0undut4zKi2X+5EBFTUYUf4Flu+r3crEH1mB5EroUMOjne20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QltuRXAkvcerd5gsR6WHYC6ow6Ufs1yz/psboIQwz3AXQL6Z
	NkiUEoXWvxjYlVpw3KCQQTPjquNDzVvRzqLBVE1Y/qgfJ/uERfmKc5eXt0CHcqvzAt4=
X-Gm-Gg: AeBDieuvA+VT0HNB4OUFwwdVP+DoclY8gPKSHao5x7cPRijUfa46e0b/N6xppkpfqk7
	TEgmWL2TKBoWtUSuxEqUNxrysjj9zP0cAMACtOdEUxwxiN+KNFaKDx4Rv9plqpwiQFcfhJbDxkx
	PhM8UOzkivZXFhY7K6vucMkC9xoVPtAHaJIOTQDN4KlQvOjGOVOeKD8JtOJDE74DO3IcHF0e8Al
	Oo2PCiMzBN6uHPEP+9gl/nuM8CkRpI/dwXHqAHW3GpqJkxM4nX+3U6c4zw0aUHx2N2siY8CK+10
	35re0FNiN+2HpbgAOXwXnO/pjA87kZH1R9ykWLHadKjtqT7VvMVhN3d51cco1EXD9QnNgQZN3M1
	h6pIRS5HQg8jdJ1jFCmPrmHSsqEyI/BLT5Lk740/vpUz+zYgBTlNpIJiLeMnts7p8lmVyLqEDyB
	Uto1cMB8Ah7/uhJQxFV6l+sK+HDKQNESPR/Izzzpo49hLth5fk3mf+qfq7OcoiSLRDBxvmn49y3
	Qp/W7i5RDAzM27CqQ==
X-Received: by 2002:a05:600c:4450:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48a98874d1emr142393595e9.12.1777889750219;
        Mon, 04 May 2026 03:15:50 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:49 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 04 May 2026 10:15:48 +0000
Subject: [PATCH v4 5/7] firmware: samsung: acpm: Fix false timeouts in
 polling path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-5-529246be6b2b@linaro.org>
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=3926;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=tcFrmEcYu2tzuwg42FiZIub27Jmrw6YPYJg6B/kafic=;
 b=byoTnQZ9OiajgkE1qADTMGG6v0P5Fdr56zuMUYOg3Q5Dhm6jmJ3RlDch4Q8PEZoRRi3hYRceW
 mdaoebfXMCoDO432C7dm4UjTiQdSX8QI2aM9laroHWs4R/gnxYG+MEt
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 12A524BB93A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242988-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

Sashiko identified the bug in [1].

In the ACPM driver's polling mode, the polling thread waits for a
response by monitoring the globally shared 'bitmap_seqnum' using
test_bit().

This creates a severe bit-reuse race condition. If the RX thread
successfully processes the response and frees the sequence number,
a concurrent TX thread can immediately reallocate that same sequence
number and set the bit back to 1. The original polling thread will
wake up from its udelay, observe the bit is 1, falsely assume its
transaction is still pending, and eventually timeout (-ETIME).

Fix this by decoupling the polling completion signal from the global
sequence allocator. Introduce a dedicated 'bool completed' flag per
sequence number slot. The RX thread sets this flag using
smp_store_release() once the data is safely copied, and the polling
thread waits on it using smp_load_acquire().

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a9449bc33bd0..ad677962d10b 100644
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
@@ -261,6 +264,12 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
+				/*
+				 * Signal completion to the polling thread.
+				 * Pairs with smp_load_acquire() in polling
+				 * loop.
+				 */
+				smp_store_release(&rx_data->completed, true);
 				clear_bit(seqnum, achan->bitmap_seqnum);
 			} else {
 				/*
@@ -271,8 +280,19 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
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
+			/*
+			 * Signal completion to the polling thread.
+			 * Pairs with smp_load_acquire() in polling loop.
+			 */
+			smp_store_release(&rx_data->completed, true);
 			clear_bit(seqnum, achan->bitmap_seqnum);
 		}
 
@@ -318,7 +338,13 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 		if (ret)
 			return ret;
 
-		if (!test_bit(seqnum - 1, achan->bitmap_seqnum))
+		/*
+		 * Safely check if our specific transaction has been processed.
+		 * smp_load_acquire prevents the CPU from speculatively
+		 * executing subsequent instructions before the transaction is
+		 * synchronized.
+		 */
+		if (smp_load_acquire(&achan->rx_data[seqnum - 1].completed))
 			return 0;
 
 		/* Determined experimentally. */
@@ -384,6 +410,7 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
+	rx_data->completed = false;
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;

-- 
2.54.0.545.g6539524ca2-goog



Return-Path: <stable+bounces-241890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBrSKO0E8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:17:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41935494A97
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9304130727D2
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A95A3FCB27;
	Wed, 29 Apr 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Phta15bj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4A3FD12D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468320; cv=none; b=FDUMY5d+yBkY14o3t5UiQ3cjCHC5A2daDi0EFjjsxmvVZojeIkE/YEqaMyZJ6bUviRtdDSFyuraV1w8WpXC6yJiPVBAP2V8IE8GJeMDzIMqg+2N0v0oVHUJ1fmqepVIi+DrZT10lslbcJDRqcRokjMMMszZNHkQl33xKvXH0UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468320; c=relaxed/simple;
	bh=qIi4uEXjUsPRYYUetGAKlVVsN1QT6jgcMevIIMn2wws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpLscdtUIWAZZ4HqjS6o95J9dfdXR/acCcTngZ99GETf+1EpW6YlmIfZsa0kyjj+5j+MgdNNklxRTPqTfzxXYpzBelSYgczgeJ05aqeiFsDonRVQ1elAtKJxVe8En6izZu8eTeSjx1cyQBdtSR9Jz0j+qwt6PGoUWmW6KlTMwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Phta15bj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so5502295e9.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468316; x=1778073116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+M8AOXn9O7RUpeUBA+tCnoNyyooYIprfAY53DgU1d8=;
        b=Phta15bj7dK6ifHnXNE1PUDeeem2mECDR8x7je5w4oXzrzPhi+JLnORS/8c9ITVDxJ
         RzDMTXYEAb0ScTyDEkwZFWkbbzvd9Qfubw3okNrvRhchKSyZrGqLOZXRK4Y22jtFehvU
         EQrY/6LHhi1E1w98gKrEg7tJrgh4CjsMCRHJiQMFAmC0A8gzuxgD03v3oxggZZDu3NY0
         Wv7XqpqVHu1oHnbV3JuV4vU9JADnUNj/9doScTb6A4yS7gJ/VaLPyhoENCF/AEfBrEz3
         3Nbg0ribgzXCWmlCAFDSkTkEgG2Nf5TIpTrTlmNRE3NPJZTmrJsflcZxE4UyGkoHuAtc
         ROmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468316; x=1778073116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+M8AOXn9O7RUpeUBA+tCnoNyyooYIprfAY53DgU1d8=;
        b=tIeipSMWMk/4266ebKithUPjcD6XHv3ysDeMpuYTraGdDQYEp4WKcL3ipChK62ed4c
         Sw6yeeVGtcLHhspR1F2eTNSnUsdQ+1TUuzW++ud+HwVgFsnveRSsB3gP2wyyxiX9PBLS
         5fqGa2Zogj8gSi9tyDBkY71+DSEZqec/NYzIur2mA9ZHJm1xTonmri+4OrAXT9Tid07F
         n+4Ny9Z8icewSXBuWwO6q+v1r6HYi2mUG1VPGwe0InKBu9uocY5wb39fwWb8tEFufQR1
         Y5Ig/RTjy/TW8DSKL/oGSRblkLiWnMiKX2lKC462Siu7x5YIukr8pdGkQht/MQOWOtJy
         S7jA==
X-Forwarded-Encrypted: i=1; AFNElJ+7H4R8TzhHHirtxa3W+rINbjhlwb+ehB2DVbG/5pGv7JCIC2kqjtcw7Mjp0XxTLz6puGp1giU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5v8dMMDBv5jXnYq2yNyyCz/GG+OtLWA7JgFs3o8zJAl+XMmfk
	P+E5QNfNg6XqeRJsFAaFiQmYq6HRivXiGsJ4Mukt8CqXV2Phl+70oNH5pQgzSnhEEWk=
X-Gm-Gg: AeBDievt17RM9Uq7rIFHS9+wZQWwu2xFQuAr8g1Xh6Gu9Kz9+c4w3gTQaYbHJqL426t
	Us/UDyved9wZTb1Ho3uv+LWqxIsjO1joMEDn83/LzvwM65TT9H1NHCXbzpBsp1TGHgDNdgSRbXC
	LlGFvOyK/jQv7MHAIdE7lfCd2WC1fXgVD68Qkm26XCG+mzpF2xCwXsQyd0sRzUywuViP8DdWtCi
	G4VcM4+we4+lyddKSJMY3hB2Hcdo936ICLTYlujex/3iQqUuVknw7KBIwW0W2Yk6OkphwKF7lK/
	opH2XI2qRf1RGkE9WiYK2RRrh44rppMdneBwfBWCX+CnJi85qsmlLutOE2Xj5sVChEL1j4fJJVU
	/K1nIqhQIrRX83fXEcg3XnChx7LrU+AdfySmp6cqngGaNC0lixnuop8GXPIIBIQramhflnFB72I
	J8GpRCfgLNBbB/CM9XYz5rWo6x21RoniYVd+wpQVOZ1OEgIbVZ3ydFkeR4L0Jt8m5xJ+KvEFdds
	Q0KeBtotye1zKYaJQ==
X-Received: by 2002:a05:600c:2e0c:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48a7bf39d6fmr31504885e9.0.1777468315731;
        Wed, 29 Apr 2026 06:11:55 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:55 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:55 +0000
Subject: [PATCH v3 6/6] firmware: samsung: acpm: Fix memory ordering races
 in RX and polling paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-6-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=5716;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qIi4uEXjUsPRYYUetGAKlVVsN1QT6jgcMevIIMn2wws=;
 b=n6p8KMgV4VXWOdTJOMRAdVfyCy1JYt9VnaozXQPFuRYYG/Sdcg02lvO7Wqps2Wkhke/a6iO7V
 YjeMPAOm5V2CdnvfidMtNJqGt3sYxPv18LMDCqgVxcTKOhqwQUxY7dC
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 41935494A97
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
	TAGGED_FROM(0.00)[bounces-241890-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Sashiko identified a memory ordering race in the RX path [1].

Sequence numbers are allocated by the TX thread and freed by the RX
thread. Because the TX path is protected by 'tx_lock' and the RX path
is protected by 'rx_lock', the shared 'bitmap_seqnum' is modified
across two separate lock domains. Thus, the operations acting on the
bitmap are effectively lockless and require explicit memory barriers.

This patch addresses missing barriers in two paths:

1. The Release Path (RX thread):
When draining the RX queue, the driver reads the payload and uses a
relaxed clear_bit() to free the sequence number. On weakly ordered
architectures like ARM64, this allows the CPU to make the cleared bit
globally visible before the preceding memory reads (memcpy or
__ioread32_copy) have completed. If a concurrent TX thread allocates
the newly freed sequence number, it can execute memset() and corrupt
the buffer while the RX thread is still actively reading from it.
Fix this by replacing clear_bit() with clear_bit_unlock() to enforce
Release semantics.

2. The Acquire Path (Polling thread):
In polling mode, zero-length messages (rxcnt == 0) can have their bits
cleared by a concurrent thread that happens to be draining the queue.
The polling thread waits on test_bit(). Because test_bit() lacks an
acquire barrier, the CPU can speculatively execute the client driver's
subsequent instructions before the RX thread's memory updates are
globally visible. Fix this by pairing the release with
test_bit_acquire().

Note that the TX allocation path (acpm_prepare_xfer) is safe as-is
and does not require an explicit acquire barrier (like
test_and_set_bit_lock) for two reasons:
* Address Dependency: The CPU mathematically cannot calculate the
  destination pointer for the memset() until the non-atomic
  find_next_zero_bit() returns the index, naturally preventing
  speculative execution of the buffer wipe.
* Lock Boundaries: The visibility of the atomic set_bit() to the next
  TX thread is safely protected by the 'tx_lock' boundaries
  (specifically the Release semantics of mutex_unlock).

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index b8a4978b091b..15627b439838 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -7,7 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
@@ -207,7 +207,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 
 	if (rx_seqnum == tx_seqnum) {
 		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
-		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
+		clear_bit_unlock(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
 
@@ -268,7 +268,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
-				clear_bit(seqnum, achan->bitmap_seqnum);
+				clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 			} else {
 				/*
 				 * The RX data corresponds to another request.
@@ -280,7 +280,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 						rx_data->rxcnt);
 			}
 		} else {
-			clear_bit(seqnum, achan->bitmap_seqnum);
+			clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 		}
 
 		i = (i + 1) % achan->qlen;
@@ -322,7 +322,14 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 		if (ret)
 			return ret;
 
-		if (!test_bit(seqnum - 1, achan->bitmap_seqnum))
+		/*
+		 * For zero-length messages (rxcnt == 0), the bit can be
+		 * cleared by a concurrent thread draining the queue. Use
+		 * test_bit_acquire() to prevent the CPU from speculatively
+		 * executing the caller's subsequent instructions before the
+		 * hardware transaction is fully synchronized.
+		 */
+		if (!test_bit_acquire(seqnum - 1, achan->bitmap_seqnum))
 			return 0;
 
 		/* Determined experimentally. */
@@ -392,13 +399,24 @@ static int acpm_prepare_xfer(struct acpm_chan *achan,
 		}
 	}
 
-	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	/*
+	 * Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62). We do
+	 * not need an explicit acquire barrier here because visibility to the
+	 * next TX thread is safely protected by the tx_lock boundaries
+	 * (mutex_unlock provides Release semantics). The RX thread only
+	 * blind-clears bits and doesn't care about this.
+	 */
 	achan->seqnum = bit + 1;
 	set_bit(bit, achan->bitmap_seqnum);
 
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
-	/* Clear data for upcoming responses */
+	/*
+	 * Clear data for upcoming responses. Speculative execution of memset()
+	 * is prevented by the strict Address Dependency (implicit barrier) on
+	 * 'bit'. The CPU mathematically cannot calculate the destination
+	 * pointer until find_next/first_zero_bit() returns.
+	 */
 	rx_data = &achan->rx_data[bit];
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */

-- 
2.54.0.545.g6539524ca2-goog



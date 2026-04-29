Return-Path: <stable+bounces-241886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBVoH7ED8mlYmgEAu9opvQ
	(envelope-from <stable+bounces-241886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B49404948DC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B17D0300A58D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2363FCB1F;
	Wed, 29 Apr 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkNf3Rdw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD23F7864
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468316; cv=none; b=Q1+Iw2d8ybCWr+8dypehX6+BS42In+tW68/kPDHeifB2+pi7lfoPEs3fi6t6n8/6EmkgTi3ihQ5ShNPqI7s7Hzrts3gustreQOLepuYBCTZ06uqzRvB17duDQiCl3pdmEiFse0ZaK3jUitN6Zwvm7nKzoJHTfdzUd2TbUOBXIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468316; c=relaxed/simple;
	bh=QTePW60Bb9iT8APl2jkQnh+1qmdtoSopKY5nHEff6yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2RiLPv6aUAdId4hMaTxavoYfsRcdfmnD8DTygu2fERE4dprJ2WMSAY8f2aAp4OnbznAneBqf3B7NqImoOE80HBLoedfIC5v2BCkfThjZj61vzaeoBAbR4NEUkuLT0nwE2if+Y3m7Qm6S0yh46Fz2rc+36ROwffTmfPhvE9wf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkNf3Rdw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so10262246f8f.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468313; x=1778073113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ougqSxlNHpdb7A3xiXDiO/CHpVSWdAi7241ogZispeo=;
        b=dkNf3RdwCZJ1bX8oKWvJAz6rCwe+L1bYu6CK0gk9gPO1f923lNdOZvl5WVDerryei1
         TIDknR7QgIOpmZcvXH3MPMju9Wr8sFJxPGN9JO6+4PNuam2gsy1b1go5McypZqJFlsK3
         zPDj+c5LrrJbEMfy0WMrahNv6XsFieAklhuZB2xrMn/9tpQaz232kjAk5+WEQwq92vfB
         o6wbylxqcTJ4NLRJRU/6bt2lq2nd2r1t3krFlkpDFMuaUXKok0PerEbd+Qo1j9Xt/mGa
         c3HTIMw4wd4PvjWd7b9dsGe70KshuIr8o/jILzDjK1bhP7h6mJZzSeifUYxW5PrtJm9N
         UcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468313; x=1778073113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ougqSxlNHpdb7A3xiXDiO/CHpVSWdAi7241ogZispeo=;
        b=d3dvRaPLHJYm+N6Gica6fts0JNddBaVWA39w9O2Pbq75FyXQETQ60RoCXOhASY0LSj
         0Tl/u0tsRuyzwLrZ6QfLhyD7FaDqPXR0Kjb6OfiADQ51uDF7Ze8GXc4DVpJK6Hijg9jK
         jpFSgTJ6TUknsj9VXe63DuH6fWqkI9993+k+L/Un6hZPqaZoBhYQ/m3NdilmXLaEwXOc
         PHSQU5v1R3A4iNE8i349wRdnOR05plYxTPTkmsVVU0MfM1mBJLfzQuvd+hcZANzsx7dA
         9qulnpQnx4i98LgE12guYT5aRQF8a/zPnA6K6Lc6Zwmy8I130VUiWBPGSVyjbcUVc9vn
         tYsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XtLT/aezt321UEVNoFv7KDo7s6yYC0p2OC2ob6+OJXyP2S9v41OxfNQuXQs1yzNmP8Q9jqus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpFLT1Uo7NereR0gHtNyymouQDQSUlFFRf4F/s2FgSPJ7AIYC
	RYJMZsOAW8VViqYBFPziH97J5Wd1DMFFmFgwmExd8V5VyF6P3gxy7HAhkUWHJizwrn0=
X-Gm-Gg: AeBDievIFzQBQ2vZQYLFE5mfv/7+8H8KjOVP2wnpcMKGOCqUMlrRmqDxJ1fTqh07S6p
	qbmwLzWfYTQ42eHLFOATbzUSGn4UxsdfCSVfPeoe3w7blXPWWjE3jO2KEE28BFv4BM68beW3YWK
	5VkkgCnDKWiXlusXSiwjFnc7YVklcdhIXsVH4ZXNtJrfk658dRMCx13/oejStMfKYYXUF0xci2y
	Jcdev1PZpZhJv02IB8SExhOXa2pV5X44SKj6uCUfaWKMoSPWgk/XZ6Wu3XLI92meBYb3BO5VnMA
	KUVLqy2yI/YERJ010S5LR3LkSUkQQaEcTY19mUdpgOx+37OfV7TTHxQIZQRKsyo1Ih4+QmAnWtT
	arFc9zUazBbb10lz1WT27S78kStb4UH+8D1YPqcnGRLLfLJatrnQZOXAn2UsEun5noFNj7bJiq9
	EyCcdwcVrY6dBHam/caQV8S7+ryA62HkEKSLie1XU9CZpgRDQYZu5GRyNqm0QXm/VgK9kNJWGb+
	bxsus7WZHdushpFCA==
X-Received: by 2002:a05:6000:2486:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-44790d12b4amr6375164f8f.41.1777468312577;
        Wed, 29 Apr 2026 06:11:52 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:50 +0000
Subject: [PATCH v3 1/6] firmware: samsung: acpm: Fix cross-thread RX length
 corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-1-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=4319;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=QTePW60Bb9iT8APl2jkQnh+1qmdtoSopKY5nHEff6yQ=;
 b=JjWGtIEPDHzDE3ifeqhjWynWDXy4srvXw+WvUSrlmTnb9fxve30Ztz8YMbnfS7UZEI4jrFd87
 agoMLbvSxq9D5XsocCvyY1WX21MMIdiQSYMYgNL+fN7MfdDcMC+3y8t
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: B49404948DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241886-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

Sashiko identified a cross-thread RX length corruption bug when
reviewing the thermal addition to ACPM [1].

When multiple threads concurrently send IPC requests, the ACPM polling
mechanism can encounter responses belonging to other threads. To drain
the queue, the driver saves these concurrent responses into an internal
cache (`rx_data->cmd`) to be retrieved later by the owning thread.

Previously, the driver incorrectly used `xfer->rxcnt` (the expected
receive length of the *current* polling thread) when copying data for
*other* threads into this cache. If the threads expected responses of
different lengths, this resulted in buffer underflows (leading to reads
of uninitialized memory) or potential buffer overflows.

Fix this by replacing the boolean `response` flag in
`struct acpm_rx_data` with `rxcnt`, caching the exact expected receive
length for each specific transaction during transfer preparation. Use
this cached length when saving concurrent responses.

Consequently, ensure that `xfer->rxcnt` is explicitly zeroed in driver
helpers (e.g., `acpm_dvfs_set_xfer`) for fire-and-forget messages to
prevent uninitialized stack garbage from being interpreted as a massive
expected receive length.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c |  3 +++
 drivers/firmware/samsung/exynos-acpm.c      | 15 ++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 06bdf62dea1f..fdea7aa24ca0 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -31,6 +31,9 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 	if (response) {
 		xfer->rxcnt = cmdlen;
 		xfer->rxd = cmd;
+	} else {
+		xfer->rxcnt = 0;
+		xfer->rxd = NULL;
 	}
 }
 
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 16c46ed60837..e95edc350efa 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -104,12 +104,12 @@ struct acpm_queue {
  *
  * @cmd:	pointer to where the data shall be saved.
  * @n_cmd:	number of 32-bit commands.
- * @response:	true if the client expects the RX data.
+ * @rxcnt:	expected length of the response in 32-bit words.
  */
 struct acpm_rx_data {
 	u32 *cmd;
 	size_t n_cmd;
-	bool response;
+	size_t rxcnt;
 };
 
 #define ACPM_SEQNUM_MAX    64
@@ -199,7 +199,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 	const struct acpm_rx_data *rx_data = &achan->rx_data[tx_seqnum - 1];
 	u32 rx_seqnum;
 
-	if (!rx_data->response)
+	if (!rx_data->rxcnt)
 		return;
 
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
@@ -256,7 +256,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		seqnum = rx_seqnum - 1;
 		rx_data = &achan->rx_data[seqnum];
 
-		if (rx_data->response) {
+		if (rx_data->rxcnt) {
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
@@ -268,7 +268,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * clear yet the bitmap. It will be cleared
 				 * after the response is copied to the request.
 				 */
-				__ioread32_copy(rx_data->cmd, addr, xfer->rxcnt);
+				__ioread32_copy(rx_data->cmd, addr,
+						rx_data->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -380,8 +381,8 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
-	if (xfer->rxd)
-		rx_data->response = true;
+	/* zero means no response expected */
+	rx_data->rxcnt = xfer->rxcnt;
 
 	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
 	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);

-- 
2.54.0.545.g6539524ca2-goog



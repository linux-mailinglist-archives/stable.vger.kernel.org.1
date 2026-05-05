Return-Path: <stable+bounces-244143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CbbNort+WkLFQMAu9opvQ
	(envelope-from <stable+bounces-244143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:15:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C894CE42E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A103014132
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645244CF37;
	Tue,  5 May 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZ2I/YcN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B323449EC3
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986835; cv=none; b=PZA+dVBj0r2JI9kJzApgpOFuwd6Aa5ytUvSfS4o5wwwz+KYOYiZGUqmUxsw+4EE+1KpIphq0VWV73jjxkCeMO7GKrTxVpweXVzBldeQTJcSVYgyOU40ajOfCe2eznngE78EbS8pd385QntPR5AxDVzQsmW1gLpt/2ehFh+7Io+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986835; c=relaxed/simple;
	bh=qp5oWm/4Ss+UIi29K/90SMb4FE1TJkPmkKkrbZErN7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BS9u2P6lTddJJrtrmqo9gilq+Mpscw+ylykH8i98TIFXEeCpqqHvkNEObXIviHoAs2Db7qvnmMCcv3DwRQHmYUsS1CQmVVgzDrnQP4NpIqOe9oAfOYPxzrSWmubJhqEZdtyFhEIhg3YussuQnGXkAm1Og5ZoNZlaeMXzz6129/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZ2I/YcN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso55864575e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986832; x=1778591632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHmLifVz2AA9OJl2Yh6Eb2RS6GSmns6VuIWZDbFoB8c=;
        b=pZ2I/YcNkG8R8nq8Y979yNgR61m8Fmi7YtAUz768sYSqu11IoNzZIKeXlhWe7yrHvl
         4koG8YPJAi1wR9ekdTGYEtuR4n7puUe2309aj5qRm/0ghL8nLVcR5TfOpzzWpJ3eOoys
         x3mdbj5HL8bTytlUHyAtkuxoU62/mDXOij4qN4fMpR+YwYI6q+6m2JOLUrCnPdZEI8HU
         jsGMlh+wgUMpRWyDW2CzvTDjAtU3fM98mPSNUKOHKi1T5s0sJyUJuvuAWjnwEYcxWq8H
         7BRgNK+0UY1Nw+OkAELGgbNMJZTG4e6haXILdbf8Gm6biqWNLfRbw51/v6OF/MXBHY5e
         PEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986832; x=1778591632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHmLifVz2AA9OJl2Yh6Eb2RS6GSmns6VuIWZDbFoB8c=;
        b=p9o0e3kYNQMWLSzOkwQGNvVbR/Mm3wi1fScEf54726y1S9vX4Uxkg8mqd1O8pDmglI
         Txpnm59Ddv0JKYAnwiEyrg4riL9HIuN4UAJgAYiFzy39LqIVjUQwXq9HD2+8EYFFqUSn
         /ZTQe4NZLABVZIxtj2fuB9WYYqsosqwS4yzYneC1NBAF8m1uju4y7uXJDDlUzW2SKe+H
         iEx7XhZu/2cflVbckwZcDfiAGQXHT6azmo7YOAatc+zwuxlKpj3w8KGbS77AArmcISLn
         Dz542IRtv2g4RdEnkOyOh+73vmBXo3h12ZjGHXXGRh3JO7Rf/rzvK7l0NRvkekuOhQyc
         rSQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZCzpRQJfuPCZLbVhPTWqtfBBmbW2ahLkLWrZWmkwFICwQxSiRcLQ9ifaiPNmPrNzF23S6EsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgw54lTm/wWglPDKoIDTyjEOH+4QgmkBIjOHkuJzXojzOqgN4g
	6zBH6agju3gKiwbUOY4+JhEJb/53W+/58nv2DU4txePpA/obFS8CxRQchoSCFkGL8R8=
X-Gm-Gg: AeBDiet9KYewH2xI+PsmstxcKcnYc5dPGiABGsTMrdrGDKSmn6JuGY8uNi8Yv8PjxfN
	nXyycXQs1w7yvznykbXxDHO2Y2UJpinjBAGTGw33lsP085/hU1KoYSxXG43r8/qvKsw/g8nk0se
	IOERx0wo+k9fBi8fUXz/XITWaLrPVRTgOMJ1WjpAAVG+8l2TYbd77Fg/qWc6DhKq7JkWYB33Doa
	Axw2XzKG4g/xbsNL06F2Y0tfGe6NoqXomJYebG/p1nsa9jhcG9JO3wIgP+M9jLKewW8vYEEKX5d
	K3NyVJg/rt5S93VB6uniAi3mN81XaAXP+T2jyliQEPZ4Fwf14TerTDwrLIIKo2FYVzIiR4tPFQm
	5ZAv0PAN1erh66zlF1sgjZo8A+qtummJeuHjVxLUwLoGfp7mgyGMHoAX0D2LM4oTKQLY7GT8Z8t
	ktuwr/axC8VruHQ8Hhdu5C/rcZf56XYvv4R1yPBVls/ql4mRhy963916WB/eqvYthd9EKYQi616
	Nhdh1rQhLRqGyljpg==
X-Received: by 2002:a05:600c:4450:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48a98639086mr210514245e9.9.1777986831930;
        Tue, 05 May 2026 06:13:51 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:12:58 +0000
Subject: [PATCH v5 1/7] firmware: samsung: acpm: Fix cross-thread RX length
 corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-1-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org, 
 Titouan Ameline <titouan.ameline@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=4462;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qp5oWm/4Ss+UIi29K/90SMb4FE1TJkPmkKkrbZErN7s=;
 b=M+zBRspfuC3hFP0WDaqmOFPc0NnPrbZ2+1IaK4wuqxMQOcglC63RdXe0nS80HpV3ih/G2NfvM
 MBqt0hibBmPBT47Q2PG68Gb21e5PHlh/x567ppjMiJkpeNfby4EGFdk
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 37C894CE42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,google.com,android.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-244143-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

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
Reported-by: Titouan Ameline <titouan.ameline@gmail.com>
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Closes: https://lore.kernel.org/r/20260426210255.73674-1-titouan.ameline@gmail.com/
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



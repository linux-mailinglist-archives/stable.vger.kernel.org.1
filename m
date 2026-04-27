Return-Path: <stable+bounces-241346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIFoNDN772lKBwEAu9opvQ
	(envelope-from <stable+bounces-241346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:05:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE9474DE0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA2030233EB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854C322527;
	Mon, 27 Apr 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuAGkdaG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CD3233E8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302261; cv=none; b=i6zDlRDJH5uN68s1NRZ3PNgF9OB5cKRvVGQxpzDt/SJj6woL7szkwAYsOTYKvXzv4jMnkpULi4i1yay6Ba04zXHJzdMJtzxeVzFNjNbYOp5ffXxtHLUy4w+RzkmdkcWNXEdNxkgYvR6qrUEIBCD51zaHQyARTKY88R5WjUoEhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302261; c=relaxed/simple;
	bh=m/tO5SKZlsZv2lDCNDVLmgGJxhoMZAGNBisteBM84SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCaVnflRN6uZ1lyyspKkRq/ERWNK8bxoVZAHzbd2O23o9Dpq4yxWTf0Yu/mWLTNdX8TPCDCp5oqlW1hEFuJCsQRy3ecOtkbYBWXBWskFHyXJt77FLDYGHV6mFTbMPIofoBPVVgsRdOAZCeBcOa+bWlZdhe3eeFUCt8JWsbzK+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cuAGkdaG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso96177775e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777302255; x=1777907055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+rXCO4mUBoHaMSfoUP0Fw9J65bipPOLJZg1yJy+iuw=;
        b=cuAGkdaGAOlVpLNjrCNBPAZMJxNNHxl4hg36qoSXDkm21wTOHvnKmUO4I4y9Uggf85
         Z3aRIoARPVn67DiutyXhymhjz4NUS0TV/wlDfYUKQ5YQa4bpdlhK4WgQ/pAfehH4WIXJ
         SpWCfC2vuI1LWzCZGQHuFf49NlHCk6NB2PAId797AenTWOZIG0mgwM5ULqytpAM8MfpK
         IJHuhdv+bQPr24UiqRDMFGfTrPAssuoU9x38JQTyA+/1OzpUMbsf4Swz+m6pVAF/P+Hu
         FFeYsDvG6Xm3t95AI/jjoZz81lwviBSMEnmnimbB/YFoGLEqJovkzCbZwABPlFOvD2aA
         KfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302255; x=1777907055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+rXCO4mUBoHaMSfoUP0Fw9J65bipPOLJZg1yJy+iuw=;
        b=LsplVa85WEPtnSpilNkt13px+HJsvwS2FaBks269/o08FKboPsi2PrptTT36sU0kf/
         fGvMvy/t9WKPkapE259gAY3ZjmJgwq9aBA7tzljajtmjohhbv8c9q/i0r4AfEM3cCuR/
         FhXevV7JAPLwBtXVuLfCGjdmvP+XHtF1djVimZgq30MmQBXRhWKQhz4abqCZ8RO63JEU
         XHtu8rgcEAwYoHeWXxyUVLt9q4di0ev4p+1xo9s7WVDRXGWK7PLVDwTHl4DWFaHWJ4tT
         91peeb/dP5uvW/RxxtGV0jXpPY1rJrmuKAAZeWNBZwKU6HXgy+tNgovP4sDRAURZBzu+
         ERsg==
X-Forwarded-Encrypted: i=1; AFNElJ9Pi8EehDtLMPHsi6TaVH2KauKF7Uax1fWCaiN7YbHEqIuGr6Ec/kuMfP3GcGYdcN48u8UuWJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jHQZF0NQLpfCxteB33S4PCG1lP9q7/J+lXVT2DREQDT2yJ2t
	+vDVqiy4zToe6sTsJOH4pMCoLPw1etaU+2qF3QqdNEqf8calU47wdPTmV+qRFKBfbhmS/EX4RvL
	YP1bTfaQ=
X-Gm-Gg: AeBDieuxX+IFb8AN5LKyqNUVO9UuNJYP1+lLtmg+Pc5b5GCnWjVp0ab0UB5exXk/RSc
	+GJEj7JFWaLJwROCvdboDYmSn3aCvoBmOnXBoKMvN8kbT/UVEFZvBR2F3rD+AWYJ8eAQ1WA+r8L
	XzCw/jFPMffbxrESmPfJSyUFCyhawE/a0YV85WPpILhTnLhPrgDTb2V2v/L8Q2DE9pSGIH9SbSZ
	/JKJscKTrX71YR7H+OlTGtbvBr6Lvg70RQ1K8dMVwXxeWBfUJiEqgT02OI/ne9TaHiFMnuisx76
	ZwUl/wAt0RVAk0V8j8DWLj2MKyU7BJnPz+GC5pIQcEHxrAdu9/6C0r5VTabK9IxeE3b2wmV3u2q
	ENwzRI+oVjqd7occqVOcF80dtdXdK8T/vkepwtc3uJ5YbqZkbE5Mk42cmZcrsGkvslk81kxPk3D
	voazrnnacT+cdQ2IRqH547VTLMbHEJ2fby+cWviW4ouZHmoFhuPXH902FgHZxU86iOYl3uz/aFV
	XT7qKsFUqM4SAhnrg==
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488fb750a2bmr435746585e9.10.1777302255373;
        Mon, 27 Apr 2026 08:04:15 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm235370215e9.26.2026.04.27.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:04:14 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 27 Apr 2026 15:04:09 +0000
Subject: [PATCH v2 4/6] firmware: samsung: acpm: Fix memory ordering race
 in RX path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpm-fixes-sashiko-reports-v2-4-1ff8de94a997@linaro.org>
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
In-Reply-To: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777302249; l=2809;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=m/tO5SKZlsZv2lDCNDVLmgGJxhoMZAGNBisteBM84SY=;
 b=5E5ST4vkspz2pIaYKwMEQIblGJZBWV/PhVFqy7dQxYqnohf57zk5thyo0lnNMquWf8nB01W4p
 JkoNrnwDadEBiGfuVEy/6Jd1w3UB0St5O12XXnW1CVE5X7T8uoO6Tlh
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 14AE9474DE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241346-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid]

Sashiko identified a memory ordering race in RX path [1].

When draining the RX queue or reading saved responses, the driver uses
clear_bit() to release the sequence number back to the available pool.
However, on weakly ordered architectures like ARM64, clear_bit() does
not provide implicit memory barriers.

This allows the CPU to reorder instructions, making the cleared bit
globally visible before the preceding memory operations (memcpy() or
__ioread32_copy()) have completed. If a concurrent thread allocates the
newly freed sequence number, it can execute acpm_prepare_xfer() and
zero out the buffer via memset() while the RX thread is still actively
reading from it, leading to silent data corruption.

Fix this by replacing clear_bit() with clear_bit_unlock() across the
RX path. This provides release semantics, guaranteeing that all prior
memory reads and writes are fully completed and visible before the
sequence number is marked as free.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index bd0d48e9d157..c9aa79c2faa4 100644
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
@@ -206,7 +206,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 
 	if (rx_seqnum == tx_seqnum) {
 		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
-		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
+		clear_bit_unlock(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
 
@@ -260,7 +260,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
-				clear_bit(seqnum, achan->bitmap_seqnum);
+				clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 			} else {
 				/*
 				 * The RX data corresponds to another request.
@@ -272,7 +272,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 						rx_data->rxcnt);
 			}
 		} else {
-			clear_bit(seqnum, achan->bitmap_seqnum);
+			clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 		}
 
 		i = (i + 1) % achan->qlen;

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog



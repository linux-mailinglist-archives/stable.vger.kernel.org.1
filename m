Return-Path: <stable+bounces-242989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEkrHfBx+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786C4BB91C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79050300827F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0BE39E6F5;
	Mon,  4 May 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCOUUjzp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F939B952
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889754; cv=none; b=lQyMacFJVFZVkcxtqRr1+KN1wxUJuRF1R/0us3oozTgsDwDtvH/4AWf/HUKMGoMALSstt2KfOicgYinP0yxGxEXXNyHwMNBhJ7h9ZA7yB+JYO5BXu/aKNDDCN6Jf3sNtRgVQOczg/eh6EMiM+ua91CiSiuAJ1SryNY+IGrP/txY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889754; c=relaxed/simple;
	bh=S69mcWVdJW47YZsriq5gOrBQLK0ksV3oXVdlIgpsiSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LavBqYcXnCFfJiVHAnjRtxwpKVCx5zG+HkUp8gYscWNZTOLsLmmHcd4KMF3f4WP1eAKnNf9bjR23Nz14GpNI6YVgrqqkAR2T7KmiuZ5+4b7tPtSj1Tj3qD6rDNZlHN+fQ55rwo4rJasbPJwo4ob65egyPy09676DPWp6bP/KTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCOUUjzp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a044cb827so2524640f8f.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889751; x=1778494551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTcuuyPM1STHES+1Gqa4UfN+n+nje0Qh2APGzRVoQg0=;
        b=sCOUUjzpDEB3+xEWZGtObzI7nBL1chkkPZxpkDaPjMa6rlyXFru106GYixchFQ0zJ1
         BV+BRKZ861o+0AciceXHs39sxDTm7sPbGKlqzoVPAG14sk/RIk2bEw/UTtKv4MxL9eBE
         p1Opq3ZL9ME92Bs37AcJywiZ3YSaCUAnFHI+wCXrTQub/sng630TkaryXUpv4+1OQUGL
         CSN1i+lWJOCAM0vuY5B3OO9WhrsWwRm3MyHcvILMwUVnRCx5C6mfSGQc6WBmz0XpxWo3
         qY/maMx3WlfubaNpObgBq7J1OF+Uz1+sQ2aLHblK/8jdKXASRorM/3CXAGeNkYDJX0j6
         XpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889751; x=1778494551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTcuuyPM1STHES+1Gqa4UfN+n+nje0Qh2APGzRVoQg0=;
        b=XMrR1bg/1lKWqZNmT59ztEmyijaynT6jnogGVOvZ3XNMZVSCasLNf0aXbmMniCRZQL
         f90EJQoE4jiKM9hMcOxWbhKYRiKnowMQEFyY1NqASQes6DgHeBhbt1RLiA7z23Po7gcQ
         48cqTWTlG7AEyj+RvzVJ6umbUOi0OqVRhcVaqeiijC0fy/uePieCJWURcUpM+EhSRusw
         tg3M3aLCSQdCVmJVKXj2OsJiLZI7LA5v0GJxI+rKSGPs3giIJSanDSjWRdZeWYgAUhLC
         nxWY1W2nT6acX5Cfuw4uJnu/g0HayysJNy/QYtVlFJuqUK5xgPykyreyK9T/0QTwSrAJ
         BuDg==
X-Forwarded-Encrypted: i=1; AFNElJ+e4e6AJzbuvLrYzWO3WxyJJixguxDglJCyOmkvEZHvkJUsmS5jiF7jQSb5dbNS3Z0SGBff9/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUUG96p4YRpwYLzzX/CJsSovDtGMYBQ6j3MmyALF7F66bDx3z
	JPAxiVEvh2v0Mp8nOnooAiodq8XQlJDaH9PVi9SJFYsUYIf/1HFm9dR1K0Nc40G1mBk=
X-Gm-Gg: AeBDieufwlPvmXS97hvl7E3qctLkB6V2LdTnsjcEpFjkQalyk1cl+kfxDR4so+bc5V5
	xkrvZ9fUWiC/lh9pDWXS5xz1TVDojRVCVwyUb1nN5tbUj4PncTpt9fKUkwZjXoMiH8nDGxB6ffy
	m5LNLkIGoOW1fOEv7hOA4wgSoyJevJDEAgtd4D/CjjHFSXYNUt3vU/s1leF4XOAxZ0cMxR7ZmpN
	/XNSFMuckQus8imaekl8D4i/sVCKYkEY0kFHTJpsGSaARV2GA0DSYMrfV5t4m1lclvzH/BBEi+e
	sJjo8p4mxD13U3hMP/FVurqSOeAREyA4xyqI/btwvNa1xLFpGH9FaoNP9a5DBvWs6h0Bf2r8bEv
	de8Yo1gKbFEUHuqdLU2X7LxYjrNFM2O/iTybx6UGpCpNbG3ZHsY0HKkIR1dMj89KnAMJSScfvpd
	vugDeSgTLVL1Eo/yWEdfQXAMZKlQnDu7AyF5+jsgrznTYZmfLM0DRjzwi5czFRQw1svsZPiPuOn
	vYeD/FVhPBmEQ/f9Q==
X-Received: by 2002:a05:6000:2909:b0:43d:7a08:a5f8 with SMTP id ffacd0b85a97d-44bb716f0c1mr14231907f8f.35.1777889750758;
        Mon, 04 May 2026 03:15:50 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:50 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 04 May 2026 10:15:49 +0000
Subject: [PATCH v4 6/7] firmware: samsung: acpm: Fix missing LKMM barriers
 in RX and TX paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-6-529246be6b2b@linaro.org>
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=4822;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=S69mcWVdJW47YZsriq5gOrBQLK0ksV3oXVdlIgpsiSo=;
 b=aU0EI1Y314zHAtNas0QYLUH/hfpwP3SCJGJfFc2yuOk2ibOlWMkcTfPdNUELSV9TnyxJXuHQO
 XXPyGVIV0+RCdG6SnrRIXTl/fC/wZ0LIKWwb5d/1//ymnkDUo353pBx
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 1786C4BB91C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242989-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Sashiko identified memory ordering races in [1].

The ACPM driver relies on a globally shared 'bitmap_seqnum' to
synchronize sequence number allocations across the TX and RX lock
domains. The TX thread allocates bits, while the RX thread frees them.

Because these operations cross lock domains, they are effectively
lockless and require explicit memory barriers. Previously, the driver
used plain bitwise operators (test_bit, set_bit, clear_bit), which lack
LKMM ordering guarantees. This creates two severe race conditions on
weakly ordered architectures like ARM64:

1. RX Release Violation: The RX thread reads the response payload and
   calls clear_bit(). Without a release barrier, the CPU can make the
   cleared bit globally visible before the memory reads complete.
2. TX Acquire Violation: The TX thread loops on test_bit() and then
   writes to the payload buffer. Without an acquire barrier, the CPU
   can speculatively execute the buffer wipe (memset) before the
   sequence number is safely claimed.

If these reorderings overlap, a TX thread can overwrite the buffer
while the RX thread is still actively reading from it.

Fix this by upgrading the bitwise operators. Wrap the TX allocation in
test_and_set_bit_lock() to establish formal LKMM Acquire semantics, and
pair it with clear_bit_unlock() in the RX path to enforce Release
semantics.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index ad677962d10b..6fc6175b8924 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -8,7 +8,7 @@
 #include <asm/barrier.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
@@ -210,7 +210,12 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 
 	if (rx_seqnum == tx_seqnum) {
 		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
-		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
+		/*
+		 * Enforce release semantics. Ensures the payload memcpy
+		 * completes before the sequence number is globally visible as
+		 * free.
+		 */
+		clear_bit_unlock(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
 
@@ -270,7 +275,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * loop.
 				 */
 				smp_store_release(&rx_data->completed, true);
-				clear_bit(seqnum, achan->bitmap_seqnum);
+				/* Enforce Release semantics for payload reads */
+				clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 			} else {
 				/*
 				 * The RX data corresponds to another request.
@@ -293,7 +299,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 			 * Pairs with smp_load_acquire() in polling loop.
 			 */
 			smp_store_release(&rx_data->completed, true);
-			clear_bit(seqnum, achan->bitmap_seqnum);
+			/* Enforce Release semantics when dropping unneeded payloads */
+			clear_bit_unlock(seqnum, achan->bitmap_seqnum);
 		}
 
 		i = (i + 1) % achan->qlen;
@@ -400,11 +407,18 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	struct acpm_rx_data *rx_data;
 	u32 *txd = (u32 *)xfer->txd;
 
-	/* Prevent chan->seqnum from being re-used */
+	/*
+	 * Prevent chan->seqnum from being re-used.
+	 * test_and_set_bit_lock() provides formal LKMM Acquire semantics.
+	 * It pairs with the RX thread's clear_bit_unlock() to ensure the CPU
+	 * does not speculatively execute the rx_data buffer wipe (memset)
+	 * before the sequence number is safely claimed.
+	 */
 	do {
 		if (++achan->seqnum == ACPM_SEQNUM_MAX)
 			achan->seqnum = 1;
-	} while (test_bit(achan->seqnum - 1, achan->bitmap_seqnum));
+		/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	} while (test_and_set_bit_lock(achan->seqnum - 1, achan->bitmap_seqnum));
 
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
@@ -414,9 +428,6 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
-
-	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
-	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);
 }
 
 /**

-- 
2.54.0.545.g6539524ca2-goog



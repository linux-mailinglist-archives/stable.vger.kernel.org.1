Return-Path: <stable+bounces-244149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGFmJxnu+WlqFQMAu9opvQ
	(envelope-from <stable+bounces-244149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B34CE521
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 309DB301B73A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8C47D95A;
	Tue,  5 May 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldYT3nXZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C247B42F
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986840; cv=none; b=FWy2bQ3jLtAp4AQJtUz3foXMVo3pwVst8CmVtWc5ZpVb6R1weo2+LftJRxhWRSlB9ZSF4Tny1X9IoIoN6KgPZhi4IX/rDFafc/HSKcuZmr2Qg2EBkXu76Jl80Uyt+SVMLA3P6olppziVE3KbqvqBZEfRImqX8vWtYKmPOptYLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986840; c=relaxed/simple;
	bh=PCWsEmI/WUR42uueqaiei2Cmh0aP35hqHHvduAG7Yz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtLTDen048EQDlqCnCMiDdSAVuafaSZ/YPew22ngMr8z9xfyd5SqhZNtly6kbopzI+sPJ3aY8EHX1OeW99BmASFVtWFAi4PvTxVKWfB+CIZEalCEspjXotjOiiXv/7+AdK+cmluz+10zECH/L9zu0FQtPXJg9LsB8gX4tHSkH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldYT3nXZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so62231355e9.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986835; x=1778591635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbpOUBhAHisNgJxpl8N8vXVEUriSOoMRSDM7NHjdJoU=;
        b=ldYT3nXZK26hstoHaQTnGll9VN+sMEgmaw7fzna9+7XVwjrK9Yhw7oSunsJqAYQbN8
         cL0P1u36dSfEjvhNu8FnCIeckQnVJJjtGU450Ctl9JSJsxnjBv92ihxcUlB88GFMnMhf
         p7E/zO8jz1PtZWWy26inyoU1NOeUGeulxln2Nq9VWfls3Fvflv43g93sODanqiinCWmN
         DkNRdGX4ymV3mYVeB0Nl90PnDentQvWseroyaWOZ+fjbHexH55p9UuTntavgT9RLjz/I
         ROk4fetj7Jwue18VStiDPswYl5tMuJAH/g497KkWclRSSwMOkl8GoPUwC17LMbwH30/S
         iQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986835; x=1778591635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XbpOUBhAHisNgJxpl8N8vXVEUriSOoMRSDM7NHjdJoU=;
        b=HbXizyBaN86VpPs+UwJWBZc3LhBZKLZje8bWEcdQ2Q2vKzTqj7j0vboEoTPc9FKkvs
         CfvvmS7x58evmRAu5OscSsQ+JlT8lKoQn3IzXGIrEwftxa+PRDQiniRzoQd++dkxEDi7
         2c75D3DKOFli792fIG2xPvg8EwJtT66AqnQpHPkFoS1g608VrsmkwrPEGW2pZttE3wmi
         6vpaN+E7XnJAcVRTXTwE3Hve5YH1RlmgIuTu40BsrfPV4y0kDl1G9GrNGox0tduAV+Pz
         BcnSbDNre2ryhYmIcMNDuEzWhtXeN3SknpP2PsSrdCB6Jy+ZMRH6k7vrTxEpE9i7OspL
         lJmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QqZjWkOXnZH/X6zAhk6OWxIfsaXVhSbpv24KMkNGhm5qVsx1EJI32/xbf7K/hOM7r/yyInM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7wUNRw69DFAMr7v4u6a3+dvEMM5P8imMNMsWnF5G7ZFU1EeW
	h5TiXAOPdBLx9s1ngQ008S9TubmC9XBdaQAaQTyStryb/0qYg3gCrbiSqa6pXWcIue8=
X-Gm-Gg: AeBDietwpky2k5vUz6byoPTywv9xXhXLXILw+hI76DFfaCoAWj/EzoBtqJPqNh8OU03
	l8PJcanZXWBLeSkCUBdZUe7Dgy8/4JQAPmGQ/PJj+w4Vn8uPwbj2ZskF3kqmSAqm67SYGyY26tg
	aCL95I0z8bz0jU2OI3pEalwXUMJgncwoPMVyYcpHxxyjijxbjW+/zS4gHq88dzYiYpjUeqOn5Zp
	Lpe7JWQlNnFRQWPUnEQJlaTITBNm52n6OEfBoE1tedfbFFt/q4MvPriCOu1X2EVGO0jFjgfnLjJ
	C/s1KDYNlUL+GPxhj+pmDwqjZ08/ayjzxnjZZaJKJXH3yFkp0XOaZTFaGzygEWfkYQrJg3fwf+g
	sDCQLdVTH7H3VhT7H5Xz+HrUkXA4YmwzXgtEmfDX1ptxOZ32fh2P04ltVMuO1R00i9gpNBn3XH2
	Xjc+Gx33OwrnkMq5pOKw9Eqfl3wAUHmGY/P1mnjSNyF7nCRezfRH21+e8UQsli9//Ci0dWA4RTU
	M6uaItpURbYrJ4+WQ==
X-Received: by 2002:a05:600c:828a:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-48a98638119mr230594515e9.9.1777986834642;
        Tue, 05 May 2026 06:13:54 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:54 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:13:03 +0000
Subject: [PATCH v5 6/7] firmware: samsung: acpm: Fix missing LKMM barriers
 in sequence allocator
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-6-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=3932;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=PCWsEmI/WUR42uueqaiei2Cmh0aP35hqHHvduAG7Yz0=;
 b=6xEALCsBvLgFLhQqxJE6EKeqjKKLMRa/BgZwjSGhuyo/8qCLag5h9khWX13dP5jGqQFFSnkGf
 zLyzE9iH3B9AXvc8+kToq57C7FccRBTmsZom4GoFmepT6jQmeA5ZBD1
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: DD9B34CE521
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244149-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]

Sashiko identified memory ordering races in [1].

The ACPM driver uses a globally shared 'bitmap_seqnum' to track
available sequence numbers. Even though threads now strictly free their
own sequence numbers, the allocation and freeing of these bits across
concurrent threads are effectively lockless operations and require
explicit LKMM memory barriers.

Previously, the driver used plain bitwise operators (test_bit, set_bit,
clear_bit), which lack ordering guarantees. This creates two race
conditions on weakly ordered architectures like ARM64:

1. Polling Release Violation: The polling thread copies its payload and
   calls clear_bit(). Without a release barrier, the CPU can reorder
   the memory operations, making the cleared bit globally visible
   before the payload reads have fully completed.
2. TX Acquire Violation: The TX thread loops on test_bit(), calls
   set_bit(), and then wipes the payload buffer via memset(). Without
   an acquire barrier, the CPU can speculatively execute the memset()
   before the bit is safely and formally claimed.

If these reorderings overlap, a new TX thread can claim the sequence
number and overwrite the buffer while the original polling thread is
still actively reading from it.

Fix this by upgrading the bitwise operators. Wrap the TX allocation in
test_and_set_bit_lock() to establish formal LKMM Acquire semantics, and
pair it with clear_bit_unlock() in the polling path to enforce Release
semantics.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 2dea9b7bfe91..fd2e46e9f7e9 100644
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
@@ -344,7 +344,7 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 				acpm_get_saved_rx(achan, xfer, seqnum);
 
 			/* Relinquish ownership of the sequence slot */
-			clear_bit(seqnum - 1, achan->bitmap_seqnum);
+			clear_bit_unlock(seqnum - 1, achan->bitmap_seqnum);
 			return 0;
 		}
 
@@ -401,11 +401,18 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
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
 
@@ -415,9 +422,6 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
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



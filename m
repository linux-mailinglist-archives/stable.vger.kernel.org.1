Return-Path: <stable+bounces-242987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA24CRFz+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:21:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A84BBA1C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA8C303FF3D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8939D6F5;
	Mon,  4 May 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmeEFNYk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAB39A04A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889753; cv=none; b=S9j+TTqIz1EBSTTzPul/MHP9WlozZlBPRxM6ATofyT+Vd2NWbmv74huXHRK9ggr9UsVwkgLgFwIqLqzRuhmDTefhAB+NFBw+m3DkEOEZ5hGOOVMZBrcT/GAsmKFl5Ga6lh+QaCqF6b/1DKuE06EElAVUqTBc7QK+1BnuAMSC6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889753; c=relaxed/simple;
	bh=wZGIg1WvrcZuYhDQpreZS8xozMJIsonW/o4iqtdaJ6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLH+YX3siNtwWWYlphaDG67JZeuoTOShowTpkFdzDPwlgE3JSPdOwxYnWjgLpy0UtGh6yiYKcFc1XyFrTqguNlsR7Y/cex0/HZjrUFVXhT/9BxnDKYs/7Rw45/Gv4XyD0iRMHI7v3mBZWJHTWGS8+rDSDUC5mHO/YjfPCOC5fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YmeEFNYk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-445795cf6f1so2267580f8f.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889750; x=1778494550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AFkvwk1yHFeeDLYag5Oi8EMMsCVOXTu0Co6nMK2/h4=;
        b=YmeEFNYkpQ5ZiugV3nwtJOP2UoMso1zydTxoSDFOcOiPwSBJK1A2qgm9oAZKs4y2Su
         Gqdpt5/YOUSDMlua2l8AwgRNQBs8QxynZF4Ctk+svYENr9qcbV5J04wErinafvucUJYM
         fSeTpEeiLZ+oGj2SdCT5C74/UZmIrvxG1eIFAej9LAX9tlxD2mk7QvEIrrdOZpgLX8+W
         ZzEZQwkzpPVdCJ8zY/wYRrP1tfrwyg9CFchN4FYOFlq2JpLIGU+skG4dQ5LT3g49Be2S
         tcttLuf0S2q1k/mm+1+ckdsGc8Jy/O5YKFh2JcC4ib0hQN8rYXk1itSq8dv4Aco3oRHr
         JLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889750; x=1778494550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AFkvwk1yHFeeDLYag5Oi8EMMsCVOXTu0Co6nMK2/h4=;
        b=XzG2F4mvWnUu2QERhmeLKQ5z3xbCmnMZf+0UTPA1PBy3Mb+kdZktXIIRlt8QpB5TAt
         GNZk1I+2sY737y5iHfRDSiFyfetBRLSqpMQrZwKCPq7IOZaBzFaT97CvTE0epRF5je5Q
         F1S/MktS/jPXamMf50vWTaBXJrmItPHBTGG18OB3Aj0pHH9dMgdzRZ6O3b3U/EJJ200H
         ZJkdGi0gKR4WA96ZFhtUlsH1e8c3eeOkvWle1eq9x9BWn9C5xLofUpIMPWsI5qjDp3VG
         FKxhbAxDiPodtD7iKrdWMoSSRTvcRAyHEVUzeJpCWMojwzGSAsQU7+FAOG0btnLLnpuc
         tb2A==
X-Forwarded-Encrypted: i=1; AFNElJ/Cl/BH+rrKs2qPIsz8dop+hdR4ocC/auUlglQYnFAI3sa8IuhXwtL2fCsxUKhIbds/LmQoBLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhOhCSJzghhkT76pTBkpnrIHLOremqp0b5of90i6sygoIXHDa
	3AjNeRkp+rZT4uZgzHZWM7G2XA0cyNmejcw7W67oraETjfWWiaN6EhGoLcea6yQtxnQ=
X-Gm-Gg: AeBDievRxJlSgq6gDe9yHiOGeLe4tK1YUEzRUGhTFHGDgUsReVnh8qvrjaepVcjoRH2
	BMRzfdDJ3+x0bJZZcuhW2DTvBm7DFxfPGNkm81jpcn8gBM3LqwM8Q33Cl2YeCOAFDAhuw5EWIlu
	aKUXZhDQzshDnRpARZAKFb+/hjEIpCrnoGiyXxrASRtz/71liF/QKRSX2YC6i6pwVXvI8Zi8QkJ
	A0celd5e+vs7uEHnaobo2JlK4FfhcdN8Iq+Elryn+wZFSqyAjRs79wfWisXT7YJ9VPqIctU2ivx
	TOiLbuAAHYZgrN/9RocR3Z/ORQDUMT/TA288Tl+Is2cdcVsQ6gse9BCQh11WCYeIEhfiYEVbs37
	dK8dsL2Zk7h2L7xhqOOP8FDDOsywRtPNjwXYfARBKb+4r7kZ88poEhhAijo11ifZ3N85DJFD44z
	z/ce1olSeKmFodl8PlBB82mwP3fzR7noKETI4wvzGex028UOROTAV/vHihYQom2cCs4snZ3B4zF
	jNGOCTBaZmAhxJoSw==
X-Received: by 2002:a05:6000:2906:b0:44d:4898:7ed9 with SMTP id ffacd0b85a97d-44d489881bbmr8562220f8f.23.1777889749744;
        Mon, 04 May 2026 03:15:49 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:49 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 04 May 2026 10:15:47 +0000
Subject: [PATCH v4 4/7] firmware: samsung: acpm: Add memory barrier before
 advancing RX pointer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-4-529246be6b2b@linaro.org>
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=2113;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=wZGIg1WvrcZuYhDQpreZS8xozMJIsonW/o4iqtdaJ6c=;
 b=suLmSOE+T23wbkQEcy8h90SPyQuIK637mI8IZ9Ruc7euPvI2vIZ2kHtS6x9sSzy80sumoELUw
 twf0j7bUtcvCZwZaVcYPk8Znt+FJlyLRxilXSSdTe46SYqdAH2SzCha
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 892A84BBA1C
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242987-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sashiko identified a silent data corruption in [1].

In acpm_get_rx(), the driver reads the response payload from SRAM using
__ioread32_copy() and subsequently updates the hardware RX rear pointer
via writel().

On weakly ordered architectures like ARM64, writel() provides a write
memory barrier (wmb()), which strictly orders prior writes against
subsequent writes. However, it does not order prior reads against
subsequent writes. Consequently, the CPU is permitted to reorder the
writel() store to become globally visible before the payload reads
have completed.

If this reordering occurs, the firmware may observe the updated rear
pointer, assume the queue slot is available, and overwrite the SRAM
payload while the kernel is still actively reading from it, leading
to silent data corruption.

Fix this by inserting a full memory barrier (mb()) before the writel()
to guarantee that all payload reads have completed before the hardware
queue pointer is advanced.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad%40linaro.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 9766425a44ab..a9449bc33bd0 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -5,6 +5,7 @@
  * Copyright 2024 Linaro Ltd.
  */
 
+#include <asm/barrier.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bits.h>
@@ -278,6 +279,9 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		i = (i + 1) % achan->qlen;
 	} while (i != rx_front);
 
+	/* Ensure all payload reads complete before advancing the rear pointer */
+	mb();
+
 	/* We saved all responses, mark RX empty. */
 	writel(rx_front, achan->rx.rear);
 

-- 
2.54.0.545.g6539524ca2-goog



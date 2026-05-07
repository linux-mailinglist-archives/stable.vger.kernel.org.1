Return-Path: <stable+bounces-244607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH/eOWnD/GnSTAAAu9opvQ
	(envelope-from <stable+bounces-244607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:52:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9684F4EC7D3
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B3A83049E67
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C93E6DED;
	Thu,  7 May 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="qafyK8Cv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AED2D23BC
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172600; cv=none; b=PIM5cP4ZgOncQsKWc4rKtjqTIjanM/pJpXlSU+5meWEtN4fuGA8ygPMZPNCnL6om0kO/gPThRol7mQcsw1rthOIh5cnI9yZd0Et8Iydt/DJV/l1FKEtCOvED4wosqxhHFNX27hUmZh/ovqZ089wPaOOaDVENLZe4IjtOrU7grV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172600; c=relaxed/simple;
	bh=g+o8Gax6yXxVJ9Ymvpwj7De47snR6AbkdQJOz9rOYXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UED5xADcm2Ve3qJlh5b3viVlZUh3DQOQ/YWIrtZ6bizF5P80X8NdrBHKDxxm0qbkjbrIR6w7wecFncRicylws7O2IJbJXRD5aavebFyRLGwowWXP729xij98CXyKUyIgHZkCQU2xzHMfKqfQvJ0/FiB/b0s5e2e3Q3oLiGxfkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=qafyK8Cv; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-12c88e5f4aeso722247c88.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1778172598; x=1778777398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqcAML0ZZ43DsvITP1E2cCodXpE6DI+947s+bAV6M6c=;
        b=qafyK8CvTdEgqBnkFua3jfjtE4gqMWnJD20A3y/53xiSB2VCLFidb0Fwlrxt9OvCz9
         10x90hxiTV2NcaQ6QXenz6s+W2+M14dR8ZFv/S6G1v0d/h/BnFiQOZQDUH/oX7sHVwIb
         0u1M49DrLmsQNHt8HljYV6AYvtB+a9VEwfb0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172598; x=1778777398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqcAML0ZZ43DsvITP1E2cCodXpE6DI+947s+bAV6M6c=;
        b=AThgWJq3WmiwD0itVrMou+rSSitvBBgyBR+0iRVLtm9D7f4zEZxK+08zivvJGPiAQW
         fMM03gWlEgtw1/WryQdA0d0/6KKaYGKfK6AqMy3TGEogrZK6jkRMJQbZLI5jwYHrQQLk
         uL42MFjgmxooE7b/OozybJpUw1fsbw+sUc5PbwIeQj3R0iNEIgHhPjqn+yEBsw19JtCF
         0McrPspNFV/VpEVC4bRUPeUBQZjfkoEO5d9NOvpQKd6BgEF8nICiNdiXSBGRXLsmBSED
         tSP3j+Qdtio5sWnQD/ME8LbKsfUqMO5Ptdb10ERWORz9/pZDkDgcvsULAIRbm4nEnCSa
         GUow==
X-Forwarded-Encrypted: i=1; AFNElJ8RaZBczDGUg8nu2/ZcPrfJnXYpD0fGjgZC+WdIgClpzm3eQPyxdQunW1DyiK/FVdyBolcuaRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32NiiojfszAmmFH1VrJRbPbffexWF4vuGMlpXkWJzhxRRnfSe
	3qghsPyVGarvtU97HaQEQud4rTIa/qiNEeXFYFyIT3/feQucch/sDKKW9vy7XoML9dB1QNfMc+v
	4BRmxwt0AUsNYDrAjcAaO2pwMfqpoLTfkfQ8l
X-Gm-Gg: AeBDieucFzL//KISptnO7h9xPbzzNoO21ZQV0LaZoXPtceY/+3KOYnZGc/f7rz0JVd6
	c9qJocW0Xfce3/kT0XnRZIv6Nb4tN/wX7aI1ztl4MMuXcug1CEj/2EyxR26QDSynhJM3RrmbAd7
	YNNA3V8n8adcjHmrpYeONFMxgK8WtidMeDtcCo3TzzhKLeu+r0D/7m0f2T0bBsdh94ZaQD6OkCV
	wIDtIatxL7gOMnfcMN9w1I28fjliH+q5fR6AiP7BBnzAGmvUHv6S41iyCsuRdb2fVyB8dXvMsl2
	MiFBn2hSf7n0E4eQLxphRd+ThHqANQ4+ngdJhoSPhu0Fufp8fklxQ9rdBVEZloXYn6TeiHe/JZm
	gySt85ORUYe2j0Vjqcpj9dwfsH3E83Fyel3panmvYTxyjIjPa
X-Received: by 2002:a05:7022:986:b0:12c:6ec9:3f1 with SMTP id a92af1059eb24-1323b0b726emr1668516c88.21.1778172598081;
        Thu, 07 May 2026 09:49:58 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-131f99a5a9dsm498874c88.4.2026.05.07.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:49:58 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Thu,  7 May 2026 16:49:43 +0000
Message-Id: <20260507164943.760009-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9684F4EC7D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,denx.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244607-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedTS.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits and use the scratch variable for the rx_buf for
both the 1 byte command to and 2 byte response from the controller.

Also relocates the scratch member of struct ser_req to force it
into a different cache line to prevent any potential issues of
DMA stepping on unrelated data in other struct members due to
sharing the same cache line.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1 -> V2: Don't use rx_buf when clearing command reg
V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
          output on xfer with len and NULL buffers
V3 -> V4: Move scratch to end of ser_req to force it to a new
          cache line.

V4 Note:  Change to moving scratch was tested against an SPI
          controller without DMA. We do not currently have a
          platform using this controller on an SPI bus supporting
          DMA.

 drivers/input/touchscreen/ads7846.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35..1ae1ae42582a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -325,7 +325,6 @@ struct ser_req {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[8];
 	/*
@@ -333,6 +332,7 @@ struct ser_req {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	__be16 sample ____cacheline_aligned;
+	u16			scratch;
 };
 
 struct ads7845_ser_req {
@@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
+	req->xfer[6].rx_buf = &req->scratch;
 	req->xfer[6].len = 1;
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1



Return-Path: <stable+bounces-220218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKc6Exkxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B78721C59C4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9C1B312CB0F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88E4DC55D;
	Sat, 28 Feb 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgZJpFRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061E47CC62;
	Sat, 28 Feb 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300123; cv=none; b=scHHG4ZWhO57M72QAs0xPnPFPrsUMWg9yTmIIcJWnpsnR3ONEyhEzvLnMTo3rdsMR8UcO4hXQSMdExSQwzSb9CzOUEWgz4afwYNF1tUkh4yYTrcbJSL1k8tsaq4RQ/tV54gFPSRsORflCNyvh+9Y7FFwB6FPrGPn9m2Gby21j9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300123; c=relaxed/simple;
	bh=bzZk1TOgUSd5fSDGays6IuFF1nr/j71MGP5pJ4t2xL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEASWTnJYi8N5/42lgJgrb16/j7l2ffU4rkKMnPsqMSmNhDOebTEMbLC54NXPg/ejjA7a9O84Xg+ljowmPYva45R2A4b8j68KinGCIqC0X8mJX3/WEJNC8C/al3C2Iety6ObVCKP048UA8KmFtYX2Are6ghnLYaiEHA7cY+Gi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgZJpFRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D175CC2BC87;
	Sat, 28 Feb 2026 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300123;
	bh=bzZk1TOgUSd5fSDGays6IuFF1nr/j71MGP5pJ4t2xL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgZJpFRbeZ4ACteRn5mvxrC2dZK6eqQltbYOGuDKJmelh1xjsnTK7fyYhJyNHHAa5
	 Ps8kU12yXJ1UXOJ0kqCcdZIK/PJCiKeVVMW/5hJwyIP1p44jtSIue75frtRoXbB9iL
	 kwT8LFxkAIKJq3SQFy9tD3FbkL1IZzs1bc/D9PHSoJnxlHIlqhU4v+BbADSr1GQ9aN
	 barX4Vq/6mp4RcC0FJo5FQh1a2YsA+YMmqcTZ564hENSc8DIV5/K3biYYOw/asNwMy
	 5qgisrVJG6GRB+J0SlQizZXKPBQxh6k9xK6wGi1t/38LPFg2s4/Q6I/GCas0JbVskW
	 RHf+faHakgJIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 140/844] spi-geni-qcom: use xfer->bits_per_word for can_dma()
Date: Sat, 28 Feb 2026 12:20:53 -0500
Message-ID: <20260228173244.1509663-141-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220218-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,marek.ca:email]
X-Rspamd-Queue-Id: B78721C59C4
X-Rspamd-Action: no action

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit fb2bbe3838728f572485706677590e4fc41eec5c ]

mas->cur_bits_per_word may not reflect the value of xfer->bits_per_word
when can_dma() is called. Use the right value instead.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Link: https://patch.msgid.link/20251120211204.24078-3-jonathan@marek.ca
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 9e9953469b3a0..5ab20d7955121 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -548,10 +548,10 @@ static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
 {
 	u32 len;
 
-	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
-		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
+	if (!(xfer->bits_per_word % MIN_WORD_LEN))
+		len = xfer->len * BITS_PER_BYTE / xfer->bits_per_word;
 	else
-		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
+		len = xfer->len / (xfer->bits_per_word / BITS_PER_BYTE + 1);
 	len &= TRANS_LEN_MSK;
 
 	return len;
@@ -571,7 +571,7 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 		return true;
 
 	len = get_xfer_len_in_words(xfer, mas);
-	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
+	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / xfer->bits_per_word;
 
 	if (len > fifo_size)
 		return true;
-- 
2.51.0



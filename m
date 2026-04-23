Return-Path: <stable+bounces-240502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNEKLncq6mnfvgIAu9opvQ
	(envelope-from <stable+bounces-240502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:19:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F140B45395E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EDD2302D5B3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6031E844;
	Thu, 23 Apr 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgofPDmD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CE318B9B
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953952; cv=none; b=jO6nnaKfBYVlpptsM7xVEteH7CS5BqU1Gm6KHbAk6zZCXKGl94vja8eHNbHB4stOnLLWQmeVz9kS85oDiun90tIHZoPi4ExL4udv7DoPI3pogpe3yNDgPdPfPzxI7F3oqoMqKW3+1FpojPWdw41U5i66Bf3aUEIYIO3fPw88uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953952; c=relaxed/simple;
	bh=VTtVl0TWCNfgfLbp5ijesyzVwlK/9w/oJ2E+cqfjm08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVAnzxNJg4S87jlI/wv4UWvm8o6E5FY5qRNIVyOYEX6UnemUPQ9UzTKP5PioVhoweoyE/k/RijrJUy+p7DBouiq7GjBYJqR5mOa6wQVNFIG+akY5kAfyxDw6oPP8qX+pZIEEw7QDvlfkoFqd7TPf7hQi7MhdiUbvmUlepiNHhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgofPDmD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so5547729f8f.2
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776953949; x=1777558749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tpkzzua20tAlQ0uvVtVJePBkUzc26KvQoLCnhghAYSc=;
        b=wgofPDmDy+Oejp5qEq5Lsec7Z/BYdEaTK1eUvKo9E+UWTwQK1Z143HA7+E8ObgdkMh
         xU374ou7r+34Vzqg0s80H33C4lYXxcPnVNNgJ2qIrwdcOtHKJGp5ZATqJ94JdzZD2i4B
         apB2Lf4HtraReBL71qKoqDDfrjD2pSkcfTEuOxNVy2ZS/8R1EnakrZaxjFSyAgNISXs8
         F+oq8t+bhD1As/2jhF6H70gUQVbCZ1NMn/Mg0xOrtHAO7wwGX5AwH5C0RCss9pRz9W2h
         7dqFvKJ6Odger0Vc+YVW9lnBlODckx9SAjMGb0OkOMH7KnIlIKeqty95nDsEi+bZsD6r
         4R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953949; x=1777558749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tpkzzua20tAlQ0uvVtVJePBkUzc26KvQoLCnhghAYSc=;
        b=VTay3Y5tqrwsO43s+oiM6Zq9GtqrOw0cBz+hIXreUCmnPuCwz0Wgp4k38WRelhHG2O
         qHjK0TVw5YWMVutpj7gzEZMYsOr/8hDvPir2esOBWvmOVkbSSyS8igzC2dnmrV6LSF6m
         LPJyFykxL82FXH2hi2zgDnJMuTVQR3ex0AfZXFQI36N+ayx5MtT1UNqsXtWU1tJ1QfL1
         IDr5PAtFPY6za7Zjs6Uz6NHqAg6UCJ1dlfB9VP4/3+ERpeHmB3a8nNdtVtAs0sl7ZkCz
         9EWtxlNMjCmQRw/KAqqtCMfj8PoSNcTIWam1E5XkGNdp1ia9BlcXey6GZRpmUcop28rn
         TBHA==
X-Forwarded-Encrypted: i=1; AFNElJ/GP5sDgjxdx07s0PyRzV3alssQEoK/JwuOqKWOoxtwqJcuvGMU3kVRysM28SO+HZJ+lDCImcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6nmHtk5dNavJWAj1rmgwB2S3U9TORHxKQ8rOvhbI5TaC94O2
	Jh+ORPOg17zgwA+eoey/JNtACQZqgpgbGaXV1CDdqjMq5BTw30cVC+xdwWqZAD9Ynqo=
X-Gm-Gg: AeBDieswvi+UQ3ZjyKqEWkS32upo99EfKWzZx5KtUTHQgcP7L9fhu6LPqSvXD8kKEio
	OQFKWOTC+3uwH0CuxXkl2vfLmx65dNtXBrLTaWNySkQzIrV1aTo3mhSxARSN2BEVQjbQq1rtgPH
	+PsdmsulliCh/1vUMVXZvMaHNlgWPJSjX7H1ra5OnwccreaijI3gDl48TI4wB7tcfWkbCF4hRoq
	7TmVsUdsJ/YvObsiLJtax10orQj4Lz6zAOCkKxikeEN0fln6YKgy0CntMMwftVIkruUjN0JpNaH
	cDWB0dRIVim/tO4REtIF2ufyuuCvHo4Z5vWh/bP6Xzp/S/yewU52DltW4or+YHeP24chHU1ZkXF
	JRQ1Mb88wrbB+wdHUd7HqltS/KH1NQBkYamvFh9NO52ay9yTX4h6Ylv/T3i94b2vxSa5qXQ56MZ
	HRUkBSKyuSX7QdDVzJmUiNuLkWfjidH9uXuIi6a3LD2iUDccU8rvKsfErzMMLI1vuWnan241+5I
	YzrgBJwP97shFSNcA==
X-Received: by 2002:a05:6000:2511:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-43fe3e0a460mr42116126f8f.33.1776953949040;
        Thu, 23 Apr 2026 07:19:09 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm51107483f8f.31.2026.04.23.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:19:08 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 14:19:06 +0000
Subject: [PATCH 2/4] firmware: samsung: acpm: Fix sequence number leak and
 infinite loop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-fixes-sashiko-reports-v1-2-2217b790925e@linaro.org>
References: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
In-Reply-To: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776953946; l=2635;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=VTtVl0TWCNfgfLbp5ijesyzVwlK/9w/oJ2E+cqfjm08=;
 b=DYOtC6hQ0ucn9EaI7t93WN6xfszysLjwGSxnLnt8/zLOQRojSUpaUAulT4yyaGqqznnu6d/eb
 IAZVKMnj/bSAiKaA92rMrcQ3twPuFvC4hYcAzccEMqK1+YuZ1KzxgbP
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
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
	TAGGED_FROM(0.00)[bounces-240502-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: F140B45395E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko identified a sequence number leak and a possible infinite loop
[1].

ACPM IPC sequence numbers are tracked via a 64-bit bitmap
(`bitmap_seqnum`) to manage concurrent transactions. A bit is set when
a sequence number is allocated in `acpm_prepare_xfer()`.

Previously, if a transfer timed out during RX polling, or if the
underlying hardware mailbox failed to send the message via
`mbox_send_message()`, the allocated sequence number bit was never
cleared.

As these transient errors accumulate, all 63 available sequence numbers
could eventually be leaked. Once the bitmap is full, the next call to
`acpm_prepare_xfer()` would enter an infinite `while` loop attempting
to find a free sequence number, permanently deadlocking the CPU.

Fix this by ensuring the sequence number bit is explicitly cleared on
all error paths:
1. In `acpm_do_xfer()`, clear the bit if the mailbox transmission
   fails.
2. In `acpm_dequeue_by_polling()`, clear the bit if the queue read fails
   or if the response times out.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e95edc350efa..a9baed5762d5 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -311,8 +311,10 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 	timeout = ktime_add_us(ktime_get(), ACPM_POLL_TIMEOUT_US);
 	do {
 		ret = acpm_get_rx(achan, xfer);
-		if (ret)
+		if (ret) {
+			clear_bit(seqnum - 1, achan->bitmap_seqnum);
 			return ret;
+		}
 
 		if (!test_bit(seqnum - 1, achan->bitmap_seqnum))
 			return 0;
@@ -324,6 +326,8 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 	dev_err(dev, "Timeout! ch:%u s:%u bitmap:%lx.\n",
 		achan->id, seqnum, achan->bitmap_seqnum[0]);
 
+	clear_bit(seqnum - 1, achan->bitmap_seqnum);
+
 	return -ETIME;
 }
 
@@ -455,8 +459,10 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 		writel(idx, achan->tx.front);
 
 		ret = mbox_send_message(achan->chan, (void *)&msg);
-		if (ret < 0)
+		if (ret < 0) {
+			clear_bit(achan->seqnum - 1, achan->bitmap_seqnum);
 			return ret;
+		}
 
 		mbox_client_txdone(achan->chan, 0);
 	}

-- 
2.54.0.545.g6539524ca2-goog



Return-Path: <stable+bounces-244144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJSDHxft+WkLFQMAu9opvQ
	(envelope-from <stable+bounces-244144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB34CE3BE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4632630065C6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07847CC6F;
	Tue,  5 May 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRiYpGEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472347886A
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986835; cv=none; b=NDXir0qavc0K+ecd1Nxc8McaElss3CZYHsMgA4AlOMahPUQlpUZNOQ6IZetQKbjMb5HPciw5Y9VzbYYghPSkkv3OmkdibaZNsy1HG1s1xFWmLxHrrl6/SwY1goCcnxDw6lUG09TT8jUSZm8XKYd9So95pomHu57OY+aTce19nxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986835; c=relaxed/simple;
	bh=d7vm0U9qdAXbH4NbIyamvNnVpjWmz6WguBCwDQ3CBjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKbZTRZc+wVrtj1I4QO2ryisutaJSLuZChX+17mRqemBFA0xZSCxt5zHsPWwIMJgTEJD2TMXKytnFsEmwsfvdcZwIdZSdg8U/2ITCQnuwsyIG88x3OJPNYVfgGNryZTjiZdUHA3YO1vPr8M9YIK6As8hNW4EiK6V0M/vg+WbwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRiYpGEs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so27214715e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986833; x=1778591633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zXNbcb1r2bmykw+LmN/b7BGBlvkjjNT8szr48jA7Sk=;
        b=mRiYpGEs9OyD0fQXYakYqpq+TWwvf+7E/5U0eqHe3Vk60i1xiOjt09M0Z/WYNCC9nL
         ySuvj6j8IELZ1PPaVYqDN8D9nBdg97P4GXIKput02+/AnxSDFLMkDYelqsP0PSeXP066
         ysPlnSP+SUtOTUYrAncX8tNcMSLzrPI/i/sTn60AkdewqQK6MRAkgIqzc7O7/cWND4Ld
         dXRCttF5u3uUm8C0pEDN2zJuUmhcfPavqR8gZzDS5qH66cz48wlH7/TH59rlQvlerZGt
         YnjtiDJ97tbmlLjKhyutJyB0xAkB7ONVayh/MNIdRFinw/tb12PPBjwp/jUg0T1QtrzF
         gMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986833; x=1778591633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zXNbcb1r2bmykw+LmN/b7BGBlvkjjNT8szr48jA7Sk=;
        b=WISGA6qrz8ePVhyTOrwe0zvGHyZd9S9zz3f2RbmIGroJf7xioIayjo/rAWAD2iOwH6
         XYLfxH49buYUvFJDQ8F5GvE3uL4RgjPWw6iWllyNvRqByICi1fvfGkI4TTTI7k1YI8ZN
         AEuez121tNBJQgiLie8RgGaE9MUpGtTvXCmQzPivFacUSHVC1K+4kI53DFAFKSrPNTXt
         IAyFHzyPuCK/k988Y+51gilCWvN8ylPh3nC4btMgIg9Xw/X8374tfUsmbqDLK6DyFWcX
         wFvhYWEqJ9Lcc+zHwwolD9rJaa/U949ywynfEz/r2p7L+d29rwXlyo+kS1YBfXpvOqre
         vudw==
X-Forwarded-Encrypted: i=1; AFNElJ8VCqLd7AU2MyhJUkk2zXOW47rIOroEQ2Ew1y8nn4Y3gFyZ9tWi47jn8M5yooM4uQI/aI8jOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8Y8fYWiWcTESNVssRAZp+RuG7KRkH7M8pdxWHv8oem/aMAsK
	b2nJPcmm5utSvfqkCJfGcrCsS7U4EibBVkoed1ZxdxDBxwwapLxcJv08H+MYdP5Wd141xM7R1ie
	JwIBJG6U=
X-Gm-Gg: AeBDieuMiWVvA6VUUkEg5pUndYFfsMwkfhwb5oyfA0ShFoqD2BJIv/Uw/RV0tMYDEG/
	2PXtxYuPUfadjZvukk/fc5Y6fAEvnlV1UTMAI1u/guCg5JYDd9YGvTK7QUTPBJAg/bmgKOviLyy
	1MJ7PLbnk1O+VffGweSRgX2A0TPj3GIO6UOYuQ0pjpguSKx9fXWMyf5v9E5snms9lNkLaK+rgGq
	euIbGNCZ72lMO+jEP1vFkb5en72HGkMRJ5v+4gZKonT3v/uhdcvuQF5341bbylrq4yO2ZNTB+sl
	Vie3Wzx8uI9a3F/dNfFICP9oQQH38syzYp4THsexdEiecOHB6wwB2XvaOmpWaO5gLpnqEdOd/bR
	pZSL5ciNZ7netPRf2IxoRQntcyafvW/jEfj/GLpFYu0WvwnMEC9anEvGEOLM0xP0ZfPqIFvbgH6
	FrtOBJ4EdmqhgNriWozdNEv9JG7dv02hSYrupqvbxNx05TSV8pRwZEPZ3ERPmG4Q5WwhGptfk7t
	2WCpwpThS8Ze3VLuQ==
X-Received: by 2002:a05:600d:8451:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48d187d9883mr36909545e9.12.1777986832495;
        Tue, 05 May 2026 06:13:52 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:12:59 +0000
Subject: [PATCH v5 2/7] firmware: samsung: acpm: Fix mailbox channel leak
 on probe error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-2-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=2402;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=d7vm0U9qdAXbH4NbIyamvNnVpjWmz6WguBCwDQ3CBjQ=;
 b=M+kZzEMj6dEoppNgvMWoO2zl4Mo+sei7crymfmwR16IvDgC0ez/YRXM/jUFit87zge5NsxBVd
 uPFQNsQWkvDD4wbmvIOaokkFfSWZApxlZ2CSlu0/KocvS/iEc6DU5Az
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: F3AB34CE3BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244144-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,linaro.org:email,linaro.org:dkim,linaro.org:mid]

Sashiko identified the leak at [1].

The ACPM driver allocates hardware mailbox channels using
`mbox_request_channel()` during `acpm_channels_init()`. However, the
driver lacked a `.remove` callback and did not free these channels on
subsequent error paths inside `acpm_probe()`.

Additionally, if `acpm_achan_alloc_cmds()` failed during the channel
initialization loop, the function returned immediately, bypassing the
manual cleanup and permanently leaking any channels successfully
requested in previous loop iterations.

Fix this by modifying `acpm_free_mbox_chans()` to match the `devres`
action signature and registering it via `devm_add_action_or_reset()`.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e95edc350efa..9766425a44ab 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -527,10 +527,11 @@ static int acpm_achan_alloc_cmds(struct acpm_chan *achan)
 
 /**
  * acpm_free_mbox_chans() - free mailbox channels.
- * @acpm:	pointer to driver data.
+ * @data:	pointer to driver data.
  */
-static void acpm_free_mbox_chans(struct acpm_info *acpm)
+static void acpm_free_mbox_chans(void *data)
 {
+	struct acpm_info *acpm = data;
 	int i;
 
 	for (i = 0; i < acpm->num_chans; i++)
@@ -558,6 +559,10 @@ static int acpm_channels_init(struct acpm_info *acpm)
 	if (!acpm->chans)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(dev, acpm_free_mbox_chans, acpm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add mbox free action.\n");
+
 	chans_shmem = acpm->sram_base + readl(&shmem->chans);
 
 	for (i = 0; i < acpm->num_chans; i++) {
@@ -579,10 +584,8 @@ static int acpm_channels_init(struct acpm_info *acpm)
 		cl->dev = dev;
 
 		achan->chan = mbox_request_channel(cl, 0);
-		if (IS_ERR(achan->chan)) {
-			acpm_free_mbox_chans(acpm);
+		if (IS_ERR(achan->chan))
 			return PTR_ERR(achan->chan);
-		}
 	}
 
 	return 0;

-- 
2.54.0.545.g6539524ca2-goog



Return-Path: <stable+bounces-242986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOtXJuNx+GlCvAIAu9opvQ
	(envelope-from <stable+bounces-242986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C764BB915
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7253A3016009
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45F539BFE9;
	Mon,  4 May 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjTEUlfN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D74399359
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889752; cv=none; b=GcVttKCpjl1KNTWZGWGGbbS7cTsQ+V3B437+PbS/tkJPh4uruumIMWU86egAd8d58VgmkO6qMh8icRVTo1CMXKsKyux9Va/DfM14yIxDgcIJtXdNRYL6MYcbo7gzh3v4vQ97zt+8fbuXexkAX1bGNl12jDqbZveSNFJJkpkQeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889752; c=relaxed/simple;
	bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+RoMFI2UKFEmT/6RvWdAiUyDCh+Urk2qrGsxlU/kwbfHyKJ20d8IuCgv3qNJUjbKS7GjKAMD5VCj+x7alMBs1wvwz6Fk2sX3auk4bNJTsMU9KOJJ+S6v/KJLKnlICNMCNmMTvmN3EUwMS4xH8+7CIy5EyZjBcraVgpbMsbjjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OjTEUlfN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso1261084f8f.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777889749; x=1778494549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=OjTEUlfNxGC41758zh+ueT+RSYTzbRLcr2f7rdcA1FddffBQvJRzuQ5VeCum4DQH+o
         JfDAy5iqZ83wZjf0gaRLLSH+cXD/GD6+l5eOvph3ezunkwPTXxJ7Md6bxacUGJUmbrN6
         BA2yTigkoxFbC0J0gdp7MTZCcnnK+Ufn47OGUWvx6NiiBAnADEpvHf14GMHQio6DzGL/
         PiZuIDNmzMx10SAp5ijYGeEX3QBLdxAqw6maGgp89LmJtm9OJZYhfVNBvn2sOHGr7Akf
         WhmnPNXWgcB+o5OKPzEDEnzLK1ejw9rHoY+mF4xG6R077lnDuApsDXs+S8jHCdrixypn
         WQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889749; x=1778494549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=sF54hJKXKhb94b/ejxmyoTAvtpyuyNYVN/dw9tru/RL1viQpkkT7I27OroJLTBfh1M
         07jqzd85kq/HGzZwnN9zFRYFIgLFM1DdevSo5wND7v4GMFnlMEmEsiileVcZWvGocTSK
         PRbl8J/NRJ7M/WSXzFIG+Gxqi0k5Cl6lcxEz5eM2jvCjVd+de/IUqX0ZKjxYcngznTgU
         SMgGghszpxb5sjlQBiE5W0tex7qqlA5ElgpcXndjdeLNNrfNS1UxNYvvi1H/9oRdMWvy
         r8rFzTYjPBv5FB25Nv2mOv8S3XF/aSldAQcmxBN4F/A4eAEH1tWqjFV7VhE2OL51rdDO
         lsEA==
X-Forwarded-Encrypted: i=1; AFNElJ+hP1JjCxxAc8grm7kEsNOZ0LLfUZBC3yuon/WXd+t4ufBST9PYrnCgQB/vrNGLCqivlWvsNX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4a92FSwKytaMA6c/nEI4pkLvWJGwOB2MbZkcVJSLsgQCeI/q
	7vsx0/r1a53aAYnUmBVKsNzrUiRcKlMIm+amW8uKltOPmflEcUzmFGUHd0k4HtQD/7g=
X-Gm-Gg: AeBDiev7Pw7thK6i0W6ESvHpFJuYPoOxKo59CiFXZIe9rWs/9mic6EFEh+EWdc2u5VD
	xcP4j8Z/i9WcAI7rAEQ1jYsSNPPl9Sz1KJa2WvjZaGdg+/MwPVSzvLDrn0z8Nxu1Qauhm6wpDx8
	4ff9Rszsq6TdPqe3cozISVx8GyzVi+1S6l3dMgSEiRvB/96F+i4hMIL0QNU4e9Ay9PzqI0wgncb
	U3dqyNrO94CF3jN3fH4gxUcrQM9r9y8Vco4YFoC1SK2GwRWfb25EZinIoHlJMaua968jJuzwKG0
	1aiy76osRav6R36Q0lS6mPaKFyyQpw14yz23zYqJ6l4QiunMcbWAlDx9Wb9BFN4uKvZI/AAOB+a
	wMVsTDSepfVNtX+e/GZ3ZMA6YXbkf1ue5QHFx1byTQ9WPDqjVoyH62biwEVV/GpBXeivZyAzjqs
	f+zHTK33siCRR9NNwQL7YB2RHkiCHKmmTIZAw38Z4NTxZcpTmlsY2x3haDtwDRDdTMRe56IGTXK
	W+Q53x144Z/T4Wkzw==
X-Received: by 2002:a05:6000:2dc6:b0:43f:e99a:ff91 with SMTP id ffacd0b85a97d-44bb4538036mr13545221f8f.4.1777889749199;
        Mon, 04 May 2026 03:15:49 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28545366f8f.30.2026.05.04.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:15:48 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 04 May 2026 10:15:46 +0000
Subject: [PATCH v4 3/7] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-acpm-fixes-sashiko-reports-v4-3-529246be6b2b@linaro.org>
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777889746; l=1843;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
 b=pwo0xPZ+j2nUIqRUV0W+GmOAiRSFJ9hB1ibEiJnHUOT5RynjZS2zWHluR75Uagx6xq6iMWjKr
 7H6qLWZki7ADMzuDAAtTu0ijPIK7z7dJq5AyuHmxz7AJ+lK1nM6C8kp
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 19C764BB915
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
	TAGGED_FROM(0.00)[bounces-242986-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

Sashiko identified a potential NULL pointer dereference [1].

The dummy stub implementation for devm_acpm_get_by_node() returns NULL
when CONFIG_EXYNOS_ACPM_PROTOCOL is disabled.

However, the active implementation of this function returns an ERR_PTR
on failure, and the consumer driver checks the return value using
IS_ERR(). Because IS_ERR(NULL) evaluates to false, returning NULL from
the stub tricks consumer drivers into treating the NULL return as a
valid handle. Subsequent attempts to access handle->ops result in a
fatal NULL pointer dereference.

Fix this by returning ERR_PTR(-ENODEV) in the disabled configuration
to correctly propagate the disabled state and match the API contract.

Cc: stable@vger.kernel.org
Fixes: 6837c006d4e7 ("firmware: exynos-acpm: add empty method to allow compile test")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 include/linux/firmware/samsung/exynos-acpm-protocol.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 13f17dc4443b..d4db2796a6fb 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -8,6 +8,7 @@
 #ifndef __EXYNOS_ACPM_PROTOCOL_H
 #define __EXYNOS_ACPM_PROTOCOL_H
 
+#include <linux/err.h>
 #include <linux/types.h>
 
 struct acpm_handle;
@@ -57,7 +58,7 @@ struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 							struct device_node *np)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 

-- 
2.54.0.545.g6539524ca2-goog



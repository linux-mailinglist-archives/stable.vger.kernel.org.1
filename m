Return-Path: <stable+bounces-244147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIo6HsPt+WkLFQMAu9opvQ
	(envelope-from <stable+bounces-244147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE1B4CE478
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F323058089
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2977147AF65;
	Tue,  5 May 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLSZ7wAE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104647887C
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986837; cv=none; b=iTnsi2iqZF4Ek+KaH3jzkzQDsM88oLs8u7Rw5DCPJdaDf5YSkdfHovxWUKhIOFSZ94AvoKCSBQkdtKGLEwOPXFBIMUHoZhnoC5p5eg1VSpoDG1J7rIaGJQR9sGlOGf+vbhkAn1LLe1+NzDaiO1Nzvm9DZvxS+nJ11g3jTceYRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986837; c=relaxed/simple;
	bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eO+2N4bWxUWa1QzsLS3lo9l5Ej2JAmNBEYswKuOpBcQAy4NoMKHx47YM6tljXklX2GOsZQ22iTuxkxMowtncXGqiAVwufxvDO4VkCMHjycP/cuq3jxZ2ziL31TnHVLwXWqx0PYYUc2iwq98c12iZkgO2qlwR36v2lcbeQW//JlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLSZ7wAE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso40033085e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777986833; x=1778591633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=GLSZ7wAEqzrE4C2LGFZSEGbYaGUjUlpYYk/a22kkXpsYhLEOSbFpfyE5q/YtiHwm7y
         OjwGWaaaEJnZAvAhzdJ8JL4XMe8YrJNmNmrKSoFjGI3eKU7wYcIBliSnHIJa5l+Ca9GM
         kKuJMPM8MmvlOnap9QDolXSAu4j3XFVfEr5G+xUhX+Gk1cR48PZArpBEiJ63GvS4LqXF
         6L7dSleodrJES07ejvwnJYbWLT40clQez2WpJn0K7ZqDu+13xYbRTRlIfm94Ggb4UNmJ
         1WOmvdJ+p1KjafsB7n2/qB879i5tRnMHI8vRsKD5wDPdMCsF1uxY3hB+jEX//dBThR+l
         hlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986833; x=1778591633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=HKplW8DCwC6wy2gQbF3q1XoyMCxbL+ksij0IaFp8TwHZvHvgsmRyFshx+td+kZqE/G
         jqSIjfs2kfB3J7Eesr9BxUiZE8CzT2khMnWmkA01hatYC+qbFcYdxA/3Ns1qTLZeBlC4
         Iff0Nyb7vtBH4XsxtrWT54SOfk040UpDaq80jEPJiOlJ8IBmorn/44j/1wcnQtVHfMdF
         F5k6b+Bw668I0HriMFJbAdR7DyAtodOoBsNzyZhdwwitBaBJxnxyxrsMVhJDdCBaICe3
         cydckDlp+V6G/K91exSTVhFhNfFD61MOOUT+kcHWO5DYj8nbeZFKZacMtLzw4q/p5aQy
         fKwg==
X-Forwarded-Encrypted: i=1; AFNElJ/fk2N1uHpu30RqvAWxQvyntPrdhe0K98dRSLnXqguOkCguQk332ZE9QQF62o5mWijIonSIzMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07jFtvC2mMW0xdmEEyZvVD5iSm2Q9gLnO94MkfYCiqAhm52y4
	1gtnOjJoQz3Gf1kuiF3217F4IH5YfFE5I5gH2XwmG8211cCc2MB/dGa6n8HciHA5JoE=
X-Gm-Gg: AeBDiet7n4PaQ3oLKITPQtboTcqGQjGGU+RcAHUCZcTh18T2TmkWX9pHfjNp6ox0UsX
	XIUnIz1t1e1XCJUsg8I7TrKCWY/ffaO89YgDVy91paE2+sHZ0+xW34GUOyTqhOgeCovULWQjDRO
	f53s+ARKq5NXnH0lHnztD2QNmYAgG+4Ws77U/LsUFcvjlBvUW6rjUAKyeQBLFNE6XSxK8BAcIdu
	cEyC5L4SqpzEnc2E6vRemyV6rdM0HPlSmicv0vlbMuMZINzkq15u13boh1DestROy/21nayqoa8
	SUtSkLLMwJzLZwgEwmhqg4iDL+q0n/EqkMZT4uiOdsswWlzAPfMgsC5cIL8ahgGbVaaPYl4r7/D
	yVcNTjLceL8hBbCXYhztXqiCr5QR4cKw6blZ7TozctCCcHN7ZgKbYy/HCffUAhEyQOc/SjKjdYM
	JWhLfNDQqqbSeQZgol84gHCKjjajmx3PJpxyNyeu8QSoicgznriFzQ7WZelERar3hl6QH4flWUS
	uwbSv3AztBbhgL1AegdjsZCTfyP
X-Received: by 2002:a05:600c:c0c2:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48a9865ea56mr172953595e9.17.1777986832975;
        Tue, 05 May 2026 06:13:52 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm366599525e9.6.2026.05.05.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:13:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 05 May 2026 13:13:00 +0000
Subject: [PATCH v5 3/7] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-acpm-fixes-sashiko-reports-v5-3-43b5ee7f1674@linaro.org>
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777986831; l=1843;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
 b=okAA+Mks+tiZ1s4Jc4QBMMHkSt6NGOv/LwbI22GhCddZCxVtABSB/BDAqOsUu9MonRPBBkxDN
 jHgz8DkXtR2AxY0TqFa7j6ljCUuvR6o7fs+Un23tC7Mas+3rVYEJtuK
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: CEE1B4CE478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244147-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]

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



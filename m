Return-Path: <stable+bounces-241345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HvxTKvt672lKBwEAu9opvQ
	(envelope-from <stable+bounces-241345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:04:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EE474D95
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56C103007507
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5252D3246ED;
	Mon, 27 Apr 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Spm2aVO0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AD322B72
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302261; cv=none; b=eycVcjk7knzYOXJ2QBDhIepmajv/kmhzijJB2LoS5JA1SxE9jvrWfxRY6BnsbEGPfpAYt6heQTVQ+ex4w+pJD/QupVDT7pKNEG8vCHY7yI7BOmcW00vrAGSSD8RYIS9K9dIJqfk4GzYc66dtezZ2Hrip7A4XemqYIBrhcMydM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302261; c=relaxed/simple;
	bh=fB8OyE4pYKQPjuNbbE1A8QI3wwuWeF5JuYv3jd8eSZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlBIYjFy6LEbv7EA5C2KyVLTXW6N6ReI0oF+ZOkul5Gos6lJest5q2U4SwZvXJUkMNm2mWdpA/QWYx0Mo+TS1C72PFUg5qFaefMyfFOO88kHneMXOKNEBkuIVa8KuoBCOtf7wNjbCC0S9mPU01VlxMVaIoAM9gKLJqAlex8zsIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Spm2aVO0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so75003935e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777302254; x=1777907054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfcec3d2oELkX+F8ksbnLWsp1V1TC87fqGSb/6ZmXtE=;
        b=Spm2aVO030DFbZfIBBjTfW9dTfGYYkBVvMXcfrua38eHHeD08I806NNtJ6VT7sa1rq
         6ICnc13qxKK4qEVLnBoDSN0gc549EsxOzukIoy7dymRKGLZEfHdqP4v0vcitYjg7XPQN
         UIFLru9emAhXcjh7NvFMPJvEyHagxYfqeo6IA1XliHUnqDCYebn3gi1oieXs7BtrGT8F
         RMy7LQsTAviXWweDJU3weaMCcIlIBzyIWm6bY9lWpAaOXG2Q55n2ntbWacNbJ1IYdF5H
         RVIm6O0k4pp4lZOK8PR3H8siwyL54OTTYuQNNWScgDGws/bYI49CkcaW0OJrpk9NIFXW
         1J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302254; x=1777907054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xfcec3d2oELkX+F8ksbnLWsp1V1TC87fqGSb/6ZmXtE=;
        b=J/GP++cOxiFJi8J5x3KiEeOV2LQxVgQeO3uIrxkrQZ5Wtq0vG2SPCjfOukGrkwxMgx
         r2P50w3Y6Vam3BvD1tQkTL0HuJ3+8pC2bcrhKhopJ3YHIpLyviBRKAwpc4sEz8W8A6tk
         caPe5/ObzqKvuF5F513AVFv38U8Qj8jrxkXfoKbI1liP98UJbdSGzdIpiwYUkskM9aVC
         Ce7lQ6kV0excLBHPUMeH2BZaxoPjKxIftpyJEBeRtLSB+vcZTE1JoNGHxvO2iOa8x8+T
         r50vJ/we177U8m1s+9SolThCvwCLBMWAo8FWBeuR0+CLk4gGa9IUXSamAuUrOx5aXSEt
         ZK1w==
X-Forwarded-Encrypted: i=1; AFNElJ+fLfCWwNSClxNqWjdBamfe0u5sy+qUBGlbNQq3Ix2DrxxkNC6yr5E8dKAqf8k85hWnZpumXjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt68vgHOAbhlmqa7wTyQQc+fEQHzmhVXosXWF1VDm6luNkWS/n
	G4wCRYqXkq2++pOPIP51oEtZraJUyFr+jGIPnPxp74ViZM44KjsFZsq5pgjxU5JD07zBaA9GvUA
	QwCQ4ysM=
X-Gm-Gg: AeBDiesvkz9dtCmXW/KwGWkRhOFYM7HiUTsY+lDH8irDV2sfLe7olf+iiK3f7VBCrP3
	A6bqOstCmqrXWDBXI7jkam28bKAr5qlQTRhmZhqFhQvis3lj5o2FNAEzVtEBVSORsh3bZZSfWgE
	4fwhJSKUlMar99Azi4bPtrh2U9denoxkEp2q4wCu0hpoSdqAR84A32aRpahFCslVBqKvh9K3hYz
	6s3B0//lZ2Ws51FjUsTLLdF7A88HbXec4gwt/1H7phU8UsiYqbFchcSvk6N2kLnjIpQ9ZSHdwq7
	YC7Bw6mrs7UXLcWBi7mIB8e6qEu2BV3VmfDowsfXWnYHj8kev0MbPwERNptGiWGczH7e3Zx3Ao/
	6vf+lgpJgd6gWpME4K5nHEaxn/fZhvGQaFgI0u/R9sHdBh0XAopISvYqMKDFn1L3fIAvmyzP3Bm
	/d4Hg6MxMk3dWaDMMwPBV22MAiNylrYEVlgNIJgtsjScU43jOOxu4A3St3OAA1v3PbOXqMfBnSk
	KWpAc/nhUHytmpkIQ==
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr527219795e9.2.1777302254188;
        Mon, 27 Apr 2026 08:04:14 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm235370215e9.26.2026.04.27.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:04:13 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 27 Apr 2026 15:04:08 +0000
Subject: [PATCH v2 3/6] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpm-fixes-sashiko-reports-v2-3-1ff8de94a997@linaro.org>
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
In-Reply-To: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777302249; l=1847;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=fB8OyE4pYKQPjuNbbE1A8QI3wwuWeF5JuYv3jd8eSZs=;
 b=KohU9VKCfVuIuMOhYROvJR+HIea1m6feyQAHQ9e2Mpn0g4X2Wbh/yKKVyVJF9PPGgjh7Ab6d8
 EfSIXn22EfOCWktI5TyxXcMHyE/XyGEbK9k3ED3GJnlMfiiN9DlvX6v
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 504EE474D95
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
	TAGGED_FROM(0.00)[bounces-241345-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]

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
2.54.0.rc2.544.gc7ae2d5bb8-goog



Return-Path: <stable+bounces-240504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDiYAMEq6mnfvgIAu9opvQ
	(envelope-from <stable+bounces-240504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:20:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B94539B3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F2F30555F5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469E318EE1;
	Thu, 23 Apr 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFV+Cyub"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536B31AF07
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953953; cv=none; b=UrsN0IgopX9H4seBLIbOJKzu5eV+Irz1MtZwLdfXvbmvuzUIGoIEHJC10wrQrz1YakciEfzvz3AnVh6fHMUt1uN6ADdAIpCwZDEouIMaqkuHwDmwSh+qlWDS1wJR87kIN9W5KycuSub8bDmRAA66cQoZJQWsXV/iuQnThXb2nxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953953; c=relaxed/simple;
	bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9CJ3YPtkUEuBb/thLpQ2XkcWiGQP8VF0DijyRAjXnFmdG5f62Elb0zzAK2x1zLFPsQXSHQ9HEIaZTh3eajOwivasSiXviktYlH3knFJdxBOpZATdcXy749zcK/0Jp8kaGmsVYcZsi60YFluGwRAK3Akrfuwj2fNHWaJORtppsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FFV+Cyub; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4411e1eba51so3316985f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776953950; x=1777558750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=FFV+CyubYP+ozgfBvbMITPj1BNmOhuRHMeOV+xU4zoI/IkpWUZT9xswbaCcw3MIeee
         Cjpkh6MnDR+GxtCiR9+Mc2Im5ZG8FqAWQmH4L5T5DsltpFLM8VuMIkjj66tfad3SJQX2
         BKeHpz8Ffq2upp4H6X2OiTe1cMJbWBRw3CCH95DnUoMz7EGd9HIy7HcuWU4JckfrJllW
         6L0lozPR0YmqUZPqHczg3BKizdsLrCfA0cJN1qZcugKm0vJodhYGTciBAhlyRVxHACkJ
         YnfF197s0p7OPzdtU3uPV82JB0gu9hhWLx54VhhUc+NjzxjnuvodRtQXcZ6e+6W/r7dL
         9Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953950; x=1777558750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=nVgZKXE4egrZ55Bf0sIeRaY2B46P1r7dYUywFoU/dr03vSZgi8GesXIdvezmxZLran
         bFwTamClTaIaXtUHDekMkXlEHAsoIMWFDxstQ+Ook7ick41Zn4YhhT5aEm0DTETpZxdr
         PdU/CEx1lz4qg+OkVXTXsZeXFUcxTNGFcO1gbhvIntak7w1W7i9LLy5BaXObItdnEo2A
         5iYRpqXhpqYufjeSvlBdTZGiTkEpgk6BZIxM9HB/BZcB9hOjp+7BtBWOJZl5Pg3LEe1H
         IQWCM/F4rvzTUbmtUzYHcj4jV5pksWzp5QYFhvf9zf8DGRIHBC9qwrERA9geQwdLUy65
         MFcw==
X-Forwarded-Encrypted: i=1; AFNElJ9JxpHrGbpnuHgWon7ZgpYZGOWV1RCe9ha/6kPnQaBtEjs47y/jOBSRJBGpvWN/OFheuH0mnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqtyBLvxBsMJSUvTyUoMI43AwsYww5rLmoVVW5GXvFDAFcTih
	JGMFrx8bzbWsqrTp43SAPQ9Q4MxQMgoAnG02ms81EPaU3En4BydoavTD6h3prHn7SRE=
X-Gm-Gg: AeBDieuqMTxSOjVtItbib2kxVho7UJo7WFDEz3Ps2cyCaGPU6cne8Ph8DNubQxQpiz2
	/YWOYtbwPVRkObZRFDf2TBVAKik9r6Bitz4q4LWhkPwetwCyhqI3pG68D7DQS9NOF6Y7WrpaB65
	qCJwA+c3SrdZ0HpLIX3dOdtpLiUv5I9XW5a38JWGO5KRlF9MNjDMQNPrSsqP+npDKvarR8cEiNZ
	k3c8L9iHdtLZayYEiV47bREcCa6jAxS++CNpFpUAvUvMdYV5zen/wQh+x57S/ginwuiXHbMrvc3
	XGXQUbAxAIzSV0hN3bjvYOkSLv02N4oTH8dWelFWtR5g6IS4ugF0gF4wJNpzKmj5edGti+TZwSP
	E71trjrnS4L+GNUnS+BQ0FeetDsryCMkIzFbkuGkFEVKm5SwYo5pLEkOpWYpe3sne2FL/Cz0ka8
	NgDHA1h1zJl7KxK+RTgvK6LvJd9wYz9wktmLHQ4ZEyMCR7uKdJ6l39HEoHTennQ5HwNvV0eL6rz
	fjCRm+w1I3MVD9VqQ==
X-Received: by 2002:a5d:4ed2:0:b0:43f:ea25:20ff with SMTP id ffacd0b85a97d-43fea252120mr26389443f8f.29.1776953950228;
        Thu, 23 Apr 2026 07:19:10 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm51107483f8f.31.2026.04.23.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:19:09 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 14:19:08 +0000
Subject: [PATCH 4/4] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-fixes-sashiko-reports-v1-4-2217b790925e@linaro.org>
References: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
In-Reply-To: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776953946; l=1843;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
 b=i79vicUFzY3Onqf5OYj/Gpp1I7cWGIKf2Gu04oPG78VdXvKe/mM1tWjxIiGpqqhWXVO7u+3NR
 a963qJxKznSA4ZndiD2phqglKzLbYatsVVbBB1pq3M36X6MzqSjxJ6G
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240504-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 286B94539B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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



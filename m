Return-Path: <stable+bounces-241887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPkXCN0E8mmsmgEAu9opvQ
	(envelope-from <stable+bounces-241887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4CC494A6B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F34330BE8E4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852A63F54AA;
	Wed, 29 Apr 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WO7hfi0O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D63FA5E5
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468317; cv=none; b=qNFA1bjoeZCdusELv6f3+fCTxaFz2wI9pCwRl38n3MLnQwDpQcJL4HrsZXfc2MVbj6hpVkY1R/ZZF5binKpCFypJfRLAECk2BHAmn9+DJGtrYFr23PfHzZW9usncPqbNdlhX0X2TqTzTHNTn26FcXPlciAS5ZIe8IwYpQ/aL5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468317; c=relaxed/simple;
	bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vC/c2lU1GEVSer5c6F89HYAZhfmj8aCHik15Jt/oCr545UCRDA6ZYuFANuq8cgC7m8uOi+VUi2ewnfnhEAYXUIFZJ0vWkwROpUc5CpiADfCXr6Eq68YvdopSw8eHFN/pNg3UENsFyVpys0E++c5U0osZ7+ehOmXbWhp/PEythIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WO7hfi0O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eada6d900so12013722f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777468314; x=1778073114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=WO7hfi0OTj8I0r4gt+AcC/GFNmGJ2kwUKPNET49mMFGmOkGQCOPiPfoYn16nQv4xQw
         HRju2Xkrl4X7Mfa7QQdI8fhp6jjrfXfhZe/sv6dQXewGP02tgAr83hlX3tB0BFsHezB5
         GRo63mO2Gkt7tcs6K7FWlF+0iHc/BU00NkSW2hH31NGoCK7ht+mSAceNaKnMGnmnxNW3
         wf1lpIRZP6OTN0W/7u3tNzmDKGJFKqjeYny3MOc8sbzVyI7KhTqFoH/onShwFDpUdw3N
         9FT2MAG/KCevGWkS32vnOF12IOIMpHIHWj//cDwhMdxeW/p8ZGlOQKkE2DSA0n6mbo4a
         jkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468314; x=1778073114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Mo2IeU/AaXoLyUW0cqRpgQJYVfBlAhtHpp2oMUPg6A=;
        b=ILKEKsLruXsTge8dJ7iaNWKggPQwf7yhtyJNZwozD6QZx8Ip44WoyAVV6gKSnjiZzT
         aDiQYBMMzciXVx0luTDMh+ciDb5E3xMemsQdQeiSfP+LyCsGfP3x+3ITgwn1tUFWEE4t
         tc8QtxiT5bnl6rU/bnFLPhy+9UvqC+6za8RYuFtgaGGkBtkp9FO9oXN0Kp1a9qQNtMI6
         9JUkb4K+HaSGy/NpcK0sOYJu04S41VXm74A2QNHGjW92xOSR/doZd/2WcNnLMohdbJsq
         cvLJtop4dakbPtsqevsOxLyZdP+KWoNVcCA6ubcRF1zDpp3jlIJuAcIpTCrGxV0Fwu6Q
         4Xvg==
X-Forwarded-Encrypted: i=1; AFNElJ9ULxRsU21/1gbUk6W99h4cPz6U0/V67wfwL+OL//N5RdElUSBaZ9CcSnTR4iDKtRopFBNE9KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+GDatm2TfhbrUtUccP/5jn7iR9/BDwZsd9+G7/tQYmVJt+FO
	N2fJ4I5BwT4rJSgV8hszYYY6XD8eAXCsMalO9VutDQp/SAgbICkA/CWlyZm2FJPtvos=
X-Gm-Gg: AeBDieva6eRPGh0S42IWjWeYHdFcvVJlRLSw7HJ4KKx9XHVwrK4r5Yrl64lPC+czSxj
	Kx6gDxDiMdc2jgxr3EXShwy2u8I7DQSPf9Q1j0Z0PzUYGyUBFjHq5k3gQgOKVuuc21d/hzqYeD1
	OALPOXEpvg7b6A3hrdOHig/1nzQK9PAUSp92XxSyY/9sTYn10PjjHtiLfcHGL6arbddMeqzlOn2
	3imGs99GwKXk3ZpQ23d4F69TCjGj+4kMjEptgjrRurJ/HROQudKLKNvhB4UQFXUJU/eeIacgdsS
	+mlATsWn3x322CGc/V+kMjiNrei3OHxFNUAwSP6tbbbAx8U1Ftd3ZcGFBdh7RluTOCoy6bddaPg
	h+pKRo5mTgzv4NuNrn9ZEKiZkv9MR23NpcHKNU2N1K0rWLKGs+1uCkC9neN0TO4sVMgUgoCwmId
	pryDTYpRjSiEYpdwOw27R84qQYaisy/ON4ha3f/F/PcImzWxYT4giLUtuDAhSia7g51BAAR8vQX
	4IqL/kTdwY4l2SZ6g==
X-Received: by 2002:a5d:5d82:0:b0:43d:7946:bae6 with SMTP id ffacd0b85a97d-4464aced1c2mr13929202f8f.43.1777468313490;
        Wed, 29 Apr 2026 06:11:53 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67b9sm4752867f8f.34.2026.04.29.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:11:53 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 29 Apr 2026 13:11:52 +0000
Subject: [PATCH v3 3/6] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-acpm-fixes-sashiko-reports-v3-3-47cf74ab09ad@linaro.org>
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468311; l=1843;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TrETAIBRtr5BpleipM5VXU32aMTdlU394IStlNmAoNo=;
 b=BzENjihfCSCZFL3n7ZtJCw2aaF7Gh/2Zynwp/jBunN4QYv/RWtS8Taoiuk5IhWHY6l6iEMxVW
 ufkny/ebf62B5nQoJpAwAt2YH2fLC9o7HUUqzZp5c9a71p70GqOONME
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 4D4CC494A6B
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
	TAGGED_FROM(0.00)[bounces-241887-lists,stable=lfdr.de];
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



Return-Path: <stable+bounces-134885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B914A95711
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772C118939D1
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E991F09A3;
	Mon, 21 Apr 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Yf0jxJ4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0A1EFFBB;
	Mon, 21 Apr 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266400; cv=none; b=AmvaQgattx5gBomMcGVc+Vt/qXllUlQP1suE+lBYYWRMUszAWdIrl+vfdjLPih+ZW5mD+M2G+nZtmitxmwWjCFs49pj23a/d6NOcw96X8Qbl+adPtMgbZlHY2ICpIHeJAcTixUfer5a251QwPw5fPZspuUj2fBwPok3hwvESpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266400; c=relaxed/simple;
	bh=pPSvjKFuytS3W/8vuBEQCuBseFQbm2us8uSCuS1HVI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME4GKFKvCsyaN4h3Q/DFhPLUU79iGdqd6D46aexJis/xPmPa/srqZR7ltQRfQa4icKxXsOyoe5WfyLumL64gsMV5Gc3jCxsAapLLnXblOA3n3JkRkBBfCTqptEtALId3U+d7QBTk8WwwFpKqDVWh7DUyMDzGxOK6foP4t45UHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Yf0jxJ4l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so5322987a12.1;
        Mon, 21 Apr 2025 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745266397; x=1745871197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ3M+bxooYYic4r0LufR96nrU2z3BmGWMkGOU6zDDn4=;
        b=Yf0jxJ4l+kyCceqmWsxcnI3Cu6UjI2svpC6s7aDfgyTG+uUSGA5TbrSxQKVIGdoLjc
         B0fTiQh/3gMUVfNW8QMf/BeTrheWlBmtBo0eQxj0940Y3R5cpi73v8fRJhKj2go9UJ8q
         RHBDW3EQlZK7v4ecqQs1LHQIk2pe22CSX+6/Y416XPD5tshJArLWu7QquaFeXIMsaQX6
         4y8X+QXqkRCTUrsTuKNamLt3kOU6SmxzY4lGLJu+8kryAZ748l7VLjNgY+LpXGFCuTJk
         EGsZ1yDmvf2WiXpcli5Vudd/bN6OHDcpfVuy4mkrBXTZ4cpIz1AiJLjHm4aFGmKwyZMX
         6QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745266397; x=1745871197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ3M+bxooYYic4r0LufR96nrU2z3BmGWMkGOU6zDDn4=;
        b=A+AAfliZWTNDga5oMEM1sMdnHUMUzXhSV0Du762G0FybeUzrCJ+8Y7GA/1iBjiQrs2
         lmHKTFfkmmRvImS1DttMCN6O1rbePLSNKVlkbwQ4mbnM4SMs4Z+8QwEHhiolqoYROCTP
         SB/mn2GwWMyXczzBgDcf43qaeYneVzPlKa85KVAxPQKoSjtgfoadZYdkyBwHDzru5T0w
         DHid3K4UBJZBLmc7badnK32F/eXZeWZb+v+HAzIeCdPxzttoY6MgQJL5Cf2kCip9BT94
         eVQDLK+VulgDqA9sYOiekSED4ZLnrErMLc2sINtaWOSqF+wnxLSq2yIzB6sR/hKM4X24
         nlCg==
X-Forwarded-Encrypted: i=1; AJvYcCUDHy3HNmqgu2sSg8W9hwfHe9oHTbawtnOCy/CEycJlvtVu5vuAd9IqW3/g1mlpECCUG05fLvDu@vger.kernel.org, AJvYcCX8vFhgDJ2Cx6jQEQdRb0bnDt6vB0p8IBls9jzTQAAk+D/piQNVlUz+2y0uGjPq2nfR6z9xT7R+e9ajU9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSum0HD4tiSlKn8XAIGSDVFKEmB3eMTuBjkkoBnKlIkT2nAncg
	axvFIBcuUXf3K+BXmeJcHnSdGIUuft04GVmWDhkFGLScyhb4zNuz
X-Gm-Gg: ASbGnctLSZ92gY9Cy5jBr8E3uokkMiI3Yr/jLROs9h5Si9TdC0n/IjoElnyP/OUOPEQ
	dHEhF3OXmWqL0vtIWQgKxJ++x/roN+++IYoDIzeXM8QBuypQaU7M27a+2G21Ah2hipRexrOWLdx
	YCiwrMSKPft4F/Dc5Bq1QhnIeGJpLBQUyTnwWgDEqiqSGSkT5NmjIMWqN8GNfIzhm/d1lM5UIMj
	DO1+/eOxGxWBpv9H4IgieD32wgG6MNIzY0XAa7/0k4Zmg85ydUNugzTXEl/G1FRIi48yPygcjPL
	6ZhwykTZMbMEi3yIW0JnZNkhqP+sSL36lLjGH65qeMoaDS3XdU4amZav1b4ZEKf83+B9vTjcoYJ
	BZD0QBUDVACdEpn5xUYpief+Di3o7payoPaD+hkAJFWEjSeNhfVHxc9cGK/ltp3TSbPl6yi3ssk
	JT
X-Google-Smtp-Source: AGHT+IEaYd+jxjizAP2cVKjHkYaRIFui46Kp2EDtjubhkBoNX1u0J2KrystqnAigLWaQ0WwVYnx50w==
X-Received: by 2002:a50:ab11:0:b0:5f6:44de:d977 with SMTP id 4fb4d7f45d1cf-5f644dee040mr5106066a12.1.1745266397171;
        Mon, 21 Apr 2025 13:13:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a503-5900-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:a503:5900::e63])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f62557a547sm4955447a12.22.2025.04.21.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 13:13:15 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org
Cc: neil.armstrong@linaro.org,
	christianshewitt@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v2 1/2] Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"
Date: Mon, 21 Apr 2025 22:12:59 +0200
Message-ID: <20250421201300.778955-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421201300.778955-1-martin.blumenstingl@googlemail.com>
References: <20250421201300.778955-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hewitt <christianshewitt@gmail.com>

This reverts commit bfbc68e.

The patch does permit the offending YUV420 @ 59.94 phy_freq and
vclk_freq mode to match in calculations. It also results in all
fractional rates being unavailable for use. This was unintended
and requires the patch to be reverted.

Fixes: bfbc68e4d869 ("drm/meson: vclk: fix calculation of 59.94 fractional rates")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..2a82119eb58e 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
-- 
2.49.0



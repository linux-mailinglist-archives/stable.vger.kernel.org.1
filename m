Return-Path: <stable+bounces-188993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D496BFC3BA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7AC626036
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3134886F;
	Wed, 22 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBhLgU/o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE849348868
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140071; cv=none; b=fRA5kpaax56V3hqQJj7czWgt7sPCT/aZ3qFitQHUvJmB3qwfotrYXCELhvLrTY/x80Hm8ZERePmdpefCNkuJSsPHy7SnMILoVde07Fx+jPbMF7DE083cXZ1PRF3AxyEQpgOFTC18hb+vjdL4nGp8kR4Se1o0bXLeg8JQOxfXdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140071; c=relaxed/simple;
	bh=t58k7nuf9fXppT7leLM5wPeiFjCn4yr98+SyB7CjCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1ezxO7MMh+h+meOws+z7ALlBobPZaBkCK3V+7sUBqZLSfcfP1yDH7/awV6XcLWEsQerl7+C39z0IkslxhTyVE2qRPNaDRPXXr3EtOEjH0bZpVAAdKFUTo7PbnO+OLnfjogC3z4jkOJZlhO/EhXCfLY68MP9VNynk6a7NWBLeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBhLgU/o; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so793445f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761140068; x=1761744868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFXbojovxWliJMkNJdsF09HvmueXHOHMsMOPKrCfmZA=;
        b=gBhLgU/ojivpduN2gcdB3lUg9+9Jw7ht01gSzRJMbpFRrvZ+TsIcl3tzsrQ06XaBYG
         b/LGE6I5n81903wXqo+Oj8YUcX9v2nTq2N3tkW6GZQpPck8w/Pum/0u/RAJu4722PNgX
         OOsuBrDMVTccEUBqEflyQojt028JOadAoosJXDH/K6f8MsDlY8PWnKXQXFfQPmBNAMEL
         aVvi//PoQF0unp1IUDv2llfwZ/pM3QWUMpzFeeS50lXHlD5BtgE+jCq96b1pGGBPcasy
         OZQkOTuqoW7zZiyVw3/KiA/3NKHozYEDWHNd8RRJKErg7Ik0/uuPM66ay3u9bxalaaxV
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140068; x=1761744868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFXbojovxWliJMkNJdsF09HvmueXHOHMsMOPKrCfmZA=;
        b=L6pZ6Til2CxeMT7K1y4Anii+QlPl12fxSSH7GOCNF96gZRSXD6RwVWK6F+n98KomUp
         PSUiA4KBbobgt5XZp+jl+3lxjks+f4ik3rbxn1Q9Ut4dn5JyPqnpppbV6YCKxqG1k3tW
         7mACoA4iL4rIjIp1Q0P1Ej7/PI6yRMQlWt3mONo9ttTe+wFMHQorEnQyY3WTBB/V4Y+T
         aU264zmYHrTF7Pa0r3F87VYQW5rvS//KAXMCgeCHrmh3Xcjc7/tKyNXDuDmhcmRgTe3E
         aNTA6IBUXyztP4znt1bQJZxUVXZQMbnYP3MULcSl06qipyQ3LG0cYyuBW5mW04s64Rro
         iiAg==
X-Forwarded-Encrypted: i=1; AJvYcCXj043jotiITkxx9m04lp9bLK0sz/qETLONFjG+Eby1CtxJW6w0x3V5a5lgnP9Rz3JmcV6dZ1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYt2zDtO2dzM4kkeb/Fudx8y2Ki8JJp0yD+OL6OQ0fIjGL+JD9
	r5GydSWXWW5gKt0BhD83Qmrj9+UDluZoAufffqxZlPxHHKWYuq4TvqJ/JyE6aiyXP6g=
X-Gm-Gg: ASbGncsftJfau6HdAqAVD3ztsTZeIx2rRK+Em3DPX3ekVk2YHBoQWErUXZkKVsplx41
	veeDBJHYGNgmZrBCqdyWNCNfLI2k8Ruru8u+DLu+ktUxWF0KjuMl+7aPtikaD/NX5pL6vnX8i5r
	fSvkSYjODEAMVHOe8bIrJzL8OWbbwcAfkkx+mdKLgSM5OFz/EEMlLJm99GReGlDY7zo5rcEZA50
	UheYgoMF7aUujGFv4IG1pN8tZxLyguknw655sCshYE8Qg3iefIc2eD0mih9ELAV2ea2X9aMgLFo
	3aErHx6u8XY7VzArvYh2dL6jvv7T2yIa/7jAlQpMoHFUaZo9wiGuotnnbttCJ/v8stxDpS6qid/
	dWSSQMzbUFren/y/jZCWdbu22BzOt1rOyQz5tGD90ukHW/HA4k5dFXAm77ap4ETYI9zzf0QbTW1
	j7AW/1LdCoqbDnTmNib88Udg==
X-Google-Smtp-Source: AGHT+IEWcnZIaP2wLBKfRqry0HILeS5KfSEJcKKwt34JV4PPLBebPsmgOhwbhA8EkzXLqs8P73MPpA==
X-Received: by 2002:a5d:55d1:0:b0:426:fff3:5d0c with SMTP id ffacd0b85a97d-4284e531afamr2257012f8f.1.1761140068108;
        Wed, 22 Oct 2025 06:34:28 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42855c2fb92sm2981201f8f.46.2025.10.22.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:34:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups
Date: Wed, 22 Oct 2025 15:34:26 +0200
Message-ID: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "groups" property can hold multiple entries (e.g.
toshiba/tmpv7708-rm-mbrc.dts file), so allow that by dropping incorrect
type (pinmux-node.yaml schema already defines that as string-array) and
adding constraints for items.  This fixes dtbs_check warnings like:

  toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl):
    pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_grp', 'pwm3_gpio19_grp'] is too long

Fixes: 1825c1fe0057 ("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/toshiba,visconti-pinctrl.yaml     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 19d47fd414bc..ce04d2eadec9 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -50,18 +50,20 @@ patternProperties:
       groups:
         description:
           Name of the pin group to use for the functions.
-        $ref: /schemas/types.yaml#/definitions/string
-        enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
-               i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
-               spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
-               spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
-               uart0_grp, uart1_grp, uart2_grp, uart3_grp,
-               pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
-               pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
-               pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
-               pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
-               pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
-               pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        items:
+          enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
+                 i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
+                 spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
+                 spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
+                 uart0_grp, uart1_grp, uart2_grp, uart3_grp,
+                 pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
+                 pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
+                 pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
+                 pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
+                 pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
+                 pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        minItems: 1
+        maxItems: 8
 
       drive-strength:
         enum: [2, 4, 6, 8, 16, 24, 32]
-- 
2.48.1



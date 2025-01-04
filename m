Return-Path: <stable+bounces-106748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD4A0152F
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AF18844DB
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA8196D8F;
	Sat,  4 Jan 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjN3yc/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B4176AA9
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000420; cv=none; b=WL68vmWuZinwsHGLA3y08drqIbDYeM8A/wZN1DlWX9kIMvdoOM0xlHnabMY+I7lESLsBz9y5FvPEG9+KMlhP7RyoRrUcp+r5OVWsGooc2vqtxLtpCUCknk1NSfJ2Q2/GbCpPEkg4V4WM3QPqiOD0PStL0b2rRci30i++lDUJfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000420; c=relaxed/simple;
	bh=4zBqMtfnCS8ROjZQQAS9yX5lEA/HJVnxMzLV+ptDTTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzpyXJ9bjxecy88uA2n0L6h4Qr6qAKtHByOFdBaQIUNOQ8XakYqTVen5UOH03OIpgHJhKk6FKZZugjXoayJFn4UfA9GJZNZHI0INbl8IjnPU5Bn0xsC7wtgXqkLlfKc579hSBApois+8vUBz1V8+FgXYwzBUBUc6yLzsWqvoKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjN3yc/F; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cd8e59fdso2224813a12.3
        for <stable@vger.kernel.org>; Sat, 04 Jan 2025 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736000417; x=1736605217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vYfoIccjBDkjw6cbBAv2evM0j3S7+LR3G5bMrrAjuw=;
        b=tjN3yc/FJZV8vIlac1+YPfBE+sXzCTsWEHfCKzbVCcLDcqvJ6COCWEGhRIbtBJXDEU
         BOKDRk8qgWK1YyqycVAaya/Bv9bABXNuc+Kcilc6C/y9waBEQxLEVjYUKNU03ueUzZYZ
         dwvcHqc1bGCMF+9bWe7P894JadvBfscFlE5JEtisEHuK/vbVt0HzFO8q3oY7L3P0Xurf
         KBQQszHuOP4/rweYMvj4C52zV9zG+ErzvqzYJQwfXViUaKwdTpMJ7wXn1rHElAyvopsX
         9/5WAcyMsy8fJGqu37SzFmvZrOCc/2SY2nSbUEIC8rY/NVZH4OfIsmHj9RZPmv7oS3WM
         abiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736000417; x=1736605217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vYfoIccjBDkjw6cbBAv2evM0j3S7+LR3G5bMrrAjuw=;
        b=o6ztnGBLsVNVo+7nVsw6MAnzJQ4JHbPcN+1im82qPinhWhpxnXS3/ijv/kdRUA/hWy
         xe2kDJuesWgYcKyioKRcdmDe+C8cP53KJeTGygdHx+LPjh0+aZwE6c99WB6zLOebUaQk
         B1exPjyAe0efBq6BHduZcJPtNrHc/G9zLfSepavmvnkHqWxEyJ9IseJ+k1e0uzo9z7u8
         3t+YKFGZ4U5ugWmgjUFkbMz4OCzbxHRMlOO/fCsUjt6Pg94gbYHWFn4xHMVtLU1ITFsP
         1j1DcUY8YVswzprPJZrHye2VcHvjZi1PN3CBiDlxByb/3FpfJ6KECpoNIyIGdTxj8cdp
         6RLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNSmoKFZ5yfuTk8bL0RO+8rTcJKDRo04beo2N51Deiacn2NSsu/ii1dDMNnXXJAeHIk/T7LDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cNh4x/YF3XbomkP921zV5yLlQ/JxJ7UJtNltNQHuHX76tT3D
	LtUQ2IcFZoM2H/lLytB7T1dP2jAF21HXci5waamUNxB71BaO63V4C2ddVDO1/z0=
X-Gm-Gg: ASbGncu4Bt4RS+QhfNdwvdqKo+4QOZHM9u5faIEGjefN9vl41ieD2weqSjSg+o0G084
	7YgsBEZ3M9HbFGV4GEohVwzDgjhf/TtNK28yWGMdG5Se8xOhS+mlOOvJuE62sBN90TGibaR0HDB
	li/siZ5LW4x2mhboFyOj4aS5V3RmTmVnUoRdm5f13iqty15uclxP0Amsucu7/H7bSnJ/6+U5A+M
	qz1afk6Gk+EXUYjrBQR28CJRcMGbydKZS5mwMLEfa5PszJFLIkqEeQJiW5cvsFI2C41OaM=
X-Google-Smtp-Source: AGHT+IGha3K/A9wzcwndXIIgjH9svK3Rsjac/aT49HWWAWPNoZX3f2AfqQT6YbI2NKa2kWUjRR+k4w==
X-Received: by 2002:a05:6402:4309:b0:5d0:bcdd:ff9b with SMTP id 4fb4d7f45d1cf-5d81de1c2f0mr18117836a12.9.1736000417341;
        Sat, 04 Jan 2025 06:20:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fed4e1sm21376270a12.70.2025.01.04.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 06:20:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neal Liu <neal.liu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] soc: mediatek: mtk-devapc: Fix leaking IO map on error paths
Date: Sat,  4 Jan 2025 15:20:11 +0100
Message-ID: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error paths of mtk_devapc_probe() should unmap the memory.  Reported by
Smatch:

  drivers/soc/mediatek/mtk-devapc.c:292 mtk_devapc_probe() warn: 'ctx->infra_base' from of_iomap() not released on lines: 277,281,286.

Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/mediatek/mtk-devapc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 2a1adcb87d4e..500847b41b16 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -273,23 +273,31 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	devapc_irq = irq_of_parse_and_map(node, 0);
-	if (!devapc_irq)
-		return -EINVAL;
+	if (!devapc_irq) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ctx->infra_clk = devm_clk_get_enabled(&pdev->dev, "devapc-infra-clock");
-	if (IS_ERR(ctx->infra_clk))
-		return -EINVAL;
+	if (IS_ERR(ctx->infra_clk)) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
 			       IRQF_TRIGGER_NONE, "devapc", ctx);
 	if (ret)
-		return ret;
+		goto err;
 
 	platform_set_drvdata(pdev, ctx);
 
 	start_devapc(ctx);
 
 	return 0;
+
+err:
+	iounmap(ctx->infra_base);
+	return ret;
 }
 
 static void mtk_devapc_remove(struct platform_device *pdev)
-- 
2.43.0



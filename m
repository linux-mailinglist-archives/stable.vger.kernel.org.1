Return-Path: <stable+bounces-160358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA16AFB12F
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B707A8849
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A829614F;
	Mon,  7 Jul 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNZKposv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09421C18C
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884038; cv=none; b=IcoygHd/W80E+M0xQa8PQebjsezY5AFpMg20wLgrKFpp3z0yvwoG+Vlg76vTfBJoeNT6PtL+lJQFkBInoXZVLlPMGYwUOAJXSd5SLKYLAXaIsgEzn1HPdrpPQugisLvD+kK+ZF7nU/0FE/4nf1ojGP6in5IV0xwyi/CDl9Gz0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884038; c=relaxed/simple;
	bh=xFUNUc5m5ajWoG/fAc3PfI2ibizJRteLWpJOojk196U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hDctKDa1alOqJZlLk1jrmvf9D75yyOc1Rw6CkcDdZgAaZqCv0Rm7yKOFPPRHDR3qLtyvZia585JOTt2ByWGL5E2xWUKgwgITmNL2hR96zETq60Bui1BY1CGhd7PIpSzaFEheb2tVwfyknZ6tbA8XAXBhsGXxltHSJ4sP0fRD6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNZKposv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23649faf69fso24160185ad.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751884036; x=1752488836; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrCguQvMCX0qN0EKrycpjflp0FRWcgp0pAKxoev4M7U=;
        b=YNZKposvjQSErj8F+ZstHuGLurQsHkaiIGNtvQi3GI2HkLtEGEvEH0XLxc8HXLpBb1
         stx3ecuLmfejyyHVBhb8llXyxE8CCGYPkudOLGJ10/10lgSlfb2+hgttYmKH4fkk9agn
         XMKKQL3b5qAYN7w4CPqpZ2tYSSSvIqyc1iySg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751884036; x=1752488836;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrCguQvMCX0qN0EKrycpjflp0FRWcgp0pAKxoev4M7U=;
        b=ru344DSNzbq21r+/XOM94U4xSnklRebEATQa2ya/DZ3XmR4QMPKAdubEMCziuWTmiz
         M6FbrtbhR8fkJQ7mfeOQ+IKXHYACFxddpbN0oHEg9I1PzXz3ye847LBXj4hX6dPMYIEc
         xQF1uDAoD+mVIW9r/LMXMTS5bVwEJN2I2r4fsZJyYKuLyL9PD60R058agupYJ1szzqia
         InRReDF360vBnibpk4sWt4mkuw9OKIT2Nv+NKj8FB9QE7gc3vJGvPj12Yh+0/HC7VEXZ
         qo2YlieF4JFISz71cQqYzmCoTe4EmwQqLT1+qKpqUgQcOeE26zuJpvR7k7ILDFcRSYDf
         8gWA==
X-Forwarded-Encrypted: i=1; AJvYcCW2NrlJ7FUQenroUMCTjPK6LwQLTCxAVvzNHXf8SrCHJoKc6FXxUMrMoN0sPvXsWkpJwibHkH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVthagguxLHyY1Svjif3yRApIzAprXLQCXlpL8P/2+7W0tZsBa
	DYN49uW3NjgDdqvt/sGWE40qiyjl9eXfZKfF2yXy3oJ0RTy9T/UXn9DzEV9eVxrjHg==
X-Gm-Gg: ASbGncvoV8xqkXgk6sKCF+BAvXNH/l36mLcY5gZ78QYprX6EZlM6S8PfiQH5/TTYbSN
	7oRhaXTYrY7SmR6aCq81YwQ8ohaDpNxlGYa+8zs/5M/+5pp3rDTpLiiZDrxKabfzUR/lgq84dg5
	LdVNN/mcn5isISwfdDx/DyNsyDySvf+hGvuWfelJmdt1eOTudJoA2BfCi7rFZUNHUhXxoV8ww0/
	tpRiJ3RB95/0sXEBaA5dg03Cx6VZdZwkBlgAzUH7BvsFocEy1P7T9GxudFcieZmnmzgwENiF/Ep
	7FrQDsDAu1el4u3HnKO0sou1BwYPr2XBpPdcWGTfCIZkrNEc7obidulVYMOonZKR0ScQ5vqiNvh
	dzprqz0f0CkTLNIuAU/3ZMDooK1W2Vy8=
X-Google-Smtp-Source: AGHT+IFDfxeN+onnny+B6L+7wHiiEtPBfsMaJLUeKdhihyzBWk863pmDXzSYrNTM3um5yiBK4Jo6vQ==
X-Received: by 2002:a17:903:138a:b0:235:eb71:a386 with SMTP id d9443c01a7336-23c875e8180mr142789935ad.50.1751884036508;
        Mon, 07 Jul 2025 03:27:16 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:53d3:893:10bb:1dc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8434f0d8sm82986895ad.82.2025.07.07.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 03:27:16 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 07 Jul 2025 18:27:10 +0800
Subject: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
X-B4-Tracking: v=1; b=H4sIAP2ga2gC/x3MPQqAMAxA4atIZiO1/gS9ijiIjZqlllREKN7d4
 vgN7yWIrMIRxiKB8i1RTp9RlwWsx+J3RnHZYI3tDBnCSyVgOMVfSI1beNjcsFILOQjKmzz/bIK
 +6mF+3w8zmkmzYQAAAA==
X-Change-ID: 20250707-trip-point-73dae9fd9c74
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-2a633

After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
("thermal/of: support thermal zones w/o trips subnode"), thermal zones
w/o trips subnode still fail to register since `mask` argument is not
set correctly. When number of trips subnode is 0, `mask` must be 0 to
pass the check in `thermal_zone_device_register_with_trips()`.

Set `mask` to 0 when there's no trips subnode.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd744725121ec7fd0d9 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-	mask = GENMASK_ULL((ntrips) - 1, 0);
+	mask = ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     mask, data, of_ops, &tzp,

---
base-commit: a5df3a702b2cba82bcfb066fa9f5e4a349c33924
change-id: 20250707-trip-point-73dae9fd9c74

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>



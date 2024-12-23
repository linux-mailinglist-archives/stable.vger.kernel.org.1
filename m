Return-Path: <stable+bounces-105574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A09FACF5
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80EA162EBA
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021813D561;
	Mon, 23 Dec 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dS2oTEDd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3F19068E
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948414; cv=none; b=rhxc2KK0ri9XzZzvBm+BNYYV9GrKj87eq3vgJwZau/+Hx7hSdpx86TkP8WvHdgbuIbAPby94rL3o/BK7flCQvd2Sf+eolOw7LboN1PMHMPYydvtFrxtTrjq77OhsQn3HNVTk7neH6WekgDbhJ1kzCG6bjx+8+fLjJOgmM8sWP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948414; c=relaxed/simple;
	bh=AqhNVOLY6WQQjAV+Pel2zEq0OBAhvURFZx7IErD9FoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1fzcyt2ndg44uvPFBThZaxR5k1Rawks0ntxEJbkRNykZ/FcNecIynVHDJ19+a3KHanlfVXxBxX/GelL9dWrBQPIck+lIR4GqoQFVl7q3pPVRh+xBFt7vcS/I0la2FQa1UuvMZk8TJnSQu4B2uyMOVLPKH7hvHfZjrZRlEPWo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dS2oTEDd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728eccf836bso3374626b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 02:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734948412; x=1735553212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKJMfhcCNoXTKKqxRI259jRf70U4iL4YiCuA5Aw9wgs=;
        b=dS2oTEDdcNpe5SpRcmwEtl4vdo4phqWOiyPD7g3A+YtMKa4qioePWWEuXCmJ3gk1BB
         vMehEXRnZyBSg8Xw5e8mW0C6609j7gaAKsbIQUzT+ZAjghLBkm6uJ+2mx0FdpPG6nbuR
         CntqnfcBhzYuwYCNuIZIgUDbgufhSWdfA44vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734948412; x=1735553212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKJMfhcCNoXTKKqxRI259jRf70U4iL4YiCuA5Aw9wgs=;
        b=Ea8JKOTD95eBKZ0E305g6trsLQPD9RB3VaoRc+WVrsaHNkBYatBHVQBcnAI+KPbIpd
         LCqbWwP4qY8pigyX4RKZ8VZPirb54TMxAUgRxfr8e/HVkfZFMpHsY3B3a2ef1M1EWpE9
         7EOls6Esh1LRqFBAnvuj+i1mrDYwWYG76sKZ4oLeSwYlH4LIEfnMQsHSHyFUc9l07wTd
         i/UnuTfWe0Y2Zo2QXVhKD7KdLF8/Sf/BElpE2QS+m/lxjRL2/3dNPGnQAKVCGOeyLO2z
         TOhqXp47Nu+Rt9r58C5PDieIzlr6e6AiYN/IhX+vGPd6pLdGnMu1k8Hmm0pHHK8HteEt
         A43g==
X-Forwarded-Encrypted: i=1; AJvYcCUE6upMrfMHuRuLo55vSvTkSH44oisiUwtEpIIh/5y2kSyPlxKHy7np3ZX1mk+u3KNYeI6ZchY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgElFyfA3QnHuAMbxux86eaRGkOy8CgucofweC8kf/BSWZMkIN
	J5hEVvd1MxiQl3ihJq+BY8fKpLqgYf6CgUVuEBuYY6fbiZPO3c+GrobxZGzckA==
X-Gm-Gg: ASbGnct0kz5ZiM7wJtUL7GyP4WtVUK0NlJSc94w5i5v8E31hZyDgBKBQHOwZvB9jCeu
	g422o05AXRjjWqC405VVbdn9iRTX/KHBqJgFwEk9x4rBz9Xaf08q/TU14VpXTWwWqrG5PwOqD2t
	7X11P8NHgy+7CdghHUPcP+hf/jXg2k63r5QmeO9m/nS6Xg0Z2JoiHl62s3c4MKx1zXigvFxUnjG
	3YV5RCj7bRBlAm8SvmeIQwrtQnGArCK4L5kjX8mYhmR6CxDkWkbAnauv35fNhCp+kAP0FVWhik=
X-Google-Smtp-Source: AGHT+IEC6g3dUwbOwegr0/4cBA+q8wZywCWC8uKKvs5wuQPerkiACHzmCx3kFeGTvXXS9OP5fvFOwQ==
X-Received: by 2002:a05:6a20:e68e:b0:1e1:becc:1c81 with SMTP id adf61e73a8af0-1e5e0801191mr22582243637.32.1734948412492;
        Mon, 23 Dec 2024 02:06:52 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4fc4:9ee5:ceb8:cb2e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72e61sm6939475a12.3.2024.12.23.02.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 02:06:52 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: mtk-efuse: Enable GPU speed bin post-processing for MT8188
Date: Mon, 23 Dec 2024 18:06:47 +0800
Message-ID: <20241223100648.2166754-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the MT8186, the MT8188 stores GPU speed binning data in its efuse.
The data needs post-processing into a format that the OPP framework can
use.

Add a compatible match for MT8188 efuse with post-processing enabled.

Cc: <stable@vger.kernel.org>
Fixes: ff1df1886f43 ("dt-bindings: nvmem: mediatek: efuse: Add support for MT8188")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

I'm not exactly sure about pointing to the dt bindings commit for the
fixes tag.
---
 drivers/nvmem/mtk-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index af953e1d9230..e8409e1e7fac 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
 static const struct of_device_id mtk_efuse_of_match[] = {
 	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
 	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
+	{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
 	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
 	{/* sentinel */},
 };
-- 
2.47.1.613.gc27f4b7a9f-goog



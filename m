Return-Path: <stable+bounces-66520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDF94ED0B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A81F211F4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9F17ADE5;
	Mon, 12 Aug 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de9bqy/G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8E17A937
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465862; cv=none; b=JqX0kWr+vWsthikSaobnXyQYfgm3AkmyEUHd8nBa/4G8m3aqx9nBGAD4oDy7HXIckAd3lwNoSwYMKjJuQlu+SIOYwj4g2uZZkagoYZerovlU4Db82cO8eAxH/7Ibk8y/Sn9q0H+PJnW+XOEkmSxlRVFoqtxWzZ4f8NzriRN53As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465862; c=relaxed/simple;
	bh=4s62qVRHCnsvaoNH4q2XMZiaS9GZto2/rKo40yJ5wGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOhC0ZLytysVSR27WE/gdCxlm/1Ce882+i+DX/qAIDmVKsAvpGCfdy9tbv47oJI2gjtou3XUOD8RsSHzy+f6N2UJOB99ODc1djoyCvRLzPVYcYo+aD/cj8JvXKxM+5uxTh+GJfMMuMStl9bGdbTzIC1cgF5BIie3F7KTOrwMe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=de9bqy/G; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367963ea053so3444818f8f.2
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723465859; x=1724070659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrjMzxFTOymK1yhiDsFxq0lcAyXP/N53dsHhhTtc+pE=;
        b=de9bqy/GLISDqJXhRY/AzKzFfYNx/NlU4BsWVM/a799aNPDuzsnyW3I9Utwsv1aVOT
         S3pZ2etyjLOt7Ay6g/b0hPnDqn7+FOTpwAiNfW0R56VWkROya8c4kTR96P+Hg3MjTuNm
         F5O8YsOYvOWPfIWLHKbd06Xh2Pw/1LAa756GUwnqo9gJhE3r9Qy102mh1yzc1Bf4RweG
         SqhzlOzwXOOyJpMvj4SQ/BBCCQqp8ATfETZ6Lz3Qux63EPv5xtGqkJHKk/1ZAu1H/h5Z
         1KNmV9gh3GkReiMp68TPUzAOCzYP2uEf0BphBTr+LdI0fUOuk5vNUjFP5AKMemawaarT
         u/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723465859; x=1724070659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrjMzxFTOymK1yhiDsFxq0lcAyXP/N53dsHhhTtc+pE=;
        b=X1zyz6cCZqLO2aZqFJ3KgN5/H3hau9StlHUTj1w3KsaApiBK4NdQQdld9vC9N0TcYC
         i1YJthzh5Xo3B6MY4TDy1RhaZs+rfCsi05eSa19tjiNge0gLhtOS5EKd+F+Z7BoBWRjF
         fjXDh/9UNPtW5v9deEFq1wHcdwqu2gtC0NF+US23Mnk37fJt2qg2dQkLjvvtuhl4DTK4
         0b2jk70th7peeXrEfO9gt6K01Fhe85mzLQASK0juhKHINho6Hvj/NhmxpMaCXV+odp5M
         zUhgFp5hyVkmLL4551e3+9ATfNJSCeAuuBDUAjS1TnfaqB70OPl2V1O1xjWydA3KUnVM
         3Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCUC+WMv/uGr4wSE1rKC2sVMxNGrEWN9V14LxipheEqx7LlV3mKIunKPVkGc3EiJcMvhjjyc+lp06C8Hxdrzxtp4/jl5a7bG
X-Gm-Message-State: AOJu0YzqQkRzHk/vfesCxkmKLGvLOc+tLzXyEvGQJ3J15qeU0m8kihee
	9xa6c7zxT8EB5/R7gwTLbtL6AAlmFaNeA3c+ncnNzBaezvRoSkTWGV624o6naY8=
X-Google-Smtp-Source: AGHT+IHqBpkoDp5Wal5s8Y3KdZUq9WqkY3HpRBrs+w1cLO3eMxLwKdriiu6K0wUn5dFjISVeNq3Axg==
X-Received: by 2002:a05:6000:1b02:b0:368:7282:51d6 with SMTP id ffacd0b85a97d-3716ccef03cmr182934f8f.21.1723465858925;
        Mon, 12 Aug 2024 05:30:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb10sm7349493f8f.84.2024.08.12.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:30:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] memory: tegra186-emc: drop unused to_tegra186_emc()
Date: Mon, 12 Aug 2024 14:30:55 +0200
Message-ID: <20240812123055.124123-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to_tegra186_emc() is not used, W=1 builds:

  tegra186-emc.c:38:36: error: unused function 'to_tegra186_emc' [-Werror,-Wunused-function]

Fixes: 9a38cb27668e ("memory: tegra: Add interconnect support for DRAM scaling in Tegra234")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra186-emc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 57d9ae12fcfe..33d67d251719 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -35,11 +35,6 @@ struct tegra186_emc {
 	struct icc_provider provider;
 };
 
-static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
-{
-	return container_of(provider, struct tegra186_emc, provider);
-}
-
 /*
  * debugfs interface
  *
-- 
2.43.0



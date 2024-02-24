Return-Path: <stable+bounces-23566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17273862491
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A5B1C21518
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B539FE1;
	Sat, 24 Feb 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8oztB5N"
X-Original-To: Stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D25286BF
	for <Stable@vger.kernel.org>; Sat, 24 Feb 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774859; cv=none; b=DAuF7OGUrFUfkzPrTFQdZ9Sy+iQ1U3099DObrwOiqz7TZQpQEUK4tVLrTcFkLJI8FzKxWcZp+WAEWQJO7SBT+2KaSN2OwfNJMqkqUhmwzMw/IF3Be+u80+RvG5EFClcURoaNUkUY5oSWbQe4uACTWLw2bg+5nQTNTV18sCaUK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774859; c=relaxed/simple;
	bh=ylGBRgBKlf7zqEum8qz3cmgz4fiIdpr66g9UmUjC3yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6gfguupNl/7xDl6G6UWYA2pqa0RrPDqlCnPIxIWLy/qIlumgbkmVAZEw9fl4h5z/QLpSI7BK+rMR2DMGIHT9sgH7ijt6fhkfoNcCSjcq0OofJZs/egsVb0SNth6KOlFhIdere6jAEl1sEIc45ffmtKIK30mVIn1EkN/zKUKEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8oztB5N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e706f50beso214129366b.0
        for <Stable@vger.kernel.org>; Sat, 24 Feb 2024 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774856; x=1709379656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLf1bZRvPVBFsx9bIK9Q5wCkUaQ96MfiepUQxmTKpHI=;
        b=l8oztB5NAVJW8k2+PEUUuR8cY+/d5yKt18HSdNvAQ8/nouSmmdRK4C+DjmOdICSxno
         Lv5yDlvj9MUs8ia/cSpFqv0JwbQGCQYglp7YsEwMAWN1pjh3B82AqnXir4Eh/Ss4+Pqo
         i08IpGfkNBxkrvOrshArh++BloImStc0nC6e3W9ZjWv3Ib9vlutm6uO+2tWh9AXoGefv
         UHYaRRJ7EktPjQNR4IyuJVmhVUXVqVT8F8uiFbSip3t9gcUocMMl6T31qV0dl0pdL07Z
         HfHSt4nMIVVcbpLHfdWHOVyaBcmYZTKaRiCQpTrRXE2lqn7AeoMAsvktqdsWAJ7pGuuT
         QlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774856; x=1709379656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLf1bZRvPVBFsx9bIK9Q5wCkUaQ96MfiepUQxmTKpHI=;
        b=XLimIElmCddyprZRPW9Nz2Y8+z/tOAQ9Xtq6AIumldEiw7+IokRi4Q3IokOx4+DFCw
         S8OnBZ6tjzCAtqUsXFtL8zgTaomn7C9iQ25Om/n/H4I5dlI3Ru2VlVSMPUxtYt4jRIcn
         CRRQcyfggzyQfSNUS8WQ1xL9NGq3YO7LYKfqEyPdM3jxfsv41aAOIf7AMNm5fY7HRffe
         I+RR6RngnJqEwxS/XrgXFoPG07LNQOeAFs96f2dS3vbmHK76N9NhjSTscAvCTvGKHPWH
         y0G67KiTAQo4NdRcZv77vG/0vvACEl1KLvBgouoQc1tnjg159yxmOff38ezbabFdWGu4
         IPHA==
X-Forwarded-Encrypted: i=1; AJvYcCU/pnhUa9zHd1NXX4KJtJayaHHQCCyCUP956wRjq7464DsYU5fjO3aScIiQuGQQBKI3g/I0QSqU9sJYFbiDqNIuoLsCuVmf
X-Gm-Message-State: AOJu0Yyk+xZSVYedKA6sjNIPLICvRSTlN4WIdL7c7pRbpTlb9z9NBsQL
	SBvsE1N+dq1SkamerJz5HmgKb9+Vsi2WJ215lasnlePHnOXCYXdqKQBnPv8/Ud0=
X-Google-Smtp-Source: AGHT+IEl1fLPEPpa5yDqJAlZGIWtJI7AKuvrlUW22SPic9KZSVTWhkY5euUk4uhmQJZLwQHhTeZDew==
X-Received: by 2002:a17:906:16cd:b0:a3e:a951:4087 with SMTP id t13-20020a17090616cd00b00a3ea9514087mr1466517ejd.76.1708774855853;
        Sat, 24 Feb 2024 03:40:55 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709063e0800b00a412d3d509fsm509335eji.181.2024.02.24.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:40:55 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Justin Stitt <justinstitt@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] nvmem: meson-efuse: fix function pointer type mismatch
Date: Sat, 24 Feb 2024 11:40:23 +0000
Message-Id: <20240224114023.85535-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114023.85535-1-srinivas.kandagatla@linaro.org>
References: <20240224114023.85535-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=jqd2R16EWEqdcbDXcRsGdVV9252ZH7ZMdbnqJsQFjug=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dWne6ybY8wxwLxYkBZD6tyXVyvXMQ4nJKWi7 7ix/YkJO6iJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnVpwAKCRB6of1ZxzRV Nw1IB/9v//b/yEDwizGp5L2Bcgb+7csEIjS8lW7y8ahfS5F+GwkrwyPQfBM2nWgPNyLf3nMaFJ/ gl7qQMcrySIX7Mj6EDe1cC6Q0FKfpSRH3sOgVInijnBCD5HSQOFDbWDHpepEhnCBaboONrrgPDv 1BiM8cIXNYoP29qB2k9CZW75u4YqX3y2kjXDinisWoH5yJ71JVSsSqk4jJoxUH5oMh7uRFy0Af2 hEdccIXXAMr4+P3wRxacyW3u9AM3hRt2ysdUOooXQaqnaXjBSSlRt6lmXufYDjz5ZXiQuNjSnHI sYymOhO++/kSkVHnvRJD3NhT3Ae1Cq5ZmNn+zImo5X0bZg8U
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   78 |                                        (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
Cc: <Stable@vger.kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index b922df99f9bc..33678d0af2c2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -47,7 +47,6 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
-	int ret;
 
 	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
@@ -60,27 +59,9 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	if (!fw)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get efuse gate");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "failed to enable gate");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
-	if (ret) {
-		dev_err(dev, "failed to add disable callback");
-		return ret;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get efuse gate");
 
 	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
-- 
2.25.1



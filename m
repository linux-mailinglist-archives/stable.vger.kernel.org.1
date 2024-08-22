Return-Path: <stable+bounces-69901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C563395BC02
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796C21F217E2
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6951CDA23;
	Thu, 22 Aug 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+n4D59I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A291CDA0F
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344431; cv=none; b=YIYuxLuav0QEJYYeL/gaFfCTFeY3GSsyKSUbLgVd3UWdJu3ne9/YCINWljO/WKUG0PrJEpZlRElkSlHEO/sYW4ABJ9Kq20X8WlK1BaktQCHYrL72wVsB7aqf9p18E2qD9zPHUpztCwTT5XbNBNTopR27qEefct4TMold9gma4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344431; c=relaxed/simple;
	bh=naDm1RtTiN2zXIk2LJ0zsnhLTTN50E2lGQMRxqbBYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlAxcY64DbWFMEuZ4Tq1lOTMaFk4Oe9rEp94SJwbzHxxSRCsHbI0sCGmES3fR+98Js0v0pnEDEc965bGZvsa+JTYHEmdHOKfEBo27QbtExAr7+lAUmtTnXFW2F3bkgkJ6JXIlN2fX75kY+HwmsZ/3547gPgFAAwszRhDbeALKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+n4D59I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428098e2b3bso982145e9.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724344428; x=1724949228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTFuV6stQx7CKFbcUpz4unCbxA3iNnf+lqvoGhhxAkM=;
        b=Y+n4D59I2HB+AV7hE/UHEWDaBT9lqkund6rGWosa3Bp2hO46mHtyUhBK/n8qahj/jJ
         m886iUhAS4IYH7b0CnEO/w9Yb8nVXHsId0c00Ipm9jb+Sp5IXcY/4prFWz46q4SC53Hi
         U49xaRGMARU27zQU4iqixAEyhrreAPP7v1jHA96tUzHDpLbBhRhEO4iaVF3Cav2ywI77
         85msSGArG0De5nBbixJP4v1ToKgcQOLzz1dprlCu9e2lnRHGdv6UXqSe6lyhJaPMeF9g
         1RdelEwOnx3uO0MG7IkwSHd0ISb8ppnekjBrVNw6ku1TIdSHFhDpXlcnEBcYj+muPgWe
         q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344428; x=1724949228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTFuV6stQx7CKFbcUpz4unCbxA3iNnf+lqvoGhhxAkM=;
        b=c0udsOvqHWF/Zm73pQ6q2w1qPwN1EEbLOfocgfeq/Z7tOJHvU97AHS3UwuSvkEFs7C
         Bs9gJHhUUvYuy5FnVCgQc6QYMumbRSuJ5K6vzSVsC3fY4Rc7G/DZRt2v9ja3KV/iFrqe
         xgW3V0GGonUk8mgAVrPPFrkpC/qjALCDQ8wnTAK2ISKsJj3u2svcE4hPSGGmHKr2i0uG
         QI65briwHxlBt3Gy2qQCPfG2km5oN8/9BS4oWpTXG8clXOhSQ5ZPc0M8YyK5rNJO8+ET
         30yj5/J/bnfgTW2TSTJpa2jv3U/jNz/ZUUtF8E67hEVoOaU4jRjmZXzPolYO3DeXQwOh
         3uSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAx5fH6uus3QXqnPpgpF9Bjfx1ZY534KMaspvCChrobQSywaWFXPA4BAlorbEnyRGT9S7NM0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u8OfRc+RaTdUp+UleoheO5bkqb5aPwkOQ9N8/2Ajzue/nC8j
	pJmV+2eN1Kmz2rLlSQj6/hT4Ik9jngNtemZCESIA4uCYnrYTJmhjOXuF/yYsCsU=
X-Google-Smtp-Source: AGHT+IGvJ/iD05Q3C/AsOQTJKor76DdYYeZaTHMvrsybklOWmJKd355kURal8Tjnr9MKo4Z1wI636Q==
X-Received: by 2002:a05:600c:3c85:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-42abd231427mr29419205e9.2.1724344428442;
        Thu, 22 Aug 2024 09:33:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813cdcfsm2069377f8f.29.2024.08.22.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:33:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: pmic_glink: fix scope of __pmic_glink_lock in pmic_glink_rpmsg_probe()
Date: Thu, 22 Aug 2024 18:33:44 +0200
Message-ID: <20240822163345.223787-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File-scope "__pmic_glink_lock" mutex protects the filke-scope
"__pmic_glink", thus reference to it should be obtained under the lock,
just like pmic_glink_rpmsg_remove() is doing.  Otherwise we have a race
during if PMIC GLINK device removal: the pmic_glink_rpmsg_probe()
function could store local reference before mutex in driver removal is
acquired.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd..452f30a9354d 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -217,10 +217,11 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 
 static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
 {
-	struct pmic_glink *pg = __pmic_glink;
+	struct pmic_glink *pg;
 	int ret = 0;
 
 	mutex_lock(&__pmic_glink_lock);
+	pg = __pmic_glink;
 	if (!pg) {
 		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
 		goto out_unlock;
-- 
2.43.0



Return-Path: <stable+bounces-106747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E70A01519
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 14:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E67A1CC2
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D51B4F14;
	Sat,  4 Jan 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQ4kMs/g"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452E191F99
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735998973; cv=none; b=EMWn5xcBsxG6X0EJGwH0gRylGqpUbVKVMp8t9AWay1UYLkvYnst4A5vuqjYiy1IEhqDzHGOJEyJSPULV/JPLX05JD069H+zIcJyK3ojviNKA//R5MeQKReLc0XSdC/gnoUxd7w9c8LvR+tEEYlG2h8o1eGOaM4gAh6SoOyi87g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735998973; c=relaxed/simple;
	bh=NI4tRP1Is76uLgwzVQpxCWLwbHMSF+L2Mz3je6ObnqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2AkK018IbhXh8DohNongYrqVaxS0EaYsEkSVgfNraN4uSqVfzbrt+g6H6pN5ll5EnIA8LcEcqFv/tqT9NKLxs0CDdoyH96StkBty3nCvWTJgUVuIkDX9gt9xN1pN+eRhbr8NRK3yN7KjDHikw1F+1cuqRhNxRY8LA1Li0wM09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GQ4kMs/g; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43616bf3358so20366335e9.3
        for <stable@vger.kernel.org>; Sat, 04 Jan 2025 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735998970; x=1736603770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJEWejicaBz6dmUxoJQXl7EdOTueBwQvHraBKvH38is=;
        b=GQ4kMs/gOkDzbQQuUHac1YRQwFnA1pFC+RPMZo0b29ONUIHhhd+8s494KTMV9BxUse
         sOsqmp0PzHLkVRwwUUvmKYYLnFKpcY5IvOMkDDK1tmGLpAFcCKWpe7MqYDrZuig0eHD2
         xe499KgtsnPm7S3ZpZHzm4mHl+Ub/LuorRbDouYqVJgGcMnyZjH+OqZaY+6ZWsURr5H3
         sP16CKFsMjEOrgJ5VRiy9cgMF0KR9OIOLQVi4PAO+sLeabpCGjHDOI+Ek5xFgaNS75KD
         /mzza+3fcN5YyOmcHuYF+8118dcItntBWr5m6hBnC942RMMW7gkyOUZYezHhk6OoqDut
         FbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735998970; x=1736603770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJEWejicaBz6dmUxoJQXl7EdOTueBwQvHraBKvH38is=;
        b=EJdQWqwDOxfRhlvBpLW7MkLnX2BRphPvFLu0D+vg6sbDIu8GxeCXe5aEj9MZvmL2bp
         kii1YZWTKXn3Rnwq5KCzYSS+jLMHzjZdtCZ1jyogrT8Tlm7X0EAr/C5/v6EvNCrJpQSZ
         AgbaXMhb68KaOfoa/oiv0JmPdDE3WbERMoc2pNvCsjN2fLbQoasXA33EPHMwKrXHmZJL
         sU9BOUESY2mf08pqczsBh++F0qE3uGbte0hrspK/Lq8Cu2G9VJ7h4oGrI1+NQAa83PSu
         0KvhMX0rOx/ktC1CnB5mtvxswt+ywmSpFkapdEtErzMArGjPX9ICjmkNI0iAodmiVSSf
         vKGg==
X-Forwarded-Encrypted: i=1; AJvYcCVPEiJ4P9+JKWfsMx/mIjY5SQ9xRCKyaEmXIH8iQa9oEz/N/9CmT/23Y5TvE3GsqRzFA19G2P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIAMWD3eZGy9/Q7Ph3k0ZKtxxTpCKh59UqGHMfwhOsE5TRqLN
	MASGArSKa2Ce7XSr1X0kAb+yGWcT+R1JPFgrUcWbkaTokSMfsKeYTUhZg5hf4Dg=
X-Gm-Gg: ASbGncsnptemVYnfoLWAqQY0wKGnHeflcZeVh1JDOhB/h44iQ1jK2mi1Tq6ADnJpzTG
	w1NUe/9ZOhQCtMVQtAQtOmxH7NYIzcyR0WqZtAFuClY84X5b7X/tua4UrdP4kqeg+mmhC92mAAo
	OaRe+V9EckdYU9ndsLOHvmsuPQ7FMQE/ryiHpI4nAJYbbFq4kYApDhhINybhN5YCNR/SG9DUwQf
	NCIXGVkhy5vzpfIh4DWpa2jDCmcMoXA5LCKkuiZ8XzUpjxUjnnFJmsJalJLRVlYwuHNrEY=
X-Google-Smtp-Source: AGHT+IEO/3u4qvFe5Vb1vURPH9ZBPG+ma9tc2SOelaqiPnyPkQaHdPOjLVZUFkyq61FMNDtN3/bC2w==
X-Received: by 2002:adf:b601:0:b0:385:f7a3:fec1 with SMTP id ffacd0b85a97d-38a221e24demr13083083f8f.3.1735998970188;
        Sat, 04 Jan 2025 05:56:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e375sm43946322f8f.73.2025.01.04.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 05:56:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soc: samsung: exynos-pmu: Fix uninitialized ret in tensor_set_bits_atomic()
Date: Sat,  4 Jan 2025 14:56:05 +0100
Message-ID: <20250104135605.109209-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If tensor_set_bits_atomic() is called with a mask of 0 the function will
just iterate over its bit, not perform any updates and return stack
value of 'ret'.

Also reported by smatch:

  drivers/soc/samsung/exynos-pmu.c:129 tensor_set_bits_atomic() error: uninitialized symbol 'ret'.

Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index d8c53cec7f37..dd5256e5aae1 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -126,7 +126,7 @@ static int tensor_set_bits_atomic(void *ctx, unsigned int offset, u32 val,
 		if (ret)
 			return ret;
 	}
-	return ret;
+	return 0;
 }
 
 static bool tensor_is_atomic(unsigned int reg)
-- 
2.43.0



Return-Path: <stable+bounces-70115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89995E4A8
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28921B21733
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE91714A8;
	Sun, 25 Aug 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghXanyug"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E815AADA
	for <stable@vger.kernel.org>; Sun, 25 Aug 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609156; cv=none; b=I9eJirVjjgEt+DtZidfMpsAiKjzKF1D22IY+fjf8uc45Nhgc/DqE0xhfoMVrhkQg80l3qSJtQrim8b5LeVzkNq8UwonqN89AdQ7i8XUq6n1/24Ijh5e5E7Yd7qA1U1mEYVpiDOKun+3brTtrFXeGka9UYwcek+nuQRRF9WsuM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609156; c=relaxed/simple;
	bh=LIZtMc9nHoVSkfFptUxs0Y+Ob0r38B/hMi0Yhl8M4mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gazg4pQxN3PZPBMyHmYixkH8Ptx5Wj9mk+Hbt2FMTflGh/SBjnGMte81ZiljGXLK1t0Yt4WL2qyqOO0nVIOxI8MwSSRgPMb90DdAGZ+W/AgJOIlgM6FGRtrBwzxW9GB77E9JbKjSe5Ug+rkPWRtNNeApgN9vWCxJn39XjEGefQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ghXanyug; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280692835dso5571475e9.1
        for <stable@vger.kernel.org>; Sun, 25 Aug 2024 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724609151; x=1725213951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYpIfMLevBxY0BufVpZdLlZOu4ayBivVHqKaTZPujng=;
        b=ghXanyugvrbAp/ewLMk7vJ+8BWnAIkp6la8z5J0jtw6DbFBqn8CXRFEkvZLpv6IYb7
         9hS09zrVuOvbv24AAWr8IGAzSCfDu/d5gmDukIUfPG0P0Qb00TyW/bObLMqTdZzbmx5+
         p3thhdO1YPiyIYdrdaJgIFJn789jyy3Ih7n0KbnEtR2i8uRpLupOGFhqsO4Y417/xBMy
         7Qn1EegZhdrCiQC6zkru3ibyCBVZRqe57Gz9LPemOzmdQycHk+GUQpAUtPKpG0F4mKIo
         j48gJ6feNCRFrkvCwxRcsMdIGmxfkLFvCojJeY7Gijx5TjrT/cqItumvRiu9yT6DpKnX
         mRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609151; x=1725213951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYpIfMLevBxY0BufVpZdLlZOu4ayBivVHqKaTZPujng=;
        b=B308D2d4uuUVpAi0NUnreHYmbPabTLghj/CIk/lTvqW2BTE6xqDNMtOAuUEkOy5oxB
         qOMpjy3Z1bJNZYRMyxM1NwNKVerRaVg30T+kEgPwVI0ED1bfln46cysegdRCkgiOt0nE
         OiZwi2cQg+fUUkYzq1fM0qzmNqUqHGzLqyQXKeY+fdAaznqVPmw0sCyHn18Wi3OVlwoR
         uHLVIcd4TT74+Npa6muYeUIrwFUBYs3cWczkqZc01CSxcbow0cDSyo4FcBrqJy2UJeH9
         piXwURMSoae3Vr3Eq/3NImNq2yeLEhgHYK8B+rfsDb3FQzsmNQTsTUAMtt9ZaWVXCHT5
         3yEg==
X-Forwarded-Encrypted: i=1; AJvYcCVu1Y/m7hN7c0Omq9o/xoeoBG/LTsB4S2Onf6ExWMgGdj+Ot+iIOF1ONNvqAZDmPFl/Ud98Trc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrgXId139CPbLoi75mvx7AXHWsJlIaVXoMWHgo8ES4VBHgNey
	pX51nf8FgF1Ti9GqiRWool2c9iSuGYb3wp6N2eS4ZZNQS0xpGNB4VzicdPJy+ys=
X-Google-Smtp-Source: AGHT+IGoA/Rn3FHpEkZNqq0MHOX/MSoH9qsr9KuvzwqRF1RAbel/snzk7XWVAhvi01a5m+hc/xV1Qg==
X-Received: by 2002:a5d:59a9:0:b0:36b:36aa:a14e with SMTP id ffacd0b85a97d-373118d1d2fmr3488407f8f.8.1724609151554;
        Sun, 25 Aug 2024 11:05:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37311dca113sm6438736f8f.16.2024.08.25.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:05:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:05:22 +0200
Subject: [PATCH 1/4] soc: versatile: integrator: fix OF node leak in
 probe() error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-soc-dev-fixes-v1-1-ff4b35abed83@linaro.org>
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LIZtMc9nHoVSkfFptUxs0Y+Ob0r38B/hMi0Yhl8M4mY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmy3J3NpIXoshBZUGa2xvTz937PSCt1g8bClII7
 Gypds9E0ceJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZstydwAKCRDBN2bmhouD
 15J4D/sFI2Pwlgu5DaqVgnr27xueYqFfMd5lL4vwH2xoYNLT2//yN0INBwq03sGZAYd816ZG9Nb
 +3VPV2x03TUVQOYCPU1iMGpnepzP5ReVw/e+zT3lOpcZVN6sM4FUfgSbdUiPhLxYKdBnJVNfbOv
 aZcCWbTtKWefPVwHsV9hxmIPRBmV1RAjJxylzEDl7jcDju1moiDueV3LZie18q+A6GvjYPMzoGV
 BAgxnBi7mHkLQuF2rKnP5/xUgGFY5h+79ahsMQHiiCJspOTU2GQQZv0hHuWsEy+yqsuPJTwzNG/
 HlPTz0ulAkdSyLCV7DwNVUnv7/rrt53x0wFzL1vNhRE1YfLazkPQCVS0nguJrr76GAcaOOQzSe9
 ynF7BeTtJehayCDlUG4LEJWuAMT+v+UO9oE2rTqzIKlpDqdxXZQjHaPy116AMZAeTQmrh4NBsli
 kxJ5HqW+BHH22T8OOv1q3wE8N/9RMPdCEegGKkPbyu+6xe00WPM4/bXOQXasfrUcwF478KRbuIJ
 Q9XstIkj7EiqAA+JdxELQ+oYjhyAiiEnt43LHJUH5Td0uE9WYdxJqV8oEBsBFCROzNVesb7Rv3T
 n+5kJj6eNtVY/Lgi/Wx/7S1ZomQYAYtNsUTmpTeDZv5r1ko3dR8I6Y0dG4bREtpgIydIvvkNCkn
 50OkEyWy90ezCMg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver is leaking OF node reference obtained from
of_find_matching_node().

Fixes: f956a785a282 ("soc: move SoC driver for the ARM Integrator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/versatile/soc-integrator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index bab4ad87aa75..d5099a3386b4 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -113,6 +113,7 @@ static int __init integrator_soc_init(void)
 		return -ENODEV;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 

-- 
2.43.0



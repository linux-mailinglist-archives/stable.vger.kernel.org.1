Return-Path: <stable+bounces-54826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963D912801
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 16:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EF2B25E6D
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E2381AF;
	Fri, 21 Jun 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D38mMTY2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB8358A7
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980665; cv=none; b=SkYh8X147lpp5oKqPfuAh8FhpW9qkAuGHOCe26hRsIwq0pfu0oZQ+kbSOlOnOOBFPWv3rVJtleJhrxjd1PMwZ0Kbg6ODpPEhuEivSEkPEhbA3U1M428JYJTUbCkgkYm+t8XGujVj7DereU04Bk//H0RqdRq+6oVHT5vPskE7n2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980665; c=relaxed/simple;
	bh=77m9S/e76ZnqolXIdKGvPpQwodpWtsZsa1irYtdWzSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez3NdfeTFNeR8K3uOvKP4uYy9bBKHQmXs/dcGTdG6VqX3BgczkIqC707v91GF9hh5RTDDeSPsLgvEBs1A44WqZkklwrg/RAgIQv/zK1+ZCfnApjoFE9CnlAQzkyB9Wrm1oi8OCrur3kVUClrmUpCv2nDQ8KGp/vo8pIlysE7/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D38mMTY2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso239126266b.2
        for <stable@vger.kernel.org>; Fri, 21 Jun 2024 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718980660; x=1719585460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpjbtuRsYUxGDKKpuIwVrQYGfcBuCB+ep5KKwdfomXI=;
        b=D38mMTY2jC7mcZ+pVmMExI8F8dmvhD2xNUmMHIShrYHRO3FkxuHEcU0b7qNWT0+WiJ
         bfy/Ab/YMbsEXL23wgM/culvJa+J3m3OjwRgrgvec45Ig3BmFIrBc7ZkQlK8ckngY+PD
         eiUD/JpLARbcxUAPoFZ2oIwGcpoFvgyp/wEqb8YBX8opC2faBXemzxP/EZFwp8Mx2GeI
         zclLYqfch8f++K5zNx7Jnr/JB1gsUgQUT525gMWc50HDzJiZWlM4rtVCBq5OB0dDatUU
         /NanDcd9ejqNBjGk45nTS34bP3DuXEVvyF3dZT16NbPQ0a5rihEwY7cL4BK7ORP9wf4k
         3L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980660; x=1719585460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpjbtuRsYUxGDKKpuIwVrQYGfcBuCB+ep5KKwdfomXI=;
        b=TcjMYqyRwp4GZZPEkGhoP+u4iBlo7fjDdmj3f33DlqkYrADBhHLnialARVJH8rB2vg
         Enh23ucujqFzYUKpDiSDXw+aIUMWUVgsJ5B3JvOb8Qum5LGXxc3Syb6cHHJc6YNPdu01
         WLL8y5a0HXp43HuS7GoFU8zcqr2vy+H/2vb/GmhFu6BAze+Xr/+zT5nTQrAwW2HMQtyT
         ygdwYcJFEiWcqRfgzbdcb1B6IEVa4dhhwxY7rENmL9H5QkajA3TzNoHEzgS9VfgO85Ua
         397VFiUBg1pkpHfqYGSxIW35Bqf5wjge0fDqbahkEIAkR2Mhn+UlcnmsdJoPaRNRQn2S
         7DdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBw4ijacKGRS3TIG3phAeI3kqHApdwKznVAggPRS5fGk04aIls7mxuNTwrcKKSR6RrQ1cVtD+N/PEXLKn2AcOhVd4/LNUK
X-Gm-Message-State: AOJu0YzLGh8pu15rRLEntcqroaQB4IOYGUvdjUoW81JcUMWUyu3bCfx9
	Z5Wi3eKZt3irQOqmRvzW3nFgMGRrao54QTXoLZsoCbzqvskR9W0I/OJFF0olwz0=
X-Google-Smtp-Source: AGHT+IFnG8vPc7gD/zkJj+cDdWoK1zUqRd6sd4hZoStrTa7UEp0SdW6Bnq1Jrrg14s9KXzb7mLfmvQ==
X-Received: by 2002:a17:907:a646:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a6fab60321fmr603671866b.8.1718980660351;
        Fri, 21 Jun 2024 07:37:40 -0700 (PDT)
Received: from localhost (p5091583d.dip0.t-ipconnect.de. [80.145.88.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56ece7sm90255466b.208.2024.06.21.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:37:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Trevor Gamblin <tgamblin@baylibre.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] pwm: stm32: Refuse too small period requests
Date: Fri, 21 Jun 2024 16:37:12 +0200
Message-ID:  <b86f62f099983646f97eeb6bfc0117bb2d0c340d.1718979150.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
References: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=77m9S/e76ZnqolXIdKGvPpQwodpWtsZsa1irYtdWzSg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmdZAb+JF1Lt4sQgcrKfQpUfAROKFoD9THKpVyX 3OGJ7yuteKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnWQGwAKCRCPgPtYfRL+ TogNB/4wXOzt1/fRlY9bvWJQ8dB2JW/44VfPAoPIjaBk7pL32PDPR21QrNgn1+8ThreMJc6YFht BTJPKzI2CtXXdaR/N90Zdv+6Hl+EAxR3+JzPp1fN0F0v74hQ/DsWOPXcQFG+21256SX25ScI2Hv s6m/49IIBgcyGmVdHiIZVt/IaoQyXtW7PfhKWqZBCcmOs2zLOhhllZQFwiLhhr5ADfObNftH080 nIxbYKKHZ+lHZIHeAKH74pq2GjrYAHvlzoSHMnHg7IcbB369mX5L2nxfkwOq/un0+QEzy8PGj0C TosDsIqF3zMkjlyMqWdIzyKTzTVNQg5bgLc9w2hB5UsIeZSq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If period_ns is small, prd might well become 0. Catch that case because
otherwise with

	regmap_write(priv->regmap, TIM_ARR, prd - 1);

a few lines down quite a big period is configured.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Cc: stable@vger.kernel.org
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a2f231d13a9f..3e7b2a8e34e7 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -337,6 +337,8 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 
 	prd = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
 				  (u64)NSEC_PER_SEC * (prescaler + 1));
+	if (!prd)
+		return -EINVAL;
 
 	/*
 	 * All channels share the same prescaler and counter so when two
-- 
2.43.0



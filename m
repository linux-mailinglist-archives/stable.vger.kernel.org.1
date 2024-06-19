Return-Path: <stable+bounces-53796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69490E6FA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36906B221E5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067B7FBD1;
	Wed, 19 Jun 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DyXPKDnS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1657FBC5
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789208; cv=none; b=MtXy1smVJpE/81JwK64b4CXAOqbUGQSDFa4RZARVPbipEvU+EfU4CgyN33xZAe8Vu7xdaGKcEvRGlvAmxc3eGQRlQaUCtq53ihTZ1A7dypFvYoMKnP+5pnPe7zDfQlJTAVtXlA1M8PnC+CP9WnC9veK/Ux+enP6Fw4lzs+QEaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789208; c=relaxed/simple;
	bh=t/egHWd+wmcQlgsPv+ZLw8ZljE6PdVD/61DykbjcgzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLoPHuVY8pp5bCcWlmpIV39mS6Il82Q463Fpcx8P8TewC9I4FSi1OA1LsLc78H0wqG9MWEBjC6Wc61MvkQibsgkOZ6vFIVr3c+7quH55UZ7ALNFVtnnwP8Q42Uq3edQm5du1ihOAgj3WbYslIB7J2N1Mmtgmc18OWQu0qiZ7BHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DyXPKDnS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so54103945e9.0
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718789205; x=1719394005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR7DaLA90oi7Sx2UQfP1lchaT92bhvbec7yBR4cuGW8=;
        b=DyXPKDnSSVzmpf1QYlg4LsYzgvHQKsHe3jQ34VvYcPi6rDjtrUTnRSe444eSdDVpbf
         8IlI8rWxGvUO8vH1fbtoT3wjib68HYuEq7p9ZLi/sVfWumjNfgGTIC/JPfWN3mFhQj4j
         9Qua2mX68jKx4rsYol5jBdate16Rw4nwcJxtqpdaCbKtCpcU0qA2YLR9zOqt3aiMFcnH
         Ge4SVxe3ig/IAs2Cznsb1PZJax3ViiclItx3IXaET9MIS33cGot8irTTeXhzjg/YEgzi
         P4k+9GO2u0ds16qnvNZS9cCK224ZdGCdn46pkUraJ8oab/jzlGgQgQulcjxkVOgKmCfg
         64FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789205; x=1719394005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR7DaLA90oi7Sx2UQfP1lchaT92bhvbec7yBR4cuGW8=;
        b=gpc3oNLgbLnCYCjZodGZe6N8SugdT7z+c/u0MJlfUwYZT+41I/HkSr5L+QPfvkSZ4a
         c5A80TwDyc/XqIArPXr/oyys9dRXvgKigbpNh9MYl+3/+1FMzAluEgRQqFyJC9Rib1un
         RMA89sbjWXf+Yr7nGPYDFoByD0wBvoTun8f2I6cqX/IbFCli5ksimFWnxh5XPvXUk5v0
         TpLOcC5SAg9JJMemLDnsR3hT/H3s5j6wRQlAPGgq6u88cAtP0GGnXgQtVA/SQpJmfr6g
         ZXamPjuCHDk5uktQoH0wsLAK0FEtD/b1vWtFtfIId5zGIrqjoYwf8twn0ZAHuFIE7rCE
         Gzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUrf86X5M0fNYmUoFD85gu9e7i6p5B0NOizVBijE27nvghTGGiGFGYMaW7G3FiQh6yYeZ74d8+0K0bxkFrjecX0GMk8AwYK
X-Gm-Message-State: AOJu0YwBKEs/qhA8TjSHmozihQi9aWeWgl2soc5tkCpNaR1C/gVIPSCL
	+ouljBrolfVaX3lr/XxGTetlBtuoStIMJbmxmTqpMFylzAK0aRDXOtGEF/GPr4I=
X-Google-Smtp-Source: AGHT+IECQtiC0VKWzrySd3phzgKGLPkfzADfJEpWsC3603JzVYfretGLD12PgHyZjjXmDS4xZ154rg==
X-Received: by 2002:a7b:cd07:0:b0:422:370a:ca57 with SMTP id 5b1f17b1804b1-4247529bd22mr12959225e9.36.1718789204826;
        Wed, 19 Jun 2024 02:26:44 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9590sm257894845e9.23.2024.06.19.02.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:26:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pwm: stm32: Refuse too small period requests
Date: Wed, 19 Jun 2024 11:26:24 +0200
Message-ID:  <c523cc0fa14dd16785c85f4b204ba6d5e02a77a3.1718788826.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
References: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=t/egHWd+wmcQlgsPv+ZLw8ZljE6PdVD/61DykbjcgzU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcqREO8R0IRhIv2cdHZmB13NIe9ta4LYlDZM/y NzbWbt7RF2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKkRAAKCRCPgPtYfRL+ TiHoB/0RVZ9pnx+IyNBO+qORuAclGa8F4EDvd1uHdrU9quZ5Vo2GZqZGHKe+jsPAwrnq5cDTuVL uRzTEYQN15LjnjI3DVpjzCXMdmxlSX8AR3oENWmvoURE8AvQjDS/aEEmkIC2M5qjg5JqtRSO475 b90u24VQc9RElRsZ+/44CaINWsndASrwah18oJ9ymattO4Zreaz2tyKDe08sImU50zAekOAbtAj /l7p8ln/vSiXb4xAuR9aSaknu6FuWBlgumoeguo47sJFpL7zbrOg1yTPdBW2JELuJ6JMbMSI9uS SuECLulflPslzng2EkpawVELbT7Kaeg/FdHL4xsR7rKXmJL7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If period_ns is small, prd might well become 0. Catch that case because
otherwise with

	regmap_write(priv->regmap, TIM_ARR, prd - 1);

a few lines down quite a big period is configured.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Cc: stable@vger.kernel.org
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



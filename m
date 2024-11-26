Return-Path: <stable+bounces-95573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640B9D9FC7
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 00:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8871B23072
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E101E00A1;
	Tue, 26 Nov 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPkmxrDh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF31DFE1E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664676; cv=none; b=tsQNv3CzWE9O/pNFhuqdzLOpp8bkL6L7myfNgWcOVyDqRwPSpKd3zerved3XjzaYIl6YowNJpk63tfwVd4sYFH9d+WbE10vevYQK4Wiwx6FwWt/OpWfnOvD7QX3mNA33GNXVW7O13Des3F7asNqUuwgPpIrX40fCI/ippW8f5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664676; c=relaxed/simple;
	bh=CdkYU+QJ7VGTHMAgD+J6/KS8Mhb64oBSKmpBnvb/LZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrWL262qb8pDKShfvhtiPvwqF6BJa2pvDFUjTgjVb0inxSqCEFN+IUrGW3hTLU1/1vfbE2SSdJyTkBWpmyKOrxu4eexsv5JF0tpC+4GnZaED7dMElY9ATBdU1y1UFeFyvAICosi/NjDI2rPDWbew/KrV2VUuXletWVd8atVeqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPkmxrDh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so4260008f8f.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732664673; x=1733269473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=HPkmxrDh0+CPbjb4L7WbvT5rXL8iMM9EZfu9l9WQMey5BAkbsfWWS4urUyEphohcbE
         m3t8rYNefwbCdh/ls0U8ldwX7WLYCtHRTsPoNFYNuxQkrMoDbAfntNsKd3+P7ZuaVjD/
         HwmvEoHAZL9IoAqcZyK9eADMJIv9/O2Aw+92MYxzL8aLIS6dFarUoo+X8QtQg/NSJtZ5
         Ogkc8cnZI6UU0BXMiygTxuI4bEssry3Ihn3eii4FAg5rQrqITrbzG1hD2BhvkZ76+dQ1
         Lg7NT7cIpmaD6NT5NQr7jxN2DDHD/BS/gIp7Eur93kdU0iK3kiEDlBXT/WO2n3/948En
         xjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664673; x=1733269473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=Z3E0EnEASk6plalzdTgTAFxvinjBjw4vTHiTsJYlXsZPV69dGeVP2qfbS00UnfXxUv
         h09/s8SD9WvUc/doOD63+b6nMB5/BJycFcUvpb9uQUi5vnxq/i5JqOEeScqEp5kUG/Xs
         FI47YmHaTvE2MjAhVCQklzy1Cl/kGYyeHSs63ymtFk1SwbSRW1sYDAx3mEx+ewC9yBZg
         ORodnBKllNQ0qPgGZGaBsKkGosKLaTeJ1prpBYeh8iqXnCJiYv43jDO95JrW3rmehnxS
         08Mw3sDO9pMLrIpEuCG7OSJ3/zkNb6ioLTGD9ZwljevOjXyKLhAjpC6mzYMsay0qdBQM
         QXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxvJD49dR77KgiLLjbjADul6vCOZr9KVAC41YyCBAHIrfTugEKrClFhbQsqynT/sKyRlAkvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRyO6Nhl9OFIA1SKoqiTjvgSOV2LFv5J2URqe6NOHGPbkV9uk
	1BbRxnChKchv/5QoNWRXdwBTABkEjk7r4ZTNdX2FctBiJMY2zzwDmn0P+gTJyJA=
X-Gm-Gg: ASbGnculqf+N0zihKPRKsYmKZdRVCIMXRarjx7Qqun4RyomoG1uHkc2gt1BFNhexiy9
	NjsGbd6BXhRX/LPkRi/kqsq1Pn00TSZIOydDY4/E9KYVqXNfkZzHNJYweKQoWVcx48aix1mYxYo
	23Y+Yl91LXeVgzgRW2v2TCqSkA5/EnXByPq+UDORVbPzpKX7KlVbCKjcB1pe7nI8Vw/rxHXvGdn
	FWHrBxwAV6l9AAsTTKRQ0qE5qImTtHr7F+9HyJSxXYdcrvSTS8P0kvn538=
X-Google-Smtp-Source: AGHT+IF/jcs8cjb4B6GiHnOvpr78M0lvjd/SOOBsND3Uk6XPO25NFtr3q9aIzztmUerymlOVowuCsQ==
X-Received: by 2002:a05:6000:2a9:b0:382:5010:c8cd with SMTP id ffacd0b85a97d-385c6ed7749mr578127f8f.44.1732664672853;
        Tue, 26 Nov 2024 15:44:32 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe338sm14482899f8f.33.2024.11.26.15.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 15:44:31 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 26 Nov 2024 23:44:27 +0000
Subject: [PATCH v3 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-1-836dad33521a@linaro.org>
References: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
In-Reply-To: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8

Adding a new clause to this if/else I noticed the existing usage of
pm_genpd_add_subdomain() wasn't capturing and returning the result code.

pm_genpd_add_subdomain() returns and int and can fail. Capture that result
code and throw it up the call stack if something goes wrong.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index fa5fe4c2a2ee7786c2e8858f3e41301f639e5d59..4fc6f957d0b846cc90e50ef243f23a7a27e66899 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -555,9 +555,11 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)
-			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		if (ret)
+			return ret;
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);

-- 
2.45.2



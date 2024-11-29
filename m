Return-Path: <stable+bounces-95812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A12A9DE6F3
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CCEB22473
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F419D8A2;
	Fri, 29 Nov 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5IDfDI9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FA156991
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885664; cv=none; b=s+qYuCDHMe7hPPyDeSE+pNYahpP4MFkkSexc0GB92OprJa1hfuB2f1l4903vxJEbONcnVlcfC1HHea/jv6UUe2xdjl+CJz/LLZm7yx/jiE8yPmU9RCk5Yws5PtCT/s6/kE/pAqRIPVF1fqh4r563BWGkLwO9TP/J75ClCgk6mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885664; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHxkljaKOcJEJWD8CBHvCEffwJ1ylN/1j6Ubd0qa5fmIpphJIrRI2M+cZohce5bgIm/hOHa598W2z1413bibN4Wxspu4YmRQ1/35c7U8MWLRLjkjs8/cHYyAFvHerr0NWspXtSiT8O7jfsltPwq2emh84uRl0YDm7p4ikHDLQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5IDfDI9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a742481aso16801675e9.3
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732885661; x=1733490461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=R5IDfDI9TKVnyj6lHw+l5l7gbB1ICpTZkx/K+V6gG4UQVmrLCb/iNc1ra4GaZE9txO
         csKf2OX0dDpsciUKr84zqwTicYwS/pbfjEoDaQXfYRqTzteX65+KG7IdYwpRAjaOe6Fr
         /nyEivv971MqrUE2DJcTPDSL+A7nUF8ihYRr+yEi5yWg7P3U/M1fI7ae4WvHYm6LR6Kq
         L3T1f8fCxlWJw7ktevq7r43ujVuo+gppeTqsml0rsY2k1wnmF9Ltae9ChjAJjKziqkjK
         1UD4MdXwlun1ujaOvCOdvJaXREGXpJs2vaylwQayUAPgQPQ3BkDIw7vb/KVMdQT49lem
         1agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885661; x=1733490461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=s3e0eCf7toKM67dkQJia8BBSVGKWSzKTF85wbvi7WpdvbSX4u0LXlN3z21YDVzp5Qr
         dUOs15fCXGwfPKh49Ve+fepg66DhawqdDoZpdsxQBby9TGHlkZRDak45yayzV/cHbM6J
         +CntSL2uCUMK722Z+peBxTvTwfFfSJ9CnM7G0YnB+C6DtwSog/oYLMhuHi4VNi5lnEEY
         nm6Y/09zKMpRLr/zmo5GoMDzmay5JK9m5E0QAABZaRHD9gfgVwDrWe5akV7Bg+OyHOsH
         IQIeJkjKRWRdC4Lnfuqt2zeSivpbQiBJHelsJFSJmDi/oYuAT2HBb7zVh9lRxH79Zv9v
         U78w==
X-Forwarded-Encrypted: i=1; AJvYcCXHAQF/naLyGwOvOGliK1z3CGpUXNiHOjUi4sJcaFSKj+xWbpp5Jh5PuXXEoP2V9e6c8F+QH3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PMFwFMtW3XJKWobjAUvJq4qSxU+ITXGGmY+dO2AK984nQX7Z
	SylFvQz9LzbtyTK6E6PFGSePrZ0sMI1iIRYHisElQplfhs8hdDOU+8kBfV6LV/o=
X-Gm-Gg: ASbGncunckB8olwda+uaYS5c3Wx4BN5Q2vPJy8rSXlxm+oiadPFx2G1Fw1scQlkOXGC
	ctP5w/+uG0pv47pVCjG02HwfE+HGEzj0SukjSTHzXKXOWd/oQQUohpLoMw/YV7GRWDggMS3NrlA
	h7fU+2vl+Wy7TWQ7hNiePCSGVVDeK998KQsdRcvC7v2EfTOcyLS/kp5HoDm5r6dPWsXbI1KTOE1
	eUe9qfSWQ5YEeymA7NeyWeTW+2LXI0WUTJRNPm5+7qgwrK3dqVraSyXhhU=
X-Google-Smtp-Source: AGHT+IHhtPopN59nF0wT9aM0MO2ZUTkad4G2GioIMf1qnkxOPmpIkivwxwFk/94QpZ1tIVuayw0v5g==
X-Received: by 2002:a05:600c:1d18:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-434a9dbbcc7mr111429935e9.4.1732885642767;
        Fri, 29 Nov 2024 05:07:22 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa77d01esm86228395e9.22.2024.11.29.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:07:21 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 29 Nov 2024 13:06:47 +0000
Subject: [PATCH v6 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-1-24486a608b86@linaro.org>
References: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
In-Reply-To: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
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

pm_genpd_add_subdomain() returns an int and can fail. Capture that result
code and throw it up the call stack if something goes wrong.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
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



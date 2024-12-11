Return-Path: <stable+bounces-100501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC879EC0AF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2AE2827E5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734E17578;
	Wed, 11 Dec 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFddXlxP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C276748A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876870; cv=none; b=e58qQd7WBL1O0T9ZJpt3Y3mQJ6Q5kqZlCiiK7NZ/HT3GgTCPXMLypzOW4v3n12ODgi+CwZ7u+jZyX/P1q8cYxoN2Ajb3KyraZQhiy3Il1gi+aKfAoPoo9Ns3Df9cj7QKYadfpdnTu3A15wolOxnw4z7gv+oUQEvaXL+XOXK7djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876870; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwZNH1axpb1AT0xSGr/4gK5+lu2f5sDhb2Qo2m+bwnsyqjL940gbFxEhvwhPgRspQ8fOwh+FGr6s3eyKBBl0sLXA5BDXndGXV1PfuiAQybbAFn0QE7ADHjB4w8K/mCdRbjvd1OpBlG3BwJmIByrDo9lrHAivL45BHknkeltNNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFddXlxP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6097769a12.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733876867; x=1734481667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=CFddXlxPbylfH/CgBkKc+nwCdkWLz7rk2e93AwaP/uMhCYDp2ysLfunIjKvOWLnzyr
         Mni2CPQ4RegvZvzHVx0hTBjZqwGMCaINHHKrTLYe0XRbiAq7gzgfkXKdCyT+rl4OYBQs
         7N8M8wS+y7KJHs/sTj/GUs2wMJM54WPTR4NpPnrbtKc0b8TPzV4v/WwV2gx4gE5dFOmu
         xhwYXJf8dCcLVqNJSI2Tn3rcU8IpZlk2AuQ+13V3IBct90rTw6ZZt7XY8tebeoJJbH4S
         scjtanV04qGqLv9kUOOblmc1ETANt9yqQPW1sWQ/vbOdY0AZFDRzCBdIvr01H4McrM7i
         dAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876867; x=1734481667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=sqoN1OUiOXZmtS9hNM6xkjvCGC8PLluGFlyvv4HU+YEiYtljNZgLsV5eCMBl4Ofxjh
         SG8hbMO6F/+TwW3DczN/aKaVP7E7hPyCHtG7hbf0AQG/g4stHBU3hxHSiBRetoil+W0N
         jvo0U6DBsCsmyiEPNg81ijD4eFfxs/sqroWp0RNd1gwIIz5+P+UmlGsRr1nScEL+AUFi
         8DdjAPEfEkVHIVf45fTnidjJyTBQtX6VXlC05sLfqQOMDJ2jheUElJUsxpVo4hUFzK/m
         BtwWF/uEl1NIKe6LKM9LQMwpHpOMVUKDukomOq3GGdKD05xeRNNVRu1WhEV5gD/ESwb5
         S6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu0+l2i2oEXklokSFNJ3JWCAKf5Hv4wXyEkNa/QoSNQOH6A92ZPVgmQ12MLn4scEcjoxR7RTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/d0FSFgu/jJzIU9qgfosvpdKFIZtWnuWOzeLBLEsWHFdYmS0
	pdC6aJVIh5nXaei3WmLeLDRSvLNZKlHai1+Ygim70Gf9YyY6pd47nK6mb3q9o1k=
X-Gm-Gg: ASbGncsRZag1yF5l7uzWhgcDabBNfawxPVE3PXu65HK5kO0xk12h/ROeAHaGy/4VYut
	5RT9UAcjy1b3TIC45GIL/o5kmyTzs9P/h2ziLjJcT4OIrx/kAZSV93q3PUUoLftJwJM5PdC8Hna
	GIpc5iBkxniPa//E/iSQDnfG8yABHMtT5Xt5xCfe1jcgI/rPV3THAMCQUxmYOuWlP+oYMj0uIuK
	TW4bGldUAESMityaNCAfKI6dSblkGpx14R985MuFTsCCIepzHLVPuquzcCkn4Y=
X-Google-Smtp-Source: AGHT+IGuQRWUUAEjEqZ4dDWJ2yJP50NE8IhkqArwEivr/Mss2dg6L0s2MPZphZdFxMVQwkR7ehoZPA==
X-Received: by 2002:a05:6402:234a:b0:5d1:22d2:8965 with SMTP id 4fb4d7f45d1cf-5d433177d66mr547146a12.30.1733876867522;
        Tue, 10 Dec 2024 16:27:47 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa97asm8155530a12.73.2024.12.10.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:27:46 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 11 Dec 2024 00:27:41 +0000
Subject: [PATCH v7 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-1-7e302fd09488@linaro.org>
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
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



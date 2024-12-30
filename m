Return-Path: <stable+bounces-106284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA339FE67D
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A7518820E6
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F991AA781;
	Mon, 30 Dec 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWrGG5ID"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736F1A8407
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565437; cv=none; b=lQxrSzZKZU0OXSlaJw+Gc1ab2hzQzg+2haEoqvypsMEddSTAIi1Wm3bIv53sLfL8K/Yq/yglEDZFVaP/aILfQQ1Zgme055sBv6HZfHEfpS9P343LQOW38tOZ7qvQtO3rTwV1DrD8sLiBgh1/5o7XTF0DTEeiWCRIkfG+ROENVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565437; c=relaxed/simple;
	bh=sNd2EYZIg7l4zPuE7KNVjgjjMpcll492t3gb4SPn5/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sqkKdygYIPCHzZw9aSJn+ioIBxphpbbgotCwxh3oEqm3YtVHzem8p7UuWce/UcCMhJHh+JsjifkQlzYS4PkK3GdVw4Uk9rLwz0+CQNcjA0NSIv1dt9voGrUXazPMAv2POoBJLFEk2a//3+5HJi1wbB75QPHAss0LmAIz6XbSuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWrGG5ID; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso65872995e9.1
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735565433; x=1736170233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmmcpflYSTdG9DnEC1Lz8/bGJpmwX76Rv9811OTTa/Q=;
        b=EWrGG5IDJZuxm92tfhj3Ag40e0RwXi5VHjBXSRtRoXMq3Ou0bU1YPg8yyt1UvhIpIK
         JA/7YT8MK04czmdMiGvx+hjAi0ZgzD2/2APWhHgv6hlSyGiOam5CaPmiHv+pL0VF2U/p
         27BbnU9yrYKPhKT66LeP16PpbzOuSwZNApxxQ1UvGUmHhoNuwhEpS3qh56qV+Isv445K
         SQfAETCNW2SOK0sB1FStt8ySnF7A8iZLeoRA5X02aur45hD3l+uLloJh/fXOiXdqnEsu
         nlGm0XvYZGiiAqW+KZJIBrsT+7SLzol64TbhmakGXxwV000Gb4trX+JaUOHWtJDGLwq2
         F7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735565433; x=1736170233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmmcpflYSTdG9DnEC1Lz8/bGJpmwX76Rv9811OTTa/Q=;
        b=rWZotAffLJE7l4aRUdhaOf0UGwjIK4zBeygMAsGFq4L2iuXZ0Wwvbv4lfEFAM/r7p+
         OnUV7GsLFrzRRCJ1MCbN/RuHE5MJ182QX48k6e/5KYaUQXCfldaFIHjngDLQx3dfSUUK
         uHG4mw69iUPKS0aWGh+ymqAn3FomsBzS8H0WQhYNU52bWNzXtx881RwS8PEhpWBCH7Gs
         4SiiuGF4W7segmwxgAG8aKJdkXLeo8M+FVnRdeLnf7LYW3IM44Y0pHbhJUPbJXsWDmXI
         +RDfZnuZCcvi82HqIsWA98OLk342AOaIMRSSQERY370v7KuPiRkYY2ZTLnYIkn/LVHlu
         vwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFh2DK5jA/3+aMq1WDtl7O4+nop0toAVDCnInqe8Nu2KYMEXVyM8oA8mMLV4JOJzbahwx3Xg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVNW100EPwRrmT3XF6U2E9Q5g14IpdpZResn2JgxrOfyyQPIL
	pqK1Hx/5uRm2bWRuLrOyLmQTgib7uFDQ86mSOpIlw18dsHzpBVup1XWDA94/jdU=
X-Gm-Gg: ASbGncs189ZhJCzaA+xWgFDG3vU2L1vgNYwXzJgOaEOPu/gb4Bea9ifH6dI6v0PV2fR
	HpFtVymJiIxAb411HGklTUzCfH1nqrb4HfLbRMkt0cPnb44uLM4rUC3o3d18LiAWe1KBB2yA4UA
	LQMc3+kCzX86TDbzYv7onEPgUg8Rdu9q5Z5fYpYY5MP9tDpqAM0KtAr7ymV4J6EqbAWyNUpCIND
	eE2Avhamm9kWyQ2vDch/qmFw7QYg98jrbJNJl+eb5+OvdGksmbfCeof0xw06bk1nw==
X-Google-Smtp-Source: AGHT+IGtqzbMxbz8z4IpV9vofNDhZDNQzchKvO50pMuWuhuqRDt6Nomht67se1WDndXJNBW+wBsc7g==
X-Received: by 2002:a5d:6484:0:b0:388:cacf:24c1 with SMTP id ffacd0b85a97d-38a223ff10bmr30771407f8f.58.1735565432677;
        Mon, 30 Dec 2024 05:30:32 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828d39sm31079082f8f.9.2024.12.30.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 05:30:32 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 30 Dec 2024 13:30:19 +0000
Subject: [PATCH v9 2/4] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-2-f15fb405efa5@linaro.org>
References: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
In-Reply-To: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6

Adding a new clause to this if/else I noticed the existing usage of
pm_genpd_add_subdomain() wasn't capturing and returning the result code.

pm_genpd_add_subdomain() returns an int and can fail. Capture that result
code and throw it up the call stack if something goes wrong.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index bc1b1e37bf4222017c172b77603f8dedba961ed5..fdedf6dfe7b90c074b200353fc0c2b897863c79f 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -506,6 +506,23 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
+{
+	struct device *dev = desc->dev;
+	struct gdsc **scs = desc->scs;
+	int i;
+
+	/* Remove subdomains */
+	for (i = num - 1; i >= 0; i--) {
+		if (!scs[i])
+			continue;
+		if (scs[i]->parent)
+			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+	}
+}
+
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
@@ -555,30 +572,27 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)
-			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		if (ret)
+			goto err_pm_subdomain_remove;
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);
+
+err_pm_subdomain_remove:
+	gdsc_pm_subdomain_remove(desc, i);
+
+	return ret;
 }
 
 void gdsc_unregister(struct gdsc_desc *desc)
 {
-	int i;
 	struct device *dev = desc->dev;
-	struct gdsc **scs = desc->scs;
 	size_t num = desc->num;
 
-	/* Remove subdomains */
-	for (i = num - 1; i >= 0; i--) {
-		if (!scs[i])
-			continue;
-		if (scs[i]->parent)
-			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-	}
+	gdsc_pm_subdomain_remove(desc, num);
 	of_genpd_del_provider(dev->of_node);
 }
 

-- 
2.45.2



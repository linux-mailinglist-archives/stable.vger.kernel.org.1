Return-Path: <stable+bounces-95332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B059D799B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F47616290E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E017C60;
	Mon, 25 Nov 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOtyzUt/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF15BA50
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496419; cv=none; b=QooC8KgVRjd8tVaK0aTGiNjYJlon54ndxWXp+rJ/efRrx3bZpJyyL/1Jw0pP0b5P/gb1fvLq4IRDqJK1rhPvebCS9DO9CT9kDbpzgcuotG84PUiSVj/QSLGEDm179c/qKr/vNYGIRRSQsJv14CUSv2ImXP2b/kDiax9MY/svyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496419; c=relaxed/simple;
	bh=CdkYU+QJ7VGTHMAgD+J6/KS8Mhb64oBSKmpBnvb/LZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIMvEXl/C/iPrYlgdK2+xj57/RKKAIJIt3t51gwPCCYm4yZrq5w+szit7/mQaT17GRPbivbAr3MlviCSPpvU7oUL3MZ6ViTxmiy6X7alwaTPGiDFeqzjKMtp3or+d+mI3PylAkkRkCNWhnJ6+GDbRxqTG6/R1mzZLY498lRBOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOtyzUt/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso35051265e9.3
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 17:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732496415; x=1733101215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=TOtyzUt/rXyh125kPo6iV5EkKKLnH+vdwcuwgZOGTYl3sFk8kq3Nyxq6W3WbhZ0jp1
         IniqdNyAbZjX3lmefFs61zWNmonVzGjus11MxR2lWC0DuBtErcvibYk2LQk4Y7NljEoR
         OGSHsLDi7ojrR3LIeysbTfuybrxBiWJLo0e4HRd1WRyNl+F/m0lBQiEtSvSJLzzu5L9A
         lK7L3OnhorHrdcLNwWel47fufCoxqe0KPqzIKIIw0gQYaNbBC334fGGOwkKwRju141o9
         GuXl34H2M0MNG+JerHZMSBQQ3PqWwMvBg2coPz8r84pFHGIAXgwZ3E8pIVEHShOEQuDJ
         pG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496415; x=1733101215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=L32kfrWnrPBTjlUG2V/XGN2JhmsyTjEo/+XxZSjexmS7ltbIgXXJn+ozG0JaEqKsLB
         Up88NtGCeUPod0mW0iATVNLB4OlDgimCc+ZiuWOHOin+D37rTe/79mMZCUuM7CwJKwAJ
         ysuEGcnJkACyibg5cX8MXCMkjjH3dZ4hiort1Fyy9iE4RqZJnJ0XoQxyqlMN1ANcqgZ0
         1Ll0EhxUO3BPOma3JQ+IZu0ZN93ycjEGdrayAWebBGTC2p5Fmz0aXZXeiBXIpFy77zZa
         2J0w+ci0lm7GI5LroOMM1Idn0deqnGjSQukMNdn6O2RfGRra3RgeL7SNnRKAvbxDyidt
         +J5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKjhPy7AbNJJzk+raTQawFdFWooJclb1IV/ql0LDqp2Ou7KC6DgYx2xmZE06f/wqJwMBFdKRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQe000Ja48hlzTFzFG5b5y1NYyNWghlIgnGDgM3HGC8tNnmel
	LLPkqMuhoZO9NdlmSWfZncAcuBfQiEDXCQLCgHN667z8zhIOxD7Tn+nfWSa6ywE=
X-Gm-Gg: ASbGncutfGL+Qljr77YmVm2GtwqJ2p+mmn4gGWNMN9+IKkzJyoQLjtWutA/UAW498tg
	C5vvCoJJOmHBA3ZT0JFX168fAQqOSwggPQ3MeUWAK2YRh+MifLOX8RgS0zGyy0Ut/AwID5F4Ud6
	5712g8lefdi53Pnsa/hO5eDJrFc7luakv7Jmz5+yD3GSA+LlzXk0oEsN8W5Rjt8DKjypG3A/LYp
	b2J0PNQnOWfJB8T13vqkMO63WJr+Oe0GTLhAI43Gphq6RWv+8ZjhWv5J60=
X-Google-Smtp-Source: AGHT+IHMErZ6fryz2Oc3MCpFRq83v9PpLk8yzbEoM1+JFIaFwdXjct61irdWGrNB++dDxJOSlfOu8w==
X-Received: by 2002:a05:600c:3ca2:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-433ce4b2f20mr107512995e9.31.1732496415157;
        Sun, 24 Nov 2024 17:00:15 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f0ba652sm24125125e9.40.2024.11.24.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 17:00:14 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 25 Nov 2024 01:00:12 +0000
Subject: [PATCH v2 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-1-a5e7554d7e45@linaro.org>
References: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
In-Reply-To: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
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



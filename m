Return-Path: <stable+bounces-100684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D633B9ED2D2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D3228303E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1421DE4CD;
	Wed, 11 Dec 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tC3XrN6N"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB331DC054
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936079; cv=none; b=C2oPT8/mhUW+SFMgLa3i38i9ZqM0sjps5ACBJrF62N0mAggAFf8f/aBuhnYFHTdZQ09lRvbiWbIap27dPpqlRK7P+fTKW42udkcnSmTJ3osdUXhYbw3q58RCvWF2U6FddOsf4fi4I00EjoBn6MY1BUPdJdAIfvpVeXI6gETqU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936079; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/6Y4TvWgn91GZWTV33frKz5RXN5KcuXqOXQl7BHQpEKvCkmT3ro4TtJdIs6fNwQm5XX/yHDauP1R/pq3/fd72IZM39NHNgMfK166UB7m1DMGQu5NeIgmc1eFsYT0Q9KxOGcUMciP5xe6XYCcP4Rk1S67Rq6Gb+ykLR+y2MpiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tC3XrN6N; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso638479966b.0
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733936075; x=1734540875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=tC3XrN6NwnJEzhQl00utYZrObhor26u41cLUk7Fo62iUelX3UZtX6pzBqzSGq5Frah
         JJop4cZaLWsjpTJwCDgCtiPxVw7U0lUZi4xFq6g/gj+FPjoCXoI2S1QZFDG5zuDpYUfd
         bZdYOvCn9iT//H2+2THybZdam1vNs3gA36TeSQNMjm1qCctzrALYOExTuS6gzMHKRqpp
         DUM37c0cWRj0WI27QiJHvffzOAmeWU0XAaRDDmctxy/lP4WdGqzlWPs6xeLPtwo/WFvU
         y/6ILyZ5F1tJBM8vdLyLiOdexPY7aBJ7W5ryIrPUgcmwuPFp1C4e12lJhOh6ydvNylKc
         nxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936075; x=1734540875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=Vbo4p30iMKY5R21YzDdn6GbUu27l19FKiR0YJz0PfK0gLKtu76ClFtfnMtOupRboX2
         yjkn9Bfzi1aJCquQHd9IIIPaCM9wKSN1TxeqbPcdiGDpzmUoUeA+yyaBVOd4g/lT7Wrn
         Xv7bQuKybItcPm1jMundrWCsfqC9O050ufwmYzrFtrVxJGqDX74ePFWrOQ7ASNZIZIZG
         hCvLS8zccA+fQ2kDVub+HT8v+aVN9llP1rm2U5vdBjGMYledMnZ9vLmAFZ6n66llvi48
         LtDDv7MaiTu6HmzYicOZvOgHQcbhfGAGnquKuee0q7XXJ++8XwsIxKYDadBFHPUl5tgO
         ZdsA==
X-Forwarded-Encrypted: i=1; AJvYcCVwh63am7Js+KRcFtwDw1wnlvjGiwYp5C0cCjrNvVWKjmgdpNmyT6jBdWRNS/gtv62LbXWx2Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwTLIiVoz3oMx5k5LTropa1b0Tdwe6a55RPRAQ+TzckDm9Tf3
	OiwZuWnoA8rGkNKM+4uKnGWpaioPE90LxHAyow0m2PI9FXhuq0v+N3ISW6HRfi8=
X-Gm-Gg: ASbGncsRC8FFyp9k64UwOhHKw2QU3FArg3aca6IXBS6IgKIbYkFGdPxrFjfaMnh8OOx
	wPP9ErJ8miQHgKjv8AwqGsVYG+YGh9Rp8yEiS4iK4oyGGRElxOiNwcGMCrDJJssZgHK7roeAHeX
	XWBq1U86mp4V6V/HyJMnLKLKCbnVGDAnAE6qV1y0hMwowFaGEuG1zemq3WNt8GzbeRzpMu77Fxn
	lTUZrUwZ5eld3C+PeYLjXmXJ11Qqlo4ZRCN+GSdykKd0NK3gg92g2+umw7NAFI=
X-Google-Smtp-Source: AGHT+IGwueC9pvbwJZHuJYb+mS/4YZvMH5+SuK3PdaZwf4O36I3sCcLiX8mfNLPMNDkWhsXmFfYC/A==
X-Received: by 2002:a17:907:9145:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-aa6c1b0a214mr45781766b.23.1733936075518;
        Wed, 11 Dec 2024 08:54:35 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66c646defsm651623866b.181.2024.12.11.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:54:35 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 11 Dec 2024 16:54:32 +0000
Subject: [PATCH v8 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-1-5d93cef910a4@linaro.org>
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
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



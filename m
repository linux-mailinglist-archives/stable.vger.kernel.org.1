Return-Path: <stable+bounces-95742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FD9DBB5A
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84018163E68
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD11C1ACF;
	Thu, 28 Nov 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpk1cOwp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5C1C07F2
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811892; cv=none; b=RPCBc9grdWg0EktJNNIq0VNav4Np0cQEYgj7VIub28X0Y8xifH4GQ3aPDFntoAJrlpNQ3XJVFs4nhZOw9lPsuanDLfjb+x8OKM2v9g72Ek0OU9zhgQLzy2wHCCMe7b5gUKrF+/mP3PXOCrFLMjEF/2otadQHhEnjCX8l2qn0zGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811892; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ux2S3yA5v1Rpw5COlrLe0TjWfS3AT9Jy1AG5mnpY0c04Hg+I/bJE/jUuBSGzAOZBVLzGI0Kd6e413WBobtIgdZOe2KU2Idnjk311dm1RLKO37o8gDHFh1kzohDhwXOnodzM1+6FhPlDCaGDbed85dTs7kdTI1/LtcyrmYMrK8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpk1cOwp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382456c6597so811899f8f.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732811888; x=1733416688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=lpk1cOwpdxBjD1Ktil27Zxp5XzPBNhpj8hVSXIvfzY3+10ziCMv0Ec3lRuXkXEhSo5
         6ygS6H5j5fa0eaK09VlZFODDYfGKemCrnFrUjjhrJVqQwjgmuk/u1jcmlduUOIFjCeW2
         hL3MuR4TkBtoVd/jim/oNe6IUKWuIa7rNIGV9IYQeozqicZ+YTkvaUl2P4bhWPIWykGY
         Nezt6ZQLTIGLmbL6gpObPbnxs/plSjhhGAVNyQcs7ReH3NTX9sxZyoWt9Xm24RXhylb4
         N4/OsDxDTnTYN6kwFTxpVtd3jbMnBVztzDms3VmiCQbA2vQ+ntCXne092nkptm377D6Y
         auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811888; x=1733416688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=XbXCVf7BWSFxTTpJpc/qVjdKg5YxvtpUMvco0mNZmMxLUiUvz+xT1tcrFgpOQpHC5O
         dVLyQi/rVJRLCsPGq3XcACP69T6XnLCF4rCa67y5M5Qw5/rgzV2scHwPPKiVCiTAqYVa
         gNbx8gW6CIFMvHK0ak4gsTSiPY4lzbVeq+fKiHGwUDQND10BwCRP4SN9+MipiAMkxbCG
         U+gCfGf28Q1kX3ghdUNuBILxdIbpWVXIPymJ7QgKdsO/hYSJbw1mHi/ghF046HftzuMW
         8LjKg58lvxZbQpiEu3acTCsypYbQGM8z/fPB8n+RlOkcGzMV/OS0vsM3+1x048vy9roE
         17Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWxjSZ8CysBOgyrknHh3NJCidmlTqUgyqRT5dHMXraEDUHwXe/lv62pWkQN3T41cBf53EjEV58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVcHuLbVGLqlcvGEMEsz7pcxjCcU/JWzf+6dgzlri+I3PSitS
	Sb9khh0e6QIC+Gi7Uh25n6SBOMnd5PHTScxDRMhAXMN7FyuuYs+J3dDm7YSYYn4=
X-Gm-Gg: ASbGncvu29R5KTuSzBNjKWjeS3ZXFfqlhVlNkYO1EwwydWTd/D3bLivbZHI7idVv5+U
	lWwGecqlHKrjZJc3je/noFpotDX7EKXn8vB8fFYpdaA1LBLprLIAKgUxINjv8mt6OIsWl0cBDug
	Z7W6UOpeD/QldxzPlOBplMW770O/Uz7YDUhbWkwQznqTJx39ZPy5OiU81k6u6+7TpdGgiH22dyt
	0CMc62EVjjQXuAs7RoBAjwgVMCbL01m1wFSGAB1gdKaL79dyqN94m1e9p8=
X-Google-Smtp-Source: AGHT+IFubuteqggyPtPqePz0DzUO88xCM2UujedDVDd3qIVP0OzH3a8fKyNdLCe9TkJ43xBopue/pQ==
X-Received: by 2002:a05:6000:2ce:b0:385:c8d2:efde with SMTP id ffacd0b85a97d-385c8d2f096mr5146870f8f.48.1732811883199;
        Thu, 28 Nov 2024 08:38:03 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78c202sm57990155e9.26.2024.11.28.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:38:02 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 28 Nov 2024 16:38:00 +0000
Subject: [PATCH v5 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-1-ca2826c46814@linaro.org>
References: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
In-Reply-To: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
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



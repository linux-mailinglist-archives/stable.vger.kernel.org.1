Return-Path: <stable+bounces-27207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF86877152
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 14:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F137AB211A1
	for <lists+stable@lfdr.de>; Sat,  9 Mar 2024 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A240874;
	Sat,  9 Mar 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZkti58G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F983D549
	for <stable@vger.kernel.org>; Sat,  9 Mar 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990116; cv=none; b=LlVVMB+/ISL9bBRVkT5TzX5s3JTJt1Ayu3EyHBJzyp2c8OUU1Ux4tgCPubYSCESrQEckEHsCQlPnS0tftSqwG4KJ+zyVFgBnOrSf8+UW8yMFPl0TpgBpJRtkh0olxx7MplwPOZyZg7G/pejBxo2fo3wDPa4QRulm5H2dliEE1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990116; c=relaxed/simple;
	bh=1zKmaCSSw5TxCbTRZY28a9vzXURFEF5JKLcjEG+HISo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T84dUZ0iVMW4deUoph0IBtofkZ+ouR10540XKJiqzwbcDZGjtVVaOK38xNjiaKj3vzk1jnp5n/8xUuXFRLNdL+LMDn+EQwPfZeVAH/aaCV3V4Ev/bhJHqxueuPmCyFo1WUrNhZ86GmTpTwUi9I2II+W2zqMJn6g/VqY9eKBBKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZkti58G; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so39137671fa.3
        for <stable@vger.kernel.org>; Sat, 09 Mar 2024 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990111; x=1710594911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuS5xkKxAChkv3klXygyRlixyQm1XAjkTPSLMGW83Tc=;
        b=SZkti58G9LFB0NPJQ9i3yL7gXa0LVbuaLIPlPMlw7HO5qxmx4SGwDFXYznZhJ5pwJ0
         5U8LY/ODm+DekJEp8DD8/T47BVVjQayBZMirRkvbAgwkKPHxV0+Tdn8ryBpfz9NSLbTe
         GSI+3iTi98WgACYJ+4iLtIWPoCU+LHwSMGCPpmXJRKQ9tfLCJ+4mjmopCtPye3NGz6Jl
         oJEzfQ3HZ1ebf27QUgk63eBzQQI3W2zmluHLSEpatXzMv+Io6QFo+3TXbRCAT7n2YlWN
         WU5S4Er+7eoVfayoO1rNi8NIfS5YJhV25u1tZxrD4EpV3q2kdiKSoN6YQGFu2GpyrjCN
         +1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990111; x=1710594911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuS5xkKxAChkv3klXygyRlixyQm1XAjkTPSLMGW83Tc=;
        b=BtxvDUrlX3lSArUCAuzYWiqO0BJZUrq1JuapTxU3cJOBgPeZEqoiWWZ0vP5o5WhIfi
         dLEY5ReYQuykzp3eApEHnHxCgAeeiqSt0MPSXPm347lp6EbonjFotsT/VOhMkvvjOwa5
         QvNJ0lexrSRfm6HLZE2JdSB20TsVJLrAALVac4/MgAvCN6Whtk7/ZmxgNnWDBYEfF41g
         QuYEKDQ/cjv1kvpbVNwWAb/PqeHz9o3Zy/dSpqghj2gXmHTf1QAyIWxSlFdjF1YYzWQ5
         KcFzyuRrWth+QmDJntpmP0vN0nOD8tBimnSkYgGRIJzbvTDZerNRGKykkRmr+/tD6bOV
         RANQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEiSW5qpxBeEyqMOtw62O+4m99GBqzP15Fabo4gYLqe+FIhJJR4HSUNEC3ygjZscKCVWnuKpcEhWaeNfCrtzFk3Uy7ev3F
X-Gm-Message-State: AOJu0Yxw2FF96PMJkGewUKJUfR7BMc98zuiM0qLlRKX3snF5Mb6dP6Tz
	SVRYM93eGdQbBs4NWksQoWeFeSBwV628TBAhXqOG96MpI2plnKsTJQr16KkH+68=
X-Google-Smtp-Source: AGHT+IEPOEM1RVrjIlKaaUwTfgMe1csvJm3TBP9ee3LeoP3bZr1TnDN/ZKE6refGJOTjv02fY+UnJQ==
X-Received: by 2002:a05:651c:b0f:b0:2d2:74ed:37b0 with SMTP id b15-20020a05651c0b0f00b002d274ed37b0mr1504989ljr.11.1709990111704;
        Sat, 09 Mar 2024 05:15:11 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i26-20020a2ea37a000000b002d3e6ce75cesm297596ljn.70.2024.03.09.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:15:11 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 09 Mar 2024 14:15:03 +0100
Subject: [PATCH v2 2/3] thermal: qcom: lmh: Check for SCM availability at
 probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709990106; l=948;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1zKmaCSSw5TxCbTRZY28a9vzXURFEF5JKLcjEG+HISo=;
 b=JJqil+Pd55w4V+n8GoA7VUlGwELl4ASURFbO2mhhito2CCvmqL0S6QbnYq50dLqP8nX/vqyfI
 4E3rY11y6sDBOf8BCdM2BvMWXGkEYvkWNkqeffRUXGCTOcrI/8SSo9R
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Up until now, the necessary scm availability check has not been
performed, leading to possible null pointer dereferences (which did
happen for me on RB1).

Fix that.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index f6edb12ec004..5225b3621a56 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -95,6 +95,9 @@ static int lmh_probe(struct platform_device *pdev)
 	unsigned int enable_alg;
 	u32 node_id;
 
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
 	if (!lmh_data)
 		return -ENOMEM;

-- 
2.44.0



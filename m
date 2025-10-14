Return-Path: <stable+bounces-185614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DABD88B3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00131923C78
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F453308F34;
	Tue, 14 Oct 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcTUX/ej"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D412FB97F
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435199; cv=none; b=A9l2vjxbs16z2bI5ayqLdU/qoGy3sXbc+PEB5GYcPPxtgRBhVG08jlzCrgraS5fx87UeIlKwWgKxHUfxJHASE+eCvBwfrOUkARHH/twZf33J8NuLYJnV91jvI7BaY38AEp7/LWRTimPobeZ1UT6xchbZ7JqJH+ssOTapuvwXmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435199; c=relaxed/simple;
	bh=Zz2R5WmG71VGhvfhWPgwTOijPEaexpycDrO5L76SRq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOM2A8ParYWCcR/p34qPKUf850hYyb34o0Gv7ngDyQ5+RlLr0qr+fdu3kQE+jFZxVrLXqu7SC9l0vIgWnBaZwaNDZ0B0S8vo1WQfRCZqXx/N5u8PMt/1vzKnbXKYAa1KbWMV32NqR/FijlaLCfLs5BDKLdZF6nZ70a+mJCXIKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcTUX/ej; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso4401406f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435195; x=1761039995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzu7zb69wVj+tqTtPM7cxHp0BkBV/6RIMLEciU347jg=;
        b=lcTUX/ejkRbzORzr9IPK9zhFnjyNhudJmksebExeKVirj4jbMtYllsoK1erLiuI4xb
         IiyfsmCc95W/xCu5HaWZjmvqWPvj3TpEs8j/R0S0dR4DtS+/VlKHVsJuyMAYHhPzcu1B
         Um9W0uX5NZwp7cJJo5J5QQeYL1CEqMdrkCDr9BhR6/sWaZsJvSNZmM7RtML5Dql/nJ4n
         MSwLladLX2cDgM9/CqkaAaiohAyG+VjaeY28L4qYkZxuZVtgG1RXhNbNNpxhF7jCaEGG
         857mWTmgcaleZjcVlXbWiemRx9Uxa0bFP9EPw7c/a6UVdmnZHksSQbnwI7e09Vs16e3x
         44Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435195; x=1761039995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzu7zb69wVj+tqTtPM7cxHp0BkBV/6RIMLEciU347jg=;
        b=LhiTTnxEVBQc+p2e2lkWwXCo2X53k6Dox8SPmrpH56iaDDo+fjtINhaUk3eY+aE2VA
         dndbKc+kKu8UqGZ7HUxrBiE+zXH66PhTBcmGFdhckuyngelC1DYSs9HrfJnzlc48ACeK
         V1MAPpjyS7ikzYGe0lLjic1ptAd1GvaEQhAtirzYHJ9ethDH6ur9VpMMKtEe/jeO1ELK
         XcVVwMFlB63AWxSLkGJegGqynw4Ki+lW1f0w0WiAEzhNXgkdm4njoxo3LCZQC7Hd+nQA
         eQ9Mx/poOOTUWjR4o+5qYBtoXFWFG5uTqfrXXG+vxq5Jy2hsJbLyUUur44DJxcBh5O2B
         WLDA==
X-Forwarded-Encrypted: i=1; AJvYcCU5VKmLyQXJ8nVLvuC0YoGtOV6OpYl6UoETidL74+5S/SnjI/hF7Q12WHJsXxGC6DXQvJ+YFoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUqctkIX5VnejbYX/+PD4IaX4kCO+CENxfvI4chWs5b3cH23/
	l9uM0Tu86YdnMV21qPOu1oX2gGJUvC0tQmOuOQOezKdaWr5c3U68ddvALZJbE8eFqjA=
X-Gm-Gg: ASbGnctWaub+kT48mDOkNYNuMl1Q0KKUkPs2GKwsj7bagLuYJHPz+Oz3FiKMGk/4KU2
	POUFSFJHoZo5j0zVVYO6ZJm1nPIIoQ3yuzy0kXNERBAE718ckjxTq75Uu0Sz+8G8NMZ1ov6ujkO
	zkH2+H2FeuLGZHnIlfBk592U+/jakG/Ca7tN5wuwYMjIbwc5EFYvIAeshI9wIkKrOi7T/OSbZou
	kfRHGYPjpNDscyQYGIX9jG3vgJT6B2btb5zccFXFrjkVulbRVGhz+wkVxwvyhp8J4Cn0k3UNlIB
	JxUzAJMtWLCbuCMiYRu9IVQTRr6Yg1/9LrWahurV/mgsx/HzqMRXAiojgcV3LJsKTRiOzUq4vy8
	FRpmyeGwz9E1ugOb45bEyXfJKu92uy/UT5VgGcqHF81UGEeHjoKWACA==
X-Google-Smtp-Source: AGHT+IHta3Li5X7p3tARLTwnX8shVwR39qDFoRnhPiY5/C8uOkis2kRSCCn/31skW47G6N/ubp5QbA==
X-Received: by 2002:a5d:588b:0:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-4266e7befe4mr16005800f8f.17.1760435194566;
        Tue, 14 Oct 2025 02:46:34 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:30 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 12:46:04 +0300
Subject: [PATCH RESEND v3 2/3] phy: qcom: edp: Make the number of clocks
 flexible
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-2-078be041d06f@linaro.org>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Zz2R5WmG71VGhvfhWPgwTOijPEaexpycDrO5L76SRq4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvmyWGvBIBA0KnfwUuTkQ5O0N0SRXHZ6M32u
 nJXVV82Xw6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b5gAKCRAbX0TJAJUV
 VkUYD/9DaysPmn6S1AiyoZDFnE8K6Uq7dCgppMiJv/5PDo08uGa+LB9OXUIhAa5VwHmc+pkqnkE
 Fcs1rasiDm6daGLMXF3XC+wPXg+fo1JG4IctnzOytQADR6S4SwMvAlghYl4AZus2Xc/NVQis1FM
 Q1LpvniFsJgNxi+x4V1t8eBdIkMOy/AMDpjx5YQYGDIaZ2rgBY9pLop3DxTHtGrx9Mgzi5vYxq9
 RpHH5ng32pUTq0HEYjgutCJoodn1guq6DbcKbs6H6aHyHQutpKdcE7JwzF3k0uArkjptOnJoWy7
 RwF0zXo+2UafhKxZhyEZxfYg35HyngzCmsWpxRP/fE2lmThXkDXL+8v0c3JmAsaG2PXNyn6JfNI
 OhaX4MJ/jzdqM1u4KgkWm8/v/f6x/q+ztig+BSoYQGCu8ByCWXAm9sO4wq7GS0YIVgqXdck7B5d
 41ziXNZoJb9zvesAj8MapR6Vszx9hn5Cyo62oM6+H3nH24KwCtmZY9h3WwZ/fPTGNV2VskzoeNp
 jvy8NLxN6ylWBbnU46PFIa0iB11iEPhGSfsQwWclkBk8Avm6X1NZdIUjK7IY28y0KVH3Y4lOdBu
 ioGUW6qPbhDa/D3bfxiz54FAGMLXRSUz0BDRVhUHQL4iI3g6CrHIWa0GZbh+NmLm5OhIJ8DEZbn
 4mf3n6OXXA5iSCQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite, the DP PHY needs another clock called ref, while all other
platforms do not.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So in order to handle these clocks on different platforms, make the driver
get all the clocks regardless of how many there are provided.

Cc: stable@vger.kernel.org # v6.10
Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d51df064f60440864c6031638670c..ca9bb9d70e29e1a132bd499fb9f74b5837acf45b 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -103,7 +103,9 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
+	struct clk_bulk_data *clks;
+	int num_clks;
+
 	struct regulator_bulk_data supplies[2];
 
 	bool is_edp;
@@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
+	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
 	if (ret)
 		goto out_disable_supplies;
 
@@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
+	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
 	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
 
 	return 0;
@@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(edp->pll))
 		return PTR_ERR(edp->pll);
 
-	edp->clks[0].id = "aux";
-	edp->clks[1].id = "cfg_ahb";
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
-	if (ret)
-		return ret;
+	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
+	if (edp->num_clks < 0)
+		return dev_err_probe(dev, edp->num_clks, "failed to parse clocks\n");
 
 	edp->supplies[0].supply = "vdda-phy";
 	edp->supplies[1].supply = "vdda-pll";

-- 
2.48.1



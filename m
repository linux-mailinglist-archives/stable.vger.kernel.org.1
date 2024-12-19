Return-Path: <stable+bounces-105323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A29F80DA
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EEB16681A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74619CD19;
	Thu, 19 Dec 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu6peO3Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AC8633F
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627622; cv=none; b=NMvFhDAy9lUlbXVksIxi658cppYSK2+uD/KUw6M5vMV3aroOpeuvpYVNBGOpV4GLeqc/x3HcR1SRSr2pK4lVb59j99GOSKqaQrKZPeocwooQQZv5nn1IW+vmXXSZxynN/Y5gdpyIrOnM8ti21GiC4kYQeHIN2EC5Iiv1htCP+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627622; c=relaxed/simple;
	bh=n21HfpMoJR9WFr9CibdW8Aomhh2HE90cnrVbP2qH+uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCAwtnD8LIpIEh+djG8B0gjMHGTXEPFk9QyqUKusSFIkIjm/uzPdprVSWQhdlYb96C4GQq/lF5nqf+brsCkdTBXmutcxRN9BFH64pvk/HbOdvAmTMmCOsmm53ka0x8vLTDylrDxtBphy9iwpZp0VXBHFBR6zSamnwzgtnu2nu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eu6peO3Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72764c995e5so678359b3a.2
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734627620; x=1735232420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvVuqV2GwLcaDiXbUpyro9fRhixYRjVVrUaD/WrniM8=;
        b=Eu6peO3QwujW1CstEXgtd8W0wR9s4Uwn49ObYpeL5prJu3rbvGe8/GA2AxQOj7HhMh
         eIdA8AiMFXF0+hL3X5a2YaX9BZAJLozhk0HF81uKnatTgNHS5p2SDlXAbz4I7oG/fqA1
         oxrEh4HXcHttwZHDlcdu9WOaMAprLX0bVQlyiGyzpjRYx8ekLcRa8/uvLhtAqzIgrB/i
         SvrMJWQVcy6znyx93XjUkzByAn+jU6VL/jItkmCivmzdwnOnbZrh1Cvq5fSqyMjdwaCO
         bmL+/9mREu28UtaW9KYJMkqXd9+SWQ2CG7ydn3ixu8j36pkE3fD29+IIiDKGiQIedMWt
         N31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627620; x=1735232420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvVuqV2GwLcaDiXbUpyro9fRhixYRjVVrUaD/WrniM8=;
        b=q/h33Q0aCfvqbH7pZefAC+hZLrCARft0PnckNrUIxFKjFGEBOSqiVEM54IpzzNYDFP
         Ta98M4CL0eJAvPFopxd6pCnK9EeY8Ng8Vc0SF/Dw39b0piwOvQkp5z/FwD4oOpiLpqQ/
         M3A5D9zgFl4/nHszRK1bgdXD2+MFHyn2DO5WL/wjgWA+XD8fj4W9pIlKLXLp1LNTYeuY
         rrHsnFVfDsFh7hPElMnLp3xyFAQ6WG/Ao17HJCz01S4JriU4dCt5uN0KNc8KlIN/It/g
         huZ3oao9ZSxZ1T/dR9Hr9TJ0dvOrWk4LGzzMIFnRa93IQsTOLT23/2u9GTMXvIgV9e17
         ABWQ==
X-Forwarded-Encrypted: i=1; AJvYcCULKzJ0inHYvemOWeVV16WPSKjlvto0btSoowCONnswEfjY7+DF07w4DUrWjMYCuNfGQewgYD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSRlogDN6G7pocAD23bKkvV3/1qfIZ530IUfMQQ3KgO7vUH86
	TJABeufeCLw3mQj8Zadcx9RlUhOxmgbCEkyMh66abIzxYbokXS53daBKwiVK1g==
X-Gm-Gg: ASbGncvi9aiTukVz1FcS2P3sE7Q0DSMdqbVh3OQ0jNc3wwnd2lmUB0N2N3YvuSmUX0M
	6nZFeUYbh2GNgmX49TupC0wtmTu0RFMUmm0mImuToEJMBsSKnYX6FHLvkq5pLTlNXYlJSZcyQgp
	jc3fDObrc/q2ZHAZfyAxInXJ1qVwKpZbRNFBBJUKoecyQ3Xj+aY5w6z2KMrZJsQIQg0IjlaSIIf
	6FVnY88iwaJRtQoAJr/y7D1jTruJMIJiRqVGQv1fQjhfLzE95Gc9f6ViQgBE3hWp2OnZTpMLuQp
	8owGLQH/4Q==
X-Google-Smtp-Source: AGHT+IFImDDOw38L2ODnRhpuOHiWBYDqi99QKYqqIgqlfkownksNYxRi6bh3dnJUpEOexYrDEBwdQA==
X-Received: by 2002:a05:6a00:430d:b0:725:df1a:281 with SMTP id d2e1a72fcca58-72abb50eebamr395776b3a.10.1734627619539;
        Thu, 19 Dec 2024 09:00:19 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e32f5f00sm1407655a12.72.2024.12.19.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:00:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 1/2] clk: qcom: gcc-sm8550: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Thu, 19 Dec 2024 22:30:10 +0530
Message-Id: <20241219170011.70140-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Cc: stable@vger.kernel.org # 6.2
Fixes: 955f2ea3b9e9 ("clk: qcom: Add GCC driver for SM8550")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sm8550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 5abaeddd6afc..862a9bf73bcb 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3003,7 +3003,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3014,7 +3014,7 @@ static struct gdsc pcie_0_phy_gdsc = {
 	.pd = {
 		.name = "pcie_0_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3025,7 +3025,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3036,7 +3036,7 @@ static struct gdsc pcie_1_phy_gdsc = {
 	.pd = {
 		.name = "pcie_1_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
-- 
2.25.1



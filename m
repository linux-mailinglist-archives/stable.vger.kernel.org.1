Return-Path: <stable+bounces-105324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703BC9F80DE
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1233F16708D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6D19DF8B;
	Thu, 19 Dec 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QE/QoBta"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25A19D082
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627625; cv=none; b=qmzdP4IEMNFjEfJds+NbF7H9+jgjwex9PTnEzwEvcjiURCgT7fpXCdwed8FVvs+ufX3PQ4N6QLycnat9s0S/VZ/cn7QEtavp36BAwGWUuotSfQSKnR7Stc6uJiApK0GUNJRTfMS3lkFdW9cNcPLWXk0XMUAUt1xQi4aN5kT0Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627625; c=relaxed/simple;
	bh=wckcOULVs/VpNyLdFrIVHSAJAEPzlkpkYIhbXxO9Efs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkBOP/k7YtB6GqRiWPAlNQqv94s+qjh2G/3Be4zhM5VfoFLEzoUrQuus2UBqzI89eEhXT+Jgyr+uhEUrFstTro1vJJLQlJbWKeR2eYCo8VZsIQSVrfGv3plfIQeTiGXg+iAxWjY7N1KsJoUa3EwabSlfwFb7GG/ZqOOkzYpNL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QE/QoBta; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21661be2c2dso8648825ad.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734627623; x=1735232423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY48cM88V/hoEtiU2jZWM2+6ic5R8sHZknBHQXdoTnM=;
        b=QE/QoBtaVd95p9Pxb/cfG/krrjY42NDUCYg2AMYR/h3qMWXi+0zi+jS9FcD8KzQqOC
         xjayYrR5NTs3ljakmwMhkGw/ddMQG2DkwpMg097wQ+GhJOasbLty+LDk2/mtqMz2U8wC
         c8giu9qnyswGIfGWHEyp4IcerPdSQZZF8tW6RekacpSl8hBszsrsgWPXuyl6Sfy7rMEf
         iYJkIA826jcF9BuVKBBHZ1SNjN5QrgFEmnCX2dFwpmhV5WWclwgYRxMiKs2h8U/AZNXX
         wmWQ5VLFuVhM7pAxy0iY8XOHBLKRUGB4i7EjfQexzAuxYiKymQ86ET6mJczoJFXHDmod
         yw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627623; x=1735232423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CY48cM88V/hoEtiU2jZWM2+6ic5R8sHZknBHQXdoTnM=;
        b=OZaPvpoYAR4Xn/rGS13FkEirJdxYOkgaq8bzoUum4NtFKLRzKU0ATYci9f3tR5wAT6
         YSwVSwZhHBk048t7lRtv9iumybR8oCwT+Qw2zCE6r2Nq8f1XOIm56+d3kBOZXEcqTVGE
         QRVBpdvdTufvrJc8pOZH3cY2qJaykkMCTOWYnMAfOPljzIyx9UANbjdUBFWUNUr/zPBV
         Y/McMp6qdvOBinHFbEUNJwhkhctSGYUVYtJKefTPgKtp1J+cj0l9D5i1IgVSbCJx8OY2
         32RScWnXtnseAYxPy0jMVM6rEdwC4Rv34h2mpwWS27LLDGcX7uUqv5/Z4unzzH3oUgPr
         NnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUryIpNvDPOLjN1Ei02CHTOMQP/GeHRCV5wFSxVEYsNHrE34xW7pAy78ylw3kBV6Tr/KYfohBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/78AoP3nZDUaEZkNMmjQ+FANTZ246MY6mfrFkhCMPsWH6aOj
	iIVlUoYbA3ODnFLNIUWe/fSh+mCtQfoEmTzZmMyLi9jM+G+1eeoo5gme6uEsBw==
X-Gm-Gg: ASbGncvidbFfLEKj+sTs78uYYPuKsd3BUPLotbj35NTnJJTms976yWdWQvR/kpchHrB
	6CnX1YFTcaU9134pIhwpHzna+xa0uPzxIYJcdxfyp+/08jimmHEwFbT5c7Fczp2Mp9l244EyqvO
	MIf47ZrTSI3Z1m9fUBhd7MvyXXXTAyL+4EHddXj0WTR7r+obZ1t7y7wbPXKOFMJsChSCv5RxUaq
	Wx5X8LgctYP2Lb5hkjIbGtcdzwIyCw5M1u42MpB2H6Oc34PCNQ7doPo1WkRmQ21Bz5Fyfkntzbg
	aXBf02CjtA==
X-Google-Smtp-Source: AGHT+IF61HYlBzOFtWSOXFDjQ6xXqIF+VEUhsruBuhPEigas2YyUqvrel2CTtb8tVYlJgL/VkknJUA==
X-Received: by 2002:a17:903:2342:b0:216:4e9f:4ebe with SMTP id d9443c01a7336-219d9692d58mr57695015ad.42.1734627622843;
        Thu, 19 Dec 2024 09:00:22 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e32f5f00sm1407655a12.72.2024.12.19.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:00:22 -0800 (PST)
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
Subject: [PATCH 2/2] clk: qcom: gcc-sm8650: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Thu, 19 Dec 2024 22:30:11 +0530
Message-Id: <20241219170011.70140-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219170011.70140-1-manivannan.sadhasivam@linaro.org>
References: <20241219170011.70140-1-manivannan.sadhasivam@linaro.org>
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

Cc: stable@vger.kernel.org # 6.8
Fixes: c58225b7e3d7 ("clk: qcom: add the SM8650 Global Clock Controller driver, part 1")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sm8650.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index fd9d6544bdd5..9dd5c48f33be 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -3437,7 +3437,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -3448,7 +3448,7 @@ static struct gdsc pcie_0_phy_gdsc = {
 	.pd = {
 		.name = "pcie_0_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -3459,7 +3459,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
@@ -3470,7 +3470,7 @@ static struct gdsc pcie_1_phy_gdsc = {
 	.pd = {
 		.name = "pcie_1_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
 };
 
-- 
2.25.1



Return-Path: <stable+bounces-60679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D158D938DBE
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D9281A8F
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D616CD01;
	Mon, 22 Jul 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cphgk2Sn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033916C852
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645875; cv=none; b=MVRsHj7K2gVs2pHhSssqOGcIvg40tx9y7phFMiNFt3+t3LnPur1dt1IWGhIQI7gC30pKK29REhq4+CBY2CG1zHwzZfb81yY/JeCxjNdfAhbpB8VQr0rGi9Gcf5SETng9+tZtbzBA5MRzoYVviocTJLz5wy/ym75XfZsVlPe5iPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645875; c=relaxed/simple;
	bh=OI9ivS0KG2RvRIz9Kdlx0Ag7Wy1NAEIIjtXE0CRf7TE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWg0KfyMqsGyJ2Vsz/ZuX6Rlm54gAq2CWNUtg0fKddkLdFmu6K+z7YZlLuVDBWT3McFEQfwacFf9v7Y3sAtGiT6H4mhm0x+HiNoSzqPgLvU8KTsUrTeDkObyml2V51U4VTqlYUqQBw7IMcwLvux9KvroDes0U5obwJi58u0HsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cphgk2Sn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d24d0a8d4so460207b3a.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721645873; x=1722250673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlyfwInqQ9SWjZNJvK5iqTVzQocr8JHKV8CHQ/SRg5g=;
        b=cphgk2Sn8FgSirVCSUkbTISzl778IHcWbKE2JBMnLzeFontkbCOzxGE9hcPHzsWZTx
         2iHZP2Zc4WOkcodyvtzuj3CSYi2fV+49SE/rNqxPG0VpbqZbAvNyECeueF6cbT9Ozn+F
         V7eBy67avkyhinp3+iR6nOaLD+1+5uFpQMedKvDpZ4puwiN+6ZBiy1yzBpdjv+1H45Ae
         Jt9opuzvuEcoLlwtgJZ49A5d1OMck/OO2YsxJ2z3CvBTiTtawZ0/tEWw2X/3ltTByeXH
         pxFTFENjeVUE3TVE6QEUOz9O4uaacoRz1Iyu1sHEnRf9nqnhRZ8byIJy7Wi10NMk5k6t
         L2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645873; x=1722250673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlyfwInqQ9SWjZNJvK5iqTVzQocr8JHKV8CHQ/SRg5g=;
        b=Usk5aTsFHsXcos7M7tWS5o2seglv0kaPPf9oq+2HRSgR1J6ohruDxKMd6tEIhCnyJG
         CJOdOgAvjSJ5pDYE+98h1ms+Oeeol5yNwBkOE7xZMc+d4fGz1gTcJx/qpl40my/l4HNp
         vt9HGutu/yJJXT/FRzIx6b7FQM4vzYDUGhGsX1bM8lkYyFpFoRx7CHTzTYMtHB+lS5yJ
         xtk3tV3pk9NbQUchX094ixy/GVT2+ICr1fOEUkWfk04BxD9FLxSYu1BHfRPlVy+jLleZ
         YPQeYJUB36GTH7g3H/tH8aPDjEl1s+iERj9C3bhB7IaEyy+BSJTeNroVcpRZ88Qi38S6
         CRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWxXoN/X047aj4O1Y7fy7G1+F0yjhAbHN+0iqIrM44eaS+nU2qpwyls7ZfIbxHpyt3Aon3Pycgy1VpYVYvciDm2mezif2Bo
X-Gm-Message-State: AOJu0YzgbZq1N3cS9brt840oJIqtU0MIP2u9hzVzbBVmKekXUxaqwRbK
	0ku2rjbOfsXogOV45ND5lhJcAC3aho6zUGo0kc71RJbOFFaxGPV30PI+enCFz5L6oDxMZIqA5XE
	=
X-Google-Smtp-Source: AGHT+IGzSZ/AeiRRay9oWlzAsexbnmsYckOBqmIpeLDEUB9QOhiN/310nuLGsNRvsdmRD1v3mLFznw==
X-Received: by 2002:a05:6a21:670d:b0:1c2:8d2f:65f4 with SMTP id adf61e73a8af0-1c4229a42fbmr5153409637.44.1721645873135;
        Mon, 22 Jul 2024 03:57:53 -0700 (PDT)
Received: from localhost.localdomain ([120.60.138.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808f050sm6683862a91.45.2024.07.22.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:57:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Mon, 22 Jul 2024 16:27:33 +0530
Message-Id: <20240722105733.13040-1-manivannan.sadhasivam@linaro.org>
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

Cc: stable@vger.kernel.org # 5.17
Fixes: db0c944ee92b ("clk: qcom: Add clock driver for SM8450")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 639a9a955914..c445c271678a 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -2974,7 +2974,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -2982,7 +2982,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
-- 
2.25.1



Return-Path: <stable+bounces-65338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032B946C42
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 07:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9741F220FD
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D815BD53B;
	Sun,  4 Aug 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ims5R1Cm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181C3C30
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750022; cv=none; b=Zcf4co8tct+Pr/Dap3JDaa4kNbtAuymeD8Egrr6J6iQg1zcYwfbfkTvT0mrqchRZNrKfQ+lh/ICuZlgdMC5MP+pjqW09Z6LMmp6xb3j7o3Qu2akta4bBP8Rr2JmfIqKL2At94Hcfz5gVgYYfykNjNGgFAnq9kWZuSHPveTJtQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750022; c=relaxed/simple;
	bh=lCsk1q0z8so6Y2tczVGuQeC5mXXz5zbJNYg4kt/XRZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwol7vWa3C4myeQWzp4o+1A4pGx2OYea/xVUf4EoFK6VfXrLQPlpqIRSBQYJVr8bTOq2fHINiroROLB59Y1TrvJK6zSw+ZIRP6idpd3g7jrvbcM1GOtJzLjwFoCWB9uhnWBPKYhUpgHw6R3McdeNKmJttFTBHK7kdXLPcD+p1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ims5R1Cm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so1128806366b.0
        for <stable@vger.kernel.org>; Sat, 03 Aug 2024 22:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750018; x=1723354818; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV2UO3BH+2H70FIcXfsxxSdrx6CyxPDxlREVUWkdsMc=;
        b=ims5R1CmRk/+9v8j/kkYIiG/GrWJaqMxZ9vpqG7IotOzajfXxfPugz3Cw59y1EOnMK
         qmzuChy1QmhwcleNFI+ATx7We0XHzdADUuCqeIsCmf2cDQ8u2vGlyVB9NqMCVeGtPbrZ
         3GOtIJ1/0RpcaCscpH63s/NgKY2S0G9ifNFhNSK4ENMpoItMy+QHoKjBbBi0dv96kha3
         hIqcZpPDfyHPoczxMNHPfK5C0eUqYLFhh0YH09v9JGG2dr53cU4FIR9ZiXA9YEbPPFHk
         iM8tsK21j2O7yn/loeETcx0sBIlhNcNqquWTl1SCw7Ir9jcdNAWIerpTS1MDYwMc5Y1e
         qSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750018; x=1723354818;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV2UO3BH+2H70FIcXfsxxSdrx6CyxPDxlREVUWkdsMc=;
        b=b2nllaiADIXwkfMaAhppisyLEgp6W5VcZRMvign5U14JElJOK8CkxB5RfIUtuCvQGT
         PWCyWT/bZ9jyIRcfaaYQfK6OusK8ebSp7qidNpXOUraROYXw4iK8Ql6znxltU6WSE3Nv
         9/NhGxK4G4dZGiI4vepaoh5dr/KgyflSJHbSmJvhIrHlg1rAvqzicTNL8Q6O1Rt0YEvc
         wkn/8U7aTk7yla9SviPAfdv1vVs+9Xf0qh5A37FEPNQhkm7SmTZ3935vDWmejRuEeGo2
         oU9ptIWMH8u4n+WC6kv9g0hquHL6pKmcHgLWnT1Xmpx4G3YgKaCOdkAebKiZOm4yfjjU
         8LCg==
X-Forwarded-Encrypted: i=1; AJvYcCVijNaet08Xgclntkuc97v54WmqjQBMWYtl9GpdykDIZMyxF/zI66JyRrpeZworQD+icdRW4SfTqve1kl4BH4ne4bd0jjQ3
X-Gm-Message-State: AOJu0YyaDFpyqmMT0RsfXyBVVPVusVlp6hEVXbK0OCOyTxVxS622Jds+
	Hm+QI2Syh0tZ+03dkYmt3y5UIe+aIHDghLpbNRWhQzRYyLOPF2ldoYHDaRqGL/4=
X-Google-Smtp-Source: AGHT+IEDT12fiPA57xX+iwmImdIwGveXHkEDrvXHMWxFxiDJTGmsEb2kKmkBKuleVWzhzq6BApdEQg==
X-Received: by 2002:a17:907:847:b0:a7a:9f78:fee with SMTP id a640c23a62f3a-a7dc4e282e9mr636574766b.17.1722750018105;
        Sat, 03 Aug 2024 22:40:18 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/11] arm64: qcom: set of fixes for SM8350 platform
Date: Sun, 04 Aug 2024 08:40:04 +0300
Message-Id: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQUr2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMT3eJcC2NTA920zIrUYl3LVHNjwzRzy2RTszQloJaColSwBFBHdGx
 tLQAQyxSaXgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lCsk1q0z8so6Y2tczVGuQeC5mXXz5zbJNYg4kt/XRZE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrxQ+ijSCqimrSzppba3nf7rGrom+4OOr65gak
 B81n9SelkeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq8UPgAKCRCLPIo+Aiko
 1RR5B/4iOJI+9B8r8uW0dwnq5eyzrbGTG/K7BtAZIo/nD+BBhfxtcJV0VW6pVahOnRDsAUmSZIo
 9DyIqFj7WIQVwS50imsIIaN+Ew1UEyBQUf5YG8Af1F9v9BH72QF4t0eqXjqd9eNx5fmVWDUQg5n
 UfP+ik8pv2e1UhQDo2uCMVuu1ykW+UjmT6HDkvWcAsIQQX6zsx1336csEg84SBdCftMLWwVjMEM
 XgSIYKa8cg8UFT8V2eDhIapjv9KjdVk/cqRWltWw+rVLE69u6kyov69PqxcwOxcdmhmAR13Q7Hg
 umSDRCCpkGoetDEmftKCAUbolR7wAwzzpjFLN0INL58sRJUi
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

A set of fixes that target stability of the SM8350 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (11):
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks
      clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL
      drm/msm/dsi: correct programming sequence for SM8350 / SM8450
      interconnect: qcom: sm8350: drop DISP nodes
      interconnect: qcom: sm8450: drop DISP nodes
      dt-bindings: interconnect: qcom,sm8350: drop DISP nodes
      dt-bindings: interconnect: qcom,sm8450: drop DISP nodes
      interconnect: qcom: sm8250: Enable sync_state
      arm64: dts: qcom: sm8350: add MDSS registers interconnect
      arm64: dts: qcom: sm8350: add refgen regulator
      arm64: defconfig: build CONFIG_REGULATOR_QCOM_REFGEN as module

 arch/arm64/boot/dts/qcom/sm8350.dtsi           |  16 ++-
 arch/arm64/configs/defconfig                   |   1 +
 drivers/clk/qcom/clk-alpha-pll.c               |  52 +++++++++
 drivers/clk/qcom/clk-alpha-pll.h               |   2 +
 drivers/clk/qcom/dispcc-sm8250.c               |  12 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c      |  12 +-
 drivers/interconnect/qcom/sm8350.c             | 155 +------------------------
 drivers/interconnect/qcom/sm8350.h             |  10 --
 drivers/interconnect/qcom/sm8450.c             | 145 -----------------------
 drivers/interconnect/qcom/sm8450.h             |  12 --
 include/dt-bindings/interconnect/qcom,sm8350.h |  10 --
 include/dt-bindings/interconnect/qcom,sm8450.h |  10 --
 12 files changed, 91 insertions(+), 346 deletions(-)
---
base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
change-id: 20240804-sm8350-fixes-9e731f79c56f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


